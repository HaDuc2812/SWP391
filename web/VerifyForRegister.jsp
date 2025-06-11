<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Xác minh đăng ký</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f4f4f4;
                margin: 0;
                padding: 50px;
            }
            .container {
                width: 400px;
                margin: auto;
                background: #fff;
                padding: 25px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                border-radius: 8px;
            }
            h2 {
                text-align: center;
                color: #333;
            }
            form {
                display: flex;
                flex-direction: column;
            }
            input[type="text"], input[type="submit"], button {
                padding: 10px;
                margin-top: 10px;
            }
            input[type="submit"] {
                background: #28a745;
                color: white;
                border: none;
                cursor: pointer;
            }
            input[type="submit"]:hover {
                background: #218838;
            }
            button {
                background: #007bff;
                color: white;
                border: none;
                cursor: pointer;
            }
            button:hover {
                background: #0069d9;
            }
            .error, .message {
                margin-top: 10px;
                text-align: center;
            }
            .error {
                color: red;
            }
            .message {
                color: green;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Nhập mã xác minh</h2>

            <!-- Verification form -->
            <form method="post" action="verify">
                <label for="code">Mã xác minh:</label>
                <input type="text" id="code" name="code" required placeholder="Nhập mã bạn nhận được qua email" />
                <input type="submit" value="Xác minh" />
            </form>

            <!-- Resend form -->
            <form method="post" action="resendVerification" style="margin-top: 15px;">
                <button type="submit">Gửi lại mã xác minh</button>
            </form>

            <!-- Display messages -->
            <%
                String error = (String) request.getAttribute("error");
                String message = (String) request.getAttribute("message");
                if (error != null) {
            %>
            <div class="error"><%= error %></div>
            <%
                } else if (message != null) {
            %>
            <div class="message"><%= message %></div>
            <%
                }
            %>
        </div>
    </body>
</html>
