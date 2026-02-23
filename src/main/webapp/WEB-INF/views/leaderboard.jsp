<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Leaderboard</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f7f9; padding: 2rem; }
        div {
            max-width: 75%;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        table { width: 100%; border-collapse: collapse; margin-top: 20px;}
        th { text-align: left; border-bottom: 2px solid #005A9E; padding: 10px; color: #333; }
        td { padding: 10px; border-bottom: 1px solid #eee; }
        tr:hover { background-color: #f9f9f9; }
    </style>
</head>
<body>
    <div>
    <h1>Leaderboard</h1>
    <table>
        <tr>
            <th>Position</th>
            <th>User</th>
            <th>Score</th>
        </tr>
        <c:forEach var="user" items="${users}" varStatus="loop">
            <tr>
                <td>${loop.index + 1}</td>
                <td>${user.firstName} ${user.lastName}</td>
                <td>${user.xp}</td>
            </tr>
        </c:forEach>
    </table>
    </div>
</body>
</html>
