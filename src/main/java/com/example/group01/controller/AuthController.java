package com.example.group01.controller;

import com.example.group01.model.User;
import com.example.group01.repository.UserRepository;
import com.example.group01.service.AchievementService;
import com.example.group01.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import jakarta.validation.Valid;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AchievementService achievementService;

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

    @GetMapping("/courses")
    public String showCourses() {
        return "courses";
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
        model.addAttribute("achievements", user.getAchievements());

        return "profile";
    }

    @PostMapping("/profile")
    public String updateProfile(
            @Valid @ModelAttribute("user") User formUser,
            BindingResult bindingResult,
            Authentication authentication,
            Model model) {

        String currentEmail = authentication.getName();
        User user = userRepository.findByEmail(currentEmail);

        if (bindingResult.hasErrors()) {
            model.addAttribute("achievements", user.getAchievements());
            model.addAttribute("error", bindingResult.getFieldError().getDefaultMessage());
            return "profile";
        }

        if (!user.getEmail().equals(formUser.getEmail())
                && userRepository.findByEmail(formUser.getEmail()) != null) {
            model.addAttribute("error", "Email already in use.");
            model.addAttribute("achievements", user.getAchievements());
            return "profile";
        }

        user.setFirstName(formUser.getFirstName());
        user.setLastName(formUser.getLastName());
        user.setEmail(formUser.getEmail());
        user.setCourse(formUser.getCourse());

        if (formUser.getPassword() != null && !formUser.getPassword().isBlank()) {
            user.setPassword(userService.encodePassword(formUser.getPassword()));
        }

        userRepository.save(user);

        model.addAttribute("user", user);
        model.addAttribute("achievements", user.getAchievements());
        model.addAttribute("success", "Profile updated successfully!");

        return "profile";
    }

    @PostMapping("/unlock-achievement")
    public String unlockAchievement(Authentication authentication) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);
        userService.awardAchievementXp();
        achievementService.unlockAchievement(user, "First Login");

        return "redirect:/profile";
    }

    @GetMapping("/leaderboard")
    public String showLeaderboard(Model model) {
        List<User> users = userRepository.findAll();
        users.sort(new Comparator<User>() {
            public int compare(User o1, User o2) {
                if (o1.getXp() > o2.getXp()) return -1;
                if (o1.getXp() < o2.getXp()) return 1;
                return 0;
            }});
        model.addAttribute("users", users);
        return "leaderboard";
    }
}

