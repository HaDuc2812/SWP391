<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="entity.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Profile</title>
        <!-- Add CSS here -->
    </head>


    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }

        .main-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="date"],
        select {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        input:focus,
        select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
        }

        button[type="submit"] {
            padding: 12px;
            background-color: #007bff;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #0056b3;
        }

        p#error-msg,
        p[style*="color: red"] {
            color: red;
            font-size: 14px;
            margin-top: 5px;
            text-align: center;
        }

        @media (max-width: 600px) {
            .main-container {
                margin: 20px;
                padding: 20px;
            }

            input,
            select {
                font-size: 16px;
            }
        }
    </style>
    <body>
        <div class="main-container">
            <h2>Edit Profile</h2>

            <form action="updateuser" method="POST">
                <label>Full Name</label>
                <input type="text" name="fullname" value="<%= currentUser.getFullname() %>" required><br/>

                <label>Email</label>
                <input type="email" name="email" value="<%= currentUser.getEmail() %>" readonly><br/>

                <label>Phone Number</label>
                <input type="text" name="phonenumber" value="<%= currentUser.getPhonenumber() %>"><br/>

                <label>Gender</label>
                <select name="gender">
                    <option value="Male" <%= "Male".equals(currentUser.getGender()) ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= "Female".equals(currentUser.getGender()) ? "selected" : "" %>>Female</option>
                    <option value="Other" <%= "Other".equals(currentUser.getGender()) ? "selected" : "" %>>Other</option>
                </select><br/>

                <label>Address</label>
                <input type="text" name="address" value="<%= currentUser.getAddress() %>"><br/>

                <label>Date of Birth</label>
                <input type="date" name="dob" value="<%= currentUser.getDob() != null ? currentUser.getDob().toString() : "" %>"><br/>

                <label>Status</label>
                <select name="status">
                    <option value="Active" <%= "Active".equals(currentUser.getStatus()) ? "selected" : "" %>>Active</option>
                    <option value="Inactive" <%= "Inactive".equals(currentUser.getStatus()) ? "selected" : "" %>>Inactive</option>
                </select><br/>

                <label>Old Password</label>
                <input type="password" name="oldPassword"><br/>

                <label>New Password</label>
                <input type="password" name="password"><br/>

                <label>Confirm New Password</label>
                <input type="password" name="confirmPassword"><br/>

                <button type="submit">Update Profile</button>

                <% String message = (String) request.getAttribute("mess"); %>
                <% if (message != null) { %>
                <p style="color: red;"><%= message %></p>
                <% } %>
            </form>
        </div>
    </body>
</html>
