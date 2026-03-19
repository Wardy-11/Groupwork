package com.example.group01.model;

import jakarta.persistence.*;

@Entity
@Table(name = "user_courses",
        uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "course_id"}))
public class UserCourse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "course_id", nullable = false)
    private Course course;

    @Column(nullable = false)
    private String status;

    public UserCourse() {}

    public UserCourse(User user, Course course, String status) {
        this.user = user;
        this.course = course;
        this.status = status;
    }

    public Long getId() { return id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Course getCourse() { return course; }
    public void setCourse(Course course) { this.course = course; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}