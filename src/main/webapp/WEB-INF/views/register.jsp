<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - IBM SkillsBuild</title>
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
            max-width: 650px;
            width: 100%;
            background: white;
            padding: 50px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.12);
        }
        
        .welcome-section {
            background: linear-gradient(135deg, #e8f5e9 0%, #f0f7f4 100%);
            padding: 25px;
            border-radius: 6px;
            margin-bottom: 30px;
            border-left: 4px solid #107C10;
        }
        
        .welcome-section h3 {
            color: #107C10;
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
        
        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        
        .form-group input:focus, .form-group select:focus {
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
        <a href="${pageContext.request.contextPath}/register" class="brand">IBM SkillsBuild</a>
    </div>
</header>

<main>
    <div class="container">
        <h2>Start Your Journey</h2>
        
        <div class="welcome-section">
            <h3>🚀 Get Ready to Upskill</h3>
            <p>Join IBM SkillsBuild today to access free professional courses, build real skills, and advance your career with industry-leading training.</p>
        </div>

        <c:if test="${not empty error}">
            <p class="error-msg">${error}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post" novalidate>
            <div class="form-group">
                <label for="firstName">First Name</label>
                <input id="firstName" type="text" name="firstName" value="${param.firstName}" required>
            </div>

            <div class="form-group">
                <label for="lastName">Last Name</label>
                <input id="lastName" type="text" name="lastName" value="${param.lastName}" required>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input id="email" type="email" name="email" value="${param.email}" required>
            </div>

            <div class="form-group">
                <label for="password">Password (min 6 chars)</label>
                <input id="password" type="password" name="password" required minlength="6">
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input id="confirmPassword" type="password" name="confirmPassword" required minlength="6">
            </div>

            <div class="form-group">
                <label for="course">Course</label>
                <select id="course" name="course">
                    <option value="Computer Science" ${param.course == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                    <option value="Software Engineering" ${param.course == 'Software Engineering' ? 'selected' : ''}>Software Engineering</option>
                    <option value="Artificial Intelligence" ${param.course == 'Artificial Intelligence' ? 'selected' : ''}>Artificial Intelligence</option>
                    <option value="Data Science" ${param.course == 'Data Science' ? 'selected' : ''}>Data Science</option>
                </select>
            </div>

            <button type="submit" class="btn btn-blue">Register</button>
            
            <div class="link-section">
                <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
            </div>
        </form>

        <p class="notice" style="text-align: center; font-size: 0.85rem; color: #666; margin-top: 15px;">
            By registering you agree to our <a href="https://students.yourlearning.ibm.com/about/terms/?_gl=1*q7ycac*_ga*MTgxMDY5NjIyOC4xNzcxNDMyNzM4*_ga_FYECCCS21D*czE3NzE2MTExMTYkbzIkZzEkdDE3NzE2MTExNDkkajI3JGwwJGgw&lang=en" style="color: #005A9E;">terms</a>.
        </p>
    </div>
</main>

</body>
</html>
