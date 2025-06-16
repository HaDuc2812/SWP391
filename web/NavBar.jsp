<%-- 
    Document   : NavBar
    Created on : Jun 16, 2025, 10:10:23 AM
    Author     : HA DUC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@page import="model.User" %>
    <%
        // Lấy thông tin user (nếu đã đăng nhập)
        User currentUser = (User) session.getAttribute("user");
        String fullName = currentUser != null ? currentUser.getFull_name() : "Khách";
    %>
    <div class="navbar">
        <a href="home" class="logo">IMS Dashboard</a>
        <div class="nav-links">
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
</html>
