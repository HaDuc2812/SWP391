<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entity.User" %>

<%
    User currentUser = (User) session.getAttribute("user"); // Full profile loaded after login
    Object rawUser = session.getAttribute("user");
    if (rawUser == null) {
        out.println("Session has no 'user'");
    } else {
        out.println("User class is: " + rawUser.getClass().getName());
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Home Page</title>
        <style>
            /* Reset and layout styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f8;
            }

            .navbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #2c3e50;
                padding: 10px 20px;
            }

            .navbar a {
                color: #bdc3c7;
                text-decoration: none;
                margin-left: 20px;
                font-size: 16px;
            }

            .navbar a:hover {
                color: #ecf0f1;
            }

            .navbar form {
                display: inline-flex;
            }

            /* Slider styles */
            .slider {
                width: 800px;
                height: 500px;
                overflow: hidden;
                margin: 40px auto;
                position: relative;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.2);
            }

            .slides {
                display: flex;
                width: 300%;
                transition: transform 0.5s ease-in-out;
            }

            .slide {
                width: 800px;
                flex-shrink: 0;
                position: relative;
            }

            .slide img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 10px;
            }

            .slide-caption {
                position: absolute;
                bottom: 20px;
                left: 20px;
                background: rgba(0,0,0,0.5);
                color: white;
                padding: 10px;
                border-radius: 5px;
            }

            .arrow {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                background: rgba(0,0,0,0.5);
                color: white;
                border: none;
                padding: 10px 15px;
                font-size: 24px;
                cursor: pointer;
                border-radius: 50%;
                z-index: 10;
            }

            .arrow.prev {
                left: 20px;
            }
            .arrow.next {
                right: 20px;
            }

            .slide-buttons {
                text-align: center;
                margin-top: 10px;
            }

            .dot {
                height: 12px;
                width: 12px;
                margin: 0 5px;
                background-color: #bbb;
                border-radius: 50%;
                display: inline-block;
                cursor: pointer;
            }

            .dot.active {
                background-color: #333;
            }

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
            <div>
                <form action="search" method="get" style="display:inline;">
                    <input type="text" name="searchKey" placeholder="Search">
                    <button type="submit">Search</button>
                </form>
                <a href="${pageContext.request.contextPath}/list">Product List</a>
                <a href="orders">Orders</a>
                <a href="${pageContext.request.contextPath}/loadFurniture?action=shopsPlaceOrders.jsp">Custom Request</a>
            </div>
            <div>
                <% if (currentUser != null) { %>
                <a href="userprofile.jsp">Hello, <%= currentUser.getFullname() %></a>
                <a href="logout">Logout</a>
                <% } else { %>
                <a href="Login.jsp">Login</a>
                <a href="register.jsp">Register</a>
                <% } %>
            </div>
        </div>

        <!-- Slider -->
        <div class="slider">
            <div class="slides" id="slides">
                <div class="slide">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8zU4XwfH8MtQqKI_qP6lXNDwTOQlhz7w2DQ&s" alt="Slide 1" />
                    <div class="slide-caption">Quản lý Hàng Hóa dễ dàng</div>
                </div>
                <div class="slide">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfaoxs8GYlhlAjgv0LEdD5snefNu--CuAfzg&s" alt="Slide 2">
                    <div class="slide-caption">Theo dõi Đơn Hàng nhanh chóng</div>
                </div>
                <div class="slide">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8q_FLE47LS5WZIwhcGw4oL_YRbjgI9t9Axg&s" alt="Slide 3">
                    <div class="slide-caption">Quản lý nhà cung cấp hiệu quả</div>
                </div>
            </div>

            <button class="arrow prev" onclick="prevSlide()">&#10094;</button>
            <button class="arrow next" onclick="nextSlide()">&#10095;</button>
        </div>

        <div class="slide-buttons" id="slide-buttons">
            <button onclick="goToSlide(0)" class="dot active"></button>
            <button onclick="goToSlide(1)" class="dot"></button>
            <button onclick="goToSlide(2)" class="dot"></button>
        </div>

        <!-- Footer -->
        <div class="footer">
            &copy; 2025 IMS. Tất cả quyền được bảo lưu.
        </div>

        <script>
            const slides = document.getElementById('slides');
            const totalSlides = document.querySelectorAll('.slide').length;
            const slideWidth = 800;
            const dots = document.querySelectorAll('.dot');
            let index = 0;

            function showSlide(i) {
                slides.style.transform = `translateX(-${i * slideWidth}px)`;
                dots.forEach(dot => dot.classList.remove('active'));
                dots[i].classList.add('active');
            }

            function nextSlide() {
                index = (index + 1) % totalSlides;
                showSlide(index);
            }

            function prevSlide() {
                index = (index - 1 + totalSlides) % totalSlides;
                showSlide(index);
            }

            function goToSlide(i) {
                index = i;
                showSlide(i);
            }
        </script>

    </body>
</html>
