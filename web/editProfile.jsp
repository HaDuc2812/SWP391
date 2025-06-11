<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Profile</title>
        <!-- Add CSS here -->
    </head>
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

        .mb-3 {
            margin-bottom: 20px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .btn {
            padding: 10px 20px;
            font-size: 14px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-primary {
            background-color: #2980b9;
            color: white;
        }

        .btn-primary:hover {
            background-color: #1f6391;
        }

        .text-center {
            text-align: center;
        }

        p.text-center {
            color: green;
            font-weight: bold;
            margin-top: -10px;
            margin-bottom: 20px;
        }

        /* Responsive */
        @media (max-width: 600px) {
            .main-container {
                margin: 30px 10px;
                padding: 20px;
            }

            .btn {
                width: 100%;
            }
        }
    </style>

    <body>
        <div class="main-container">
            <h2>Edit Profile</h2>

            <form action="updateuser" method="POST" class="mb-3">
                <div class="mb-3">
                    <input type="text" id="name" name="name" class="form-control" placeholder="Name">
                </div>

                <div class="mb-3">
                    <input type="text" id="phone" name="phone" class="form-control" placeholder="Phone">
                </div>

                <div class="mb-3">
                    <input type="text" id="address" name="address" class="form-control" placeholder="Address">
                </div>

                <div class="mb-3">
                    <input type="password" id="password" name="password" class="form-control mb-2" placeholder="New Password">
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control mb-2" placeholder="Confirm Password">
                </div>

                <p id="error-msg" style="color: red; margin-top: 5px;"></p>

                <div class="text-center" style="margin-top: 15px;">
                    <button type="submit" class="btn btn-primary">Update</button>
                </div>
            </form>

        </div>
    </body>
</html>
