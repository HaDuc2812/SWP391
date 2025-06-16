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
        background-color: #ffffff;
        padding: 40px 30px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        max-width: 400px;
        width: 100%;
        text-align: center;
    }

    .form-container h2 {
        font-size: 24px;
        color: #2c3e50;
        margin-bottom: 25px;
    }

    .form-container input[type="password"] {
        width: 100%;
        padding: 12px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 14px;
    }

    .form-container button {
        width: 100%;
        background-color: #2980b9;
        color: white;
        padding: 12px;
        font-size: 16px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .form-container button:hover {
        background-color: #1f6391;
    }

    .form-container .error {
        margin-top: 10px;
        color: #e74c3c;
        background-color: #fcecec;
        padding: 10px;
        border-radius: 4px;
        font-size: 14px;
    }

    .form-container .success {
        margin-top: 10px;
        color: #2ecc71;
        background-color: #eafaf1;
        padding: 10px;
        border-radius: 4px;
        font-size: 14px;
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
