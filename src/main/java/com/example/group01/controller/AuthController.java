package com.example.group01.controller;

import com.example.group01.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * Handles authentication-related requests such as login, registration,
 * logout and the post-login homepage. 
 */
@Controller
public class AuthController {
    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    private static final String ERROR_ATTR = "error";

    @GetMapping("/register")
    public String showRegistrationForm() {
        return "register";
    }

    @PostMapping("/register")
    public String handleRegistration(
            String firstName,
            String lastName,
            String email,
            String password,
            String confirmPassword,
            String course,
            Model model
    ) {

        if (firstName == null || firstName.isBlank()) {
            model.addAttribute(ERROR_ATTR, "First name is required.");
            return "register";
        }

        if (lastName == null || lastName.isBlank()) {
            model.addAttribute(ERROR_ATTR, "Last name is required.");
            return "register";
        }

        if (email == null || email.isBlank()) {
            model.addAttribute(ERROR_ATTR, "Email address is required.");
            return "register";
        }

        if (!email.contains("@")) {
            model.addAttribute(ERROR_ATTR, "Please provide a valid email address.");
            return "register";
        }

        if (password == null || password.length() < 6) {
            model.addAttribute(ERROR_ATTR, "Password must be at least six characters.");
            return "register";
        }

        if (!password.equals(confirmPassword)) {
            model.addAttribute(ERROR_ATTR, "Passwords do not match.");
            return "register";
        }

        try {
            userService.registerUser(firstName, lastName, email, password, course);
        } catch (RuntimeException e) {
            model.addAttribute(ERROR_ATTR, e.getMessage());
            return "register";
        }

        // registration succeeded, send user to login page
        return "redirect:/login";
    }




    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/logout")
    public String logoutUser(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/homepage")
    public String showHomepage() {
        return "homepage";
    }

}
