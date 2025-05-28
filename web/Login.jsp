<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login - My Web Shop</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
            }

            .navbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #2c3e50;
                padding: 10px 20px;
            }

            .navbar .logo {
                color: #fff;
                font-size: 24px;
                font-weight: bold;
                text-decoration: none;
            }

            .nav-links a {
                text-decoration: none;
                color: #ecf0f1;
                margin-left: 15px;
                padding: 8px 16px;
                background-color: #34495e;
                border-radius: 4px;
                transition: background-color 0.3s;
            }

            .nav-links a:hover {
                background-color: #1abc9c;
            }

            .login-container {
                max-width: 400px;
                margin: 80px auto;
                padding: 30px;
                background-color: #ffffff;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
                border-radius: 8px;
                text-align: center;
            }

            .login-container h2 {
                margin-bottom: 20px;
                color: #2c3e50;
            }

            .login-container input[type="text"],
            .login-container input[type="password"] {
                width: 100%;
                padding: 12px;
                margin: 8px 0 20px;
                border: 1px solid #ccc;
                border-radius: 6px;
            }

            .login-container input[type="submit"] {
                background-color: #1abc9c;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 16px;
            }

            .login-container input[type="submit"]:hover {
                background-color: #16a085;
            }

            .footer {
                background-color: #2c3e50;
                color: #ecf0f1;
                text-align: center;
                padding: 20px 10px;
                position: absolute;
                bottom: 0;
                width: 100%;
            }

            .footer p {
                margin: 5px 0;
            }
        </style>
    </head>
    <body>

        <jsp:include page="NavBar.jsp"></jsp:include>

            <div class="login-container">
                <h2>Login to Your Account</h2>
                <form action="LoginServlet" method="post">
                    <input type="text" name="username" placeholder="Username" required><br>
                    <input type="password" name="password" placeholder="Password" required><br>
                    <input type="submit" value="Login">

                </form>
                <div style="margin-top: 15px;">
                    <a href="META-INF/../register.jsp" class="btn-link">Register</a> | 
                    <a href="forgotPassword.jsp" class="btn-link">Forgot Password?</a>
                </div>
            </div>
        <jsp:include page="Footer.jsp"></jsp:include>


    </body>
</html>
