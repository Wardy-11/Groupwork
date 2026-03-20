package com.example.group01.controller;

import com.example.group01.model.Course;
import com.example.group01.model.UserCourse;
import com.example.group01.repository.CourseRepository;
import com.example.group01.repository.UserCourseRepository;
import org.springframework.security.core.Authentication;
import com.example.group01.repository.UserRepository;
import com.example.group01.model.User;
import com.example.group01.model.UserCourse;
import com.example.group01.repository.CourseRepository;
import com.example.group01.repository.UserCourseRepository;
import com.example.group01.repository.UserRepository;
import com.example.group01.service.AchievementService;
import com.example.group01.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;
import java.util.stream.Collectors;

@Controller
public class DashboardController {

    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private UserCourseRepository userCourseRepository;
    @Autowired
    private UserService userService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private AchievementService achievementService;

    @GetMapping("/dashboard")
    public String showDashboard(@RequestParam(name = "keyword", required = false)
                                String keyword,
                                Model model,
                                Authentication authentication) {

        String email = authentication.getName();
        User user = userRepository.findByEmail(email);
        Long userId = user.getId();

        boolean hasCourseMaster = user.getAchievements() != null && user.getAchievements().stream()
                .anyMatch(a -> a.getTitle().equals("Course Master (3 Courses)"));
        model.addAttribute("hasCourseMaster", hasCourseMaster);

        List<Course> coursesDisplay;
        if (keyword != null && !keyword.isEmpty()) {
            coursesDisplay = courseRepository.findByTitleContainingIgnoreCase(keyword);
        } else {
            coursesDisplay = courseRepository.findAll();
        }

        List<UserCourse> userProgress = userCourseRepository.findByUserId(user.getId());

        Map<Long, String> statusByCourseId = userProgress.stream()
                .collect(Collectors.toMap(
                        uc -> uc.getCourse().getId(),
                        UserCourse::getStatus
                ));

        Comparator<Course> pathComparator = Comparator
                .comparing((Course c) -> c.getPathName() == null ? "Other" : c.getPathName(), String.CASE_INSENSITIVE_ORDER)
                .thenComparing(c -> c.getPathOrder() == null ? Integer.MAX_VALUE : c.getPathOrder())
                .thenComparing(Course::getTitle, String.CASE_INSENSITIVE_ORDER);

        List<Course> startedCourses = coursesDisplay.stream()
                .filter(c -> "STARTED".equals(statusByCourseId.get(c.getId())))
                .sorted(pathComparator)
                .collect(Collectors.toList());

        List<Course> completedCourses = coursesDisplay.stream()
                .filter(c -> "COMPLETED".equals(statusByCourseId.get(c.getId())))
                .sorted(pathComparator)
                .collect(Collectors.toList());

        List<Course> availableCourses = coursesDisplay.stream()
                .filter(c -> !statusByCourseId.containsKey(c.getId()))
                .sorted(pathComparator)
                .collect(Collectors.toList());

        /* List<Long> startedIds = userCourses.stream()
                .filter(uc -> "STARTED".equals(uc.getStatus()))
                .map(uc -> uc.getCourse().getId())
                .collect(Collectors.toList());

        List<Long> completedIds = userCourses.stream()
                .filter(uc -> "COMPLETED".equals(uc.getStatus()))
                .map(uc -> uc.getCourse().getId())
                .collect(Collectors.toList());

        List<Course> availableCourses = allCourses.stream()
                .filter(c -> !startedIds.contains(c.getId()) && !completedIds.contains(c.getId()))
                .collect(Collectors.toList()); */

        long completedCourseCount = userCourseRepository.countByUserIdAndStatus(userId, "COMPLETED");

        model.addAttribute("startedCourses", startedCourses);
        model.addAttribute("availableCourses", availableCourses);
        model.addAttribute("completedCourses", completedCourses);

        model.addAttribute("startedCoursesByPath", groupCoursesByPath(startedCourses));
        model.addAttribute("availableCoursesByPath", groupCoursesByPath(availableCourses));
        model.addAttribute("completedCoursesByPath", groupCoursesByPath(completedCourses));

        model.addAttribute("completedCourseCount", completedCourses.size());

        return "dashboard";
    }

    private Map<String, List<Course>> groupCoursesByPath(List<Course> courses) {
        return courses.stream()
                .collect(Collectors.groupingBy(
                        c -> (c.getPathName() == null || c.getPathName().isBlank()) ? "Other" : c.getPathName(),
                        LinkedHashMap::new,
                        Collectors.toList()
                ));
    }

    @PostMapping("/complete-course")
    public String completeCourse(@RequestParam("courseId") Long id, Authentication authentication) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);
        Course course = courseRepository.findById(id).orElseThrow();
        Long userId = user.getId();
        Long courseId = course.getId();

        Optional<UserCourse> existing = userCourseRepository.findByUserIdAndCourseId(userId, courseId);
        if (existing.isPresent()) {
            existing.get().setStatus("COMPLETED");
            userCourseRepository.save(existing.get());
        } else {
            userCourseRepository.save(new UserCourse(user, course, "COMPLETED"));
        }

        userService.awardCourseCompletionXp();

        long totalCompleted = userCourseRepository.countByUserIdAndStatus(userId, "COMPLETED");
        if (totalCompleted >= 3) {
            user = userRepository.findByEmail(email);
            achievementService.unlockAchievement(user, "Course Master (3 Courses)");
        }

        return "redirect:/dashboard";
    }

    @PostMapping("/start-course")
    public String startCourse(@RequestParam("courseId") Long id, Authentication authentication) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);
        Course course = courseRepository.findById(id).orElseThrow();

        UserCourse userCourse = userCourseRepository
                .findByUserIdAndCourseId(user.getId(), course.getId())
                .orElseGet(() -> new UserCourse(user, course, "STARTED"));

        if (!"COMPLETED".equals(userCourse.getStatus())) {
            userCourse.setStatus("STARTED");
            userCourseRepository.save(userCourse);
        }

        return "redirect:/dashboard";
    }
}