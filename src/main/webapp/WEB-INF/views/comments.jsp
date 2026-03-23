<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Course Comments – IBM SkillsBuild</title>
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
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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
        }

        .nav-divider {
            width: 2px;
            height: 24px;
            background-color: rgba(255,255,255,0.3);
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

        .nav-links a:hover { color: #e0e0e0; opacity: 0.9; }

        .logout-link {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border: 2px solid #fff;
            border-radius: 4px;
            transition: background-color 0.2s, color 0.2s;
        }

        .logout-link:hover { background-color: #fff; color: #005A9E; }

        .page-shell {
            max-width: 860px;
            margin: 2rem auto 3rem auto;
            padding: 0 1.5rem;
        }

        .hero {
            background: linear-gradient(135deg, #005A9E 0%, #0a6bb4 100%);
            color: white;
            border-radius: 12px;
            padding: 1.75rem 2rem;
            box-shadow: 0 10px 24px rgba(0,90,158,0.12);
            margin-bottom: 1.5rem;
        }

        .hero h1 { font-size: 1.75rem; margin-bottom: 0.35rem; }
        .hero p  { color: rgba(255,255,255,0.88); font-size: 0.97rem; }

        .meta-pill {
            font-size: 0.82rem;
            color: #44515d;
            background: #f3f6f9;
            border: 1px solid #e2e8ef;
            border-radius: 999px;
            padding: 0.35rem 0.7rem;
        }

        .section-card {
            background: white;
            border: 1px solid #dbe3ea;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.05);
            overflow: hidden;
            margin-bottom: 1.5rem;
        }

        .section-header {
            padding: 1.1rem 1.4rem;
            border-bottom: 1px solid #e8edf2;
            background: #fff;
        }

        .section-title {
            font-size: 1.15rem;
            font-weight: 700;
            color: #222;
        }

        .section-body { padding: 1rem 1.4rem 1.4rem; }

        .comment-item {
            padding: 1rem 0;
            border-bottom: 1px solid #e8edf2;
        }

        .comment-item:last-child { border-bottom: none; padding-bottom: 0; }

        .comment-meta {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 0.45rem;
            flex-wrap: wrap;
        }

        .comment-username {
            font-weight: 700;
            color: #1f2933;
            font-size: 0.97rem;
        }

        .comment-rating {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            font-size: 0.82rem;
            font-weight: 700;
            padding: 0.25rem 0.65rem;
            border-radius: 999px;
            background: #fff8ec;
            color: #b45309;
            border: 1px solid #fde68a;
        }

        .comment-text {
            color: #56616b;
            line-height: 1.6;
            font-size: 0.95rem;
        }

        .empty-state {
            padding: 1rem;
            border: 1px dashed #ccd6df;
            border-radius: 10px;
            color: #6b7280;
            background: #fafcfe;
            font-size: 0.95rem;
        }


        .alert {
            padding: 0.85rem 1.1rem;
            border-radius: 8px;
            font-size: 0.93rem;
            margin-bottom: 1.25rem;
        }

        .alert-success {
            background: #eaf7ea;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .alert-error {
            background: #fef2f2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .alert-info {
            background: #f0f6ff;
            color: #1e40af;
            border: 1px solid #bfdbfe;
            font-style: italic;
        }

        .form-group { margin-bottom: 1.1rem; }

        .form-group label {
            display: block;
            font-size: 0.9rem;
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.4rem;
        }

        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.6rem 0.8rem;
            border: 1px solid #d1d9e0;
            border-radius: 6px;
            font-family: inherit;
            font-size: 0.95rem;
            color: #333;
            background: #fafcfe;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #005A9E;
            box-shadow: 0 0 0 3px rgba(0,90,158,0.12);
            background: #fff;
        }

        .form-group textarea { resize: vertical; min-height: 100px; }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 18px;
            text-decoration: none;
            border-radius: 6px;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            font-family: inherit;
            transition: transform 0.15s ease, box-shadow 0.15s ease, background-color 0.2s ease;
        }

        .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        }

        .btn-blue  { background-color: #005A9E; }
        .btn-blue:hover  { background-color: #004a87; }

        .btn-green { background-color: #107C10; }
        .btn-green:hover { background-color: #0d660d; }

        .btn-muted { background-color: #6b7280; }
        .btn-muted:hover { background-color: #555c67; }

        .button-group {
            display: flex;
            gap: 0.75rem;
            align-items: center;
            flex-wrap: wrap;
            margin-top: 0.5rem;
        }

        form { margin: 0; }

        .course-info-card {
            background: white;
            border: 1px solid #dbe3ea;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.05);
            overflow: hidden;
            margin-bottom: 1.5rem;
            border-left: 5px solid #005A9E;
        }

        .course-info-body {
            padding: 1.25rem 1.4rem;
        }

        .course-info-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #1f2933;
            margin-bottom: 0.5rem;
        }

        .course-info-desc {
            color: #56616b;
            line-height: 1.6;
            font-size: 0.95rem;
            margin-bottom: 1rem;
        }

        .course-info-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 0.55rem;
            margin-bottom: 1rem;
        }

        /* ── User title badge on comments ── */
        .user-title-badge {
            display: inline-block;
            font-weight: 700;
            font-size: 0.75rem;
            padding: 0.2rem 0.6rem;
            border-radius: 12px;
            color: white;
            vertical-align: middle;
        }

        @media (max-width: 768px) {
            header { padding: 1rem; }
            .header-container { gap: 1rem; flex-wrap: wrap; }
            .nav-links { gap: 1rem; flex-wrap: wrap; }
            .page-shell { padding: 0 1rem; }
            .hero { padding: 1.25rem; }
            .hero h1 { font-size: 1.4rem; }
        }
    </style>
</head>
<body>

<header>
    <div class="header-container">
        <a href="${pageContext.request.contextPath}/homepage" class="brand">IBM SkillsBuild</a>
        <div class="nav-divider"></div>
        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/homepage">Home</a>
            <a href="${pageContext.request.contextPath}/profile">Profile</a>
            <a href="${pageContext.request.contextPath}/dashboard">Courses</a>
            <a href="${pageContext.request.contextPath}/leaderboard">Leaderboard</a>
            <a href="${pageContext.request.contextPath}/friends">Friends</a>
        </nav>
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
    </div>
</header>

<div class="page-shell">

    <div class="hero">
            <h1>${course.title}</h1>
            <p>${course.description}</p>
            <div style="display:flex; flex-wrap:wrap; gap:0.5rem; margin-top:1rem; align-items:center;">
                <span style="background:rgba(255,255,255,0.18); border:1px solid rgba(255,255,255,0.3); border-radius:999px; padding:0.3rem 0.75rem; font-size:0.82rem;">Level: ${course.level}</span>
                <span style="background:rgba(255,255,255,0.18); border:1px solid rgba(255,255,255,0.3); border-radius:999px; padding:0.3rem 0.75rem; font-size:0.82rem;">Duration: ${course.duration}</span>
                <span style="background:rgba(255,255,255,0.18); border:1px solid rgba(255,255,255,0.3); border-radius:999px; padding:0.3rem 0.75rem; font-size:0.82rem;">Path Step: ${course.pathOrder}</span>
                <a href="${course.url}" target="_blank"
                   style="margin-left:auto; background:white; color:#005A9E; font-weight:700; font-size:0.85rem; padding:0.35rem 1rem; border-radius:6px; text-decoration:none;">
                    View Course ↗
                </a>
            </div>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <div class="section-card">
        <div class="section-header">
            <div class="section-title">Reviews</div>
        </div>
        <div class="section-body">
            <c:if test="${empty comments}">
                <div class="empty-state">No comments yet. Be the first to comment!</div>
            </c:if>

            <c:forEach var="comment" items="${comments}">
                <div class="comment-item">
                    <div class="comment-meta">
                        <span class="comment-username">${comment.user.username}</span>
                        <c:set var="displayTitle"
                               value="${not empty comment.user.equippedTitle ? comment.user.equippedTitle : 'Newcomer'}"/>
                        <span class="user-title-badge"
                              style="background-color: ${allTitles[displayTitle].colour};">
                                ${displayTitle}
                        </span>
                        <span class="comment-rating">⭐ ${comment.rating} / 5</span>
                    </div>
                    <p class="comment-text">${comment.commentText}</p>
                </div>
            </c:forEach>
        </div>
    </div>

    <%-- ── Add comment form ── --%>
    <div class="section-card">
        <div class="section-header">
            <div class="section-title">Add a Comment</div>
        </div>
        <div class="section-body">
            <c:if test="${!hasCommented}">
                <form action="${pageContext.request.contextPath}/comments" method="post">
                    <input type="hidden" name="userId"   value="${userId}" />
                    <input type="hidden" name="courseId" value="${courseId}" />

                    <div class="form-group">
                        <label for="rating">Rating (0 – 5)</label>
                        <select id="rating" name="rating" required>
                            <option value="">Select a rating…</option>
                            <c:forEach begin="0" end="5" var="i">
                                <option value="${i}">${i}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="commentText">Your Comment</label>
                        <textarea id="commentText" name="commentText" rows="4" required
                                  placeholder="Share your thoughts about this course…"></textarea>
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn btn-green">Submit Comment</button>
                        <button type="button" class="btn btn-muted"
                                onclick="window.location.href='${pageContext.request.contextPath}/dashboard'">
                            Back to Courses
                        </button>
                    </div>
                </form>
            </c:if>

            <c:if test="${hasCommented}">
                <div class="alert alert-info">You have already commented on this course.</div>
                <div class="button-group">
                    <button type="button" class="btn btn-blue"
                            onclick="window.location.href='${pageContext.request.contextPath}/dashboard'">
                        Back to Courses
                    </button>
                </div>
            </c:if>
        </div>
    </div>

</div>
</body>
</html>
