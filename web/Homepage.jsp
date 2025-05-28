<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home Page</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
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

        .content {
            text-align: center;
            padding: 40px 20px 10px;
        }

        .slider-container {
            width: 100%;
            overflow: hidden;
            position: relative;
            margin-top: 20px;
        }

        .slides {
            display: flex;
            width: 400%;
            animation: slide 16s infinite;
        }

        .slides img {
            width: 80vw;
            height: 70vh;
            object-fit: cover;
        }

        @keyframes slide {
            0% { transform: translateX(0); }
            25% { transform: translateX(-100vw); }
            50% { transform: translateX(-200vw); }
            75% { transform: translateX(-300vw); }
            100% { transform: translateX(0); }
        }

        .footer {
            background-color: #2c3e50;
            color: #ecf0f1;
            text-align: center;
            padding: 20px 10px;
        }

        .footer p {
            margin: 5px 0;
        }
    </style>
</head>
<body>

    <jsp:include page="NavBar.jsp"></jsp:include>

<div class="content">
    <h1>Welcome to Our Furniture Shop</h1>
</div>

<div class="slider-container">
    <div class="slides">
        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToLqUFxy1FH1PNMghHTWyZ5sdGOapprHZyCQ&s" alt="Product 1">
        <img src="https://noithatcokhi.com/data/news/3279/ban-nang-ha-thong-minh-mat-go-tu-nhien.jpg" alt="Product 2">
        <img src="https://product.hstatic.net/1000310803/product/xg7_1024x1024.jpg" alt="Product 3">
        <img src="data:image/jpeg;base64,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" alt="Product 4">
    </div>
</div>

    <jsp:include page="Footer.jsp"></jsp:include>

</body>
</html>
