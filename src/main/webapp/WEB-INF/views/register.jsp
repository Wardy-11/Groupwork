<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>
<h2>Register</h2>

<form action="${pageContext.request.contextPath}/register" method="post">

    <p>First Name:
        <input type="text" name="firstName" required>
    </p>

    <p>Last Name:
        <input type="text" name="lastName" required>
    </p>

    <p>Email:
        <input type="email" name="email" required>
    </p>
    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>


    <p>Password:
        <input type="password" name="password" required>
    </p>

    <p>Confirm Password:
        <input type="password" name="confirmPassword" required>
    </p>
    <p>Course:
        <select name="course">
            <option value="Computer Science">Computer Science</option>
            <option value="Software Engineering">Software Engineering</option>
            <option value="Artificial Intelligence">Artificial Intelligence</option>
            <option value="Data Analysis">Data Science</option>
        </select>
    </p>


    <button type="submit">Register</button>
</form>

<p><a href="${pageContext.request.contextPath}/login">Back to login</a></p>
</body>
</html>
