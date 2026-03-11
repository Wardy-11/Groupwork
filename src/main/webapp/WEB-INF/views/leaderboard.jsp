<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Leaderboard</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f7f9; padding: 2rem; }
        .card {
            max-width: 75%;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .tabs {
            display: flex;
            gap: 0;
            border-bottom: 2px solid #005A9E;
            margin-bottom: 0;
        }
        .tab-btn {
            padding: 10px 24px;
            border: none;
            background: none;
            cursor: pointer;
            font-size: 1rem;
            font-family: 'Segoe UI', sans-serif;
            color: #555;
            border-radius: 6px 6px 0 0;
            transition: background 0.15s, color 0.15s;
        }
        .tab-btn:hover { background: #f0f4f8; color: #005A9E; }
        .tab-btn.active {
            background: #005A9E;
            color: white;
            font-weight: 600;
        }
        .tab-content { display: none; }
        .tab-content.active { display: block; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { text-align: left; border-bottom: 2px solid #005A9E; padding: 10px; color: #333; }
        td { padding: 10px; border-bottom: 1px solid #eee; }
        tr:hover { background-color: #f9f9f9; }
        h1 { margin-top: 0; margin-bottom: 1rem; }
    </style>
</head>
<body>
<div class="card">
    <h1>Leaderboard</h1>

    <div class="tabs">
        <button class="tab-btn active" onclick="switchTab('global', this)">🌐 Global</button>
        <button class="tab-btn" onclick="switchTab('friends', this)">👥 Friends</button>
    </div>

    <!-- Global Leaderboard -->
    <div id="global" class="tab-content active">
        <table>
            <tr>
                <th>Position</th>
                <th>User</th>
                <th>Score</th>
            </tr>
            <c:forEach var="user" items="${users}" varStatus="loop">
                <tr>
                    <td>${loop.index + 1}</td>
                    <td>${user.username}</td>
                    <td>${user.xp}</td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <!-- Friends Leaderboard -->
    <div id="friends" class="tab-content">
        <table>
            <tr>
                <th>Position</th>
                <th>User</th>
                <th>Score</th>
            </tr>
            <c:forEach var="user" items="${friendsUsers}" varStatus="loop">
                <tr>
                    <td>${loop.index + 1}</td>
                    <td>${user.username}</td>
                    <td>${user.xp}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

<script>
    function switchTab(tabId, btn) {
        document.querySelectorAll('.tab-content').forEach(el => el.classList.remove('active'));
        document.querySelectorAll('.tab-btn').forEach(el => el.classList.remove('active'));
        document.getElementById(tabId).classList.add('active');
        btn.classList.add('active');
    }
</script>
</body>
</html>
