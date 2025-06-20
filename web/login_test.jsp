<%-- 
    Document   : login
    Created on : 18 thg 6, 2025, 16:18:06
    Author     : dungv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Login</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <style>
            body {
                background-color: #f8f9fa;
                height: 100vh;
                display: flex;
                align-items: center;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }
            .login-container {
                max-width: 400px;
                width: 100%;
                margin: 0 auto;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }
            .login-header {
                background-color: #4e73df;
                color: white;
                padding: 20px;
                text-align: center;
            }
            .login-body {
                padding: 30px;
            }
            .form-control:focus {
                border-color: #4e73df;
                box-shadow: 0 0 0 0.25rem rgba(78, 115, 223, 0.25);
            }
            .btn-login {
                background-color: #4e73df;
                border: none;
                width: 100%;
                padding: 10px;
                font-weight: 600;
            }
            .btn-login:hover {
                background-color: #3a5bc7;
            }
            .input-group-text {
                background-color: #f8f9fa;
            }

            /* Toast Notification Styles */
            .toast-container {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 1100;
            }
            .toast {
                min-width: 300px;
                border: none;
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            }
            .toast-header {
                font-weight: 600;
            }
        </style>
    </head>
    <body>
        <!-- Toast Notification Container -->
        <div class="toast-container">
            <div id="successToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="5000">
                <div class="toast-header bg-success text-white">
                    <strong class="me-auto"><i class="bi bi-check-circle-fill"></i> Update information successfull!</strong>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body bg-white">
                    ${param.message}
                </div>
            </div>
        </div>

        <div class="container">
            <div class="login-container">
                <div class="login-header">
                    <h4><i class="bi bi-person-circle"></i> USER LOGIN</h4>
                </div>

                <div class="login-body">
                    <!-- Hiển thị thông báo lỗi -->
                    <c:if test="${not empty requestScope.error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill"></i> ${requestScope.error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="login" method="POST">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" 
                                       placeholder="Enter your email" value="${requestScope.email}" required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="password" class="form-label">Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="Enter your password" value="${requestScope.password}" required>
                                <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary btn-login">
                                <i class="bi bi-box-arrow-in-right"></i> LOGIN
                            </button>
                        </div>

                        <div class="text-center">
                            <a href="forgot-password.jsp" class="text-decoration-none">Forgot Password?</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap 5 JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Auto show toast if there are messages from server
            document.addEventListener('DOMContentLoaded', function () {
                // Show success toast if profile was completed
            <c:if test="${not empty param.message}">
                const successToast = new bootstrap.Toast(document.getElementById('successToast'));
                successToast.show();
            </c:if>

                // Auto close alerts after 5 seconds
                setTimeout(() => {
                    const alerts = document.querySelectorAll('.alert');
                    alerts.forEach(alert => {
                        new bootstrap.Alert(alert).close();
                    });
                }, 5000);
            });
            
            // Toggle password visibility
            document.getElementById('togglePassword').addEventListener('click', function () {
                const passwordInput = document.getElementById('password');
                const icon = this.querySelector('i');
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                } else {
                    passwordInput.type = 'password';
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                }
            });
        </script>
    </body>
</html>
