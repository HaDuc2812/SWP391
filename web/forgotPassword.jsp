<%-- 
    Document   : forgotPassword
    Created on : Jun 6, 2025, 10:08:47 PM
    Author     : HA DUC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Send Verification Code</title>
         <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .main-container {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        .main-container h2 {
            color: #2c3e50;
            font-size: 24px;
            margin-bottom: 20px;
        }

        .main-container label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
            font-weight: bold;
            color: #34495e;
        }

        .main-container input[type="email"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .main-container input[type="submit"] {
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

        .main-container input[type="submit"]:hover {
            background-color: #1f6391;
        }
    </style>
    </head>
    <body>
        <div class="main-container">
            <h2>Reset Password</h2>
            <form action="forgotpassword" method="post">
                <label>Email:</label>
                <input type="email" name="email" required />
                <input type="hidden" name="purpose" value="forgotPassword" />
                <input type="submit" value="Send Verification Code" />
            </form>

        </div>
    </body>
</html>

