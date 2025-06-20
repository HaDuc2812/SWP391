<%-- 
    Document   : change_temp_password
    Created on : 18 thg 6, 2025, 16:21:22
    Author     : dungv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Change Password</title>
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
            .password-container {
                max-width: 500px;
                width: 100%;
                margin: 0 auto;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }
            .password-header {
                background-color: #4e73df;
                color: white;
                padding: 20px;
                text-align: center;
            }
            .password-body {
                padding: 30px;
            }

            /* Style cho password requirements */
            .password-requirements {
                margin-top: 10px;
                padding: 10px;
                background-color: #f8f9fa;
                border-radius: 5px;
                font-size: 0.9rem;
            }
            .requirement {
                display: flex;
                align-items: center;
                margin-bottom: 5px;
                color: #6c757d;
            }
            .requirement i {
                margin-right: 5px;
            }
            .valid {
                color: #28a745;
            }
            .invalid {
                color: #dc3545;
            }
            .error-message {
                color: #dc3545;
                font-size: 0.875rem;
                margin-top: 5px;
                display: none;
            }
            .form-control:focus {
                border-color: #4e73df;
                box-shadow: 0 0 0 0.25rem rgba(78, 115, 223, 0.25);
            }
            .btn-password {
                background-color: #4e73df;
                border: none;
                width: 100%;
                padding: 10px;
                font-weight: 600;
            }
            .btn-password:hover {
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
            <div id="loginToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="5000">
                <div class="toast-header bg-success text-white">
                    <strong class="me-auto"><i class="bi bi-check-circle-fill"></i> Success</strong>
                    <small>Just now</small>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body bg-white">
                    You have logged in successfully! Please change your password now!
                </div>
            </div>
        </div>

        <div class="container">
            <div class="password-container">
                <div class="password-header">
                    <h4><i class="bi bi-shield-lock"></i> CHANGE PASSWORD</h4>
                </div>

                <div class="password-body">
                    <!-- Giữ nguyên các phần hiện có -->
                    <form id="passwordForm" action="change_temp_pass" method="POST">
                        <div class="mb-3">
                            <label class="form-label">New Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                <input type="password" class="form-control" id="newPassword" name="newPassword" 
                                       placeholder="Enter new password" required>
                                <button class="btn btn-outline-secondary" type="button" id="toggleNewPassword">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                            <div class="error-message" id="passwordError"></div>
                            <div class="password-requirements">
                                <div class="requirement" id="lengthReq">
                                    <i class="bi bi-circle"></i> At least 8 characters
                                </div>
                                <div class="requirement" id="digitReq">
                                    <i class="bi bi-circle"></i> Contains at least 1 digit
                                </div>
                                <div class="requirement" id="specialReq">
                                    <i class="bi bi-circle"></i> Contains at least 1 special character
                                </div>                               
                                <div class="requirement" id="caseReq">
                                    <i class="bi bi-circle"></i> Contains both uppercase and lowercase
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Confirm Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                       placeholder="Confirm new password" required>
                                <button class="btn btn-outline-secondary" type="button" id="toggleConfirmPassword">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                            <div class="error-message" id="confirmError">Passwords do not match</div>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary btn-password" id="submitBtn" disabled>
                                <i class="bi bi-key"></i> CHANGE PASSWORD
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap 5 JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Show toast
            document.addEventListener('DOMContentLoaded', function () {
            <c:if test="${sessionScope.user.status eq 'Temporary'}">
                const toastEl = document.getElementById('loginToast');
                const toast = new bootstrap.Toast(toastEl);
                toast.show();
            </c:if>
            });

            // Password validation logic
            const passwordInput = document.getElementById('newPassword');
            const confirmInput = document.getElementById('confirmPassword');
            const passwordError = document.getElementById('passwordError');
            const confirmError = document.getElementById('confirmError');
            const submitBtn = document.getElementById('submitBtn');

            // Các yêu cầu mật khẩu
            const requirements = {
                length: document.getElementById('lengthReq'),
                digit: document.getElementById('digitReq'),
                special: document.getElementById('specialReq'),
                case: document.getElementById('caseReq')
            };

            // Validate password on input
            passwordInput.addEventListener('input', function () {
                validatePassword();
                validatePasswordMatch(); // Thêm dòng này để validate lại confirm password khi password thay đổi
            });

            confirmInput.addEventListener('input', validatePasswordMatch);

            function validatePassword() {
                const password = passwordInput.value;
                let isValid = true;

                // Kiểm tra độ dài
                const isLengthValid = password.length >= 8;
                updateRequirement(requirements.length, isLengthValid);

                // Kiểm tra có số
                const hasDigit = /\d/.test(password);
                updateRequirement(requirements.digit, hasDigit);

                // Kiểm tra ký tự đặc biệt
                const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(password);
                updateRequirement(requirements.special, hasSpecial);

                // Kiểm tra chữ hoa và thường
                const hasUpper = /[A-Z]/.test(password);
                const hasLower = /[a-z]/.test(password);
                const isCaseValid = hasUpper && hasLower;
                updateRequirement(requirements.case, isCaseValid);

                // Kiểm tra tổng thể
                isValid = isLengthValid && hasDigit && hasSpecial && isCaseValid;

                if (password.length > 0 && !isValid) {
                    passwordError.style.display = 'block';
                    passwordError.textContent = 'Password does not meet requirements';
                } else {
                    passwordError.style.display = 'none';
                }

                return isValid;
            }

            function validatePasswordMatch() {
                const password = passwordInput.value;
                const confirm = confirmInput.value;

                if (confirm.length > 0 && password !== confirm) {
                    confirmError.style.display = 'block';
                } else {
                    confirmError.style.display = 'none';
                }

                // Kích hoạt nút submit nếu tất cả hợp lệ
                const isPasswordValid = validatePassword();
                const isMatchValid = password === confirm && confirm.length > 0;

                submitBtn.disabled = !(isPasswordValid && isMatchValid);

                // Debug log - có thể xóa sau khi kiểm tra
                console.log('Password valid:', isPasswordValid, 'Match valid:', isMatchValid);
            }

            function updateRequirement(element, isValid) {
                const icon = element.querySelector('i');
                icon.className = isValid ? 'bi bi-check-circle valid' : 'bi bi-circle invalid';
                element.style.color = isValid ? '#28a745' : '#6c757d';
            }

            // Xử lý submit form
            document.getElementById('passwordForm').addEventListener('submit', function (e) {
                const isPasswordValid = validatePassword();
                const isMatchValid = passwordInput.value === confirmInput.value && confirmInput.value.length > 0;

                if (!isPasswordValid || !isMatchValid) {
                    e.preventDefault();
                    if (!isPasswordValid) {
                        passwordError.style.display = 'block';
                        passwordError.textContent = 'Please fix password requirements';
                    }
                    if (!isMatchValid) {
                        confirmError.style.display = 'block';
                    }
                }
            });

            // Toggle password visibility (giữ nguyên)
            document.getElementById('toggleNewPassword').addEventListener('click', function () {
                togglePasswordVisibility('newPassword', this);
            });

            document.getElementById('toggleConfirmPassword').addEventListener('click', function () {
                togglePasswordVisibility('confirmPassword', this);
            });

            function togglePasswordVisibility(inputId, button) {
                const input = document.getElementById(inputId);
                const icon = button.querySelector('i');

                if (input.type === 'password') {
                    input.type = 'text';
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                } else {
                    input.type = 'password';
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                }
            }

            // Auto close alerts after 5 seconds
            setTimeout(() => {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    new bootstrap.Alert(alert).close();
                });
            }, 5000);
        </script>
    </body>
</html>
