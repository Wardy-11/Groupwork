package com.example.group01.service;

import com.example.group01.model.User;
import com.example.group01.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {

    private static final Logger log = LoggerFactory.getLogger(UserService.class);

    private static final long course_xp = 75;
    private static final long level_xp = 100;
    private static final long achievement_xp = 50;

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public User loginUser(String email, String password) {
        User user = userRepository.findByEmail(email);
        if (user == null) {
            log.warn("Login attempt with unknown email {}", email);
            throw new RuntimeException("Invalid email or password");
        }
        if (!passwordEncoder.matches(password, user.getPassword())) {
            log.warn("Invalid password for user {}", email);
            throw new RuntimeException("Invalid email or password");
        }
        log.info("User {} authenticated successfully", email);
        return user;
    }

    public void registerUser(String firstName, String lastName, String email, String password, String course) {
        if (userRepository.findByEmail(email) != null) {
            log.warn("Attempted to register with existing email {}", email);
            throw new RuntimeException("Email already exists");
        }

        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setUsername(generateUniqueUsername(firstName, lastName));
        user.setXp(0);
        user.setLevel(1);
        user.setPassword(passwordEncoder.encode(password));
        user.setRole("USER");
        user.setCourse(course);

        userRepository.save(user);
        log.info("New user registered: {} (username: {})", email, user.getUsername());
    }

    public String encodePassword(String password) {
        return passwordEncoder.encode(password);
    }

    public void awardCourseCompletionXp() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated()) {
            throw new RuntimeException("No authenticated user found");
        }
        User user = userRepository.findByEmail(auth.getName());
        if (user == null) throw new RuntimeException("User not found for email: " + auth.getName());

        long newXp = user.getXp() + course_xp;
        user.setXp(newXp);
        user.setLevel(calculateLevel(newXp));
        userRepository.save(user);
    }

    public void awardAchievementXp() {
        awardXp(achievement_xp);
    }

    public void awardXp(long amount) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated()) {
            throw new RuntimeException("No authenticated user found");
        }
        User user = userRepository.findByEmail(auth.getName());
        if (user == null) throw new RuntimeException("User not found");

        long newXp = user.getXp() + amount;
        user.setXp(newXp);
        user.setLevel(calculateLevel(newXp));
        userRepository.save(user);
    }

    public int updateLoginStreak(String email) {
        User user = userRepository.findByEmail(email);
        if (user == null) throw new RuntimeException("User not found");

        LocalDate today = LocalDate.now();
        LocalDate last = user.getLastLoginDate();

        if (last == null || last.isBefore(today.minusDays(1))) {
            user.setLoginStreak(1);
        } else if (last.isEqual(today.minusDays(1))) {
            user.setLoginStreak(user.getLoginStreak() + 1);
        }

        user.setLastLoginDate(today);
        userRepository.save(user);
        return user.getLoginStreak();
    }

    private int calculateLevel(long xp) {
        return (int) (xp / level_xp) + 1;
    }

    private String generateUniqueUsername(String firstName, String lastName) {
        String base = (firstName + "." + lastName)
                .toLowerCase()
                .trim()
                .replaceAll("\\s+", "")
                .replaceAll("[^a-z0-9.]", "");

        if (base.isBlank()) base = "user";

        if (!userRepository.existsByUsername(base)) return base;

        for (int i = 2; i <= 9999; i++) {
            String possible = base + i;
            if (!userRepository.existsByUsername(possible)) return possible;
        }
        throw new RuntimeException("Could not generate unique username for " + base);
    }

    public List<String> removeFriend(List<String> friends, String username) {
        List<String> users = new ArrayList<>();
        for (String friend : friends) {
            if (!friend.equals(username)) {
                users.add(friend);
            }
        }
        return users;
    }

    public void deleteUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated()) {
            throw new RuntimeException("No authenticated user found");
        }
        String email = auth.getName();
        User user = userRepository.findByEmail(email);
        if (user == null) throw new RuntimeException("User not found for email: " + email);
        userRepository.delete(user);
    }
}