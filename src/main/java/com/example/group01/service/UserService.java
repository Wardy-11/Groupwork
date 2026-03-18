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

import java.util.ArrayList;
import java.util.List;

/**
 * Business operations related to {@link User} entities such as
 * registration and credential validation.
 */
@Service
public class UserService {

    private static final Logger log = LoggerFactory.getLogger(UserService.class);

    private static final long course_xp = 75;
    private static final long level_xp = 100;
    private static final long achievement_xp = 50;

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserService(UserRepository userRepository,
                       PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    /**
     * Validates provided credentials and returns the matching user.
     *
     * @param email    email address supplied by the user
     * @param password raw password supplied by the user
     * @return the authenticated {@link User}
     * @throws RuntimeException if no user is found or password does not match
     */
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


    /**
     * Register a new user account with the provided details.
     *
     * @param firstName first name of the student
     * @param lastName  last name of the student
     * @param email     unique email address
     * @param password  plain text password (will be encoded)
     * @param course    course enrolled in
     * @throws RuntimeException if the email address is already taken
     */
    public void registerUser(String firstName,
                             String lastName,
                             String email,
                             String password,
                             String course) {

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

        // encode the plain password before saving
        user.setPassword(passwordEncoder.encode(password));

        user.setRole("USER");
        user.setCourse(course);

        userRepository.save(user);
        log.info("New user registered: {} (username: {})", email, user.getUsername());
    }

    public String encodePassword(String password){
        return passwordEncoder.encode(password);
    }


    public void awardCourseCompletionXp() {

        Authentication auth = SecurityContextHolder
                .getContext()
                .getAuthentication();

        if (auth == null || !auth.isAuthenticated()) {
            throw new RuntimeException("No authenticated user found");
        }

        String email = auth.getName(); // this is your logged-in identifier

        User user = userRepository.findByEmail(email);
        if (user == null) {
            throw new RuntimeException("User not found for email: " + email);
        }

        long newXp = user.getXp() + course_xp;
        user.setXp(newXp);
        user.setLevel(calculateLevel(newXp));

        userRepository.save(user);

    }

    public void awardAchievementXp() {

        Authentication auth = SecurityContextHolder
                .getContext()
                .getAuthentication();

        if (auth == null || !auth.isAuthenticated()) {
            throw new RuntimeException("No authenticated user found");
        }

        String email = auth.getName(); // this is your logged-in identifier

        User user = userRepository.findByEmail(email);
        if (user == null) {
            throw new RuntimeException("User not found for email: " + email);
        }

        long newXp = user.getXp() + achievement_xp;
        user.setXp(newXp);
        user.setLevel(calculateLevel(newXp));

        userRepository.save(user);

    }


    private int calculateLevel(long xp) {
        return (int) (xp / level_xp) + 1;
    }

    private String generateUniqueUsername(String firstName, String lastName) {
        String base = (firstName + "." + lastName)
                .toLowerCase()
                .trim()
                .replaceAll("\\s+", "")          // remove spaces
                .replaceAll("[^a-z0-9.]", "");   // remove symbols

        if (base.isBlank()) base = "user";

        if (!userRepository.existsByUsername(base)) {
            return base;
        }

        for (int i = 2; i <= 9999; i++) {
            String possible = base + i;
            if (!userRepository.existsByUsername(possible)) {
                return possible;
            }
        }
        throw new RuntimeException("Could not generate unique username for " + base);
    }

    public List<String> removeFriend(List<String> friends, String username) {
        List<String> users = new ArrayList<>();
        for (String friend : friends) {
            if (!friend.equals(username)){
                users.add(friend);
            }
        }
        return users;
    }

    public void deleteUser() {
        Authentication auth = SecurityContextHolder
                .getContext()
                .getAuthentication();

        if (auth == null || !auth.isAuthenticated()) {
            throw new RuntimeException("No authenticated user found");
        }

        String email = auth.getName();

        User user = userRepository.findByEmail(email);
        if (user == null) {
            throw new RuntimeException("User not found for email: " + email);
        }

        userRepository.delete(user);

    }
}