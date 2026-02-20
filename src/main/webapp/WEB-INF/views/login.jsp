<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Student Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 2rem;
            background-color: #f4f7f9;
        }
        nav {
            text-align: right;
            margin-bottom: 1rem;
        }
        nav a {
            color: #005A9E;
            text-decoration: none;
            font-weight: 600;
        }
        nav a:hover { text-decoration: underline; }

        .container {
            max-width: 400px;
            margin: 0 auto;
            background: white;
            padding: 20px 30px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        h2 { color: #333; text-align: center; margin-bottom: 1rem; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 600; }
        .form-group input {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 4px;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
        }
        .btn-blue { background-color: #005A9E; }
        .btn-blue:hover { background-color: #004a87; }
        .error-msg { color: red; font-weight: bold; margin-bottom: 15px; text-align:center; }
        .notice { font-size: 0.9rem; text-align: center; margin-top: 15px; }
    </style>
</head>
<body>
<nav>
    <a href="${pageContext.request.contextPath}/register">Need an account? Register</a>
</nav>
<div class="container">
    <h2>Login</h2>
    <c:if test="${param.error != null}">
        <p class="error-msg">Invalid email or password</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit" class="btn btn-blue">Login</button>
    </form>

    <p class="notice"><a href="${pageContext.request.contextPath}/register">Create an account</a></p>
</div>

</body>
</html>
