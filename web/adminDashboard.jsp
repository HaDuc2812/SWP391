<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <title>Admin Dashboard – MyWineShop</title>
        <!-- Bootstrap CSS for responsive layout -->
        <link
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-MrY6Zx2eZ6iYlIeTQEG90R1lDpl+zutInb1E5niL+78z0uZqeDBwMUlqkQPR1y1C"
            crossorigin="anonymous"
            />
        <style>
            /* Sidebar styling */
            body {
                font-family: Arial, sans-serif;
            }
            #sidebar {
                min-height: 100vh;
                background-color: #343a40;
            }
            #sidebar .nav-link {
                color: #ffffff;
            }
            #sidebar .nav-link:hover,
            #sidebar .nav-link.active {
                background-color: #495057;
                color: #ffffff;
            }
            .main-content {
                padding: 20px;
            }
            .nav-item .badge {
                float: right;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <nav id="sidebar" class="col-md-2 d-none d-md-block sidebar">
                    <div class="sidebar-sticky pt-3">
                        <h5 class="text-white px-3">Admin Menu</h5>
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a
                                    class="nav-link ${pageContext.request.requestURI.endsWith("overview.jsp") ? "active" : ""}"
                                    href="overview.jsp">
                                    Overview
                                </a>
                            </li>
                            <li class="nav-item">
                                <a
                                    class="nav-link ${pageContext.request.requestURI.endsWith("products.jsp") ? "active" : ""}"
                                    href="products.jsp">
                                    Products
                                </a>
                            </li>
                            <li class="nav-item">
                                <a
                                    class="nav-link ${pageContext.request.requestURI.endsWith("inventory.jsp") ? "active" : ""}"
                                    href="inventory.jsp">
                                    Inventory
                                    <span class="badge badge-warning">12</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a
                                    class="nav-link ${pageContext.request.requestURI.endsWith("orders.jsp") ? "active" : ""}"
                                    href="orders.jsp">
                                    Orders
                                    <span class="badge badge-info">5</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a
                                    class="nav-link ${pageContext.request.requestURI.endsWith("customers.jsp") ? "active" : ""}"
                                    href="customers.jsp">
                                    Customers
                                </a>
                            </li>
                            <li class="nav-item">
                                <a
                                    class="nav-link ${pageContext.request.requestURI.endsWith("suppliers.jsp") ? "active" : ""}"
                                    href="suppliers.jsp">
                                    Suppliers
                                </a>
                            </li>
                            <li class="nav-item">
                                <a
                                    class="nav-link ${pageContext.request.requestURI.endsWith("reports.jsp") ? "active" : ""}"
                                    href="reports.jsp">
                                    Reports
                                </a>
                            </li>
                            <li class="nav-item">
                                <a
                                    class="nav-link ${pageContext.request.requestURI.endsWith("users.jsp") ? "active" : ""}"
                                    href="users.jsp">
                                    Users & Roles
                                </a>
                            </li>
                            <li class="nav-item">
                                <a
                                    class="nav-link ${pageContext.request.requestURI.endsWith("settings.jsp") ? "active" : ""}"
                                    href="settings.jsp">
                                    Settings
                                </a>
                            </li>
                            <li class="nav-item">
                                <a
                                    class="nav-link ${pageContext.request.requestURI.endsWith("notifications.jsp") ? "active" : ""}"
                                    href="notifications.jsp">
                                    Notifications
                                    <span class="badge badge-danger">3</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>

                <!-- Main Content Area -->
                <main role="main" class="col-md-10 ml-sm-auto px-4 main-content">
                    <!-- If you want to show a default page in this frame, you can include it here. 
                         For example, if “overview.jsp” is the default: -->
                    <jsp:include page="overview.jsp" />
                    <!-- Otherwise, you can leave this blank or show a “Select a section” message. -->
                </main>
            </div>
        </div>

        <!-- Bootstrap JS (optional, if you add any dropdowns or JS features later) -->
        <script
            src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
            integrity="sha384-DfXdWtJBt2u9JgB6I6Fffv+QuGmJtaVLdGKe1zh28UM1gZwCvQkXgABkPL0TZYtS"
            crossorigin="anonymous"
        ></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-pZRs4tQ7msE1nv8C9PVu1ZPOiZz5c9aB9VswGVp6qNL7Q4BwPMDiCLtDBmpe6Oz7"
            crossorigin="anonymous"
        ></script>
    </body>
</html>
