<%-- 
    Document   : NavBar
    Created on : Jun 16, 2025, 10:10:23 AM
    Author     : HA DUC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
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
    .navbar .nav-links form {
        display: inline-flex;
    }
</style>
<html>
    <%@page import="model.User" %>
    <%
        // Lấy thông tin user (nếu đã đăng nhập)
        User currentUser = (User) session.getAttribute("user");
        String fullName = currentUser != null ? currentUser.getFull_name() : "Khách";
    %>
    <div class="navbar">
        <div class="nav-links">
                <form action="search" method="get">
                    <input type="text" name="searchKey" placeholder="search">
                    <button type="submit">Search</button>
                </form>
        <a href="home" class="logo">IMS Dashboard</a>
        <div class="nav-links">
            <a href="Homepage.jsp">Home</a>
            <a href="MainPage.jsp">Hàng Hóa</a>
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
</html>
