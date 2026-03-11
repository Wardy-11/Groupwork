<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<html>
<head>
    <title>My Profile</title>
    <style>
       * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f7f9; }

        header {
            background-color: #005A9E;
            padding: 1rem 2rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 100%;
        }
        
        .brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: #fff;
            text-decoration: none;
            display: flex;
            align-items: center;
        }
        
        .nav-divider {
            width: 2px;
            height: 24px;
            background-color: rgba(255, 255, 255, 0.3);
            margin: 0 1.5rem;
        }
        
        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
            flex: 1;
        }
        
        .nav-links a {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s, opacity 0.2s;
            padding: 0.5rem 0;
        }
        
        .nav-links a:hover {
            color: #e0e0e0;
            opacity: 0.9;
        }
        
        .logout-link {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border: 2px solid #fff;
            border-radius: 4px;
            transition: background-color 0.2s, color 0.2s;
        }
        
        .logout-link:hover {
            background-color: #fff;
            color: #005A9E;
        }
    

        
       
        .container { max-width: 50%; margin: 2rem auto 0 auto; background: white; padding: 20px 30px; border: 1px solid #ddd; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
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
<header>
    <div class="header-container">
        <a href="<c:url value='/homepage' />" class="brand">IBM SkillsBuild</a>
        <div class="nav-divider"></div>
        <nav class="nav-links">
            <a href="<c:url value='/homepage' />">Home</a>
            <a href="<c:url value='/profile' />">Profile</a>
            <a href="<c:url value='/dashboard' />">Courses</a>
            <a href="<c:url value='/leaderboard' />">Leaderboard</a>
            <a href="<c:url value='/friends' />">Friends</a>
        </nav>
        <a href="<c:url value='/logout' />" class="logout-link">Logout</a>
    </div>
</header>

<div class="container">

    <h1>My Profile</h1>
    <p style="text-align:center; font-size:1.5rem;">Level: <strong>${user.level}</strong></p>

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