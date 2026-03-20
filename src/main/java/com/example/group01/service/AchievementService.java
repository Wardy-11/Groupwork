package com.example.group01.service;

import com.example.group01.model.Achievement;
import com.example.group01.model.User;
import com.example.group01.repository.AchievementRepository;
import com.example.group01.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class AchievementService {

    @Autowired
    private AchievementRepository achievementRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserService userService;

    public static final Map<String, AchievementDefinition> ALL_ACHIEVEMENTS = new LinkedHashMap<>();

    static {
        ALL_ACHIEVEMENTS.put("First Login",
                new AchievementDefinition("First Login", "Log in to IBM SkillsBuild for the first time.", 25));
        ALL_ACHIEVEMENTS.put("On a Roll",
                new AchievementDefinition("On a Roll", "Log in 3 days in a row.", 50));
        ALL_ACHIEVEMENTS.put("Streak Starter",
                new AchievementDefinition("Streak Starter", "Log in 5 days in a row.", 100));
        ALL_ACHIEVEMENTS.put("Committed Learner",
                new AchievementDefinition("Committed Learner", "Log in 10 days in a row.", 200));
        ALL_ACHIEVEMENTS.put("Unstoppable",
                new AchievementDefinition("Unstoppable", "Log in 25 days in a row.", 400));
        ALL_ACHIEVEMENTS.put("Legend",
                new AchievementDefinition("Legend", "Log in 50 days in a row.", 750));
        ALL_ACHIEVEMENTS.put("Course Master (3 Courses)",
                new AchievementDefinition("Course Master (3 Courses)", "Complete 3 IBM SkillsBuild courses.", 150));
    }

    public boolean unlockAchievement(User user, String title) {
        if (user.getAchievements() != null) {
            boolean alreadyUnlocked = user.getAchievements().stream()
                    .anyMatch(a -> a.getTitle().equals(title));
            if (alreadyUnlocked) return false;
        }

        AchievementDefinition def = ALL_ACHIEVEMENTS.get(title);
        String description = def != null ? def.getDescription() : "Achievement unlocked: " + title;
        long xpReward = def != null ? def.getXpReward() : 50;

        Achievement achievement = new Achievement();
        achievement.setTitle(title);
        achievement.setDescription(description);
        achievement.setUser(user);
        achievementRepository.save(achievement);

        if (user.getAchievements() != null) {
            user.getAchievements().add(achievement);
        }
        userRepository.save(user);

        userService.awardXp(xpReward);

        return true;
    }

    public void checkStreakAchievements(User user, int streak) {
        if (streak >= 3)  unlockAchievement(user, "On a Roll");
        if (streak >= 5)  unlockAchievement(user, "Streak Starter");
        if (streak >= 10) unlockAchievement(user, "Committed Learner");
        if (streak >= 25) unlockAchievement(user, "Unstoppable");
        if (streak >= 50) unlockAchievement(user, "Legend");
    }

    public static class AchievementDefinition {
        private final String title;
        private final String description;
        private final long xpReward;

        public AchievementDefinition(String title, String description, long xpReward) {
            this.title = title;
            this.description = description;
            this.xpReward = xpReward;
        }

        public String getTitle() { return title; }
        public String getDescription() { return description; }
        public long getXpReward() { return xpReward; }
    }
}