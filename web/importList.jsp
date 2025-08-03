<%-- 
    Document   : importList
    Created on : Aug 1, 2025, 2:28:20 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Import Bills</title>
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
            h1 {
                color: #2c3e50;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
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
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .action-btn {
                padding: 5px 10px;
                text-decoration: none;
                border-radius: 4px;
            }
            .view-btn {
                background-color: #3498db;
                color: white;
            }
            .new-btn {
                background-color: #2ecc71;
                color: white;
                padding: 8px 15px;
                margin-bottom: 15px;
                display: inline-block;
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
                <h1>Import Bills</h1>
                <a href="${pageContext.request.contextPath}/import/new" class="new-btn">Create New Import</a>

                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Supplier</th>
                            <th>Date</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th>Created By</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${imports}" var="importBill">
                            <tr>
                                <td>${importBill.importId}</td>
                                <td>${importBill.supplier.sname}</td>
                                <td>${importBill.importDate}</td>
                                <td>$${importBill.totalAmount}</td>
                                <td>${importBill.status}</td>
                                <td>${importBill.createdBy}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/import/detail?id=${importBill.importId}" 
                                       class="action-btn view-btn">View</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
