package com.example.group01.controller;

import com.example.group01.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
            String confirmPassword
    ) {

        if (!password.equals(confirmPassword)) {
            return "register";
        }

        userService.registerUser(firstName, lastName, email, password);

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
