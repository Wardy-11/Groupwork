<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SkillsBuild Dashboard</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 2rem; background-color: #f4f7f9; }
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

<h1>Track your SkillsBuild Progress</h1>

<form action="/dashboard" method="get">
    <input type="text" name="keyword" class="search-box" placeholder="Search courses (e.g., 'Python')" value="${param.keyword}" />
    <button type="submit" class="btn btn-blue">Search</button>
    <c:if test="${not empty param.keyword}">
        <a href="/dashboard" style="margin-left:10px; color:#666; font-size:0.9rem;">Clear Search</a>
    </c:if>
</form>

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