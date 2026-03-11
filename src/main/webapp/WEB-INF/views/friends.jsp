<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 2rem; background-color: #f4f7f9; }
        h1 { color: #333; margin: 0; }

        .island {
            max-width: 75%;
            margin: 0 auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 24px;
        }

        .island-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .island-header-left { display: flex; align-items: center; gap: 12px; }

        .nav-link { color: #005A9E; text-decoration: none; font-weight: 600; white-space: nowrap; }
        .nav-link:hover { text-decoration: underline; }

        .search-box { padding: 8px 12px; width: 250px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }

        .btn { padding: 8px 15px; border-radius: 4px; color: white; border: none; cursor: pointer; font-size: 14px; font-weight: 600; }
        .btn-blue { background-color: #005A9E; }
        .btn-blue:hover { background-color: #004a87; }
        .btn-green { background-color: #107C10; }
        .btn-green:hover { background-color: #0d660d; }
        .btn-red { background-color: #d9534f; }
        .btn-red:hover { background-color: #c9302c; }

        table { width: 100%; border-collapse: collapse; table-layout: fixed; }
        td { padding: 10px; border-bottom: 1px solid #eee; }
        td:first-child { width: 80%; }
        td:last-child { width: 20%; text-align: right; }
        tr:hover { background-color: #f9f9f9; }
        form { margin: 0; }
    </style>
</head>
<body>
<div class="island">
    <div class="island-header">
        <div class="island-header-left">
            <h1>Friends</h1>
            <form action="/friends" method="get" style="display:flex; gap:8px; align-items:center;">
                <input type="text" name="keyword" class="search-box" placeholder="Find Friends" value="${param.keyword}" />
                <button type="submit" class="btn btn-blue">Search</button>
                <c:if test="${not empty param.keyword}">
                    <a href="/friends" style="color:#666; font-size:0.9rem;">Clear Search</a>
                </c:if>
            </form>
        </div>
        <a href="<c:url value='/allUsers'/>" class="nav-link">Add Friends</a>
    </div>

    <table>
        <c:forEach var="friend" items="${friends}">
            <tr>
                <td>${friend}</td>
                <td>
                    <c:choose>
                        <c:when test="${currentUser.friends.contains(friend)}">
                            <form action="/removeFriend" method="get">
                                <input type="hidden" name="username" value="${friend}"/>
                                <input type="hidden" name="source" value="friends"/>
                                <button type="submit" class="btn btn-red">Unfriend</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <form action="/addFriend" method="get">
                                <input type="hidden" name="username" value="${friend}"/>
                                <input type="hidden" name="source" value="friends"/>
                                <button type="submit" class="btn btn-green">Friend</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>