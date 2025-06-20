<%-- 
    Document   : compeliton_profile
    Created on : 18 thg 6, 2025, 16:21:39
    Author     : dungv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Complete Profile</title>
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
            .profile-container {
                max-width: 600px;
                width: 100%;
                margin: 0 auto;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }
            .profile-header {
                background-color: #4e73df;
                color: white;
                padding: 20px;
                text-align: center;
            }
            .profile-body {
                padding: 30px;
            }
            .form-control:focus {
                border-color: #4e73df;
                box-shadow: 0 0 0 0.25rem rgba(78, 115, 223, 0.25);
            }
            .btn-profile {
                background-color: #4e73df;
                border: none;
                width: 100%;
                padding: 10px;
                font-weight: 600;
            }
            .btn-profile:hover {
                background-color: #3a5bc7;
            }
            .readonly-field {
                background-color: #f8f9fa;
                cursor: not-allowed;
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
            /* Error message styles */
            .error-message {
                color: #dc3545;
                font-size: 0.875rem;
                margin-top: 5px;
                display: none;
            }
            .is-invalid {
                border-color: #dc3545;
            }
        </style>
    </head>
    <body>
        <!-- Toast Notification Container -->
        <div class="toast-container">
            <div id="successToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="5000">
                <div class="toast-header bg-success text-white">
                    <strong class="me-auto"><i class="bi bi-check-circle-fill"></i> Password update successful!</strong>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body bg-white">
                    ${requestScope.message}
                </div>
            </div>
        </div>

        <div class="container">
            <div class="profile-container">
                <div class="profile-header">
                    <h4><i class="bi bi-person-badge"></i> COMPLETE YOUR PROFILE</h4>
                </div>

                <div class="profile-body">
                    <c:if test="${not empty requestScope.error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill"></i> ${requestScope.error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form id="profileForm" action="complete_profile" method="POST">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control readonly-field" 
                                       value="${sessionScope.user.fullname}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control readonly-field" 
                                       value="${sessionScope.user.email}" readonly>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Gender <span class="text-danger">*</span></label>
                                <select class="form-select" id="gender" name="gender" required>
                                    <option value="">Select Gender</option>
                                    <option value="Male" ${requestScope.gender == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${requestScope.gender == 'Female' ? 'selected' : ''}>Female</option>
                                    <option value="Other" ${requestScope.gender == 'Other' ? 'selected' : ''}>Other</option>
                                </select>
                                <div class="error-message" id="genderError">Please select your gender</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Date of Birth <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" id="dob" name="dob" 
                                       value="${requestScope.dob}" required>
                                <div class="error-message" id="dobError">Please select a valid date of birth (minimum age 18)</div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Address <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="address" name="address" rows="3" required>${requestScope.address}</textarea>
                            <div class="error-message" id="addressError">Please enter your address (minimum 10 characters)</div>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary btn-profile">
                                <i class="bi bi-check-circle"></i> COMPLETE PROFILE
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap 5 JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Auto show toast if there are messages from server
            document.addEventListener('DOMContentLoaded', function() {
                // Show success toast when updated password
                <c:if test="${not empty requestScope.message}">
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
                
                // Set max date for date of birth (18 years ago)
                const today = new Date();
                const maxDate = new Date();
                maxDate.setFullYear(today.getFullYear() - 18);
                document.getElementById('dob').max = maxDate.toISOString().split('T')[0];
                
                // Validate form on submit
                document.getElementById('profileForm').addEventListener('submit', function(e) {
                    if (!validateForm()) {
                        e.preventDefault();
                        const errorToast = new bootstrap.Toast(document.getElementById('errorToast'));
                        errorToast.show();
                    }
                });
                
                // Add real-time validation
                document.getElementById('gender').addEventListener('change', validateGender);
                document.getElementById('dob').addEventListener('change', validateDOB);
                document.getElementById('address').addEventListener('input', validateAddress);
            });
            
            // Validation functions
            function validateForm() {
                const isGenderValid = validateGender();
                const isDobValid = validateDOB();
                const isAddressValid = validateAddress();
                
                return isGenderValid && isDobValid && isAddressValid;
            }
            
            function validateGender() {
                const genderSelect = document.getElementById('gender');
                const errorElement = document.getElementById('genderError');
                
                if (genderSelect.value === '') {
                    genderSelect.classList.add('is-invalid');
                    errorElement.style.display = 'block';
                    return false;
                } else {
                    genderSelect.classList.remove('is-invalid');
                    errorElement.style.display = 'none';
                    return true;
                }
            }
            
            function validateDOB() {
                const dobInput = document.getElementById('dob');
                const errorElement = document.getElementById('dobError');
                
                if (!dobInput.value) {
                    dobInput.classList.add('is-invalid');
                    errorElement.style.display = 'block';
                    return false;
                }
                
                // Check if age is at least 18
                const dob = new Date(dobInput.value);
                const today = new Date();
                let age = today.getFullYear() - dob.getFullYear();
                const monthDiff = today.getMonth() - dob.getMonth();
                
                if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dob.getDate())) {
                    age--;
                }
                
                if (age < 18) {
                    dobInput.classList.add('is-invalid');
                    errorElement.style.display = 'block';
                    errorElement.textContent = 'You must be at least 18 years old';
                    return false;
                } else {
                    dobInput.classList.remove('is-invalid');
                    errorElement.style.display = 'none';
                    return true;
                }
            }
            
            function validateAddress() {
                const addressInput = document.getElementById('address');
                const errorElement = document.getElementById('addressError');
                
                if (!addressInput.value || addressInput.value.trim().length < 10) {
                    addressInput.classList.add('is-invalid');
                    errorElement.style.display = 'block';
                    errorElement.textContent = 'Address must be at least 10 characters long';
                    return false;
                } else {
                    addressInput.classList.remove('is-invalid');
                    errorElement.style.display = 'none';
                    return true;
                }
            }
        </script>
    </body>
</html>
