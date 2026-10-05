Group 01 - Learning & Social Platform
A full-stack Java web application built with Spring Boot and JSP. This platform allows users to register, manage their profiles, enroll in courses, earn achievements, and interact with other users through friends lists and comments.   

Tech Stack
Backend: Java, Spring Boot (MVC Architecture)   

Frontend: JSP (JavaServer Pages)   

Build Tool: Gradle   

Security: Spring Security   

Key Features
Based on the project's architecture, this application includes the following core functionalities:

User Authentication: Secure login and registration system (AuthController, SecurityConfig).   

User Profiles & Dashboard: Personalized dashboards and profile management for users (DashboardController, profile.jsp).   

Course Management: Browse and enroll in various courses (CourseController, UserCourse).   

Social Features: Add friends, view all users, and interact via comments (CommentController, friends.jsp).   

Gamification: Track progress through a Leaderboard and unlock Achievements (AchievementService, leaderboard.jsp).   

Project Structure
├── src/main/java/com/example/group01/
│   ├── configuration/   # Security configurations (SecurityConfig)
│   ├── controller/      # Handles HTTP requests (Auth, Course, Dashboard, etc.)
│   ├── model/           # Database entities (User, Course, Comment, Achievement)
│   ├── repository/      # Data access interfaces
│   └── service/         # Business logic layer
├── src/main/webapp/WEB-INF/views/ # JSP templates (Frontend)
│   ├── login.jsp, register.jsp
│   ├── dashboard.jsp, profile.jsp
│   ├── courses.jsp, leaderboard.jsp
│   └── comments.jsp, friends.jsp
├── User Manual/         # Contains user documentation and screenshots
├── Scrum Board Screen Shots/ # Agile tracking and sprint history
└── build.gradle         # Gradle dependencies and build configuration
   
Getting Started
Prerequisites
Java Development Kit (JDK): Ensure you have a compatible Java version installed to run a Spring Boot application.

Gradle: The project uses the Gradle wrapper, so a local Gradle installation is optional.

Installation & Running Locally
Clone the repository:

Bash
git clone <your-repository-url>
cd Groupwork-main
Build the project:
Use the included Gradle wrapper to build the application.

Bash
# On Windows
gradlew.bat build

# On Mac/Linux
./gradlew build
Run the application:

Bash
# On Windows
gradlew.bat bootRun

# On Mac/Linux
./gradlew bootRun
Access the application:
Open your web browser and navigate to the local server port (typically http://localhost:8080).


👥 Team
atm27 Tomass

fs262 Filip

jt468 Josh

jw990 Jack (ME)

kfc15 Kyle
