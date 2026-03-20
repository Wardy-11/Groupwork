<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
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

        .delete-account-btn {
            background-color: #c62828;
            color: white;
            border: none;
            padding: 10px 16px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 16px;
            width: 100%;
            font-size: 14px;
            font-weight: 600;
        }

        .delete-account-btn:hover { background-color: #a61d1d; }

        .container {
            max-width: 50%;
            margin: 2rem auto 2rem auto;
            background: white;
            padding: 20px 30px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        h1, h2 { color: #333; text-align: center; }

        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 600; }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .btn {
            width: 100%;
            padding: 10px;
            background-color: #005A9E;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
            margin-top: 10px;
            font-size: 14px;
        }

        .btn:hover { background-color: #004a87; }

        .section-tabs {
            display: flex;
            gap: 0;
            border-bottom: 2px solid #005A9E;
            margin: 2rem 0 0 0;
        }

        .section-tab-btn {
            padding: 8px 20px;
            border: none;
            background: none;
            cursor: pointer;
            font-size: 0.95rem;
            font-family: 'Segoe UI', sans-serif;
            color: #555;
            border-radius: 6px 6px 0 0;
            transition: background 0.15s, color 0.15s;
        }

        .section-tab-btn:hover { background: #f0f4f8; color: #005A9E; }

        .section-tab-btn.active {
            background: #005A9E;
            color: white;
            font-weight: 600;
        }

        .section-tab-content { display: none; padding-top: 16px; }
        .section-tab-content.active { display: block; }

        .achievement-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 12px;
            margin-bottom: 10px;
        }

        .achievement-box {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            padding: 14px;
            border-radius: 8px;
            border: 2px solid;
        }

        .achievement-box.unlocked { border-color: #107C10; background-color: #f0fff0; }
        .achievement-box.locked { border-color: #ccc; background-color: #f9f9f9; opacity: 0.6; }

        .achievement-icon { font-size: 1.8rem; line-height: 1; }

        .achievement-info {
            display: flex;
            flex-direction: column;
            gap: 3px;
            font-size: 0.88rem;
            color: #444;
        }

        .achievement-info strong { font-size: 0.95rem; color: #222; }
        .achievement-box.locked .achievement-info strong { color: #999; }

        .achievement-xp { color: #005A9E; font-weight: 600; font-size: 0.82rem; }

        .titles-scroll {
            max-height: 340px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 10px;
            padding-right: 4px;
            margin-bottom: 10px;
        }

        .titles-scroll::-webkit-scrollbar { width: 6px; }
        .titles-scroll::-webkit-scrollbar-track { background: #f0f0f0; border-radius: 3px; }
        .titles-scroll::-webkit-scrollbar-thumb { background: #ccc; border-radius: 3px; }

        .title-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 14px;
            border-radius: 8px;
            border: 2px solid #eee;
            background: #fafafa;
        }

        .title-row.equipped {
            border-color: #005A9E;
            background: #eef4fb;
        }

        .title-row.locked-title {
            opacity: 0.45;
        }

        .title-left { display: flex; align-items: center; gap: 10px; }

        .title-badge {
            font-weight: 700;
            font-size: 0.85rem;
            padding: 3px 10px;
            border-radius: 12px;
            color: white;
        }

        .title-desc { font-size: 0.82rem; color: #666; }

        .equip-btn {
            padding: 5px 14px;
            border-radius: 4px;
            font-size: 0.82rem;
            font-weight: 600;
            cursor: pointer;
            border: none;
            background-color: #005A9E;
            color: white;
            transition: background 0.2s;
        }

        .equip-btn:hover { background-color: #004a87; }

        .equipped-label {
            font-size: 0.82rem;
            font-weight: 600;
            color: #005A9E;
        }

        .current-title-display {
            text-align: center;
            margin-bottom: 14px;
            font-size: 0.9rem;
            color: #555;
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

<div class="container">

    <h1>My Profile</h1>
    <p style="text-align:center; font-size:1.2rem; margin: 6px 0 4px 0;">Level: <strong>${user.level}</strong></p>

    <div class="current-title-display">
        Current title:
        <span class="title-badge" style="background-color: ${equippedTitleDef.colour};">
            ${equippedTitleDef.name}
        </span>
    </div>

    <c:if test="${not empty error}">
        <p style="color:red; font-weight:bold; margin-bottom:10px;">${error}</p>
    </c:if>
    <c:if test="${not empty success}">
        <p style="color:green; font-weight:bold; margin-bottom:10px;">${success}</p>
    </c:if>

    <form action="<c:url value='/profile' />" method="post">
        <div class="form-group">
            <label>First Name</label>
            <input type="text" name="firstName" value="${user.firstName}" required />
        </div>
        <div class="form-group">
            <label>Last Name</label>
            <input type="text" name="lastName" value="${user.lastName}" required />
        </div>
        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" value="${user.email}" required />
        </div>
        <div class="form-group">
            <label>Course</label>
            <select name="course">
                <option value="Computer Science"        ${user.course == 'Computer Science'        ? 'selected' : ''}>Computer Science</option>
                <option value="Software Engineering"    ${user.course == 'Software Engineering'    ? 'selected' : ''}>Software Engineering</option>
                <option value="Artificial Intelligence" ${user.course == 'Artificial Intelligence' ? 'selected' : ''}>Artificial Intelligence</option>
                <option value="Data Science"            ${user.course == 'Data Science'            ? 'selected' : ''}>Data Science</option>
            </select>
        </div>
        <div class="form-group">
            <label>New Password (optional)</label>
            <input type="password" name="password" minlength="6" />
        </div>
        <button type="submit" class="btn">Update Profile</button>
    </form>

    <div class="section-tabs">
        <button class="section-tab-btn active" onclick="switchSection('achievements', this)">&#127942; Achievements</button>
        <button class="section-tab-btn" onclick="switchSection('titles', this)">&#127775; Titles</button>
    </div>

    <div id="achievements" class="section-tab-content active">
        <div class="achievement-grid">
            <c:forEach var="def" items="${allAchievements}">
                <c:set var="earned" value="false" />
                <c:forEach var="a" items="${user.achievements}">
                    <c:if test="${a.title == def.title}">
                        <c:set var="earned" value="true" />
                    </c:if>
                </c:forEach>
                <div class="achievement-box ${earned ? 'unlocked' : 'locked'}">
                    <div class="achievement-icon">${earned ? '&#127942;' : '&#128274;'}</div>
                    <div class="achievement-info">
                        <strong>${def.title}</strong>
                        <span>${def.description}</span>
                        <span class="achievement-xp">+${def.xpReward} XP</span>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <div id="titles" class="section-tab-content">
        <div class="titles-scroll">
            <c:forEach var="def" items="${allTitles}">
                <c:set var="isUnlocked" value="false" />
                <c:forEach var="unlocked" items="${unlockedTitles}">
                    <c:if test="${unlocked.name == def.name}">
                        <c:set var="isUnlocked" value="true" />
                    </c:if>
                </c:forEach>
                <c:set var="isEquipped" value="${user.equippedTitle == def.name || (empty user.equippedTitle && def.name == 'Newcomer')}" />

                <div class="title-row ${isEquipped ? 'equipped' : ''} ${!isUnlocked ? 'locked-title' : ''}">
                    <div class="title-left">
                        <span class="title-badge" style="background-color: ${def.colour};">${def.name}</span>
                        <span class="title-desc">${def.description}</span>
                    </div>
                    <c:choose>
                        <c:when test="${isEquipped}">
                            <span class="equipped-label">&#10003; Equipped</span>
                        </c:when>
                        <c:when test="${isUnlocked}">
                            <form action="<c:url value='/profile/equip-title' />" method="post" style="margin:0;">
                                <input type="hidden" name="titleName" value="${def.name}" />
                                <button type="submit" class="equip-btn">Equip</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <span style="font-size:0.82rem; color:#aaa;">&#128274; Locked</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:forEach>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/profile/delete" method="post"
          onsubmit="return confirm('Are you sure you want to delete your account? This action cannot be undone.');">
        <button type="submit" class="delete-account-btn">Delete Account</button>
    </form>

</div>

<script>
    function switchSection(tabId, btn) {
        document.querySelectorAll('.section-tab-content').forEach(el => el.classList.remove('active'));
        document.querySelectorAll('.section-tab-btn').forEach(el => el.classList.remove('active'));
        document.getElementById(tabId).classList.add('active');
        btn.classList.add('active');
    }
</script>
</body>
</html>
