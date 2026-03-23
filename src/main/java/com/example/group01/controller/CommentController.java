package com.example.group01.controller;

import com.example.group01.model.Comment;
import com.example.group01.model.User;
import com.example.group01.model.Course;
import com.example.group01.repository.UserRepository;
import com.example.group01.repository.CourseRepository;
import com.example.group01.service.CommentService;
import com.example.group01.service.TitleService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/comments")
public class CommentController {

    private final CommentService commentService;
    private final UserRepository userRepository;
    private final CourseRepository courseRepository;

    public CommentController(CommentService commentService, UserRepository userRepository, CourseRepository courseRepository) {
        this.commentService = commentService;
        this.userRepository = userRepository;
        this.courseRepository = courseRepository;
    }

    @GetMapping("/course/{courseId}")
    @ResponseBody
    public List<Comment> getComments(@PathVariable Long courseId) {
        return commentService.getAllComments(courseId);
    }

    @PostMapping
    public String addComment(@ModelAttribute Comment comment,
                             @RequestParam(required = false) Long courseId,
                             RedirectAttributes redirectAttributes) {
        try {
            if (courseId == null && comment.getCourse() != null) {
                courseId = comment.getCourse().getId();
            }

            if (courseId == null) {
                throw new RuntimeException("Course ID missing");
            }

            Course course = courseRepository.findById(courseId).get();
            comment.setCourse(course);

            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            String email = auth != null ? auth.getName() : null;
            if (email == null) {
                throw new RuntimeException("User not authenticated");
            }

            User user = userRepository.findByEmail(email);
            if (user == null) {
                throw new RuntimeException("User not found");
            }

            comment.setUser(user);
            Comment saved = commentService.saveComment(comment);

            redirectAttributes.addFlashAttribute("message", "Comment posted.");
            return "redirect:/comments/comments-page?courseId=" + courseId;
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to post comment: " + e.getMessage());
            if (courseId != null) {
                return "redirect:/comments/comments-page?courseId=" + courseId;
            } else {
                return "redirect:/comments/comments-page";
            }
        }
    }

    @GetMapping("/comments-page")
    public String commentsPage(Model model, @RequestParam(required = false) Long courseId) {
        model.addAttribute("comment", new Comment());
        model.addAttribute("courseId", courseId);

        Course course = courseRepository.findById(courseId).orElse(null);
        model.addAttribute("course", course);

        model.addAttribute("allTitles", TitleService.ALL_TITLES);

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = (auth != null && auth.isAuthenticated()) ? auth.getName() : null;
        model.addAttribute("userEmail", username);

        if (username != null) {
            User user = userRepository.findByEmail(username);
            if (user != null) {
                model.addAttribute("userId", user.getId());

                if (courseId != null) {
                    Comment existingComment = commentService.getUserCommentOnCourse(user.getId(), courseId);
                    if (existingComment != null) {
                        model.addAttribute("userComment", existingComment);
                        model.addAttribute("hasCommented", true);
                    }
                }
            }
        }

        if (courseId != null) {
            List<Comment> comments = commentService.getAllComments(courseId);
            model.addAttribute("comments", comments);
        } else {
            model.addAttribute("comments", List.of());
            model.addAttribute("error", "Missing courseId");
        }

        return "comments";
    }
}



