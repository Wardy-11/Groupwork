package com.example.group01.service;

import com.example.group01.model.Comment;
import com.example.group01.model.User;
import com.example.group01.model.Course;
import com.example.group01.repository.CommentRepository;
import com.example.group01.repository.UserRepository;
import com.example.group01.repository.CourseRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {

    private final CommentRepository commentRepository;
    private final UserRepository userRepository;
    private final CourseRepository courseRepository;

    public CommentService(CommentRepository commentRepository,
                          UserRepository userRepository,
                          CourseRepository courseRepository) {
        this.commentRepository = commentRepository;
        this.userRepository = userRepository;
        this.courseRepository = courseRepository;
    }

    public Comment saveComment(Comment comment) {
        System.out.println("Service reached");

        User managedUser = userRepository.findById(comment.getUser().getId())
                .orElseThrow(() -> new RuntimeException("User not found"));
        Course managedCourse = courseRepository.findById(comment.getCourse().getId())
                .orElseThrow(() -> new RuntimeException("Course not found"));

        comment.setUser(managedUser);
        comment.setCourse(managedCourse);

        // Check for existing comment
        Comment existing = commentRepository.findByUserAndCourse(managedUser, managedCourse);
        if (existing != null) {
            throw new RuntimeException("You have already commented on this course");
        }

        return commentRepository.save(comment);
    }

    public List<Comment> getAllComments(Long courseId) {
        return commentRepository.findByCourse_Id(courseId);
    }


    public Comment getUserCommentOnCourse(Long userId, Long courseId) {
        User user = userRepository.findById(userId).orElse(null);
        Course course = courseRepository.findById(courseId).orElse(null);
        
        if (user != null && course != null) {
            return commentRepository.findByUserAndCourse(user, course);
        }
        return null;
    }
}
