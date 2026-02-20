<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Homepage</title>
</head>
<body>
<h1>Welcome to Your Homepage!</h1>


<p>
    <a href="<c:url value='/profile' />">View / Edit Profile</a>
</p>

<p>
    <a href="<c:url value='/logout' />">Logout</a>
</p>
</body>
</html>