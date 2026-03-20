package com.example.group01.service;

import com.example.group01.model.User;
import com.example.group01.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class TitleService {

    @Autowired
    private UserRepository userRepository;

    public static final Map<String, TitleDefinition> ALL_TITLES = new LinkedHashMap<>();

    static {
        ALL_TITLES.put("Newcomer",
                new TitleDefinition("Newcomer", "#6c757d", "Default title for all users.", null));
        ALL_TITLES.put("On a Roll",
                new TitleDefinition("On a Roll", "#17a2b8", "Awarded for a 3-day login streak.", "On a Roll"));
        ALL_TITLES.put("Streak Starter",
                new TitleDefinition("Streak Starter", "#007bff", "Awarded for a 5-day login streak.", "Streak Starter"));
        ALL_TITLES.put("Committed Learner",
                new TitleDefinition("Committed Learner", "#6f42c1", "Awarded for a 10-day login streak.", "Committed Learner"));
        ALL_TITLES.put("Unstoppable",
                new TitleDefinition("Unstoppable", "#fd7e14", "Awarded for a 25-day login streak.", "Unstoppable"));
        ALL_TITLES.put("Legend",
                new TitleDefinition("Legend", "#ffc107", "Awarded for a 50-day login streak.", "Legend"));
        ALL_TITLES.put("Course Master",
                new TitleDefinition("Course Master", "#28a745", "Awarded for completing 3 courses.", "Course Master (3 Courses)"));
    }

    public List<TitleDefinition> getUnlockedTitles(User user) {
        List<TitleDefinition> unlocked = new ArrayList<>();
        unlocked.add(ALL_TITLES.get("Newcomer"));

        if (user.getAchievements() == null) return unlocked;

        for (TitleDefinition def : ALL_TITLES.values()) {
            if (def.getRequiredAchievement() == null) continue;
            boolean hasAchievement = user.getAchievements().stream()
                    .anyMatch(a -> a.getTitle().equals(def.getRequiredAchievement()));
            if (hasAchievement) {
                unlocked.add(def);
            }
        }
        return unlocked;
    }

    public boolean equipTitle(User user, String titleName) {
        List<TitleDefinition> unlocked = getUnlockedTitles(user);
        boolean canEquip = unlocked.stream().anyMatch(t -> t.getName().equals(titleName));
        if (!canEquip) return false;
        user.setEquippedTitle(titleName);
        userRepository.save(user);
        return true;
    }

    public TitleDefinition getEquippedTitleDefinition(User user) {
        String equipped = user.getEquippedTitle();
        if (equipped == null || !ALL_TITLES.containsKey(equipped)) {
            return ALL_TITLES.get("Newcomer");
        }
        return ALL_TITLES.get(equipped);
    }

    public static class TitleDefinition {
        private final String name;
        private final String colour;
        private final String description;
        private final String requiredAchievement;

        public TitleDefinition(String name, String colour, String description, String requiredAchievement) {
            this.name = name;
            this.colour = colour;
            this.description = description;
            this.requiredAchievement = requiredAchievement;
        }

        public String getName() { return name; }
        public String getColour() { return colour; }
        public String getDescription() { return description; }
        public String getRequiredAchievement() { return requiredAchievement; }
    }
}