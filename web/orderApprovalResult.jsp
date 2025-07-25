<%@ page import="java.util.List" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Approval Result</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 30px;
                background-color: #f4f4f4;
            }
            .result {
                background: #fff;
                padding: 25px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                max-width: 600px;
                margin: auto;
            }
            .success {
                color: green;
                font-weight: bold;
            }
            .error {
                color: red;
                font-weight: bold;
            }
            ul {
                padding-left: 20px;
                color: red;
            }
            .btn {
                display: inline-block;
                padding: 10px 16px;
                background: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                margin-top: 20px;
            }
            .btn:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="result">
            <h2>Order Approval Result</h2>

            <%
                String result = (String) session.getAttribute("orderApprovalResult");
                List<String> insufficientProducts = (List<String>) session.getAttribute("insufficientProducts");

                if (result != null) {
                    String cssClass = (result.toLowerCase().contains("cannot") || result.toLowerCase().contains("fail") || result.toLowerCase().contains("invalid"))
                                      ? "error" : "success";
            %>
            <p class="<%= cssClass %>"><%= result %></p>
            <%
                }

                if (insufficientProducts != null && !insufficientProducts.isEmpty()) {
            %>
            <p class="error">Insufficient stock for the following items:</p>
            <ul>
                <% for (String item : insufficientProducts) { %>
                <li><%= item %></li>
                    <% } %>
            </ul>
            <%
                }

                // Clean up
                session.removeAttribute("orderApprovalResult");
                session.removeAttribute("insufficientProducts");
            %>

            <a class="btn" href="orderDetail?order_id=<%= request.getParameter("order_id") %>">🔍 View Order Details</a>
        </div>
    </body>
</html>
