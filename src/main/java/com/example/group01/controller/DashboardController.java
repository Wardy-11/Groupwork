package com.example.group01.controller;

import com.example.group01.model.Course;
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

import java.util.List;
import java.util.Optional;
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
    public String showDashboard(@RequestParam(name = "keyword", required = false) String keyword,
                                Model model, Authentication authentication) {

        String email = authentication.getName();
        User user = userRepository.findByEmail(email);

        boolean hasCourseMaster = user.getAchievements() != null && user.getAchievements().stream()
                .anyMatch(a -> a.getTitle().equals("Course Master (3 Courses)"));
        model.addAttribute("hasCourseMaster", hasCourseMaster);

        List<Course> allCourses;
        if (keyword != null && !keyword.isEmpty()) {
            allCourses = courseRepository.findByTitleContainingIgnoreCase(keyword);
        } else {
            allCourses = courseRepository.findAll();
        }

        List<UserCourse> userCourses = userCourseRepository.findByUser(user);

        List<Course> startedCourses = userCourses.stream()
                .filter(uc -> "STARTED".equals(uc.getStatus()))
                .map(UserCourse::getCourse)
                .filter(c -> keyword == null || keyword.isEmpty() || c.getTitle().toLowerCase().contains(keyword.toLowerCase()))
                .collect(Collectors.toList());

        List<Course> completedCourses = userCourses.stream()
                .filter(uc -> "COMPLETED".equals(uc.getStatus()))
                .map(UserCourse::getCourse)
                .filter(c -> keyword == null || keyword.isEmpty() || c.getTitle().toLowerCase().contains(keyword.toLowerCase()))
                .collect(Collectors.toList());

        List<Long> startedIds = userCourses.stream()
                .filter(uc -> "STARTED".equals(uc.getStatus()))
                .map(uc -> uc.getCourse().getId())
                .collect(Collectors.toList());

        List<Long> completedIds = userCourses.stream()
                .filter(uc -> "COMPLETED".equals(uc.getStatus()))
                .map(uc -> uc.getCourse().getId())
                .collect(Collectors.toList());

        List<Course> availableCourses = allCourses.stream()
                .filter(c -> !startedIds.contains(c.getId()) && !completedIds.contains(c.getId()))
                .collect(Collectors.toList());

        long completedCourseCount = userCourseRepository.countByUserAndStatus(user, "COMPLETED");

        model.addAttribute("startedCourses", startedCourses);
        model.addAttribute("availableCourses", availableCourses);
        model.addAttribute("completedCourses", completedCourses);
        model.addAttribute("completedCourseCount", completedCourseCount);

        return "dashboard";
    }

    @PostMapping("/complete-course")
    public String completeCourse(@RequestParam("courseId") Long id, Authentication authentication) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);
        Course course = courseRepository.findById(id).orElseThrow();

        Optional<UserCourse> existing = userCourseRepository.findByUserAndCourse(user, course);
        if (existing.isPresent()) {
            existing.get().setStatus("COMPLETED");
            userCourseRepository.save(existing.get());
        } else {
            userCourseRepository.save(new UserCourse(user, course, "COMPLETED"));
        }

        userService.awardCourseCompletionXp();

        long totalCompleted = userCourseRepository.countByUserAndStatus(user, "COMPLETED");
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

        Optional<UserCourse> existing = userCourseRepository.findByUserAndCourse(user, course);
        if (existing.isEmpty()) {
            userCourseRepository.save(new UserCourse(user, course, "STARTED"));
        }

        return "redirect:/dashboard";
    }
}