<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
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
            <li class="nav-item"><a class="nav-link text-white" href="dashboard.jsp">Dashboard</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="product-stock.jsp">Product Stock</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="employee-stats.jsp">Employee Stats</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="../Homepage.jsp">Logout</a></li>
        </ul>
    </div>

    <div class="p-4" style="flex-grow: 1;">
        <h2>Store Dashboard</h2>
        <p>Welcome, manager. Use the sidebar to navigate through store data.</p>
    </div>
</div>
</body>
</html>
