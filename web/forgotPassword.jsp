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
                margin: 0;
                padding: 0;
            }

            .main-container {
                max-width: 600px;
                margin: 60px auto;
                padding: 30px;
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 30px;
            }

            label {
                font-weight: bold;
                display: block;
                margin-bottom: 8px;
            }

            .form-control {
                width: 100%;
                padding: 10px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 6px;
                margin-bottom: 20px;
            }

            .btn-primary {
                padding: 10px 20px;
                font-size: 14px;
                border-radius: 6px;
                border: none;
                background-color: #2980b9;
                color: white;
                cursor: pointer;
                width: 100%;
                transition: background-color 0.3s ease;
            }

            .btn-primary:hover {
                background-color: #1f6391;
            }

            .error-msg {
                color: red;
                text-align: center;
                margin-top: 10px;
            }

            @media (max-width: 600px) {
                .main-container {
                    margin: 30px 10px;
                    padding: 20px;
                }

                .btn-primary {
                    width: 100%;
                }
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

