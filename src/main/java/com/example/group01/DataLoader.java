package com.example.group01;

import com.example.group01.model.Course;
import com.example.group01.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataLoader implements CommandLineRunner {

    @Autowired
    private CourseRepository courseRepository;

    @Override
    public void run(String... args) throws Exception {

        if (courseRepository.count() == 0) {

            courseRepository.save(new Course(
                    "Artificial Intelligence Fundamentals",
                    "Learn AI basics",
                    "Beginner",
                    "10 hours",
                    "https://ibm.com/ai"
            ));

            courseRepository.save(new Course(
                    "Python for Data Science",
                    "Learn Python for data analysis",
                    "Beginner",
                    "12 hours",
                    "https://ibm.com/python"
            ));

            courseRepository.save(new Course(
                    "Enterprise Design Thinking",
                    "Learn IBM’s design thinking approach",
                    "Beginner",
                    "8 hours",
                    "https://ibm.com/design"
            ));

            courseRepository.save(new Course(
                    "Cybersecurity Basics",
                    "Understand core cybersecurity concepts",
                    "Beginner",
                    "9 hours",
                    "https://ibm.com/security"
            ));

            courseRepository.save(new Course(
                    "Data Analytics Basics",
                    "Introduction to data analytics",
                    "Beginner",
                    "11 hours",
                    "https://ibm.com/data"
            ));

            System.out.println("✅ Dummy courses successfully loaded into MySQL");
        } else {
            System.out.println("✅ Database already has data. Skipping DataLoader.");
        }
    }
}