<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%@page import="model.User" %>
<%
    // Lấy thông tin user (nếu đã đăng nhập)
    User currentUser = (User) session.getAttribute("user");
    String fullName = currentUser != null ? currentUser.getFull_name() : "Khách";
%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Home Page</title>
        <style>
            /* Reset cơ bản */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f8;
            }
            /* Navbar */
            .navbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #2c3e50;
                padding: 10px 20px;
            }
            .navbar .logo {
                color: #ecf0f1;
                font-size: 24px;
                font-weight: bold;
                text-decoration: none;
            }
            .navbar .nav-links a {
                text-decoration: none;
                color: #bdc3c7;
                margin-left: 20px;
                font-size: 16px;
            }
            .navbar .nav-links a:hover {
                color: #ecf0f1;
            }
            /* Container chính */
            .container {
                max-width: 1200px;
                margin: 30px auto;
                padding: 0 20px;
            }
            /* Phần chào mừng */
            .welcome {
                margin-bottom: 30px;
            }
            .welcome h2 {
                font-size: 28px;
                color: #2c3e50;
            }
            /* Thống kê */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 20px;
            }
            .stat-card {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                padding: 20px;
                text-align: center;
            }
            .stat-card h3 {
                font-size: 22px;
                color: #34495e;
                margin-bottom: 10px;
            }
            .stat-card p {
                font-size: 36px;
                color: #e74c3c;
                font-weight: bold;
            }
            /* Footer */
            .footer {
                text-align: center;
                margin-top: 40px;
                color: #7f8c8d;
                font-size: 14px;
                padding: 20px 0;
            }
        </style>
    </head>
    <body>

        <!-- Navbar -->
        <div class="navbar">
            <a href="home" class="logo">IMS Dashboard</a>
            <div class="nav-links">
                <form action="search" method="get" style="display: flex">
                    <input type="text" name ="searchKey" placeholder="search">
                    <button type="submit" style="padding: 5px 10px">Search</button>
                </form><br>
                <a href="goods">Hàng Hóa</a>
                <a href="suppliers">Nhà Cung Cấp</a>
                <a href="orders">Đơn Hàng</a>
                <a href="requests">Yêu Cầu KH</a>
                <% if (currentUser != null) { %>
                <a href="userprofile.jsp">Xin chào, <%= fullName %></a>
                <a href="logout">Đăng Xuất</a>
                <% } else { %>
                <a href="Login.jsp">Đăng Nhập</a>
                <a href="register.jsp">Đăng Ký</a>
                <% } %>
            </div>
        </div>

        <div class="container">
            <!-- Phần chào mừng người dùng -->
            <div class="welcome">
                <h2>Chào mừng, <%= fullName %>!</h2>
                <p>Đây là trang tổng quan (Dashboard) của hệ thống Quản lý Kho Hàng.</p>
            </div>

            <!-- Thống kê sơ bộ -->
            <div class="stats-grid">
                <div class="stat-card">
                    <h3>Tổng số hàng hóa</h3>
                    <p><%= request.getAttribute("totalGoods") %></p>
                </div>
                <div class="stat-card">
                    <h3>Tổng số nhà cung cấp</h3>
                    <p><%= request.getAttribute("totalSuppliers") %></p>
                </div>
                <div class="stat-card">
                    <h3>Tổng số đơn hàng</h3>
                    <p><%= request.getAttribute("totalOrders") %></p>
                </div>
                <div class="stat-card">
                    <h3>Yêu cầu KH</h3>
                    <p><%= request.getAttribute("totalRequests") %></p>
                </div>
            </div>

            <!-- Mục điều hướng nhanh (nếu cần) -->
            <div style="margin-top: 40px;">
                <h3>Thao tác nhanh:</h3>
                <ul>
                    <li><a href="goods">Quản lý Hàng Hóa</a></li>
                    <li><a href="suppliers">Quản lý Nhà Cung Cấp</a></li>
                    <li><a href="orders">Quản lý Đơn Hàng</a></li>
                    <li><a href="requests">Danh sách Yêu Cầu KH</a></li>
                </ul>
            </div>
        </div>

                
                
                
           
        <!-- Footer -->
        <div class="footer">
            &copy; 2025 IMS. Tất cả quyền được bảo lưu.
        </div>

    </body>
</html>
