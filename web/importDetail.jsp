<%-- 
    Document   : importDetail
    Created on : Aug 1, 2025, 2:52:08 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Import Bill Details</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .sidebar {
                width: 250px;
                min-height: 100vh;
                background-color: #343a40;
                color: white;
            }
            .main-content {
                flex-grow: 1;
                padding: 20px;
            }
            .detail-container {
                max-width: 1000px;
                margin: 0 auto;
                background: #f9f9f9;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h1 {
                color: #2c3e50;
                border-bottom: 2px solid #3498db;
                padding-bottom: 10px;
            }
            .bill-info {
                margin-bottom: 20px;
            }
            .bill-info p {
                margin: 5px 0;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #3498db;
                color: white;
            }
            .total-row {
                font-weight: bold;
                background-color: #f2f2f2;
            }
            .btn {
                padding: 8px 15px;
                text-decoration: none;
                border-radius: 4px;
                color: white;
            }
            .btn-back {
                background-color: #7f8c8d;
            }
        </style>
    </head>
    <body>
        <div class="d-flex">
            <!-- Sidebar -->
            <div class="sidebar p-3">
                <h4>Store Admin</h4>
                <ul class="nav flex-column mt-4">
                    <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/inventoryDashboard.jsp">Dashboard</a>
                    <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/import/list">Import from Suppliers</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/export/list">Export to Shops</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="pushOrdersToSuppliers">Requested List</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/datapush?action=requestToSupplier">Request to Suppliers</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/listfromshops?action=shopOrderList.jsp">Orders from Stores</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                </ul>
            </div>

            <!-- Main content -->
            <div class="main-content">
                <div class="detail-container">
                    <h1>Import Bill #${importBill.importId}</h1>

                    <div class="bill-info">
                        <p><strong>Supplier:</strong> ${importBill.supplier.sname}</p>
                        <p><strong>Import Date:</strong> <fmt:formatDate value="${importBill.importDate}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
                        <p><strong>Status:</strong> ${importBill.status}</p>
                        <p><strong>Created By:</strong> User #${importBill.createdBy}</p>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th>Product ID</th>
                                <th>Product Name</th>
                                <th>Brand</th>
                                <th>Category</th>
                                <th>Quantity</th>
                                <th>Unit Price ($)</th>
                                <th>Total ($)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${importBill.items}" var="item">
                                <tr>
                                    <td>${item.furnitureId}</td>
                                    <td>${item.product.furnitureName}</td>
                                    <td>${item.product.brand}</td>
                                    <td>${item.product.category}</td>
                                    <td>${item.quantity}</td>
                                    <td><fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="$"/></td>
                                    <td><fmt:formatNumber value="${item.quantity * item.unitPrice}" type="currency" currencySymbol="$"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr class="total-row">
                                <td colspan="6" style="text-align: right;">Grand Total:</td>
                                <td><fmt:formatNumber value="${importBill.totalAmount}" type="currency" currencySymbol="$"/></td>
                            </tr>
                        </tfoot>
                    </table>

                    <a href="${pageContext.request.contextPath}/import/list" class="btn btn-back">Back to List</a>
                </div>
            </div>
        </div>
    </body>
</html>
