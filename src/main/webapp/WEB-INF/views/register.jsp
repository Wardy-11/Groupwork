<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 2rem;
            background-color: #f4f7f9;
        }
        h2 { color: #333; text-align: center; }
        .form-container {
            background: white;
            padding: 20px 30px;
            border: 1px solid #ddd;
            border-radius: 8px;
            max-width: 500px;
            margin: 0 auto;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 600; }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn { padding: 8px 15px; text-decoration: none; border-radius: 4px;
               color: white; border: none; cursor: pointer; font-size: 14px; font-weight: 600; }
        .btn-blue { background-color: #005A9E; }
        .btn-blue:hover { background-color: #004a87; }
        .error-msg { color: red; font-weight: bold; margin-bottom: 15px; }
        .notice { font-size: 0.9rem; text-align: center; margin-top: 15px; }
    </style>
</head>
<body>

<h2>Register</h2>

<div class="form-container">
    <c:if test="${not empty error}">
        <p class="error-msg">${error}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post" novalidate>
        <div class="form-group">
            <label for="firstName">First Name</label>
            <input id="firstName" type="text" name="firstName" value="${param.firstName}" required>
        </div>

        <div class="form-group">
            <label for="lastName">Last Name</label>
            <input id="lastName" type="text" name="lastName" value="${param.lastName}" required>
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input id="email" type="email" name="email" value="${param.email}" required>
        </div>

        <div class="form-group">
            <label for="password">Password (min 6 chars)</label>
            <input id="password" type="password" name="password" required minlength="6">
        </div>

        <div class="form-group">
            <label for="confirmPassword">Confirm Password</label>
            <input id="confirmPassword" type="password" name="confirmPassword" required minlength="6">
        </div>

        <div class="form-group">
            <label for="course">Course</label>
            <select id="course" name="course">
                <option value="Computer Science" ${param.course == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                <option value="Software Engineering" ${param.course == 'Software Engineering' ? 'selected' : ''}>Software Engineering</option>
                <option value="Artificial Intelligence" ${param.course == 'Artificial Intelligence' ? 'selected' : ''}>Artificial Intelligence</option>
                <option value="Data Science" ${param.course == 'Data Science' ? 'selected' : ''}>Data Science</option>
            </select>
        </div>

        <button type="submit" class="btn btn-blue">Register</button>
    </form>

    <p class="notice">
        Already have an account? <a href="${pageContext.request.contextPath}/login">Back to login</a>
    </p>
</div>

</body>
</html>
