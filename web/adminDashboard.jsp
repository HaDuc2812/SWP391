<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<%
    Object currentUser = session.getAttribute("user");
    String fullName = (String) session.getAttribute("userName");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
            }

            .dashboard-container {
                display: flex;
                height: 100vh;
            }

            /* Sidebar */
            .sidebar {
                width: 220px;
                background-color: #2c3e50;
                color: white;
                padding: 20px;
                display: flex;
                flex-direction: column;
            }

            .sidebar h2 {
                font-size: 18px;
                margin-bottom: 20px;
            }

            .nav-btn {
                background-color: #34495e;
                color: white;
                border: none;
                padding: 10px;
                margin-bottom: 10px;
                text-align: left;
                cursor: pointer;
                border-radius: 4px;
            }

            .nav-btn:hover {
                background-color: #1abc9c;
            }

            .user-info {
                margin-top: auto;
                font-size: 14px;
            }

            .user-info a {
                color: #e74c3c;
                text-decoration: none;
            }

            /* Main Content */
            .main-content {
                flex-grow: 1;
                padding: 30px;
                background-color: #ecf0f1;
                overflow-y: auto;
            }

            .content-section {
                display: none;
            }

            .content-section.active-section {
                display: block;
            }
        </style>
    </head>
    <body>
        <div class="dashboard-container">
            <!-- Sidebar Navigation -->
            <div class="sidebar">
                <h2>Admin Dashboard</h2>
                <button class="nav-btn" onclick="showSection('goods')">Hàng Hóa</button>
                <button class="nav-btn" onclick="showSection('suppliers')">Nhà Cung Cấp</button>
                <button class="nav-btn" onclick="showSection('orders')">Đơn Hàng</button>
                <button class="nav-btn" onclick="showSection('requests')">Yêu Cầu KH</button>

                <div class="user-info">
                    <% if (currentUser != null) { %>
                    <span>Xin chào, <%= fullName %></span><br>
                    <a href="logout">[Đăng Xuất]</a>
                    <% } else { %>
                    <a href="Login.jsp">Đăng Nhập</a><br>
                    <a href="register.jsp">Đăng Ký</a>
                    <% } %>
                </div>
            </div>

            <!-- Main Content -->
            <div class="main-content">
                <div id="goods" class="content-section active-section">
                    <h2>Danh sách Hàng Hóa</h2>
                    <table class="goods-table">
                        <thead>…</thead>
                        <tbody>
                        <c:forEach var="g" items="${goodsList}">
                            <tr>
                                <td>${g.goodId}</td>
                                <td>${g.goodName}</td>
                                <td>${g.category}</td>
                                <td><fmt:formatNumber value="${g.price}" type="currency"/></td>
                            <td>${g.quantity}</td>
                            <td>${g.supplierId}</td>
                            <td><fmt:formatDate value="${g.addedOn}" pattern="yyyy-MM-dd HH:mm"/></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty goodsList}">
                            <tr><td colspan="7" style="text-align:center;">Chưa có hàng hóa nào.</td></tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>

                <div id="suppliers" class="content-section">
                    <h2>Thông tin Nhà Cung Cấp</h2>
                    <%-- Add supplier info --%>
                </div>

                <div id="orders" class="content-section">
                    <h2>Đơn Hàng</h2>
                    <%-- Add order data --%>
                </div>

                <div id="requests" class="content-section">
                    <h2>Yêu Cầu Khách Hàng</h2>
                    <%-- Add customer requests --%>
                </div>
            </div>
        </div>

        <script>
            function showSection(sectionId) {
                var sections = document.getElementsByClassName('content-section');
                for (var i = 0; i < sections.length; i++) {
                    sections[i].classList.remove('active-section');
                }
                document.getElementById(sectionId).classList.add('active-section');
            }
        </script>
    </body>

</html>

