<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Result</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f0f2f5;
                padding: 40px;
            }
            .result-container {
                background: white;
                max-width: 600px;
                margin: auto;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 12px rgba(0,0,0,0.1);
                text-align: center;
            }
            h1 {
                color: #2c3e50;
            }
            p {
                font-size: 18px;
                margin: 20px 0;
            }
            .success {
                color: #27ae60;
            }
            .error {
                color: #e74c3c;
            }
            .btn {
                background-color: #3498db;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 4px;
                margin: 10px;
                display: inline-block;
            }
            .btn:hover {
                background-color: #2980b9;
            }
        </style>
    </head>
    <body>
        <div class="result-container">
            <h1>Order Submission Result</h1>

            <c:choose>
                <c:when test="${success}">
                    <p class="success">${message}</p>
                    <c:if test="${not empty orderId}">
                        <p><strong>Order ID:</strong> ${orderId}</p>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <p class="error">${message}</p>
                </c:otherwise>
            </c:choose>

           
            <a href="${pageContext.request.contextPath}/datapush?action=requestToSupplier" class="btn">Back to Store Orders</a>
            <a href="inventoryDashboard.jsp" class="btn">Go to Dashboard</a>
        </div>
    </body>
</html>
