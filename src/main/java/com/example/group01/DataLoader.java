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
                    "Getting Started with Cybersecurity",
                    "Learn the key elements of cybersecurity, data privacy concepts, and how to evaluate security using the CIA triad model.",
                    "Beginner",
                    "3 hours",
                    "https://skillsbuild.org/college-students/course-catalog/getting-started-with-cybersecurity",
                    "Cybersecurity Fundamentals",
                    1
            ));

            courseRepository.save(new Course(
                    "Cybersecurity Fundamentals",
                    "Explore cyber threat groups, types of attacks, social engineering, cryptography, and risk management strategies.",
                    "Beginner",
                    "7.5 hours",
                    "https://skillsbuild.org/college-students/course-catalog/cybersecurity-fundamentals",
                    "Cybersecurity Fundamentals",
                    2
            ));

            courseRepository.save(new Course(
                    "Governance, Risk, Compliance, and Data Privacy",
                    "Understand how organisations manage governance frameworks, assess risk, and comply with data privacy regulations.",
                    "Beginner",
                    "8 hours",
                    "https://skillsbuild.org/college-students/course-catalog/governance-risk-compliance-and-data-privacy",
                    "Cybersecurity Fundamentals",
                    3
            ));

            courseRepository.save(new Course(
                    "System and Network Security",
                    "Gain practical skills to protect systems and infrastructure against cyber threats through network security techniques.",
                    "Intermediate",
                    "8 hours",
                    "https://skillsbuild.org/college-students/course-catalog/system-and-network-security",
                    "Network & Infrastructure Security",
                    1
            ));

            courseRepository.save(new Course(
                    "Vulnerability Management",
                    "Learn to identify, categorise, and mitigate vulnerabilities and evaluate the overall security posture of an organisation.",
                    "Intermediate",
                    "8 hours",
                    "https://skillsbuild.org/college-students/course-catalog/vulnerability-management",
                    "Network & Infrastructure Security",
                    2
            ));

            courseRepository.save(new Course(
                    "Cloud Security",
                    "Learn to safeguard data and applications in cloud environments against modern cybersecurity threats.",
                    "Intermediate",
                    "8 hours",
                    "https://skillsbuild.org/college-students/course-catalog/cloud-security",
                    "Network & Infrastructure Security",
                    3
            ));

            courseRepository.save(new Course(
                    "Security Operations and Management",
                    "Assemble security operations components, manage SOC roles, perform network reconnaissance, and monitor endpoints.",
                    "Advanced",
                    "8 hours",
                    "https://skillsbuild.org/college-students/course-catalog/security-operations-and-management",
                    "Security Operations",
                    1
            ));

            courseRepository.save(new Course(
                    "Incident Response and System Forensics",
                    "Learn to detect, respond to, and recover from security incidents using forensic tools and structured response procedures.",
                    "Advanced",
                    "8 hours",
                    "https://skillsbuild.org/college-students/course-catalog/incident-response-and-system-forensics",
                    "Security Operations",
                    2
            ));

            courseRepository.save(new Course(
                    "IBM SkillsBuild Cybersecurity Certificate",
                    "Earn a comprehensive certificate covering governance, network security, cloud security, operations management, and forensics.",
                    "Advanced",
                    "60 hours",
                    "https://skillsbuild.org/college-students/course-catalog/ibm-skillsbuild-cybersecurity-certificate",
                    "Security Operations",
                    3
            ));

            courseRepository.save(new Course(
                    "Getting Started with Data",
                    "Understand foundational data concepts including big data, the analytics process, and the data science landscape.",
                    "Beginner",
                    "3 hours",
                    "https://skillsbuild.org/college-students/course-catalog/getting-started-with-data",
                    "Data Fundamentals",
                    1
            ));

            courseRepository.save(new Course(
                    "Data Fundamentals",
                    "Learn data analytics concepts, data science methodologies, and tools used in the data ecosystem including IBM Watson Studio.",
                    "Beginner",
                    "6 hours",
                    "https://skillsbuild.org/college-students/course-catalog/data-fundamentals",
                    "Data Fundamentals",
                    2
            ));

            courseRepository.save(new Course(
                    "Data Classification",
                    "Learn how to classify data types and understand their significance in managing and securing organisational data assets.",
                    "Beginner",
                    "8 hours",
                    "https://skillsbuild.org/college-students/course-catalog/data-classification",
                    "Data Fundamentals",
                    3
            ));

            courseRepository.save(new Course(
                    "Data Usability for Organisations",
                    "Explore how organisations assess and improve data usability to make better informed business and technical decisions.",
                    "Beginner",
                    "8 hours",
                    "https://skillsbuild.org/college-students/course-catalog/data-usability-for-organizations",
                    "Data Fundamentals",
                    4
            ));

            courseRepository.save(new Course(
                    "Inferential and Descriptive Statistics",
                    "Build a foundation in statistics, covering descriptive measures and inferential techniques used in data analysis.",
                    "Intermediate",
                    "8 hours",
                    "https://skillsbuild.org/college-students/course-catalog/inferential-and-descriptive-statistics",
                    "Data Analysis",
                    1
            ));

            courseRepository.save(new Course(
                    "Data Collection and Analysis",
                    "Master the five steps of the data analysis process: preparation, collection, cleaning, analysis, and interpreting results.",
                    "Intermediate",
                    "8 hours",
                    "https://skillsbuild.org/college-students/course-catalog/data-collection-and-analysis",
                    "Data Analysis",
                    2
            ));

            courseRepository.save(new Course(
                    "Data Preparation for Analysis",
                    "Develop skills to subdivide and join datasets and determine the impact and actionability of prepared data.",
                    "Intermediate",
                    "8 hours",
                    "https://skillsbuild.org/college-students/course-catalog/data-preparation-for-analysis",
                    "Data Analysis",
                    3
            ));

            courseRepository.save(new Course(
                    "Data Visualization and Presentation",
                    "Learn to create compelling visual stories from data using charts, dashboards, and presentation techniques.",
                    "Intermediate",
                    "8 hours",
                    "https://skillsbuild.org/college-students/course-catalog/data-visualization-and-presentation",
                    "Data Analysis",
                    4
            ));

            courseRepository.save(new Course(
                    "Getting Started with Artificial Intelligence",
                    "Explore foundational AI concepts, common applications, and get hands-on with generative AI and prompt crafting.",
                    "Beginner",
                    "3 hours",
                    "https://skillsbuild.org/college-students/course-catalog/getting-started-with-artificial-intelligence",
                    "Artificial Intelligence",
                    1
            ));

            courseRepository.save(new Course(
                    "Artificial Intelligence Fundamentals",
                    "Study AI concepts including NLP, computer vision, machine learning, deep learning, neural networks, and AI ethics.",
                    "Beginner",
                    "6 hours",
                    "https://skillsbuild.org/college-students/course-catalog/artificial-intelligence-fundamentals",
                    "Artificial Intelligence",
                    2
            ));

            courseRepository.save(new Course(
                    "Getting Started with Generative AI",
                    "Discover how generative AI creates text and images, explore ethical considerations, and apply large language models like IBM Granite.",
                    "Beginner",
                    "3 hours",
                    "https://skillsbuild.org/college-students/course-catalog/getting-started-with-generative-ai",
                    "Artificial Intelligence",
                    3
            ));

            courseRepository.save(new Course(
                    "Generative AI in Action",
                    "Apply generative AI principles and Python libraries, explore prompt engineering, and examine real-world ethical considerations.",
                    "Intermediate",
                    "8 hours",
                    "https://skillsbuild.org/college-students/course-catalog/generative-ai-in-action",
                    "Artificial Intelligence",
                    4
            ));

            courseRepository.save(new Course(
                    "Supercharge Your Data Analytics with Generative AI",
                    "Learn how generative AI reshapes analytics through automation, synthetic data generation, and responsible AI use.",
                    "Intermediate",
                    "4 hours",
                    "https://skillsbuild.org/college-students/course-catalog/supercharge-your-data-analytics-with-generative-ai",
                    "Advanced AI & Machine Learning",
                    1
            ));

            courseRepository.save(new Course(
                    "Machine Learning for Data Science Projects",
                    "Apply advanced data science techniques including machine learning, deep learning, and automation tools on real-world projects.",
                    "Advanced",
                    "12 hours",
                    "https://skillsbuild.org/college-students/course-catalog/machine-learning-for-data-science-projects",
                    "Advanced AI & Machine Learning",
                    2
            ));

            courseRepository.save(new Course(
                    "Artificial Intelligence Practitioner Pathway",
                    "Prepare for AI careers through deep dives into machine learning, NLP, deep learning, data analytics, and AI ethics with hands-on labs.",
                    "Advanced",
                    "20 hours",
                    "https://skillsbuild.org/college-students/course-catalog/artificial-intelligence-practitioner-pathway",
                    "Advanced AI & Machine Learning",
                    3
            ));

            courseRepository.save(new Course(
                    "IBM SkillsBuild Data Analytics Certificate",
                    "Earn a comprehensive certificate covering data classification, statistics, collection, preparation, and visualisation for analytics careers.",
                    "Advanced",
                    "60 hours",
                    "https://skillsbuild.org/college-students/course-catalog/ibm-skillsbuild-data-analytics-certificate",
                    "Advanced AI & Machine Learning",
                    4
            ));

            System.out.println("✅ Dummy courses successfully loaded into MySQL");
        } else {
            System.out.println("✅ Database already has data. Skipping DataLoader.");
        }
    }
}