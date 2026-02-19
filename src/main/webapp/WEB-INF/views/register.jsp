<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>

<h2>Register</h2>

<!-- Global error message -->
<c:if test="${not empty error}">
    <p style="color:red; font-weight:bold;">${error}</p>
</c:if>

<form action="${pageContext.request.contextPath}/register" method="post" novalidate>

    <p>
        First Name:
        <input type="text" name="firstName" value="${param.firstName}">
    </p>

    <p>
        Last Name:
        <input type="text" name="lastName" value="${param.lastName}">
    </p>

    <p>
        Email:
        <input type="email" name="email" value="${param.email}">
    </p>

    <p>
        Password:
        <input type="password" name="password">
    </p>

    <p>
        Confirm Password:
        <input type="password" name="confirmPassword">
    </p>

    <p>
        Course:
        <select name="course">
            <option value="Computer Science"
            ${param.course == 'Computer Science' ? 'selected' : ''}>
                Computer Science
            </option>
            <option value="Software Engineering"
            ${param.course == 'Software Engineering' ? 'selected' : ''}>
                Software Engineering
            </option>
            <option value="Artificial Intelligence"
            ${param.course == 'Artificial Intelligence' ? 'selected' : ''}>
                Artificial Intelligence
            </option>
            <option value="Data Science"
            ${param.course == 'Data Science' ? 'selected' : ''}>
                Data Science
            </option>
        </select>
    </p>

    <button type="submit">Register</button>

</form>

<p>
    <a href="${pageContext.request.contextPath}/login">Back to login</a>
</p>

</body>
</html>
