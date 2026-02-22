package com.example.group01.service;

import com.example.group01.model.Achievement;
import com.example.group01.model.User;
import com.example.group01.repository.AchievementRepository;
import com.example.group01.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AchievementService {

    @Autowired
    private AchievementRepository achievementRepository;

    @Autowired
    private UserRepository userRepository;

    public void unlockAchievement(User user, String title) {

        if (user.getAchievements() != null) {
            boolean alreadyUnlocked = user.getAchievements().stream()
                    .anyMatch(a -> a.getTitle().equals(title));

            if (alreadyUnlocked) {
                return;
            }
        }

        Achievement achievement = new Achievement();
        achievement.setTitle(title);
        achievement.setDescription("Achievement unlocked: " + title);
        achievement.setUser(user);

        achievementRepository.save(achievement);

        if (user.getAchievements() != null) {
            user.getAchievements().add(achievement);
        }

        userRepository.save(user);
    }
}