<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Goods" %>
<%
    String searchKey = (String) request.getAttribute("searchKey");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product List - Cards</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f6f8;
                margin: 0;
                padding: 20px;
            }

            .search-bar {
                text-align: center;
                margin-bottom: 20px;
            }

            .search-bar input {
                padding: 8px;
                width: 250px;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            .search-bar button {
                padding: 8px 12px;
                border-radius: 5px;
                background-color: #2c3e50;
                color: #fff;
                border: none;
                cursor: pointer;
            }

            .title {
                text-align: center;
                font-size: 26px;
                font-weight: bold;
                margin-bottom: 20px;
                color: #2c3e50;
            }

            .card-container {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                justify-content: center;
            }

            .product-card {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                padding: 20px;
                width: 250px;
                transition: transform 0.2s ease;
            }

            .product-card:hover {
                transform: translateY(-5px);
            }

            .product-name {
                font-size: 18px;
                font-weight: bold;
                color: #2c3e50;
                margin-bottom: 10px;
            }

            .product-category {
                font-size: 14px;
                color: #7f8c8d;
                margin-bottom: 8px;
            }

            .product-price {
                font-size: 16px;
                font-weight: bold;
                color: #27ae60;
            }
        </style>
    </head>
    <body>

        <form action="search" method="get" class="search-bar">
            <input type="text" name="searchKey" placeholder="Search by name or category" value="<%= searchKey != null ? searchKey : "" %>">
            <button type="submit">Search</button>
        </form>

        <div class="title">
            <%= (request.getAttribute("searchKey") != null && !((String) request.getAttribute("searchKey")).trim().isEmpty()) 
                ? "Search Results for: \"" + request.getAttribute("searchKey") + "\"" 
                : "All Available Products" 
            %>
            <a href="Homepage.jsp">return to Home</a>
        </div>

        <div class="card-container">
            <%
                List<Goods> goodsList = (List<Goods>) request.getAttribute("goodsList");
                if (goodsList != null && !goodsList.isEmpty()) {
                    for (Goods g : goodsList) {
            %>
            <div class="product-card">
                <div class="product-name"><%= g.getName() %></div>
                <div class="product-category">Category: <%= g.getCategory() %></div>
                <div class="product-price">$<%= g.getPrice() %></div>
                <div class="product-stocks">Stock: <%= g.getQuantity() %></div>
            </div>
            <%
                    }
                } else {
            %>
            <p>No products found.</p>
            <%
                }
            %>
        </div>
        <form action="Homepage.jsp" method="get">
            <button type="submit">Return to Home</button>
        </form>
    </body>
</html>
