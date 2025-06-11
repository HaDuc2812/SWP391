<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    // 1) Check if there's a "user" object in session
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        // Not logged in → redirect to Login.jsp
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <title>User Profile</title>
        <!-- Bootstrap CSS (optional, for styling) -->

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f8;
                margin: 0;
                padding: 0;
            }

            /* Navbar (if needed) */
            .navbar {
                background-color: #2c3e50;
                padding: 10px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .navbar a {
                color: #ecf0f1;
                text-decoration: none;
                margin-left: 20px;
                font-size: 16px;
            }

            .navbar a:hover {
                color: #ffffff;
            }

            /* Main container */
            .profile-container {
                max-width: 600px;
                margin: 50px auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .profile-title {
                font-size: 32px;
                font-weight: bold;
                color: #2c3e50;
                margin-bottom: 30px;
                border-left: 8px solid #2980b9;
                padding-left: 10px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
                color: #34495e;
            }

            .form-group input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
            }

            .form-actions {
                display: flex;
                gap: 10px;
                margin-top: 20px;
            }

            .form-actions input,
            .form-actions button {
                background-color: #2980b9;
                color: #fff;
                border: none;
                padding: 10px 20px;
                font-size: 14px;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .form-actions button.logout {
                background-color: #e74c3c;
            }

            .form-actions input:hover,
            .form-actions button:hover {
                background-color: #1f6391;
            }

            .form-actions button.logout:hover {
                background-color: #c0392b;
            }

            .footer {
                text-align: center;
                margin-top: 40px;
                color: #7f8c8d;
                font-size: 14px;
                padding: 20px 0;
            }

            .footer p {
                margin: 5px 0;
            }
        </style>

    </head>
    <body class="container-fluid">
        <header class="row">
            <div class="col-md-2 logo">
                <a href="homepage"><img src="elements/logo/home_logo.png" alt="Home Logo"></a>
            </div>
            <jsp:include page="NavBar.jsp"></jsp:include>
            </header>

            <main class="row justify-content-center">

                <c:if test="${sessionScope.user == null}">
                <c:redirect url="login.jsp" />
            </c:if>

            <c:if test="${sessionScope.user != null}">



                <div class="col-md-6">
                    <h2 class="text-center" style="font-size: 3.2em; margin-bottom: 4vh">profile.</h2>

                    <div class="mb-3 d-flex align-items-center">
                        <p style="width: 20%" class="title">Email: </p>
                        <input type="text" id="name" name="value" class="form-control me-2"  value="${sessionScope.user.email}"  readonly="readonly">

                    </div>

                    <div  class="mb-3 d-flex align-items-center">
                        <p class="title" style="width: 20%">Name: </p>
                        <input  type="text" id="name" name="value" class="form-control me-2"  value="${sessionScope.user.username}" readonly="readonly">

                    </div>

                    <div  class="mb-3 d-flex align-items-center">
                        <p class="title" style="width: 20%">Phone: </p><input type="text" id="phone" name="value" class="form-control me-2"  value="${sessionScope.user.phone}" readonly="readonly">

                    </div>

                    <div  class="mb-3 d-flex align-items-center">
                        <p class="title" style="width: 20%">Address: </p>
                        <input type="text" id="address" name="value" class="form-control me-2"  value="${sessionScope.user.address}" readonly="readonly">

                    </div>

                    <div class="mb-3 d-flex align-items-center">
                        <p class="title" style="width: 20%">Password: </p>
                        <input type="password" id="password" name="value" class="form-control me-2"  value="**********" readonly="readonly">
                    </div>

                </div>
                <div class="row" style="margin-top: 2vh">
                    <div class="col-md-3"></div>
                    <div class="col-md-3">
                        <form action="editProfile.jsp" method="POST">
                            <button type="submit" class="btn btn-primary w-100">Edit Profile</button>
                        </form>
                    </div>
                    <div class="col-md-3">
                        <form action="logout" method="POST">
                            <button type="submit" class="btn btn-primary w-100">Log Out</button>
                        </form>
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </c:if>
            <jsp:include page="Footer.jsp"></jsp:include>
        </main>
    </body>
</html>
