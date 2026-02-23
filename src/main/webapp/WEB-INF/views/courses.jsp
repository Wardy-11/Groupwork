<%@ page isELIgnored="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>IBM SkillsBuild Courses</title>
    <meta charset="UTF-8" />
    <style>
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
    const loading = document.getElementById("loading");

    function esc(s){ return String(s ?? "").replace(/[&<>"']/g, m => ({
        "&":"&amp;","<":"&lt;",">":"&gt;","\"":"&quot;","'":"&#39;"
    }[m])); }

    function renderCourses(courses){
        list.innerHTML = ``;
        courses.forEach(c => {
            const card = document.createElement("div");
            card.className = "course-card";
            if(c.status !== "COMPLETED" && c.status !== "STARTED"){
                card.innerHTML = `<div class="card">
                <h3>${esc(c.title)}</h3>
                <p>Status: ${esc(c.status)}</p>
                <div class="meta">
                <span><b>Course ID:</b> ${esc(c.id)}</span>
                </div>
                <div style="margin-top:10px;">
                <a href="${esc(c.link)}" target="_blank">
                    <button>Start Course</button>
                </a>
                </div>
                </div>`;
                list.appendChild(card);
            }
            else{
                return;
            }

        });
        courses.forEach(c => {
            const card = document.createElement("div");
            card.className = "course-card";
            if(c.status === "COMPLETED" || c.status === "STARTED"){
                card.innerHTML = `<div class="card">
                <h3>${esc(c.title)}</h3>
                <p>Status: ${esc(c.status)}</p>
                <div class="meta">
                <span><b>Course ID:</b> ${esc(c.id)}</span>
                </div>
                <div style="margin-top:10px;">
                <a href="${esc(c.link)}" target="_blank">
                    <button disabled>Start Course</button>
                </a>
                </div>
                </div>`;
                list.appendChild(card);
            }
            else{
                return;
            }
        });
    }

    function loadCourses(){
        fetch("/api/courses")
            .then(res => res.json())
            .then(data => {
                renderCourses(data);
                loading.style.display = "none";
            })
            .catch(() => {
                loading.textContent = "Failed to load courses.";
            });
    }

    loadCourses();
</script>

</body>
</html>