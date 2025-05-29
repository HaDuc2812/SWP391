<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Home Page</title>
        <style>
            html, body {
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                height: 100%;
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
                height: calc(100vh - 160px); /* Adjust based on navbar and footer */
                position: relative;
                overflow: hidden;
            }

            .slider-container {
                width: 100%;
                height: 100%;
                position: relative;
            }

            .slides {
                display: flex;
                width: 400%; /* 4 images */
                height: 100%;
                animation: slide 16s infinite;
            }

            .slides img {
                width: 100vw;
                height: 100%;
                object-fit: cover;
                flex-shrink: 0;
            }

            @keyframes slide {
                0% {
                    transform: translateX(0);
                }
                20% {
                    transform: translateX(0);
                }
                25% {
                    transform: translateX(-100vw);
                }
                45% {
                    transform: translateX(-100vw);
                }
                50% {
                    transform: translateX(-200vw);
                }
                70% {
                    transform: translateX(-200vw);
                }
                75% {
                    transform: translateX(-300vw);
                }
                95% {
                    transform: translateX(-300vw);
                }
                100% {
                    transform: translateX(0);
                }
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
                <div class="slider-container">
                    <div class="slides">
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6QWUpmPiDy4YTDFApC9NBJhH45oHNlQqNMw&s" alt="Product 1">
                        <img src="https://noithatkenli.vn/wp-content/uploads/2025/04/fantasia-cover.jpg" alt="Product 2">
                        <img src="https://shopnoithatgiare.com/data/product/z6105874360632_d9b66ff9addf0763b27b49d8c6c9c0d1.jpg" alt="Product 3">
                        <img src="https://shopnoithatgiare.com/data/product/sofa-chan-thuyen-go-soi-nga-0324%20(2).jpg" alt="Product 4">
                    </div>
                </div>
            </div>

        <jsp:include page="Footer.jsp"></jsp:include>

    </body>
</html>
