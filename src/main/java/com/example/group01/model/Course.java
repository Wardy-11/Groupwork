package com.example.group01.model;

import jakarta.persistence.*;

@Entity
@Table(name = "courses")
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String status;
    private String link;

    public Course() {}

    public Course(String title, String status, String link) {
        this.title = title;
        this.status = status;
        this.link = link;
    }

    public Long getId() { return id; }
    public String getTitle() { return title; }
    public String getStatus() { return status; }
    public String getLink() { return link; }

    public void setStatus(String status) { this.status = status; }
}