<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map, model.OrderItem" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String shopName = (String) request.getAttribute("shopName");
    Integer orderId = (Integer) request.getAttribute("orderId");
    List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");
    Map<Integer, String> comboNames = (Map<Integer, String>) request.getAttribute("comboNames");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Order Receipt</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 40px;
            }
            .receipt-header {
                border-bottom: 2px solid #333;
                padding-bottom: 10px;
                margin-bottom: 20px;
            }
            .receipt-info {
                margin-bottom: 20px;
            }
            .receipt-info p {
                margin: 5px 0;
            }
            table {
                border-collapse: collapse;
                width: 100%;
            }
            th, td {
                padding: 12px;
                border: 1px solid #ccc;
                text-align: left;
            }
            th {
                background-color: #f0f0f0;
            }
            .total-row {
                font-weight: bold;
            }
            .btn-back {
                margin-top: 30px;
            }
        </style>
    </head>
    <body>

        <div class="receipt-header">
            <h2>📦 Order Receipt</h2>
        </div>

        <div class="receipt-info">
            <p><strong>Order ID:</strong> <%= orderId %></p>
            <p><strong>Ship to:</strong> <%= shopName %></p>
            <p><strong>Number of Items:</strong> <%= (orderItems != null ? orderItems.size() : "0") %></p>
        </div>

        <c:choose>
            <c:when test="${not empty orderItems}">
                <table>
                    <thead>
                        <tr>
                            <th>Combo ID</th>
                            <th>Combo Name</th>
                            <th>Quantity</th>
                            <th>Unit Price</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="totalCost" value="0" />
                        <c:forEach var="item" items="${orderItems}">
                            <c:set var="lineTotal" value="${item.quantity * item.unitPrice}" />
                            <c:set var="totalCost" value="${totalCost + lineTotal}" />
                            <tr>
                                <td>${item.good_id}</td>
                                <td>${comboNames[item.good_id]}</td>
                                <td>${item.quantity}</td>
                                <td>${item.unitPrice}</td>
                                <td>${lineTotal}</td>
                            </tr>
                        </c:forEach>
                        <tr class="total-row">
                            <td colspan="4" style="text-align: right;">Grand Total:</td>
                            <td>${totalCost}</td>
                        </tr>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p>No items found for this order.</p>
            </c:otherwise>
        </c:choose>
        <!-- Buttons Section -->
        <div style="margin-top: 20px;">
            <!-- Approve Button Form -->
            <form action="${pageContext.request.contextPath}/approveorders" method="post" style="display: inline;">
                <input type="hidden" name="orderId" value="<%= orderId %>" />
                <button type="submit" class="btn-approve" style="padding: 10px 20px; background-color: green; color: white; border: none; border-radius: 5px;">
                    ✅ Approve Order
                </button>
            </form>

            <!-- Back Button Form -->
            <form action="${pageContext.request.contextPath}/listfromshops" method="get" style="display: inline;">
                <button type="submit" class="btn-back" style="padding: 10px 20px; background-color: gray; color: white; border: none; border-radius: 5px;">
                    ⬅ Back to Order List
                </button>
            </form>
        </div>
    </body>
</html>
