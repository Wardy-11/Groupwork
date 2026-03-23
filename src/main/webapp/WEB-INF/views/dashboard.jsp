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

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f9;
            color: #333;
        }

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

        .page-shell {
            max-width: 1200px;
            margin: 2rem auto 3rem auto;
            padding: 0 1.5rem;
        }

        .hero {
            background: linear-gradient(135deg, #005A9E 0%, #0a6bb4 100%);
            color: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 10px 24px rgba(0, 90, 158, 0.12);
            margin-bottom: 1.5rem;
        }

        .hero h1 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .hero p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1rem;
            line-height: 1.5;
            max-width: 700px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 1rem;
            margin: 1.5rem 0 0 0;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.14);
            border: 1px solid rgba(255, 255, 255, 0.18);
            border-radius: 10px;
            padding: 1rem 1.1rem;
            backdrop-filter: blur(2px);
        }

        .stat-label {
            font-size: 0.85rem;
            opacity: 0.9;
            margin-bottom: 0.35rem;
        }

        .stat-value {
            font-size: 1.7rem;
            font-weight: 700;
        }

        .goal-card,
        .goal-card-complete,
        .section-card {
            background: white;
            border: 1px solid #dbe3ea;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.05);
        }

        .goal-card,
        .goal-card-complete {
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .goal-card {
            background: linear-gradient(180deg, #eef6ff 0%, #ffffff 100%);
            border-color: #cfe2f5;
        }

        .goal-card-complete {
            background: linear-gradient(180deg, #eefaf0 0%, #ffffff 100%);
            border-color: #cfe9d2;
        }

        .goal-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 1rem;
            flex-wrap: wrap;
            margin-bottom: 1rem;
        }

        .goal-title {
            font-size: 1.35rem;
            font-weight: 700;
            color: #005A9E;
        }

        .goal-card-complete .goal-title {
            color: #107C10;
        }

        .goal-subtitle {
            color: #56616b;
            margin-top: 0.35rem;
            line-height: 1.5;
        }

        .goal-progress-text {
            font-size: 1rem;
            font-weight: 600;
            color: #333;
            white-space: nowrap;
        }

        .progress-bar-wrap {
            width: 100%;
            height: 16px;
            background: #dfe6ec;
            border-radius: 999px;
            overflow: hidden;
            margin: 1rem 0 1.25rem 0;
        }

        .progress-bar-fill {
            height: 100%;
            background: linear-gradient(90deg, #107C10 0%, #1fa51f 100%);
            border-radius: 999px;
            transition: width 0.5s ease-in-out;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 16px;
            text-decoration: none;
            border-radius: 6px;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: transform 0.15s ease, box-shadow 0.15s ease, background-color 0.2s ease;
        }

        .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        }

        .btn-blue {
            background-color: #005A9E;
        }

        .btn-blue:hover {
            background-color: #004a87;
        }

        .btn-green {
            background-color: #107C10;
        }

        .btn-green:hover {
            background-color: #0d660d;
        }

        .btn-muted {
            background-color: #6b7280;
        }

        .btn-muted:hover {
            background-color: #555c67;
        }

        .section-card {
            overflow: hidden;
            margin-bottom: 1.5rem;
        }

        .section-header {
            padding: 1.25rem 1.4rem;
            border-bottom: 1px solid #e8edf2;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
            background: #fff;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #222;
        }

        .section-subtitle {
            font-size: 0.92rem;
            color: #6a7680;
            margin-top: 0.2rem;
        }

        .section-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 34px;
            height: 34px;
            padding: 0 12px;
            border-radius: 999px;
            background: #eef4fb;
            color: #005A9E;
            font-weight: 700;
            font-size: 0.9rem;
        }

        .section-body {
            padding: 1rem 1.2rem 1.2rem 1.2rem;
        }

        .empty-state {
            padding: 1rem;
            border: 1px dashed #ccd6df;
            border-radius: 10px;
            color: #6b7280;
            background: #fafcfe;
        }

        .path-group {
            border: 1px solid #e3e9ef;
            border-radius: 10px;
            background: #fcfdff;
            overflow: hidden;
            margin-bottom: 1rem;
        }

        .path-header {
            width: 100%;
            border: none;
            background: #f2f6fa;
            padding: 1rem 1.1rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            text-align: left;
            transition: background-color 0.2s ease;
        }

        .path-header:hover {
            background: #e9f0f7;
        }

        .path-left {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .path-name {
            font-size: 1rem;
            font-weight: 700;
            color: #24313d;
        }

        .path-meta {
            font-size: 0.85rem;
            color: #6b7280;
        }

        .path-arrow {
            font-size: 1.1rem;
            color: #005A9E;
            transition: transform 0.3s ease;
            flex-shrink: 0;
        }

        .path-header.open .path-arrow {
            transform: rotate(180deg);
        }

        .path-content {
            display: grid;
            grid-template-rows: 0fr;
            transition: grid-template-rows 0.35s ease;
        }

        .path-content.active {
            grid-template-rows: 1fr;
        }

        .path-content-inner {
            overflow: hidden;
        }

        .path-courses {
            padding: 1rem;
            display: grid;
            gap: 1rem;
        }

        .course-card {
            background: white;
            border: 1px solid #dfe7ee;
            border-radius: 12px;
            padding: 1.1rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            transition: transform 0.15s ease, box-shadow 0.15s ease, border-color 0.2s ease;
        }

        .course-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(0,0,0,0.06);
            border-color: #cfdceb;
        }

        .course-card.started {
            border-left: 5px solid #005A9E;
        }

        .course-card.available {
            border-left: 5px solid #107C10;
        }

        .course-card.completed {
            background: #fafafa;
            border-left: 5px solid #8b949e;
        }

        .course-top {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            align-items: flex-start;
            flex-wrap: wrap;
            margin-bottom: 0.6rem;
        }

        .course-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #1f2933;
        }

        .status-badge {
            font-size: 0.78rem;
            font-weight: 700;
            padding: 0.35rem 0.7rem;
            border-radius: 999px;
            white-space: nowrap;
        }

        .status-started {
            background: #e8f1fb;
            color: #005A9E;
        }

        .status-available {
            background: #eaf7ea;
            color: #107C10;
        }

        .status-completed {
            background: #eceff3;
            color: #5f6b76;
        }

        .course-description {
            color: #56616b;
            line-height: 1.55;
            margin-bottom: 0.9rem;
        }

        .course-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 0.55rem;
            margin-bottom: 1rem;
        }

        .meta-pill {
            font-size: 0.82rem;
            color: #44515d;
            background: #f3f6f9;
            border: 1px solid #e2e8ef;
            border-radius: 999px;
            padding: 0.35rem 0.7rem;
        }

        .button-group {
            display: flex;
            gap: 0.75rem;
            align-items: center;
            flex-wrap: wrap;
            margin-top: 0.25rem;
        }

        form {
            margin: 0;
        }

        @media (max-width: 768px) {
            header {
                padding: 1rem;
            }

            .header-container {
                gap: 1rem;
                flex-wrap: wrap;
            }

            .nav-links {
                gap: 1rem;
                flex-wrap: wrap;
            }

            .page-shell {
                padding: 0 1rem;
            }

            .hero {
                padding: 1.5rem;
            }

            .hero h1 {
                font-size: 1.6rem;
            }

            .section-header,
            .goal-header,
            .course-top {
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>

<c:set var="startedCourseCount" value="0" />
<c:forEach var="pathEntry" items="${startedCoursesByPath}">
    <c:set var="startedCourseCount" value="${startedCourseCount + pathEntry.value.size()}" />
</c:forEach>

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

<div class="page-shell">
    <section class="hero">
        <h1>Track your SkillsBuild progress</h1>
        <p>Manage your learning journey, continue active courses, discover new ones, and look back at everything you have already completed.</p>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-label">Started</div>
                <div class="stat-value">${startedCourseCount}</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Completed</div>
                <div class="stat-value">${completedCourseCount}</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Goal Target</div>
                <div class="stat-value">3</div>
            </div>
        </div>
    </section>

    <c:if test="${!hasCourseMaster}">
        <section class="goal-card">
            <div class="goal-header">
                <div>
                    <div class="goal-title">🏆 Current Goal: Complete 3 Courses</div>
                    <div class="goal-subtitle">Finish three courses to unlock the Course Master achievement and level up.</div>
                </div>
                <div class="goal-progress-text">
                        ${completedCourseCount >= 3 ? 3 : completedCourseCount} / 3 complete
                </div>
            </div>

            <div class="progress-bar-wrap">
                <div class="progress-bar-fill"
                     style="width: ${completedCourseCount >= 3 ? 100 : (completedCourseCount / 3.0) * 100}%;">
                </div>
            </div>

            <c:if test="${completedCourseCount >= 3}">
                <form action="<c:url value='/unlock-achievement' />" method="post">
                    <input type="hidden" name="achievementTitle" value="Course Master (3 Courses)">
                    <button type="submit" class="btn btn-green">Claim Level Up!</button>
                </form>
            </c:if>
        </section>
    </c:if>

    <c:if test="${hasCourseMaster}">
        <section class="goal-card-complete">
            <div class="goal-title">🎉 Goal Achieved: Course Master!</div>
            <div class="goal-subtitle">You have completed the milestone. Check your profile to view your rewards.</div>
        </section>
    </c:if>

    <section class="section-card">
        <div class="section-header">
            <div>
                <div class="section-title">Started Courses</div>
                <div class="section-subtitle">Pick up where you left off.</div>
            </div>
            <div class="section-badge">${startedCourseCount}</div>
        </div>

        <div class="section-body">
            <c:if test="${empty startedCoursesByPath}">
                <div class="empty-state">No courses are currently in progress.</div>
            </c:if>

            <c:forEach var="pathEntry" items="${startedCoursesByPath}" varStatus="status">
                <div class="path-group">
                    <button type="button"
                            class="path-header open"
                            onclick="togglePath('started-${status.index}', this)">
                        <div class="path-left">
                            <span class="path-name">${pathEntry.key}</span>
                            <span class="path-meta">${pathEntry.value.size()} course(s) in progress</span>
                        </div>
                        <span class="path-arrow">⌄</span>
                    </button>

                    <div id="started-${status.index}" class="path-content active">
                        <div class="path-content-inner">
                            <div class="path-courses">
                                <c:forEach var="course" items="${pathEntry.value}">
                                    <div class="course-card started">
                                        <div class="course-top">
                                            <div class="course-title">${course.title}</div>
                                            <span class="status-badge status-started">STARTED</span>
                                        </div>

                                        <p class="course-description">${course.description}</p>

                                        <div class="course-meta">
                                            <span class="meta-pill">Learning Path Step: ${course.pathOrder}</span>
                                        </div>

                                        <div class="button-group">
                                            <a href="${course.url}" target="_blank" class="btn btn-blue">Resume Course</a>
                                            <form action="${pageContext.request.contextPath}/complete-course" method="post">
                                                <input type="hidden" name="courseId" value="${course.id}">
                                                <button type="submit" class="btn btn-green">Mark as Complete</button>
                                                <a href="${pageContext.request.contextPath}/comments/comments-page?courseId=${course.id}" class="btn btn-blue">View Comments</a>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <section class="section-card">
        <div class="section-header">
            <div>
                <div class="section-title">Available Courses</div>
                <div class="section-subtitle">Explore more learning paths and start something new.</div>
            </div>
        </div>

        <div class="section-body">
            <c:if test="${empty availableCoursesByPath}">
                <div class="empty-state">No available courses found.</div>
            </c:if>

            <c:forEach var="pathEntry" items="${availableCoursesByPath}" varStatus="status">
                <div class="path-group">
                    <button type="button"
                            class="path-header"
                            onclick="togglePath('available-${status.index}', this)">
                        <div class="path-left">
                            <span class="path-name">${pathEntry.key}</span>
                            <span class="path-meta">${pathEntry.value.size()} available course(s)</span>
                        </div>
                        <span class="path-arrow">⌄</span>
                    </button>

                    <div id="available-${status.index}" class="path-content">
                        <div class="path-content-inner">
                            <div class="path-courses">
                                <c:forEach var="course" items="${pathEntry.value}">
                                    <div class="course-card available">
                                        <div class="course-top">
                                            <div class="course-title">${course.title}</div>
                                            <span class="status-badge status-available">AVAILABLE</span>
                                        </div>

                                        <p class="course-description">${course.description}</p>

                                        <div class="course-meta">
                                            <span class="meta-pill">Path Step: ${course.pathOrder}</span>
                                            <span class="meta-pill">Level: ${course.level}</span>
                                            <span class="meta-pill">Duration: ${course.duration}</span>
                                        </div>

                                        <div class="button-group">
                                            <a href="${course.url}" target="_blank" class="btn btn-blue">View Details</a>
                                            <form action="${pageContext.request.contextPath}/start-course" method="post">
                                                <input type="hidden" name="courseId" value="${course.id}">
                                                <button type="submit" class="btn btn-green">Start Course</button>
                                                <a href="${pageContext.request.contextPath}/comments/comments-page?courseId=${course.id}" class="btn btn-blue">View Comments</a>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <section class="section-card">
        <div class="section-header">
            <div>
                <div class="section-title">Completed Courses</div>
                <div class="section-subtitle">Review what you have already finished.</div>
            </div>
        </div>

        <div class="section-body">
            <c:if test="${empty completedCoursesByPath}">
                <div class="empty-state">You haven't completed any courses yet. Keep going.</div>
            </c:if>

            <c:forEach var="pathEntry" items="${completedCoursesByPath}" varStatus="status">
                <div class="path-group">
                    <button type="button"
                            class="path-header"
                            onclick="togglePath('completed-${status.index}', this)">
                        <div class="path-left">
                            <span class="path-name">${pathEntry.key}</span>
                            <span class="path-meta">${pathEntry.value.size()} completed course(s)</span>
                        </div>
                        <span class="path-arrow">⌄</span>
                    </button>

                    <div id="completed-${status.index}" class="path-content">
                        <div class="path-content-inner">
                            <div class="path-courses">
                                <c:forEach var="course" items="${pathEntry.value}">
                                    <div class="course-card completed">
                                        <div class="course-top">
                                            <div class="course-title">${course.title}</div>
                                            <span class="status-badge status-completed">COMPLETED</span>
                                        </div>

                                        <p class="course-description">Completed successfully. You can reopen the material whenever you want a refresher.</p>

                                        <div class="course-meta">
                                            <span class="meta-pill">Completed Path Step: ${course.pathOrder}</span>
                                        </div>

                                        <div class="button-group">
                                            <a href="${course.url}" target="_blank" class="btn btn-muted">Review Material</a>
                                            <a href="${pageContext.request.contextPath}/comments/comments-page?courseId=${course.id}" class="btn btn-blue">View Comments</a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>
</div>

<script>
    function togglePath(id, button) {
        const content = document.getElementById(id);
        content.classList.toggle("active");
        button.classList.toggle("open");
    }
</script>
</body>
</html>