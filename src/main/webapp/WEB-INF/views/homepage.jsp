<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f7f9; }

        header {
            background-color: #005A9E;
            padding: 1rem 2rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 100%;
        }

        .brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: #fff;
            text-decoration: none;
            display: flex;
            align-items: center;
        }

        .nav-divider {
            width: 2px;
            height: 24px;
            background-color: rgba(255, 255, 255, 0.3);
            margin: 0 1.5rem;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
            flex: 1;
        }

        .nav-links a {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s, opacity 0.2s;
            padding: 0.5rem 0;
        }

        .nav-links a:hover {
            color: #e0e0e0;
            opacity: 0.9;
        }

        .logout-link {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border: 2px solid #fff;
            border-radius: 4px;
            transition: background-color 0.2s, color 0.2s;
        }

        .logout-link:hover {
            background-color: #fff;
            color: #005A9E;
        }

        main {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            min-height: calc(100vh - 80px);
        }

        .homepage-container {
            background-color: white;
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .homepage-container h1 {
            color: #005A9E;
            font-size: 2rem;
            margin-bottom: 2rem;
            border-bottom: 3px solid #005A9E;
            padding-bottom: 1rem;
        }

        .user-info h2 {
            color: #333;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .username-badge {
            background-color: #e8f0f8;
            color: #005A9E;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .user-stats {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .stat {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            padding: 1rem;
            background-color: #f4f7f9;
            border-radius: 6px;
            min-width: 200px;
        }

        .stat-label {
            font-weight: 600;
            color: #005A9E;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-value {
            font-size: 1.3rem;
            color: #333;
            font-weight: 500;
        }

        .courses-section {
            margin-top: 3rem;
        }

        .courses-section h3 {
            color: #005A9E;
            font-size: 1.3rem;
            margin-bottom: 1.5rem;
            border-bottom: 2px solid #005A9E;
            padding-bottom: 0.5rem;
        }

        .course-card {
            background-color: #fff;
            border: 1px solid #e0e0e0;
            border-radius: 6px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        .course-card h4 {
            color: #333;
            margin-bottom: 0.5rem;
            font-size: 1.1rem;
        }

        .course-card p {
            color: #666;
            font-size: 0.95rem;
            margin-bottom: 1rem;
        }

        .course-buttons {
            display: flex;
            gap: 1rem;
        }

        .btn-resume {
            display: inline-block;
            background-color: #005A9E;
            color: white;
            padding: 0.6rem 1.2rem;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: background-color 0.2s;
        }

        .btn-resume:hover {
            background-color: #004a87;
        }

        .empty-message {
            color: #999;
            font-style: italic;
            padding: 1rem;
        }
    </style>
</head>
<body>
<header>
    <div class="header-container">
        <a href="<c:url value='/homepage' />" class="brand">IBM SkillsBuild</a>
        <div class="nav-divider"></div>
        <nav class="nav-links">
            <a href="<c:url value='/homepage' />">Home</a>
            <a href="<c:url value='/profile' />">Profile</a>
            <a href="<c:url value='/dashboard' />">Courses</a>
            <a href="<c:url value='/leaderboard' />">Leaderboard</a>
            <a href="<c:url value='/friends' />">Friends</a>
        </nav>
        <a href="<c:url value='/logout' />" class="logout-link">Logout</a>
    </div>
</header>

<main>
    <div class="homepage-container">
        <h1>Homepage</h1>
        <div class="user-info">
            <h2>
                Welcome, <c:out value="${user.firstName} ${user.lastName}" />!
                <span class="username-badge">@<c:out value="${user.username}" /></span>
            </h2>
            <div class="user-stats">
                <div class="stat">
                    <span class="stat-label">Level:</span>
                    <span class="stat-value"><c:out value="${user.level}" /></span>
                </div>
                <div class="stat">
                    <span class="stat-label">Streak:</span>
                    <span class="stat-value"><c:out value="${streak}" /> &#128293;</span>
                </div>
            </div>
        </div>

        <div class="courses-section">
            <h3>Continue Your Learning</h3>
            <c:if test="${empty startedCourses}">
                <p class="empty-message">You haven't started any courses yet. Start one from the Courses section!</p>
            </c:if>
            <c:forEach items="${startedCourses}" var="course">
                <div class="course-card">
                    <h4><c:out value="${course.title}" /></h4>
                    <p>Status: <span style="color: #107C10; font-weight: bold;">In Progress</span></p>
                    <div class="course-buttons">
                        <a href="<c:out value="${course.url}" />" target="_blank" class="btn-resume">Continue Course</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</main>

</body>
</html>
