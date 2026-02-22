package com.example.group01.controller;

import com.example.group01.model.User;
import com.example.group01.repository.UserRepository;
import com.example.group01.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class MyController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(
            String firstName,
            String lastName,
            String email,
            String password,
            String confirmPassword,
            String course,
            Model model
    ) {
        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match");
            return "register";
        }

        try {
            userService.registerUser(firstName, lastName, email, password, course);
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return "register";
        }

        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/homepage")
    public String home() {
        return "homepage";
    }

    @GetMapping("/profile")
    public String viewProfile(Model model, Authentication authentication) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);

        model.addAttribute("user", user);
        return "profile";
    }

    @PostMapping("/profile")
    public String updateProfile(User formUser, Authentication authentication, Model model) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);

        user.setFirstName(formUser.getFirstName());
        user.setLastName(formUser.getLastName());
        user.setCourse(formUser.getCourse());

        if (formUser.getPassword() != null && !formUser.getPassword().isEmpty()) {
            //user.setPassword(userService.encodePassword(formUser.getPassword()));
            user.setPassword(formUser.getPassword());
        }

        userRepository.save(user);

        model.addAttribute("user", user);
        model.addAttribute("success", "Profile updated successfully!");
        return "profile";
    }
}