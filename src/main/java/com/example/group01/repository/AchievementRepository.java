package com.example.group01.repository;

import com.example.group01.model.Achievement;
import com.example.group01.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AchievementRepository extends JpaRepository<Achievement, Long> {
    List<Achievement> findByUser(User user);
}