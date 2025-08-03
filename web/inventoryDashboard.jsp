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

            <!-- Main Content -->
            <div class="p-4 flex-grow-1" style="background-color: #f8f9fc;">
                <h2 class="mb-4">Inventory Dashboard</h2>

                <!-- Summary Cards -->
                <div class="row">
                    <!-- Total Products -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card primary h-100">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Total Products</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${stats.totalProducts}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-boxes fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Total Stock -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card success h-100">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            Total Stock</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${stats.totalStock}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-warehouse fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Inventory Value -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card info h-100">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                            Inventory Value</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                                            <fmt:formatNumber value="${stats.inventoryValue}" type="currency" currencySymbol="$"/>
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Activities -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card warning h-100">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                            Recent Activities (30 days)</div>
                                        <div class="row no-gutters align-items-center">
                                            <div class="col-auto">
                                                <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
                                                    ${stats.recentImports} Imports
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                    ${stats.recentExports} Exports
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts Row -->
                <div class="row">
                    <!-- Monthly Activity Chart -->
                    <div class="col-xl-8 col-lg-7">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold text-primary">Monthly Import/Export Activity</h6>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="monthlyActivityChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Inventory Distribution Pie Chart -->
                    <div class="col-xl-4 col-lg-5">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold text-primary">Inventory Distribution</h6>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="inventoryDistributionChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Transactions Table -->
                <div class="row">
                    <div class="col-12">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Recent Transactions</h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>Date</th>
                                                <th>Type</th>
                                                <th>Transaction ID</th>
                                                <th>Partner</th>
                                                <th>Items</th>
                                                <th>Total Value</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Sample data - should be replaced with actual data -->
                                            <tr>
                                                <td>2023-06-15</td>
                                                <td><span class="badge bg-primary">Import</span></td>
                                                <td>IMP-10025</td>
                                                <td>ABC Suppliers</td>
                                                <td>5 items</td>
                                                <td>$1,250.00</td>
                                                <td><span class="badge bg-success">Completed</span></td>
                                            </tr>
                                            <tr>
                                                <td>2023-06-14</td>
                                                <td><span class="badge bg-warning text-dark">Export</span></td>
                                                <td>EXP-10024</td>
                                                <td>Main Store</td>
                                                <td>8 items</td>
                                                <td>$980.50</td>
                                                <td><span class="badge bg-success">Completed</span></td>
                                            </tr>
                                            <tr>
                                                <td>2023-06-12</td>
                                                <td><span class="badge bg-primary">Import</span></td>
                                                <td>IMP-10023</td>
                                                <td>XYZ Furniture</td>
                                                <td>12 items</td>
                                                <td>$2,340.75</td>
                                                <td><span class="badge bg-success">Completed</span></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- JavaScript -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Monthly Activity Chart
                const monthlyCtx = document.getElementById('monthlyActivityChart').getContext('2d');
                const monthlyChart = new Chart(monthlyCtx, {
                    type: 'bar',
                    data: {
                        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                        datasets: [
                            {
                                label: 'Imports',
                                data: [12, 19, 15, 17, 14, 8],
                                backgroundColor: 'rgba(54, 162, 235, 0.7)',
                                borderColor: 'rgba(54, 162, 235, 1)',
                                borderWidth: 1
                            },
                            {
                                label: 'Exports',
                                data: [8, 12, 10, 14, 11, 6],
                                backgroundColor: 'rgba(255, 99, 132, 0.7)',
                                borderColor: 'rgba(255, 99, 132, 1)',
                                borderWidth: 1
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    precision: 0
                                }
                            }
                        },
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        return context.dataset.label + ': ' + context.raw;
                                    }
                                }
                            }
                        }
                    }
                });

                // Inventory Distribution Chart
                const inventoryCtx = document.getElementById('inventoryDistributionChart').getContext('2d');
                const inventoryChart = new Chart(inventoryCtx, {
                    type: 'doughnut',
                    data: {
                        labels: ['Chairs', 'Tables', 'Sofas', 'Beds', 'Cabinets'],
                        datasets: [{
                                data: [35, 25, 20, 15, 5],
                                backgroundColor: [
                                    'rgba(54, 162, 235, 0.7)',
                                    'rgba(255, 99, 132, 0.7)',
                                    'rgba(255, 206, 86, 0.7)',
                                    'rgba(75, 192, 192, 0.7)',
                                    'rgba(153, 102, 255, 0.7)'
                                ],
                                borderColor: [
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(255, 99, 132, 1)',
                                    'rgba(255, 206, 86, 1)',
                                    'rgba(75, 192, 192, 1)',
                                    'rgba(153, 102, 255, 1)'
                                ],
                                borderWidth: 1
                            }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'right',
                            },
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        const label = context.label || '';
                                        const value = context.raw || 0;
                                        const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                        const percentage = Math.round((value / total) * 100);
                                        return `${label}: ${value} (${percentage}%)`;
                                    }
                                }
                            }
                        }
                    }
                });
            });
        </script>

        <!-- Font Awesome for icons -->
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>                                    
    </body>
</html>
