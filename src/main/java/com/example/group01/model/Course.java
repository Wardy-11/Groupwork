package com.example.group01.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Course {

    @Id
    private String id;

    private String title;
    private String description;
    private String level;
    private String duration;
    private String url;

    public Course() {
    }

    public Course(String id, String title, String description,
                  String level, String duration, String url) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.level = level;
        this.duration = duration;
        this.url = url;
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}