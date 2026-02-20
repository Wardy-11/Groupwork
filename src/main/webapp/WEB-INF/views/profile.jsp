<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>My Profile</title>
</head>
<body>
<h1>My Profile</h1>

<c:if test="${not empty success}">
    <p style="color: green;">${success}</p>
</c:if>

<form action="<c:url value='/profile' />" method="post">
    <label>First Name:</label>
    <input type="text" name="firstName" value="${user.firstName}" /><br/><br/>

    <label>Last Name:</label>
    <input type="text" name="lastName" value="${user.lastName}" /><br/><br/>

    <label>Course:</label>
    <input type="text" name="course" value="${user.course}" /><br/><br/>

    <label>New Password (optional):</label>
    <input type="password" name="password" /><br/><br/>

    <input type="submit" value="Update Profile" />
</form>

<p>
    <a href="<c:url value='/homepage' />">Back to Homepage</a>
</p>

</body>
</html>