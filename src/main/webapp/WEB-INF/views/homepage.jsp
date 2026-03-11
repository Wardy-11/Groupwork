<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Homepage</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f7f9; margin: 2rem; }
        .container { max-width: 450px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; border: 1px solid #ddd; text-align: center; }
        .nav-link { display: block; padding: 12px; margin: 10px 0; background: #005A9E; border: 1px solid #fff; color: #fff; text-decoration: none; border-radius: 4px; font-weight: 600; transition: 0.2s; }
        .nav-link:hover { background: #fff; color: #005A9E; border-color: #005A9E}
        .logout { color: #fff; border-color: #fff; background:#d9534f;}
        .logout:hover { background: #fff; color: #d9534f; border-color: #d9534f}
        nav {
            text-align: right;
            margin-bottom: 1rem;
        }
        nav a {
            color: #005A9E;
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Welcome to Your Homepage!</h1>
    <a href="<c:url value='/profile' />" class="nav-link">My Profile</a>
    <a href="<c:url value='/dashboard' />" class="nav-link">Student Dashboard</a>
    <a href="<c:url value='/friends'/>" class="nav-link">Friends</a>
    <a href="<c:url value='/courses' />" class="nav-link">View Courses</a>
    <a href="<c:url value='/leaderboard' />" class="nav-link">Leaderboard</a>
    <a href="<c:url value='/logout' />" class="nav-link logout">Logout</a>
</div>


</body>
</html>