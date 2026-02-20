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

            courseRepository.save(new Course("Artificial Intelligence Fundamentals", "STARTED", "https://ibm.com/ai"));
            courseRepository.save(new Course("Python for Data Science", "AVAILABLE", "https://ibm.com/python"));
            courseRepository.save(new Course("Enterprise Design Thinking", "AVAILABLE", "https://ibm.com/design"));
            courseRepository.save(new Course("Cybersecurity Basics", "COMPLETED", "https://ibm.com/security"));
            courseRepository.save(new Course("Data Analytics Basics", "AVAILABLE", "https://ibm.com/data"));

            System.out.println("✅ Dummy courses successfully loaded into MySQL");
        } else {
            System.out.println("✅ Database already has data. Skipping DataLoader.");
        }
    }
}