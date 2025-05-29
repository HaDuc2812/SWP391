<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Register - My Web Shop</title>
        <style>
            /* Similar styling as login page */
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                margin: 0;
            }
            .container {
                max-width: 400px;
                margin: 80px auto;
                padding: 30px;
                background: white;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
                border-radius: 8px;
                text-align: center;
            }
            input[type=text], input[type=password], input[type=email] {
                width: 100%;
                padding: 12px;
                margin: 8px 0 20px;
                border: 1px solid #ccc;
                border-radius: 6px;
            }
            input[type=submit] {
                background-color: #1abc9c;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 16px;
            }
            input[type=submit]:hover {
                background-color: #16a085;
            }
            p.error {
                color: red;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2>Create Your Account</h2>
            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
            <p class="error"><%= error %></p>
            <% } %>

            <form action="register" method="post">
                <input type="text" name="username" placeholder="Username" required />
                <input type="password" name="password" placeholder="Password" required />
                <input type="text" name="fullName" placeholder="Full Name" />
                <input type="email" name="email" placeholder="Email" required />
                <input type="submit" value="Register" />
            </form>
        </div>

    </body>
</html>
