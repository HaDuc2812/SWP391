<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            max-width: 400px;
            width: 100%;
        }

        input[type="password"], button {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            font-size: 14px;
        }

        .error {
            color: red;
            margin-top: 10px;
        }

        .success {
            color: green;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Reset Your Password</h2>
        <form action="updatepassword" method="post">
            <input type="password" name="newPassword" placeholder="New Password" required />
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required />
            <button type="submit">Update Password</button>
        </form>
        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
        <c:if test="${not empty success}">
            <p class="success">${success}</p>
        </c:if>
    </div>
</body>
</html>
