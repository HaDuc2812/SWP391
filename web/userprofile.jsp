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
        <link
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-MrY6Zx2eZ6iYlIeTQEG90R1lDpl+zutInb1E5niL+78z0uZqeDBwMUlqkQPR1y1C"
            crossorigin="anonymous"
            />
        <style>
            .profile-card {
                max-width: 600px;
                margin: 40px auto;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
                background-color: #ffffff;
            }
            .profile-header {
                text-align: center;
                margin-bottom: 20px;
            }
            .profile-header h2 {
                margin: 0;
            }
            .profile-row {
                margin-bottom: 15px;
            }
            .profile-label {
                font-weight: 600;
                width: 150px;
            }
        </style>
    </head>
    <body class="container-fluid">
        <header class="row">
            <div class="col-md-2 logo">
                <a href="homepage"><img src="elements/logo/home_logo.png" alt="Home Logo"></a>
            </div>
            <div class="col-md-4"></div>
            <nav class="col-md-6 navigate">
                <a href="homepage">home</a>
                <a href="search.jsp">search</a>
                <a href="home">explore</a>
                <a href="login.jsp">account</a>
                <a href="cart.jsp">cart</a>
            </nav>
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
                        <input  type="text" id="name" name="value" class="form-control me-2"  value="${sessionScope.user.full_name}" readonly="readonly">

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
        </main>

        <footer class="footer row">
            <div class="col-md-4 title_contact">
                <h3>CONTACT US</h3>
            </div>
            <div class="col-md-4 contact_info">
                <p>Address: 123 Main Street, Ha Noi</p>
                <p>Phone: 0123456789</p>
            </div>
        </footer>
    </body>
</html>
