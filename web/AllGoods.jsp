<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Goods, model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    String fullName = currentUser != null ? currentUser.getFull_name() : "Khách";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>All Goods</title>
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                font-family: Arial, sans-serif;
            }

            .navbar {
                background-color: #333;
                padding: 10px 20px;
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .navbar .logo {
                font-weight: bold;
                font-size: 20px;
                color: white;
                text-decoration: none;
            }

            .nav-links a,
            .nav-links form {
                color: white;
                margin-left: 15px;
                text-decoration: none;
                display: inline-block;
            }

            .nav-links input {
                padding: 5px;
            }

            .nav-links button {
                padding: 5px 10px;
            }

            .page-layout {
                display: flex;
                height: calc(100vh - 50px); /* minus navbar height */
            }

            .filter-sidebar {
                width: 250px;
                background-color: #f5f5f5;
                padding: 20px;
                overflow-y: auto;
                border-right: 1px solid #ccc;
            }

            .main-content {
                flex: 1;
                padding: 20px;
                overflow-y: auto;
            }
            .category-group{
                margin-bottom: 20px;
            }
            .category-group label{
                display:flex;
                align-items: center;
                margin: 4px 0;
                font-size: 14px
            }
            .category-group input[type="checkbox"]{
                margin-right: 8px;
            }

            h2 {
                text-align: center;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                border: 1px solid #ccc;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #eee;
            }

            .popup-alert {
                position: fixed;
                bottom: 20px;
                right: 20px;
                width: 300px;
                background-color: #ffdddd;
                color: #a94442;
                border: 1px solid red;
                padding: 15px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0,0,0,0.2);
                z-index: 1000;
                animation: fadeInOut 8s ease-in-out forwards;
            }

            @keyframes fadeInOut {
                0% {
                    opacity: 0;
                    transform: translateY(20px);
                }
                10% {
                    opacity: 1;
                    transform: translateY(0);
                }
                80% {
                    opacity: 1;
                }
                100% {
                    opacity: 0;
                    transform: translateY(20px);
                }
            }
        </style>
    </head>
    <body>

        <!-- Navbar -->
        <div class="navbar">
            <a href="home" class="logo">IMS Dashboard</a>
            <div class="nav-links">
                <form action="search" method="get" style="display:inline;">
                    <input type="text" name="searchKey" placeholder="Search">
                    <button type="submit">Search</button>
                </form>
                <a href="${pageContext.request.contextPath}/list">Product List</a>
                <a href="suppliers">Suppliers</a>
                <a href="orders">Orders</a>
                <a href="requests">Custom Request</a>
                <% if (currentUser != null) { %>
                <a href="userprofile.jsp">Hello, <%= fullName %></a>
                <a href="logout">Logout</a>
                <% } else { %>
                <a href="Login.jsp">Login</a>
                <a href="register.jsp">Register</a>
                <% } %>
            </div>
        </div>

        <!-- Main Layout -->
        <div class="page-layout">

            <!-- Sidebar -->
            <div class="filter-sidebar">
                <h3>Filter by Category</h3>
                <form action="filter" method="get">
                    <div class="category-group">
                        <strong>Chair</strong><br>
                        <label><input type="checkbox" name="category" value="Gaming Chair"> Gaming Chair</label>
                        <label><input type="checkbox" name="category" value="Office Chair"> Office Chair</label>
                        <label><input type="checkbox" name="category" value="Dining Chair"> Dining Chair</label>
                        <label><input type="checkbox" name="category" value="Recliner Chair"> Recliner Chair</label>
                        <label><input type="checkbox" name="category" value="Rocking Chair"> Rocking Chair</label>
                        <label><input type="checkbox" name="category" value="Folding Chair"> Folding Chair</label>
                        <label><input type="checkbox" name="category" value="Bar Chair"> Bar Chair</label>
                        <label><input type="checkbox" name="category" value="Casual Chair"> Casual Chair</label>
                        <label><input type="checkbox" name="category" value="Kids Chair"> Kids Chair</label>
                        <label><input type="checkbox" name="category" value="Outdoor Chair"> Outdoor Chair</label>
                    </div>

                    <div class="category-group">
                        <strong>Table</strong><br>
                        <label><input type="checkbox" name="category" value="Gaming Table"> Gaming Table</label>
                        <label><input type="checkbox" name="category" value="Dining Table"> Dining Table</label>
                        <label><input type="checkbox" name="category" value="Coffee Table"> Coffee Table</label>
                        <label><input type="checkbox" name="category" value="Side Table"> Side Table</label>
                        <label><input type="checkbox" name="category" value="Study Table"> Study Table</label>
                        <label><input type="checkbox" name="category" value="Outdoor Table"> Outdoor Table</label>
                        <label><input type="checkbox" name="category" value="Meeting Table"> Meeting Table</label>
                        <label><input type="checkbox" name="category" value="Utility Table"> Utility Table</label>
                        <label><input type="checkbox" name="category" value="Wall Table"> Wall Table</label>
                        <label><input type="checkbox" name="category" value="Computer Table"> Computer Table</label>
                    </div>

                    <div class="category-group">
                        <strong>Other</strong><br>
                        <label><input type="checkbox" name="category" value="Sofa"> Sofa</label>
                        <label><input type="checkbox" name="category" value="Shelf"> Shelf</label>
                        <label><input type="checkbox" name="category" value="Bed"> Bed</label>
                        <label><input type="checkbox" name="category" value="Wardrobe"> Wardrobe</label>
                        <label><input type="checkbox" name="category" value="Bench"> Bench</label>
                        <label><input type="checkbox" name="category" value="Workstation">Workstation</label>
                    </div>
                    <h3>Price Range</h3>
                    <div class="category-group">
                        <label><input type="radio" name="priceRange" value="0-99"> $0 – $99</label>
                        <label><input type="radio" name="priceRange" value="100-199"> $100 – $199</label>
                        <label><input type="radio" name="priceRange" value="200-299"> $200 – $299</label>
                        <label><input type="radio" name="priceRange" value="300-399"> $300 – $399</label>
                        <label><input type="radio" name="priceRange" value="400-499"> $400 – $499</label>
                        <label><input type="radio" name="priceRange" value="500-599"> $500 – $599</label>
                        <label><input type="radio" name="priceRange" value="600-699"> $600 – $699</label>
                        <label><input type="radio" name="priceRange" value="700-800"> $700 – $800</label>
                    </div>

                    <hr>
                    <button type="submit">Apply Filters</button>
                </form>
            </div>

            <!-- Main Content -->
            <div class="main-content">
                <h2>Product List</h2>

                <% 
    List<Goods> lowStockGoods = (List<Goods>) request.getAttribute("lowStockGoods");
    if (currentUser != null && 
       ("admin".equals(currentUser.getRole()) || "manager".equals(currentUser.getRole())) &&
       lowStockGoods != null && !lowStockGoods.isEmpty()) { 
                %>
                <div class="popup-alert">
                    <strong>⚠ Low Stock Alert:</strong>
                    <ul style="padding-left: 18px;">
                        <% for (Goods g : lowStockGoods) { %>
                        <li><strong><%= g.getName() %></strong>: <%= g.getQuantity() %> left</li>
                                <% } %>
                    </ul>
                </div>
                <% } %>

                <% List<Goods> goodsList = (List<Goods>) request.getAttribute("goodsList");
        if (goodsList == null || goodsList.isEmpty()) { %>
                <p style="text-align:center;">No products found.</p>
                <% } else { %>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Supplier</th>
                        <th>Added On</th>
                    </tr>
                    <% for (Goods g : goodsList) { %>
                    <tr>
                        <td><%= g.getGood_id() %></td>
                        <td><%= g.getName() %></td>
                        <td><%= g.getDescription() %></td>
                        <td><%= g.getCategory() %></td>
                        <td><%= g.getPrice() %>$</td>
                        <td><%= g.getQuantity() %></td>
                        <td><%= g.getSupplier_id() %></td>
                        <td><%= g.getAdded_on() %></td>
                    </tr>
                    <% } %>
                </table>
                <% } %>
            </div>
        </div>

    </body>
</html>
