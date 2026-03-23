package com.example.group01.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;

@Entity
@Table(name="comments",
uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "course_id"}))
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(length=1000)
    private String commentText;

    @Column(nullable=false)
    @Min(0)
    @Max(5)
    private int rating;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;

    public Comment() {}

    public Comment(String commentText, int rating, User user, Course course) {
        this.commentText = commentText;
        this.rating = rating;
        this.user = user;
        this.course = course;
    }

    public long getId() {
        return id;
    }
    public String getCommentText(){
        return commentText;
    }

    public void setCommentText(String commentText){
        this.commentText = commentText;
    }
    public int getRating(){
        return rating;
    }
    public void setRating(int rating){
        this.rating = rating;
    }
    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }
    public Course getCourse() {
        return course;
    }
    public void setCourse(Course course) {
        this.course = course;
    }

}
