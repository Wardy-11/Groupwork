package com.example.group01.controller;

import com.example.group01.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class MyController {
    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String register(){
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

        if (firstName == null || firstName.isBlank()) {
            model.addAttribute("error", "First name is required");
            return "register";
        }

        if (lastName == null || lastName.isBlank()) {
            model.addAttribute("error", "Last name is required");
            return "register";
        }

        if (email == null || email.isBlank()) {
            model.addAttribute("error", "Email is required");
            return "register";
        }

        if (!email.contains("@")) {
            model.addAttribute("error", "Invalid email format");
            return "register";
        }

        if (password == null || password.length() < 6) {
            model.addAttribute("error", "Password must be at least 6 characters");
            return "register";
        }

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
    public String login(){
        return "login";
    }
    @GetMapping("/homepage")
    public String home(){
        return "homepage";
    }

}
