<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 2rem; background-color: #f4f7f9; }
        h2 { color: #333; text-align: center; }
        .container {
            background: white;
            padding: 20px 30px;
            border: 1px solid #ddd;
            border-radius: 8px;
            max-width: 500px;
            margin: 0 auto;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            text-align: center;
        }
        .btn { padding: 8px 15px; text-decoration: none; border-radius: 4px; color: white; border: none; cursor: pointer; font-size: 14px; font-weight: 600; }
        .btn-blue { background-color: #005A9E; }
        .btn-blue:hover { background-color: #004a87; }
    </style>
</head>
<body>

<div class="container">
    <h2>Welcome</h2>
    <form action="${pageContext.request.contextPath}/logout" method="post">
        <button type="submit" class="btn btn-blue">Logout</button>
    </form>
</div>
</body>
</html>