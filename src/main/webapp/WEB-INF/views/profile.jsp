<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>My Profile</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f7f9; margin: 2rem; }
        .container { max-width: 500px; margin: 0 auto; background: white; padding: 20px 30px; border: 1px solid #ddd; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        h1, h2 { color: #333; text-align: center; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 600; }
        .form-group input { width: 100%; padding: 8px 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn { width: 100%; padding: 10px; background-color: #005A9E; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: 600; margin-top: 10px; }
        .btn:hover { background-color: #004a87; }
        .achievement-list { list-style: none; padding: 0; margin-top: 20px; border-top: 1px solid #eee; }
        .achievement-item { padding: 10px 0; border-bottom: 1px solid #eee; font-size: 0.9rem; }
    </style>
</head>
<body>
<div class="container">
    <h1>My Profile</h1>
    <p style="text-align:center;">Level: <strong>${user.level}</strong></p>

    <form action="<c:url value='/profile' />" method="post">
        <div class="form-group">
            <label>First Name</label>
            <input type="text" name="firstName" value="${user.firstName}" />
        </div>
        <div class="form-group">
            <label>Last Name</label>
            <input type="text" name="lastName" value="${user.lastName}" />
        </div>
        <div class="form-group">
            <label>Course</label>
            <input type="text" name="course" value="${user.course}" />
        </div>
        <div class="form-group">
            <label>New Password (optional)</label>
            <input type="password" name="password" />
        </div>
        <button type="submit" class="btn">Update Profile</button>
    </form>

    <h2>Achievements</h2>
    <ul class="achievement-list">
        <c:forEach var="achievement" items="${user.achievements}">
            <li class="achievement-item">
                <strong>${achievement.title}</strong>: ${achievement.description}
            </li>
        </c:forEach>
    </ul>

    <form action="<c:url value='/unlock-achievement' />" method="post">
        <button type="submit" class="btn" style="background-color: #107C10;">Unlock Achievement</button>
    </form>
</div>
</body>
</html>