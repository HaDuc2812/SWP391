<%-- 
    Document   : exportList
    Created on : Aug 1, 2025, 2:55:59 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Export Bills</title>
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
                background-color: #e67e22;
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
                background-color: #e67e22;
                color: white;
            }
            .new-btn {
                background-color: #2ecc71;
                color: white;
                padding: 8px 15px;
                margin-bottom: 15px;
                display: inline-block;
            }
            .filter-container {
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .form-label {
                font-weight: 500;
                color: #495057;
            }

            /* Đảm bảo form controls hiển thị đẹp */
            .form-control, .form-select {
                padding: 0.375rem 0.75rem;
                border: 1px solid #ced4da;
                border-radius: 0.25rem;
            }

            /* Responsive cho form filter */
            @media (max-width: 768px) {
                .filter-container .col-md-3,
                .filter-container .col-md-2 {
                    margin-bottom: 1rem;
                }
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
                <h1>Export Bills</h1>
                <a href="${pageContext.request.contextPath}/export/new" class="new-btn">Create New Export</a>

                <div class="filter-container mb-4 p-3 bg-light rounded">
                    <form method="get" action="${pageContext.request.contextPath}/export/list" class="row g-3">
                        <div class="col-md-3">
                            <label for="search" class="form-label">Search</label>
                            <input type="text" class="form-control" id="search" name="search" 
                                   value="${param.search}" placeholder="ID or Shop">
                        </div>
                        <div class="col-md-2">
                            <label for="status" class="form-label">Status</label>
                            <select class="form-select" id="status" name="status">
                                <option value="">All</option>
                                <option value="Completed" ${param.status eq 'Completed' ? 'selected' : ''}>Completed</option>
                                <option value="Pending" ${param.status eq 'Pending' ? 'selected' : ''}>Pending</option>
                                <option value="Cancelled" ${param.status eq 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label for="fromDate" class="form-label">From Date</label>
                            <input type="date" class="form-control" id="fromDate" name="fromDate" 
                                   value="${param.fromDate}">
                        </div>
                        <div class="col-md-3">
                            <label for="toDate" class="form-label">To Date</label>
                            <input type="date" class="form-control" id="toDate" name="toDate" 
                                   value="${param.toDate}">
                        </div>
                        <div class="col-md-1 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary">Filter</button>
                            <button type="button" id="clearFilter" class="btn btn-secondary">Clear</button>
                        </div>

                    </form>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Shop</th>
                            <th>Date</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th>Created By</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${exports}" var="exportBill">
                            <tr>
                                <td>${exportBill.exportId}</td>
                                <td>${exportBill.shop.shopName}</td>
                                <td>${exportBill.exportDate}</td>
                                <td>$${exportBill.totalAmount}</td>
                                <td>${exportBill.status}</td>
                                <td>${exportBill.createdBy}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/export/detail?id=${exportBill.exportId}" 
                                       class="action-btn view-btn">View</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Xử lý clear filter
                const clearFilter = document.getElementById('clearFilter');
                if (clearFilter) {
                    clearFilter.addEventListener('click', function () {
                        document.getElementById('search').value = '';
                        document.getElementById('status').selectedIndex = 0;
                        document.getElementById('fromDate').value = '';
                        document.getElementById('toDate').value = '';
                    });
                }

                // Validate date range
                const form = document.querySelector('.filter-container form');
                if (form) {
                    form.addEventListener('submit', function (e) {
                        const fromDate = document.getElementById('fromDate').value;
                        const toDate = document.getElementById('toDate').value;

                        if (fromDate && toDate && new Date(fromDate) > new Date(toDate)) {
                            alert('"From Date" cannot be after "To Date"');
                            e.preventDefault();
                        }
                    });
                }
            });
        </script>
    </body>
</html>
