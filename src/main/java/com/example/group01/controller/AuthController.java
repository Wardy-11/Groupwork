package com.example.group01.controller;

import com.example.group01.model.Course;
import com.example.group01.model.User;
import com.example.group01.model.UserCourse;
import com.example.group01.repository.UserCourseRepository;
import com.example.group01.repository.CourseRepository;
import com.example.group01.repository.UserRepository;
import com.example.group01.service.AchievementService;
import com.example.group01.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import jakarta.validation.Valid;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class AuthController {

    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private UserService userService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private AchievementService achievementService;
    @Autowired
    private UserCourseRepository userCourseRepository;

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
    public String showCourses(Model model) {
        model.addAttribute("courses", courseRepository.findAll());
        return "courses";
    }

    @GetMapping("/homepage")
    public String home(Model model, Authentication authentication) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);
        model.addAttribute("user", user);

        List<Course> startedCourses = userCourseRepository.findByUserId(user.getId()).stream()
                .filter(uc -> "STARTED".equals(uc.getStatus()))
                .map(UserCourse::getCourse)
                .collect(Collectors.toList());

        model.addAttribute("startedCourses", startedCourses);

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

    @PostMapping("/profile/delete")
    public String deleteAccount(Authentication authentication,
                                HttpServletRequest request,
                                HttpServletResponse response,
                                Model model) {
        try {
            userService.deleteUser();

            new SecurityContextLogoutHandler().logout(request, response, authentication);

            return "redirect:/login?deleted";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());

            if (authentication != null) {
                String email = authentication.getName();
                User user = userRepository.findByEmail(email);

                if (user != null) {
                    model.addAttribute("user", user);
                    model.addAttribute("achievements", user.getAchievements());
                }
            }

            return "profile";
        }
    }

    @PostMapping("/unlock-achievement")
    public String unlockAchievement(
            @RequestParam(value = "achievementTitle", defaultValue = "First Login") String title,
            Authentication authentication) {

        String email = authentication.getName(); //
        User user = userRepository.findByEmail(email); //

        // 1. Try to unlock the specific achievement passed from the JSP
        boolean isNewAchievement = achievementService.unlockAchievement(user, title);

        // 2. ONLY award XP if they didn't already have it
        if (isNewAchievement) {
            userService.awardAchievementXp();
        }

        return "redirect:/profile";
    }

   @GetMapping("/leaderboard")
    public String showLeaderboard(Model model, Authentication authentication) {
        // Global leaderboard
        List<User> users = userRepository.findAll();
        users.sort(Comparator.comparingLong(User::getXp).reversed());
        model.addAttribute("users", users);

        // Friends leaderboard (includes the current user)
        String email = authentication.getName();
        User currentUser = userRepository.findByEmail(email);

        List<User> friendsUsers = new ArrayList<>();
        friendsUsers.add(currentUser);

        if (currentUser.getFriends() != null && !currentUser.getFriends().isEmpty()) {
            for (String friendUsername : currentUser.getFriends()) {
                User friendUser = userRepository.findByUsername(friendUsername);
                if (friendUser != null) {
                    friendsUsers.add(friendUser);
                }
            }
        }

        friendsUsers.sort(Comparator.comparingLong(User::getXp).reversed());
        model.addAttribute("friendsUsers", friendsUsers);

        return "leaderboard";
    }

    public void validate(Model model, String firstName, String lastName, String password) {
        if (firstName == null || firstName.isBlank()) {
            model.addAttribute(ERROR_ATTR, "First name is required.");
        }

        if (lastName == null || lastName.isBlank()) {
            model.addAttribute(ERROR_ATTR, "Last name is required.");
        }

        if (password == null || password.length() < 6) {
            model.addAttribute(ERROR_ATTR, "Password must be at least six characters.");
        }
    }

    @GetMapping("/friends")
    public String showFriends(Model model,Authentication authentication, @RequestParam(name = "keyword", required = false) String keyword) {
        List<String> friendsDisplay;
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);

        if (keyword != null && !keyword.isEmpty()) {
            friendsDisplay = userRepository.findFriendsByUsername(user.getId(), keyword);
        } else {

            friendsDisplay = user.getFriends();
        }

        model.addAttribute("friends", friendsDisplay);
        model.addAttribute("currentUser", user);
        return "friends";
    }

    @GetMapping("/allUsers")
    public String showAllUsers(Model model, Authentication authentication, @RequestParam(name = "keyword", required = false) String keyword) {
        List<User> usersDisplay;
        List<String> usernameDisplay =  new ArrayList<>();
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);
        if(keyword != null && !keyword.isEmpty()) {
            usersDisplay = userRepository.findAllByUsernameContainingIgnoreCase(keyword);
        }
        else {
            usersDisplay = userRepository.findAll();
        }
        for(User account : usersDisplay) {
            if(account.getUsername() != user.getUsername()){
                usernameDisplay.add(account.getUsername());
            }
        }
        model.addAttribute("friends", usernameDisplay);
        model.addAttribute("currentUser", user);
        return "allUsers";
    }

    @GetMapping("/removeFriend")
    public String removeFriend(Authentication authentication, @RequestParam("username") String username, @RequestParam("source") String source) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);
        List<String> friends = user.getFriends();
        List<String> newFriendList = userService.removeFriend(friends, username);
        user.setFriends(newFriendList);
        user = userRepository.save(user);
        return "redirect:/"+source;
    }

    @GetMapping("/addFriend")
    public String addFriend(Authentication authentication, @RequestParam("username") String username, @RequestParam("source") String source) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);
        List<String> friends = user.getFriends();
        friends.add(username);
        user.setFriends(friends);
        user = userRepository.save(user);
        return "redirect:/" + source;
    }


}

