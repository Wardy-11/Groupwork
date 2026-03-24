package com.example.group01.controller;

import com.example.group01.model.Course;
import com.example.group01.model.User;
import com.example.group01.model.UserCourse;
import com.example.group01.repository.CourseRepository;
import com.example.group01.repository.UserCourseRepository;
import com.example.group01.repository.UserRepository;
import com.example.group01.service.AchievementService;
import com.example.group01.service.TitleService;
import com.example.group01.service.TitleService.TitleDefinition;
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
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class AuthController {

    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private UserCourseRepository userCourseRepository;
    @Autowired
    private UserService userService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private AchievementService achievementService;


    @Autowired
    private TitleService titleService;

    private static final String ERROR_ATTR = "error";

    @GetMapping("/register")
    public String showRegistrationForm() {
        return "register";
    }

    @PostMapping("/register")
    public String handleRegistration(
            String firstName, String lastName, String email,
            String password, String confirmPassword, String course,
            Model model) {

        if (firstName == null || firstName.isBlank()) { model.addAttribute(ERROR_ATTR, "First name is required."); return "register"; }
        if (lastName == null || lastName.isBlank()) { model.addAttribute(ERROR_ATTR, "Last name is required."); return "register"; }
        if (email == null || email.isBlank()) { model.addAttribute(ERROR_ATTR, "Email address is required."); return "register"; }
        if (!email.contains("@")) { model.addAttribute(ERROR_ATTR, "Please provide a valid email address."); return "register"; }
        if (password == null || password.length() < 6) { model.addAttribute(ERROR_ATTR, "Password must be at least six characters."); return "register"; }
        if (!password.equals(confirmPassword)) { model.addAttribute(ERROR_ATTR, "Passwords do not match."); return "register"; }

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

        int streak = userService.updateLoginStreak(email);
        achievementService.checkStreakAchievements(user, streak);
        achievementService.unlockAchievement(user, "First Login");
        user = userRepository.findByEmail(email);
        Long userId = user.getId();

        List<Course> startedCourses = userCourseRepository.findByUserIdAndStatus(userId, "STARTED")
                .stream()
                .map(UserCourse::getCourse)
                .collect(Collectors.toList());

        model.addAttribute("user", user);
        model.addAttribute("streak", streak);
        model.addAttribute("startedCourses", startedCourses);

        return "homepage";
    }

    @GetMapping("/profile")
    public String viewProfile(Model model, Authentication authentication) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);
        populateProfileModel(model, user);
        boolean hasTrendsetter = false;
        if (user.getAchievements() != null) {
            hasTrendsetter = user.getAchievements().stream()
                    .anyMatch(a -> a.getTitle().equals("Trendsetter (Equip a Title)"));
        }
        model.addAttribute("hasTrendsetter", hasTrendsetter);
        return "profile";
    }

    @PostMapping("/profile")
    public String updateProfile(
            @RequestParam("firstName") String firstName,
            @RequestParam("lastName") String lastName,
            @RequestParam("email") String email,
            @RequestParam(value = "course", required = false) String course,
            @RequestParam(value = "password", required = false) String password,
            Authentication authentication,
            Model model) {

        String currentEmail = authentication.getName();
        User user = userRepository.findByEmail(currentEmail);

        if (firstName == null || firstName.isBlank()) { model.addAttribute("error", "First name is required."); populateProfileModel(model, user); return "profile"; }
        if (lastName == null || lastName.isBlank()) { model.addAttribute("error", "Last name is required."); populateProfileModel(model, user); return "profile"; }
        if (email == null || email.isBlank() || !email.contains("@")) { model.addAttribute("error", "A valid email address is required."); populateProfileModel(model, user); return "profile"; }
        if (!user.getEmail().equals(email) && userRepository.findByEmail(email) != null) { model.addAttribute("error", "That email address is already in use."); populateProfileModel(model, user); return "profile"; }

        if (password != null && !password.isBlank()) {
            if (password.length() < 6) { model.addAttribute("error", "New password must be at least 6 characters."); populateProfileModel(model, user); return "profile"; }
            user.setPassword(userService.encodePassword(password));
        }

        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setCourse(course);
        userRepository.save(user);

        model.addAttribute("success", "Profile updated successfully!");
        populateProfileModel(model, user);
        return "profile";
    }

    @PostMapping("/profile/equip-title")
    public String equipTitle(@RequestParam("titleName") String titleName, Authentication authentication) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);
        titleService.equipTitle(user, titleName);
        if (user != null) {
            achievementService.unlockAchievement(user, "Trendsetter (Equip a Title)");
        }
        return "redirect:/profile";
    }

    @PostMapping("/profile/delete")
    public String deleteAccount(Authentication authentication, HttpServletRequest request, HttpServletResponse response, Model model) {
        try {
            userService.deleteUser();
            new SecurityContextLogoutHandler().logout(request, response, authentication);
            return "redirect:/login?deleted";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            if (authentication != null) {
                User user = userRepository.findByEmail(authentication.getName());
                if (user != null) populateProfileModel(model, user);
            }
            return "profile";
        }
    }

    @GetMapping("/leaderboard")
    public String showLeaderboard(Model model, Authentication authentication) {
        List<User> users = userRepository.findAll();
        users.sort(Comparator.comparingLong(User::getXp).reversed());
        model.addAttribute("users", users);

        String email = authentication.getName();
        User currentUser = userRepository.findByEmail(email);

        List<User> friendsUsers = new ArrayList<>();
        friendsUsers.add(currentUser);

        if (currentUser.getFriends() != null && !currentUser.getFriends().isEmpty()) {
            for (String friendUsername : currentUser.getFriends()) {
                User friendUser = userRepository.findByUsername(friendUsername);
                if (friendUser != null) friendsUsers.add(friendUser);
            }
        }

        friendsUsers.sort(Comparator.comparingLong(User::getXp).reversed());
        model.addAttribute("friendsUsers", friendsUsers);

        Map<String, TitleDefinition> titleMap = new HashMap<>();
        for (User u : users) {
            titleMap.put(u.getUsername(), titleService.getEquippedTitleDefinition(u));
        }
        model.addAttribute("titleMap", titleMap);

        return "leaderboard";
    }

    @GetMapping("/friends")
    public String showFriends(Model model, Authentication authentication, @RequestParam(name = "keyword", required = false) String keyword) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);

        List<String> friendsDisplay;
        if (keyword != null && !keyword.isEmpty()) {
            friendsDisplay = userRepository.findFriendsByUsername(user.getId(), keyword);
        } else {
            friendsDisplay = user.getFriends();
        }
        Map<String, TitleDefinition> titleMap = new HashMap<>();
        if (friendsDisplay != null) {
            for (String username : friendsDisplay) {
                User friendUser = userRepository.findByUsername(username);
                if (friendUser != null) titleMap.put(username, titleService.getEquippedTitleDefinition(friendUser));
            }
        }
        boolean hasFirstFriend = false;
        if (user.getAchievements() != null) {
            hasFirstFriend = user.getAchievements().stream()
                    .anyMatch(a -> a.getTitle().equals("Social Butterfly (Add 1 Friend)"));
        }
        model.addAttribute("hasFirstFriend", hasFirstFriend);
        int friendCount = (user.getFriends() != null) ? user.getFriends().size() : 0;
        model.addAttribute("friendCount", friendCount);
        model.addAttribute("friends", friendsDisplay);
        model.addAttribute("currentUser", user);
        model.addAttribute("titleMap", titleMap);
        return "friends";
    }
    @GetMapping("/allUsers")
    public String showAllUsers(Model model, Authentication authentication, @RequestParam(name = "keyword", required = false) String keyword) {
        List<User> usersDisplay;
        List<String> usernameDisplay = new ArrayList<>();
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);

        if (keyword != null && !keyword.isEmpty()) {
            usersDisplay = userRepository.findAllByUsernameContainingIgnoreCase(keyword);
        } else {
            usersDisplay = userRepository.findAll();
        }

        for (User account : usersDisplay) {
            if (account.getUsername() != user.getUsername()) usernameDisplay.add(account.getUsername());
        }

        Map<String, TitleDefinition> titleMap = new HashMap<>();
        for (String username : usernameDisplay) {
            User u = userRepository.findByUsername(username);
            if (u != null) titleMap.put(username, titleService.getEquippedTitleDefinition(u));
        }

        model.addAttribute("friends", usernameDisplay);
        model.addAttribute("currentUser", user);
        model.addAttribute("titleMap", titleMap);
        return "allUsers";
    }

    @GetMapping("/removeFriend")
    public String removeFriend(Authentication authentication, @RequestParam("username") String username, @RequestParam("source") String source) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);
        user.setFriends(userService.removeFriend(user.getFriends(), username));
        userRepository.save(user);
        return "redirect:/" + source;
    }

    @GetMapping("/addFriend")
    public String addFriend(Authentication authentication, @RequestParam("username") String username, @RequestParam("source") String source) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email);

        user.getFriends().add(username);
        userRepository.save(user);
        achievementService.unlockAchievement(user, "Social Butterfly (Add 1 Friend)");
        return "redirect:/" + source;
    }

    private void populateProfileModel(Model model, User user) {
        model.addAttribute("user", user);
        model.addAttribute("achievements", user.getAchievements());
        model.addAttribute("allAchievements", AchievementService.ALL_ACHIEVEMENTS.values());
        model.addAttribute("allTitles", TitleService.ALL_TITLES.values());
        model.addAttribute("unlockedTitles", titleService.getUnlockedTitles(user));
        model.addAttribute("equippedTitleDef", titleService.getEquippedTitleDefinition(user));
    }
}