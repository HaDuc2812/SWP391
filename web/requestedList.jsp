<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="model.Order" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Requested Supplier Orders</title>
        <style>
            table {
                width: 90%;
                margin: 20px auto;
                border-collapse: collapse;
            }

            th, td {
                padding: 10px;
                border: 1px solid #aaa;
                text-align: center;
            }

            th {
                background-color: #f2f2f2;
            }

            h2 {
                text-align: center;
                margin-top: 30px;
            }
            .sidebar {
                width: 250px;
                min-height: 100vh;
            }
        </style>
    </head>
    <body>
        <div class="d-flex">

            <h2>All Supplier Orders</h2>
            
            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Supplier Name</th>
                    <th>Status</th>
                    <th>Placed By</th>
                    <th>Total Cost</th>
                    <th>Order Date</th>
                </tr>

                <%
                    List<Order> orders = (List<Order>) request.getAttribute("supplierOrders");
                    Map<Integer, String> supplierNames = (Map<Integer, String>) request.getAttribute("supplierNames");

                    if (orders != null && !orders.isEmpty()) {
                        for (Order o : orders) {
                            String supplierName = supplierNames.get(o.getSupplierId());
                %>
                <tr>
                    <td><%= o.getOrderId() %></td>
                    <td><%= supplierName != null ? supplierName : "Unknown" %></td>
                    <td><%= o.getStatus() %></td>
                    <td><%= o.getPlacedBy() %></td>
                    <td><%= o.getTotalCost() %>$</td>
                    <td><%= o.getOrderDate() %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr><td colspan="6">No supplier orders found.</td></tr>
                <% } %>
            </table>
            <a href="inventoryDashboard.jsp" class="btn">← Return to Dashboard</a>

    </body>
</html>
