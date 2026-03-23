package com.example.group01.repository;

import com.example.group01.model.Comment;
import com.example.group01.model.Course;
import com.example.group01.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Long> {
    List<Comment> findByUser(User user);
    List<Comment> findByCourse(Course course);
    Comment findByUserAndCourse(User user, Course course);
    List<Comment> findByCourse_Id(Long courseId);
}