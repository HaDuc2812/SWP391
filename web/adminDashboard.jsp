<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<html>
    
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
</head>
<body>
<div class="d-flex">
    <div class="bg-dark text-white p-3" style="min-height: 100vh; width: 250px;">
        <h4>Admin</h4>
        <ul class="nav flex-column">
            <li class="nav-item"><a class="nav-link text-white" href="dashboard.jsp">Dashboard</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="accounts.jsp">Account Management</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="products.jsp">Product Management</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="reports.jsp">Reports</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="Homepage.jsp">Logout</a></li>
        </ul>
    </div>

    <div class="p-4" style="flex-grow: 1;">
        <h2>Dashboard</h2>
        <p>Welcome, admin. Choose an option from the sidebar.</p>
    </div>
</div>
</body>
</html>
