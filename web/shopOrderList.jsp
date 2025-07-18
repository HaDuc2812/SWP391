<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Order" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*, model.Order, dal.DAO" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    DAO dao = new DAO(); // create once to reuse
%>
<html>
    <head>
        <title>Shop Orders</title>
        <style>
            table {
                width: 80%;
                margin: auto;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #f0f0f0;
            }
        </style>
    </head>
    <body>
        <h2 style="text-align:center;">Orders from Shops to Storage</h2>
        <table>
            <tr>
                <th>Order ID</th>
                <th>Shop ID</th>
                <th>Order Date</th>
                <th>Status</th>
                <th>Total Cost</th>
                <th>Placed By</th>
            </tr>
            <% if (orders != null) {
                for (Order order : orders) {
            %>
            <tr>
                <td><%= order.getOrderId() %></td>
                <td><%= dao.getShopNameById(order.getShopid()) %></td>
                <td><%= order.getOrderDate() %></td>
                <td><%= order.getStatus() %></td>
                <td><%= order.getTotalCost() %></td>
                <td><%= dao.getUsernameById(order.getPlacedBy()) %></td>
                <td>
                    <a href="orderDetail?order_id=<%= order.getOrderId() %>" class = "btn btn-info"> view details</a>
                </td>
            </tr>
            <%  }
}               else { %>
            <tr><td colspan="4">No orders found.</td></tr>
            <% } %>
        </table>
        <!-- Back Button Form -->
        <form action="inventoryDashboard.jsp" method="get" style="display: inline;">
            <button type="submit" class="btn-back" style="padding: 10px 20px; background-color: gray; color: white; border: none; border-radius: 5px;">
                ⬅ Back to Dashboard
            </button>
        </form>
    </body>
</html>