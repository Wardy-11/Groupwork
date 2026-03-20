package com.example.group01.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "First name is required")
    private String firstName;

    @NotBlank(message = "Last name is required")
    private String lastName;

    @Email(message = "Invalid email format")
    @NotBlank(message = "Email is required")
    @Column(unique = true)
    private String email;

    @Size(min = 6, message = "Password must be at least 6 characters")
    @NotBlank(message = "Password is required")
    private String password;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<Achievement> achievements;

    @Column(nullable = false, unique = true, length = 64)
    private String username;

    @Column(nullable = false)
    private long xp = 0;

    @Column(nullable = false)
    private int level = 1;

    private String role;
    private String course;

    @ElementCollection
    @CollectionTable(name = "user_friends", joinColumns = @JoinColumn(name = "user_id"))
    @Column(name = "friend_username")
    private List<String> friends;

    @Column
    private LocalDate lastLoginDate;

    @Column(nullable = false)
    private int loginStreak = 0;

    @Column
    private String equippedTitle;

    public List<String> getFriends() { return friends; }
    public void setFriends(List<String> friends) { this.friends = friends; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getCourse() { return course; }
    public void setCourse(String course) { this.course = course; }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public List<Achievement> getAchievements() { return achievements; }
    public void setAchievements(List<Achievement> achievements) { this.achievements = achievements; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public long getXp() { return xp; }
    public void setXp(long xp) { this.xp = xp; }

    public int getLevel() { return level; }
    public void setLevel(int level) { this.level = level; }

    public LocalDate getLastLoginDate() { return lastLoginDate; }
    public void setLastLoginDate(LocalDate lastLoginDate) { this.lastLoginDate = lastLoginDate; }

    public int getLoginStreak() { return loginStreak; }
    public void setLoginStreak(int loginStreak) { this.loginStreak = loginStreak; }

    public String getEquippedTitle() { return equippedTitle; }
    public void setEquippedTitle(String equippedTitle) { this.equippedTitle = equippedTitle; }
}