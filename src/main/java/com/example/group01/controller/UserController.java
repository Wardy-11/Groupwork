package com.example.group01.controller;

import com.example.group01.model.Course;
import com.example.group01.model.User;
import com.example.group01.model.UserCourse;
import com.example.group01.repository.CourseRepository;
import com.example.group01.repository.UserCourseRepository;
import com.example.group01.repository.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Set;

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final UserRepository userRepository;
    private final CourseRepository courseRepository;
    private final UserCourseRepository userCourseRepository;

    public UserController(UserRepository userRepository, CourseRepository courseRepository, UserCourseRepository userCourseRepository) {
        this.userRepository = userRepository;
        this.courseRepository = courseRepository;
        this.userCourseRepository = userCourseRepository;
    }

    @GetMapping
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @PostMapping
    public User createUser(@RequestBody User user) {
        return userRepository.save(user);
    }

    @GetMapping("/{userId}/courses")
    public List<UserCourse> getMyCourses(@PathVariable Long userId) {
        if (!userRepository.existsById(userId)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found");
        }
        return userCourseRepository.findByUserId(userId);
    }

    @PostMapping("/{userId}/courses/{courseId}")
    public void startCourse(@PathVariable Long userId, @PathVariable Long courseId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));

        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Course not found"));

        UserCourse userCourse = userCourseRepository
                .findByUserIdAndCourseId(userId, courseId)
                .orElseGet(() -> new UserCourse(user, course, "STARTED"));

        if (!"COMPLETED".equals(userCourse.getStatus())) {
            userCourse.setStatus("STARTED");
            userCourseRepository.save(userCourse);
        }
    }
}