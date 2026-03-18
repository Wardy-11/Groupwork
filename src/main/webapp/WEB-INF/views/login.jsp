<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - IBM SkillsBuild</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f9;
        }
        
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
        
        .brand:hover {
            opacity: 0.9;
        }

        main {
            padding: 2rem;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 80px);
        }

        .container {
            max-width: 600px;
            width: 100%;
            background: white;
            padding: 50px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.12);
        }
        
        .welcome-section {
            background: linear-gradient(135deg, #e8f0f8 0%, #f0f5fa 100%);
            padding: 25px;
            border-radius: 6px;
            margin-bottom: 30px;
            border-left: 4px solid #005A9E;
        }
        
        .welcome-section h3 {
            color: #005A9E;
            font-size: 1.2rem;
            margin-bottom: 8px;
        }
        
        .welcome-section p {
            color: #555;
            font-size: 0.95rem;
            line-height: 1.5;
        }
        
        h2 { 
            color: #333; 
            text-align: center; 
            margin-bottom: 1.5rem; 
            font-size: 1.8rem;
        }
        
        .form-group { margin-bottom: 20px; }
        
        .form-group label { 
            display: block; 
            margin-bottom: 5px; 
            font-weight: 600;
            color: #333;
        }
        
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #005A9E;
            box-shadow: 0 0 0 2px rgba(0, 90, 158, 0.1);
        }
        
        .btn {
            width: 100%;
            padding: 10px;
            text-decoration: none;
            border-radius: 4px;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: background-color 0.2s;
        }
        
        .btn-blue { background-color: #005A9E; }
        .btn-blue:hover { background-color: #004a87; }
        
        .error-msg { 
            color: #d32f2f; 
            font-weight: bold; 
            margin-bottom: 15px; 
            text-align: center;
            padding: 10px;
            background-color: #ffebee;
            border-radius: 4px;
        }
        .deleted-msg {
            background-color: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            border: 1px solid #c3e6cb;
            font-weight: 500;
        }
        
        .link-section {
            text-align: center;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
        
        .link-section a {
            color: #005A9E;
            text-decoration: none;
            font-weight: 600;
        }
        
        .link-section a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>
<header>
    <div class="header-container">
        <a href="${pageContext.request.contextPath}/login" class="brand">IBM SkillsBuild</a>
    </div>
</header>

<main>
    <div class="container">
        <h2>Welcome Back</h2>
        
        <div class="welcome-section">
            <h3>🎓 Continue Your Learning Journey</h3>
            <p>Log in to access your courses, track your progress, and unlock new skills with IBM SkillsBuild.</p>
        </div>
        
        <c:if test="${param.error != null}">
            <p class="error-msg">Invalid email or password</p>
        </c:if>
        <c:if test="${param.deleted != null}">
            <div class="deleted-msg">
                Your account has been successfully deleted!
            </div>
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
        
        <div class="link-section">
            <p>Need an account? <a href="${pageContext.request.contextPath}/register">Register here</a></p>
        </div>
    </div>
</main>

</body>
</html>
