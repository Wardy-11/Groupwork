<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Leaderboard</title>
</head>
<body>
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
</body>
</html>
