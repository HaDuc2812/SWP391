<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html> 
<html> 
    <head>
        <meta charset="UTF-8"> 
        <title>Shop Order Result</title>
        <style>
            .body {
                font-family: Arial, sans-serif;
                background: #f5f5f5;
                padding: 30px;
            }
            .container {
                background: #fff;
                max-width: 700px;
                margin: auto;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h1 {
                color: #2c3e50;
                text-align: center;
            }
            .success {
                color: green;
                font-weight: bold;
            }
            .error {
                color: red;
                font-weight: bold;
            }
            .info {
                margin-top: 20px;
                line-height: 1.6;
            }
            .info p {
                margin: 5px 0;
            }
            .back-btn {
                display: block;
                margin-top: 30px;
                text-align: center;
            }
            .back-btn a {
                background-color: #3498db;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 4px;
            }
            .back-btn a:hover {
                background-color: #2980b9;
            }
        </style> 
    </head> 
    <body> 
        <div class="container">
            <h1>Order Submission Result</h1>

            <c:choose>
                <c:when test="${status eq 'success'}">
                    <p class="success">${message}</p>
                    <div class="info">
                        <c:if test="${not empty orderId}">
                            <p><strong>Order ID:</strong> ${orderId}</p>
                        </c:if>
                        <c:if test="${not empty shopName}">
                            <p><strong>Shop Name:</strong> ${shopName}</p>
                        </c:if>
                        <c:if test="${not empty shopAddress}">
                            <p><strong>Shop Address:</strong> ${shopAddress}</p>
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="error">${message}</p>
                </c:otherwise>
            </c:choose>

            <div class="back-btn">
                <a href="shopsPlaceOrders.jsp">Back to Order Page</a>
            </div>
        </div> 
    </body> 
</html>