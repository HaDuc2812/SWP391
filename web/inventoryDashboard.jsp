<%-- 
    Document   : inventoryDashboard
    Created on : May 29, 2025, 8:32:40 AM
    Author     : HA DUC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Store Management Dashboard</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <style>
            .sidebar {
                width: 250px;
                min-height: 100vh;
            }
        </style>
    </head>
    <body>
        <div class="d-flex">
            <div class="bg-dark text-white p-3 sidebar">
                <h4>Store Admin</h4>
                <ul class="nav flex-column mt-4">
                    <ul class="nav flex-column mt-4">
                        <li class="nav-item"><a class="nav-link text-white" href="inventoryDashboard.jsp">Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/import/list">Import from Suppliers</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/export/list">Export to Shops</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="pushOrdersToSuppliers">Requested List</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/datapush?action=requestToSupplier">Request to Suppliers</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/listfromshops?action=shopOrderList.jsp">Orders from Stores</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                    </ul>
                </ul>
            </div>

            <div class="p-4" style="flex-grow: 1;">
                <h2>Store Dashboard</h2>
                <p>Welcome, manager. Use the sidebar to navigate through store data.</p>

                <!-- Thêm phần thống kê -->
                <div class="row mt-4">
                    <!-- Card 1: Tổng sản phẩm -->
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-primary h-100">
                            <div class="card-body">
                                <h5 class="card-title">Total Products</h5>
                                <h1 class="display-4">${stats.totalProducts}</h1>
                            </div>
                        </div>
                    </div>

                    <!-- Card 2: Tổng tồn kho -->
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-success h-100">
                            <div class="card-body">
                                <h5 class="card-title">Total Stock</h5>
                                <h1 class="display-4">${stats.totalStock}</h1>
                            </div>
                        </div>
                    </div>

                    <!-- Card 3: Giá trị tồn kho -->
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-info h-100">
                            <div class="card-body">
                                <h5 class="card-title">Inventory Value</h5>
                                <h1 class="display-4">
                                    <fmt:formatNumber value="${stats.inventoryValue}" type="currency" currencySymbol="$"/>
                                </h1>
                            </div>
                        </div>
                    </div>

                    <!-- Card 4: Hoạt động gần đây -->
                    <div class="col-md-3 mb-4">
                        <div class="card text-white bg-warning h-100">
                            <div class="card-body">
                                <h5 class="card-title">Recent Activities</h5>
                                <div class="mb-2">
                                    <i class="fas fa-arrow-down"></i> ${stats.recentImports} Imports
                                </div>
                                <div>
                                    <i class="fas fa-arrow-up"></i> ${stats.recentExports} Exports
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Biểu đồ (có thể thêm sau) -->
                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h5>Monthly Activity</h5>
                            </div>
                            <div class="card-body">
                                <div id="chartContainer" style="height: 300px;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
