<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>

<h2>Login</h2>

<c:if test="${param.error != null}">
    <p style="color:red; font-weight:bold;">
        Invalid email or password
    </p>
</c:if>

<form action="${pageContext.request.contextPath}/login" method="post">
    <p>
        Email: <input type="email" name="email" required>
    </p>
    <p>
        Password: <input type="password" name="password" required>
    </p>
    <button type="submit">Login</button>
</form>

<p><a href="${pageContext.request.contextPath}/register">Register</a></p>

</body>
</html>
