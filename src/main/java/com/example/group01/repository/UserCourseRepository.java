package com.example.group01.repository;

import com.example.group01.model.Course;
import com.example.group01.model.User;
import com.example.group01.model.UserCourse;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserCourseRepository extends JpaRepository<UserCourse, Long> {
    List<UserCourse> findByUser(User user);
    Optional<UserCourse> findByUserAndCourse(User user, Course course);
    List<UserCourse> findByUserAndStatus(User user, String status);
    long countByUserAndStatus(User user, String status);
}