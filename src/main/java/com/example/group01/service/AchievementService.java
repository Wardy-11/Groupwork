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

    public boolean unlockAchievement(User user, String title) {

        if (user.getAchievements() != null) {
            boolean alreadyUnlocked = user.getAchievements().stream()
                    .anyMatch(a -> a.getTitle().equals(title));

            if (alreadyUnlocked) {
                // If they already have it, return false so the Controller knows NOT to give XP
                return false;
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

        // If we made it all the way down here, it's a brand new achievement!
        // Return true so the Controller knows to award the XP!
        return true;
    }
}