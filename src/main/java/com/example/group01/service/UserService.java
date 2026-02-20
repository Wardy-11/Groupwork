package com.example.group01.service;

import com.example.group01.model.User;
import com.example.group01.repo.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

/**
 * Business operations related to {@link User} entities such as
 * registration and credential validation.
 */
@Service
public class UserService {

    private static final Logger log = LoggerFactory.getLogger(UserService.class);

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

        // encode the plain password before saving
        user.setPassword(passwordEncoder.encode(password));

        user.setRole("USER");
        user.setCourse(course);

        userRepository.save(user);
        log.info("New user registered: {}", email);
    }
}