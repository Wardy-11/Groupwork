<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SkillsBuild Dashboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f9; }
        
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

        main { padding: 2rem; }
        h1 { color: #333; }

        .course-card {
            background: white;
            border: 1px solid #ddd;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .button-group { display: flex; gap: 10px; align-items: center; margin-top: 15px; }

        .search-box { padding: 10px; width: 300px; border: 1px solid #ccc; border-radius: 4px; }

        .btn { padding: 8px 15px; text-decoration: none; border-radius: 4px; color: white; border: none; cursor: pointer; font-size: 14px; font-weight: 600; }
        .btn-blue { background-color: #005A9E; }
        .btn-blue:hover { background-color: #004a87; }
        .btn-green { background-color: #107C10; }
        .btn-green:hover { background-color: #0d660d; }

        hr { border: 0; border-top: 1px solid #eee; margin: 40px 0; }
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

<h1>Track your SkillsBuild Progress</h1>


<c:if test="${!hasCourseMaster}">
    <div class="course-card" style="background-color: #e6f2ff; border-color: #b3d9ff; text-align: center; margin-top: 20px;">
        <h2 style="color: #005A9E; margin-bottom: 10px;">🏆 Current Goal: Complete 3 Courses</h2>

        <p style="font-size: 1.2rem; color: #333;">Progress: <strong>${completedCourseCount >= 3 ? 3 : completedCourseCount} / 3</strong></p>

        <div style="width: 100%; background-color: #ddd; border-radius: 5px; margin-top: 15px; overflow: hidden;">
            <div style="width: ${completedCourseCount >= 3 ? 100 : (completedCourseCount / 3.0) * 100}%;
                    height: 20px; background-color: #107C10; border-radius: 5px; transition: width 0.5s ease-in-out;"></div>
        </div>

        <c:if test="${completedCourseCount >= 3}">
            <form action="<c:url value='/unlock-achievement' />" method="post" style="margin-top: 15px;">
                <input type="hidden" name="achievementTitle" value="Course Master (3 Courses)">
                <button type="submit" class="btn btn-green" style="font-size: 1.1rem; padding: 10px 20px;">Claim Level Up!</button>
            </form>
        </c:if>
    </div>
</c:if>

<c:if test="${hasCourseMaster}">
    <div class="course-card" style="background-color: #e8f5e9; border-color: #c8e6c9; text-align: center; margin-top: 20px;">
        <h2 style="color: #2e7d32; margin-bottom: 0;">🎉 Goal Achieved: Course Master!</h2>
        <p style="color: #666; margin-top: 5px;">Check your profile to see your rewards.</p>
    </div>
</c:if>

<hr/>

<h2>Started Courses</h2>
<c:if test="${empty startedCourses}">
    <p>No courses currently in progress.</p>
</c:if>
<c:forEach items="${startedCourses}" var="course">
    <div class="course-card">
        <h3>${course.title}</h3>
        <p>Status: <span style="color: #107C10; font-weight: bold;">${course.status}</span></p>

        <div class="button-group">
            <a href="${course.url}" target="_blank" class="btn btn-blue">Resume Course</a>

            <form action="/complete-course" method="post" style="margin: 0;">
                <input type="hidden" name="courseId" value="${course.id}">
                <button type="submit" class="btn btn-green">Mark as Complete</button>
            </form>
        </div>
    </div>
</c:forEach>

<h2>Available Courses</h2>
<c:if test="${empty availableCourses}">
    <p>No available courses found.</p>
</c:if>
<c:forEach items="${availableCourses}" var="course">
    <div class="course-card">
        <h3>${course.title}</h3>
        <p>Explore this IBM SkillsBuild course.</p>

        <div class="button-group">
            <a href="${course.url}" target="_blank" class="btn btn-blue">View Details</a>

            <form action="/start-course" method="post" style="margin: 0;">
                <input type="hidden" name="courseId" value="${course.id}">
                <button type="submit" class="btn btn-green">Start Course</button>
            </form>
        </div>
    </div>
</c:forEach>

<hr/>

<h2 style="color: #666;">Completed Courses</h2>
<c:if test="${empty completedCourses}">
    <p>You haven't completed any courses yet. Keep going!</p>
</c:if>

<c:forEach items="${completedCourses}" var="course">
    <div class="course-card" style="background-color: #f9f9f9; border-color: #eee;">
        <h3 style="color: #888;">${course.title} (Completed ✅)</h3>
        <div class="button-group">
            <a href="${course.url}" target="_blank" class="btn btn-blue" style="background-color: #666;">Review Material</a>
        </div>
    </div>
</c:forEach>

</body>
</html>