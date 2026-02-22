package com.example.group01.model;

import jakarta.persistence.*;

@Entity
@Table(name = "courses")
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String description;
    private String level;
    private String duration;
    private String url;
    private String status;

    public Course() {}

    public Course(String title, String description, String level, String duration, String url, String status) {
        this.title = title;
        this.description = description;
        this.level = level;
        this.duration = duration;
        this.url = url;
        this.status = status;
    }

    public Long getId() { return id; }
    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public String getLevel() { return level; }
    public String getDuration() { return duration; }
    public String getUrl() { return url; }
    public String getStatus() { return status; }

    public void setStatus(String status) { this.status = status; }
}