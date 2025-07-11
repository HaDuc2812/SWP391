<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="entity.User" %>
<%@ page import="entity.Accounts" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>User Profile</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(to right, #dfe9f3, #ffffff);
                margin: 0;
                padding: 0;
            }

            .profile-container {
                max-width: 900px;
                margin: 60px auto;
                background-color: #ffffff;
                border-radius: 15px;
                box-shadow: 0 8px 24px rgba(0,0,0,0.1);
                padding: 40px;
            }

            .profile-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .profile-header h1 {
                font-size: 24px;
                color: #2c3e50;
            }

            .button-group {
                display: flex;
                gap: 10px;
            }

            .edit-button,
            .update-button {
                padding: 8px 16px;
                background-color: #3498db;
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .edit-button:hover,
            .update-button:hover {
                background-color: #2980b9;
            }

            .profile-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 25px;
                margin-top: 30px;
            }

            .profile-group label {
                font-weight: 600;
                font-size: 14px;
                margin-bottom: 6px;
                display: block;
                color: #34495e;
            }

            .profile-group input {
                width: 100%;
                padding: 10px 12px;
                font-size: 14px;
                border: 1px solid #dcdcdc;
                border-radius: 6px;
                background-color: #f8f8f8;
            }

            .footer {
                text-align: center;
                font-size: 14px;
                color: #888;
                margin-top: 40px;
            }
        </style>
    </head>
    <body>

        <div class="profile-container">
            <div class="profile-header">
                <h1>Welcome, <%= currentUser.getFullname() %></h1>
                <div class="button-group">
                    <form action="editProfile.jsp" method="post" style="margin: 0;">
                        <button type="submit" class="edit-button">Edit</button>
                    </form>
                    <form action="updateProfile" method="get" style="margin: 0;">
                        <button type="submit" class="update-button">Update Profile</button>
                    </form>
                </div>
            </div>

            <div class="profile-grid">
                <div class="profile-group">
                    <label>Full Name</label>
                    <input type="text" value="<%= currentUser.getFullname() %>" readonly />
                </div>
                <div class="profile-group">
                    <label>Email</label>
                    <input type="text" value="<%= currentUser.getEmail() %>" readonly />
                </div>
                <div class="profile-group">
                    <label>Phone Number</label>
                    <input type="text" value="<%= currentUser.getPhonenumber() %>" readonly />
                </div>
                <div class="profile-group">
                    <label>Gender</label>
                    <input type="text" value="<%= currentUser.getGender() %>" readonly />
                </div>
                <div class="profile-group">
                    <label>Address</label>
                    <input type="text" value="<%= currentUser.getAddress() %>" readonly />
                </div>
                <div class="profile-group">
                    <label>Date of Birth</label>
                    <input type="text" value="<%= currentUser.getDob() %>" readonly />
                </div>
                <div class="profile-group">
                    <label>Role</label>
                    <input type="text" value="<%= currentUser.getRole() %>" readonly />
                </div>
                <div class="profile-group">
                    <label>Status</label>
                    <input type="text" value="<%= currentUser.getStatus() %>" readonly />
                </div>
            </div>
        </div>

        <div class="footer">
            &copy; 2025 IMS. All rights reserved.
        </div>

    </body>
</html>
