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
    const msgDiv = document.getElementById("msg");
    const coursesDiv = document.getElementById("courses");
    const myCoursesDiv = document.getElementById("myCourses");

    function showMsg(type, text) {
        msgDiv.innerHTML = `<div class="${type}">${text}</div>`;
        setTimeout(() => msgDiv.innerHTML = "", 4000);
    }

    function esc(s) {
        return String(s)
            .replaceAll("&", "&amp;")
            .replaceAll("<", "&lt;")
            .replaceAll(">", "&gt;")
            .replaceAll("\"", "&quot;")
            .replaceAll("'", "&#039;");
    }

    let myCourseIds = new Set();

    async function loadCourses() {
        try {
            coursesDiv.textContent = "Loading courses…";
            const res = await fetch("/api/courses");
            if (!res.ok) throw new Error(`Failed to load courses (${res.status})`);
            const courses = await res.json();

            if (!Array.isArray(courses) || courses.length === 0) {
                coursesDiv.innerHTML = "<p>No courses found.</p>";
                return;
            }

            coursesDiv.innerHTML = courses.map(c => {
                const started = myCourseIds.has(c.id);
                return `
                    <div class="card" style="margin-top: 10px;">
                        <h3 style="margin: 0 0 6px;">${esc(c.title)}</h3>
                        <p style="margin: 0 0 8px;">${esc(c.description)}</p>
                        <div class="meta">
                            <span><b>Level:</b> ${esc(c.level)}</span>
                            <span><b>Duration:</b> ${esc(c.duration)}</span>
                        </div>
                        <div class="actions">
                            <button ${started ? "disabled" : ""} onclick="startCourse('${esc(c.id)}')">
                                ${started ? "Started" : "Start"}
                            </button>
                            <a href="${esc(c.url)}" target="_blank" rel="noreferrer">Open course</a>
                        </div>
                    </div>
                `;
            }).join("");
        } catch (e) {
            coursesDiv.innerHTML = "";
            showMsg("error", e.message);
        }
    }

    async function loadMyCourses() {
        try {
            myCoursesDiv.textContent = "Loading your courses…";
            const res = await fetch(`/api/users/${userId}/courses`);
            if (!res.ok) throw new Error(`Failed to load your courses (${res.status})`);
            const myCourses = await res.json();

            myCourseIds = new Set((myCourses || []).map(c => c.id));

            if (!Array.isArray(myCourses) || myCourses.length === 0) {
                myCoursesDiv.innerHTML = "<p>You haven’t started any courses yet.</p>";
            } else {
                myCoursesDiv.innerHTML = `
                    <ul>
                        ${myCourses.map(c => `
                            <li style="margin-bottom: 8px;">
                                <b>${esc(c.title)}</b> — ${esc(c.level)} (${esc(c.duration)})
                                - <a href="${esc(c.url)}" target="_blank" rel="noreferrer">Open</a>
                            </li>
                        `).join("")}
                    </ul>
                `;
            }

            await loadCourses(); // update "Started" buttons
        } catch (e) {
            myCoursesDiv.innerHTML = "";
            showMsg("error", e.message);
        }
    }

    async function startCourse(courseId) {
        try {
            const res = await fetch(`/api/users/${userId}/courses/${courseId}`, { method: "POST" });
            if (!res.ok) throw new Error(`Failed to start course (${res.status})`);
            showMsg("ok", "Course started!");
            await loadMyCourses();
        } catch (e) {
            showMsg("error", e.message);
        }
    }

    loadMyCourses();
</script>

</body>
</html>