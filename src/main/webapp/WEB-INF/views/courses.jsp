<%@ page isELIgnored="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>IBM SkillsBuild Courses</title>
    <meta charset="UTF-8" />
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 16px; }
        .card { border: 1px solid #ddd; border-radius: 10px; padding: 14px; }
        .meta { color: #555; font-size: 14px; display: flex; gap: 12px; flex-wrap: wrap; margin-top: 6px; }
        .actions { margin-top: 10px; display: flex; gap: 10px; align-items: center; }
        .error { padding: 10px; border: 1px solid #ffb3b3; background: #ffecec; border-radius: 8px; margin-bottom: 12px; }
        .ok { padding: 10px; border: 1px solid #b6f2c1; background: #eaffef; border-radius: 8px; margin-bottom: 12px; }
        button { padding: 8px 12px; cursor: pointer; }
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
    <div class="card">
        <h2>All Courses</h2>
        <div id="courses">Loading…</div>
    </div>

    <div class="card">
        <h2>My Started Courses</h2>
        <div id="myCourses">Loading…</div>
        <div class="actions">
            <button onclick="loadMyCourses()">Refresh</button>
        </div>
    </div>
</div>

<script>
    const list = document.getElementById("courseList");
    const loading = document.getElementById("loading");

    function esc(s){ return String(s ?? "").replace(/[&<>"']/g, m => ({
        "&":"&amp;","<":"&lt;",">":"&gt;","\"":"&quot;","'":"&#39;"
    }[m])); }

    function renderCourses(courses){
        list.innerHTML = "";
        courses.forEach(c => {
            const card = document.createElement("div");
            card.className = "course-card";
            card.innerHTML = `
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
    `;
            list.appendChild(card);
        });
    }

    function loadCourses(){
        fetch("/api/courses")
            .then(res => res.json())
            .then(data => {
                loading.style.display = "none";
                renderCourses(data);
            })
            .catch(() => {
                loading.textContent = "Failed to load courses.";
            });
    }

    loadCourses();
</script>

</body>
</html>