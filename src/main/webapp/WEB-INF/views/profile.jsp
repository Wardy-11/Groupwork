<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Profile</title>
</head>
<body>

<h2>Your Profile</h2>


<c:if test="${not empty success}">
    <p style="color: green;">${success}</p>
</c:if>


<form action="/profile" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

    First Name:<br>
    <input type="text" name="firstName" value="${user.firstName}" required><br><br>

    Last Name:<br>
    <input type="text" name="lastName" value="${user.lastName}" required><br><br>

    Course:<br>
    <input type="text" name="course" value="${user.course}" required><br><br>

    New Password (leave blank to keep current):<br>
    <input type="password" name="password"><br><br>

    <button type="submit">Update Profile</button>
</form>

<hr>

<h3>Your Achievements</h3>

<c:if test="${empty achievements}">
    <p>No achievements yet.</p>
</c:if>

<h3>Your Achievements</h3>
<ul>
    <c:forEach var="achievement" items="${user.achievements}">
        <li>${achievement.title}</li>
    </c:forEach>
</ul>

<hr>

<h3>Unlock Test Achievement</h3>

<form action="/unlock-first-login" method="post">
    <button type="submit">Unlock First Login</button>
</form>

<form action="/unlock-persistent-learner" method="post">
    <button type="submit">Unlock Persistent Learner</button>
</form>

<form action="/unlock-early-bird" method="post">
    <button type="submit">Unlock Early Bird</button>
</form>

<br>
<a href="/homepage">Back to Homepage</a>

</body>
</html>