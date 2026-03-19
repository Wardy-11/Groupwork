package com.example.group01.controller;

import com.example.group01.model.Course;
import com.example.group01.model.User;
import com.example.group01.repository.CourseRepository;
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
import java.util.stream.Collectors;

@Controller
public class DashboardController {

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AchievementService achievementService;

    @GetMapping("/dashboard")
    public String showDashboard(@RequestParam(name = "keyword", required = false) String keyword, Model model, Authentication authentication) {

        String email = authentication.getName();
        User user = userRepository.findByEmail(email);

        boolean hasCourseMaster = false;
        if (user.getAchievements() != null) {
            hasCourseMaster = user.getAchievements().stream()
                    .anyMatch(a -> a.getTitle().equals("Course Master (3 Courses)"));
        }
        model.addAttribute("hasCourseMaster", hasCourseMaster);

        List<Course> allCourses = courseRepository.findAll();

        int completedCourseCount = (int) allCourses.stream()
                .filter(c -> "COMPLETED".equals(c.getStatus()))
                .count();
        model.addAttribute("completedCourseCount", completedCourseCount);

        List<Course> coursesDisplay;
        if (keyword != null && !keyword.isEmpty()) {
            coursesDisplay = courseRepository.findByTitleContainingIgnoreCase(keyword);
        } else {
            coursesDisplay = allCourses;
        }

        List<Course> startedCourses = coursesDisplay.stream()
                .filter(c -> "STARTED".equals(c.getStatus()))
                .collect(Collectors.toList());

        List<Course> availableCourses = coursesDisplay.stream()
                .filter(c -> "AVAILABLE".equals(c.getStatus()))
                .collect(Collectors.toList());

        List<Course> completedCourses = coursesDisplay.stream()
                .filter(c -> "COMPLETED".equals(c.getStatus()))
                .collect(Collectors.toList());

        model.addAttribute("startedCourses", startedCourses);
        model.addAttribute("availableCourses", availableCourses);
        model.addAttribute("completedCourses", completedCourses);

        return "dashboard";
    }

    @PostMapping("/complete-course")
    public String completeCourse(@RequestParam("courseId") Long id, Authentication authentication) {

        Course course = courseRepository.findById(id).orElseThrow();
        course.setStatus("COMPLETED");
        courseRepository.save(course);

        userService.awardCourseCompletionXp();

        String email = authentication.getName();
        User user = userRepository.findByEmail(email);

        long totalCompleted = courseRepository.findAll().stream()
                .filter(c -> "COMPLETED".equals(c.getStatus()))
                .count();

        if (totalCompleted >= 3) {
            achievementService.unlockAchievement(user, "Course Master (3 Courses)");
        }

        return "redirect:/dashboard";
    }

    @PostMapping("/start-course")
    public String startCourse(@RequestParam("courseId") Long id) {
        Course course = courseRepository.findById(id).orElseThrow();
        course.setStatus("STARTED");
        courseRepository.save(course);
        return "redirect:/dashboard";
    }
}