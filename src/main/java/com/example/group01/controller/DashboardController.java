package com.example.group01.controller;

import com.example.group01.model.Course;
import com.example.group01.repository.CourseRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.stream.Collectors;

@Controller
public class DashboardController {

    private final CourseRepository courseRepository;

    public DashboardController(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    @GetMapping("/dashboard")
    public String dashboard(String keyword, Model model) {

        List<Course> courses;

        if (keyword != null && !keyword.isEmpty()) {
            courses = courseRepository.findByTitleContainingIgnoreCase(keyword);
        } else {
            courses = courseRepository.findAll();
        }

        List<Course> started = courses.stream()
                .filter(c -> "Started".equalsIgnoreCase(c.getStatus()))
                .collect(Collectors.toList());

        List<Course> completed = courses.stream()
                .filter(c -> "Completed".equalsIgnoreCase(c.getStatus()))
                .collect(Collectors.toList());

        List<Course> available = courses.stream()
                .filter(c -> c.getStatus() == null || "Available".equalsIgnoreCase(c.getStatus()))
                .collect(Collectors.toList());

        model.addAttribute("startedCourses", started);
        model.addAttribute("completedCourses", completed);
        model.addAttribute("availableCourses", available);

        return "dashboard";
    }
}