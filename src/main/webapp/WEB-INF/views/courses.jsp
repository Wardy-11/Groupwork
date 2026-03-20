<%@ page isELIgnored="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
    <title>IBM SkillsBuild Courses</title>
    <meta charset="UTF-8" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
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
        
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f7f9;}
        .grid { display: grid; grid-template-rows: repeat(2, 1fr); gap: 16px; }
        .card { border: 1px solid #ddd; border-radius: 10px; padding: 14px; background-color: white; margin: 6px;}
        .meta { color: #555; font-size: 14px; display: flex; gap: 12px; flex-wrap: wrap; margin-top: 6px; }
        .actions {display: inline-flex; align-items: center; }
        .error { padding: 10px; border: 1px solid #ffb3b3; background: #ffecec; border-radius: 8px; margin-bottom: 12px; }
        .ok { padding: 10px; border: 1px solid #b6f2c1; background: #eaffef; border-radius: 8px; margin-bottom: 12px; }
        button { padding: 10px; background-color: #005A9E; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: 600; }
        button[disabled] { cursor: not-allowed; opacity: 0.6; }
        a { text-decoration: none; }
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

<h1>IBM SkillsBuild Courses</h1>
<p>Browse available courses and start learning.</p>

<!-- TEMP: hardcoded userId. Replace later with logged-in user's id -->
<script>
    const userId = 1;
</script>

<div id="msg"></div>

<div class="grid">
    <h2>All Courses</h2>
    <div class="actions">
        <button onclick="loadCourses()">Refresh</button>
    </div>
    <div id="courseList">Loading…</div>
</div>
<script>
    const list = document.getElementById("courseList");

    function esc(s){ return String(s ?? "").replace(/[&<>"']/g, m => ({
        "&":"&amp;","<":"&lt;",">":"&gt;","\"":"&quot;","'":"&#39;"
    }[m])); }

    function renderCourses(courses){
        list.innerHTML = ``;

        courses.forEach(c => {
            const card = document.createElement("div");
            card.className = "course-card";

            card.innerHTML = `
                <div class="card">
                    <h3>${esc(c.title)}</h3>
                    <p>${esc(c.description)}</p>
                    <div class="meta">
                        <span><b>Level:</b> ${esc(c.level)}</span>
                        <span><b>Duration:</b> ${esc(c.duration)}</span>
                        <span><b>Course ID:</b> ${esc(c.id)}</span>
                    </div>
                    <div style="margin-top:10px;">
                        <a href="${esc(c.url)}" target="_blank">
                            <button>View Course</button>
                        </a>
                    </div>
                </div>
            `;
            list.appendChild(card);
        });
    }

    function loadCourses(){
        fetch("api/courses")
            .then(res => res.json())
            .then(data => {
                renderCourses(data);
            })
            .catch(() => {
                list.textContent = "Failed to load courses.";
            });
    }

    loadCourses();
</script>

</body>
</html>