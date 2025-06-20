<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>User Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .readonly {
                background-color: #f9f9f9;
                border: none;
            }
            /* CSS cho password field và toggle button */
            .password-container {
                position: relative;
            }

            .password-toggle-btn {
                position: absolute;
                right: 0;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                padding: 0 10px;
                padding-top: 22px;
                cursor: pointer;
            }

            .password-toggle-btn:hover {
                background: none;
            }

            .password-toggle-btn:focus {
                outline: none;
                box-shadow: none;
            }

            /* Đảm bảo input password có padding-right để không bị chữ đè lên button */
            #passwordField {
                padding-right: 40px;
            }

            /* CSS cho dropdown menu */
            .dropdown-menu {
                border: 1px solid #e9ecef; /* viền nhẹ */
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1); /* bóng đổ */
                padding: 0.25rem 0; /* padding cho menu */
                min-width: 12rem; /* chiều rộng tối thiểu */
            }

            /* CSS cho các item trong dropdown khi bình thường */
            .dropdown-menu li {
                transition: all 0.2s ease; /* hiệu ứng mượt khi hover */
            }

            /* CSS cho các item trong dropdown khi hover */
            .dropdown-menu li:hover {
                background-color: #f8f9fa; /* màu nền khi hover */
            }

            /* CSS cho các link trong dropdown */
            .dropdown-menu li a.dropdown-item {
                padding: 0.5rem 1.5rem; /* padding cho item */
                color: #212529; /* màu chữ */
                font-size: 0.875rem; /* cỡ chữ */
                display: block; /* hiển thị dạng block */
                clear: both; /* clear float */
                font-weight: 400; /* độ đậm chữ */
                text-decoration: none; /* bỏ gạch chân */
                white-space: nowrap; /* không xuống dòng */
                transition: all 0.2s ease; /* hiệu ứng mượt */
            }

            /* CSS cho link khi hover */
            .dropdown-menu li a.dropdown-item:hover {
                background-color: #f1f3f5; /* màu nền khi hover */
                color: #0d6efd; /* màu chữ khi hover (màu primary) */
            }

            /* CSS cho divider */
            .dropdown-menu li .dropdown-divider {
                margin: 0.25rem 0; /* khoảng cách trên dưới */
                border-top: 1px solid #e9ecef; /* đường kẻ ngang */
            }

            /* CSS cho icon trong dropdown item */
            .dropdown-menu li a.dropdown-item i.bi {
                margin-right: 0.5rem; /* khoảng cách với text */
                width: 1em; /* chiều rộng icon */
                text-align: center; /* căn giữa icon */
            }

            /* Empty state container */
            .empty-state-container {
                background-color: #f8f9fa;
                border-radius: 12px;
                border: 1px dashed #dee2e6;
                margin: 2rem 0;
                padding: 3rem !important;
                animation: fadeIn 0.5s ease;
            }

            .empty-state-image {
                opacity: 0.7;
                filter: grayscale(30%);
            }

            .empty-state-title {
                font-size: 1.5rem;
                font-weight: 500;
            }

            .empty-state-title i {
                font-size: 1.8rem;
                vertical-align: middle;
                margin-right: 0.5rem;
            }

            .empty-state-description {
                font-size: 1.05rem;
                line-height: 1.6;
                max-width: 500px;
                margin-left: auto;
                margin-right: auto;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Responsive adjustments */
            @media (max-width: 576px) {
                .empty-state-image {
                    width: 120px;
                }
                .empty-state-title {
                    font-size: 1.3rem;
                }
                .d-flex {
                    flex-direction: column;
                    gap: 1rem !important;
                }
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 123, 255, 0.2);
                transition: all 0.3s ease;
            }
        </style>
    </head>
    <body class="p-4">

        <!-- Search Bar + Actions -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <!-- Search Bar -->
            <div class="w-50">
                <form action="usermanage" method="GET" class="input-group">
                    <input type="text" name="search" class="form-control" placeholder="Search users by name, phone or email." 
                           value="${requestScope.search}" aria-label="Search users">
                    <input type="hidden" name="page" value="1">
                    <button class="btn btn-outline-secondary" type="submit">
                        <i class="bi bi-search"></i> Search
                    </button>
                </form>
            </div>

            <!-- Filter and Action Buttons -->
            <div class="d-flex">
                <!-- Role Filter Dropdown -->
                <div class="dropdown me-2">
                    <button class="btn btn-outline-secondary dropdown-toggle" type="button" 
                            data-bs-toggle="dropdown" aria-expanded="false">
                        Filter by Role
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="usermanage?role=all&status=${requestScope.statusFilter}&search=${requestScope.search}">All Roles</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="usermanage?role=Administrator&status=${requestScope.statusFilter}&search=${requestScope.search}">Administrator</a></li>
                        <li><a class="dropdown-item" href="usermanage?role=InventoryManager&status=${requestScope.statusFilter}&search=${requestScope.search}">Inventory Manager</a></li>
                        <li><a class="dropdown-item" href="usermanage?role=StoreManager&status=${requestScope.statusFilter}&search=${requestScope.search}">Store Manager</a></li>
                        <li><a class="dropdown-item" href="usermanage?role=Salesperson&status=${requestScope.statusFilter}&search=${requestScope.search}">Salesperson</a></li>
                    </ul>
                </div>

                <!-- Status Filter Dropdown -->
                <div class="dropdown me-2">
                    <button class="btn btn-outline-secondary dropdown-toggle" type="button" 
                            data-bs-toggle="dropdown" aria-expanded="false">
                        Filter by Status
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="usermanage?status=all&role=${requestScope.roleFilter}&search=${requestScope.search}">All Statuses</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="usermanage?status=active&role=${requestScope.roleFilter}&search=${requestScope.search}">Active</a></li>
                        <li><a class="dropdown-item" href="usermanage?status=suspend&role=${requestScope.roleFilter}&search=${requestScope.search}">Suspend</a></li>
                    </ul>
                </div>

                <!-- Actions Dropdown -->
                <div class="dropdown">
                    <button class="btn btn-outline-secondary dropdown-toggle" type="button" 
                            data-bs-toggle="dropdown" aria-expanded="false">
                        Actions
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#addUserModal">
                                <i class="bi bi-plus-circle"></i> Create New Account
                            </a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="usermanage?sort=name_asc&role=${requestScope.roleFilter}&status=${requestScope.statusFilter}&search=${requestScope.search}">
                                <i class="bi bi-sort-alpha-down"></i> Sort by Name A-Z
                            </a></li>
                        <li><a class="dropdown-item" href="usermanage?sort=name_desc&role=${requestScope.roleFilter}&status=${requestScope.statusFilter}&search=${requestScope.search}">
                                <i class="bi bi-sort-alpha-down-alt"></i> Sort by Name Z-A
                            </a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Phần hiển thị table -->
        <c:choose>
            <c:when test="${not empty listU}">
                <table class="table table-bordered table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>No.</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Phone Number</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${requestScope.listU}" varStatus="loop">
                            <tr>
                                <td>${(currentPage - 1) * recordsPerPage + loop.index + 1}</td>
                                <td>${user.fullname}</td>
                                <td>${user.email}</td>
                                <td>${user.phonenumber}</td>
                                <td>${user.role}</td>
                                <td>${user.status}</td>
                                <td>
                                    <form action="usermanage" method="GET" style="display:inline;">
                                        <input type="hidden" name="action" value="view">
                                        <input type="hidden" name="userId" value="${user.user_id}">
                                        <button type="submit" class="btn btn-sm btn-info me-1">View</button>
                                    </form>
                                    <button class="btn btn-sm btn-danger" 
                                            onclick="showDeleteModal(
                                                            '${user.user_id}',
                                                            '${user.fullname}',
                                                            '${user.email}',
                                                            '${user.phonenumber}',
                                                            '${user.role}'
                                                            )">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Phân trang (chỉ hiện khi có dữ liệu) -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center" id="pagination">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="usermanage?page=${currentPage-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach begin="1" end="${noOfPages}" var="i">
                            <c:choose>
                                <c:when test="${currentPage eq i}">
                                    <li class="page-item active"><a class="page-link" href="#">${i}</a></li>
                                    </c:when>
                                    <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="usermanage?page=${i}">${i}</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                        <c:if test="${currentPage lt noOfPages}">
                            <li class="page-item">
                                <a class="page-link" href="usermanage?page=${currentPage+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:when>

            <c:otherwise>
                <div class="empty-state-container text-center py-5">
                    <!-- SVG trực tiếp - Biểu tượng nhóm người với dấu gạch chéo -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 24 24" fill="none" stroke="#6c757d" stroke-width="1" class="mb-4">
                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                    <circle cx="9" cy="7" r="4"></circle>
                    <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                    <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                    <line x1="3" y1="3" x2="21" y2="21" stroke="#dc3545" stroke-width="1.5"></line>
                    </svg>

                    <!-- Tiêu đề và mô tả -->
                    <div class="empty-state-content">
                        <h3 class="empty-state-title text-muted mb-3">
                            <i class="bi bi-people-fill text-primary"></i> No Users Found
                        </h3>
                        <p class="empty-state-description text-secondary mb-4">
                            No results match your current filters.<br>
                            Try adjusting your search criteria or create a new user.
                        </p>

                        <c:if test="${not empty requestScope.search != null or requestScope.roleFilter != 'all' or requestScope.statusFilter != 'all'}">
                            <div class="active-filters mb-4">
                                <span class="badge bg-light text-dark me-2">
                                    <i class="bi bi-funnel"></i> Current Filters:
                                </span>
                                <c:if test="${not empty requestScope.search}">
                                    <span class="badge bg-info me-2">
                                        Search input: "${requestScope.search}"
                                    </span>
                                </c:if>
                                <c:if test="${requestScope.roleFilter != 'all'}">
                                    <span class="badge bg-warning me-2">
                                        Role filter: ${requestScope.roleFilter}
                                    </span>
                                </c:if>
                                <c:if test="${requestScope.statusFilter !='all'}">
                                    <span class="badge bg-secondary">
                                        Status filter: ${requestScope.statusFilter}
                                    </span>
                                </c:if>
                            </div>
                        </c:if>

                        <!-- Các action buttons -->
                        <div class="d-flex justify-content-center gap-3">
                            <a href="usermanage" class="btn btn-primary">
                                <i class="bi bi-arrow-counterclockwise"></i> Reset Filters
                            </a>
                            <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                                <i class="bi bi-plus-circle"></i> Add New User
                            </button>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Add User Modal -->
        <div class="modal fade" id="addUserModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="addform" action="usermanage" method="POST">
                        <input type="hidden" name="action" value="add">
                        <div class="modal-header">
                            <h5 class="modal-title">Create New User</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control" name="fullname" placeholder="Ex: nguyen van A, etc..." required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" placeholder="Ex: abc@example.com, etc..." required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Phone Number</label>
                                <input type="tel" 
                                       class="form-control" 
                                       name="phonenumber" 
                                       pattern="[0-9]{10,15}" 
                                       title="Phone number must be 10-15 digits"
                                       placeholder="Ex: 1234567890, etc..." 
                                       required>
                                <div class="invalid-feedback">
                                    Please enter a valid phone number (10-15 digits)
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Role</label>
                                <select class="form-select" name="role" required>
                                    <option value="">Select User Role</option>
                                    <option value="Administrator">Administrator</option>
                                    <option value="InventoryManager">Inventory Manager</option>
                                    <option value="StoreManager">Store Manager</option>
                                    <option value="Salesperson">Salesperson</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Create New User</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Delete Confirm Modal -->
        <div class="modal fade" id="deleteConfirmModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirm Deletion</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the following user?</p>
                        <div class="card">
                            <div class="card-body">
                                <p class="mb-1"><strong>Full Name:</strong> <span id="deleteUserName"></span></p>
                                <p class="mb-1"><strong>Email:</strong> <span id="deleteUserEmail"></span></p>
                                <p class="mb-1"><strong>Phone:</strong> <span id="deleteUserPhone"></span></p>
                                <p class="mb-1"><strong>Role:</strong> <span id="deleteUserRole"></span></p>
                            </div>
                        </div>
                        <div class="alert alert-warning mt-3">
                            <i class="bi bi-exclamation-triangle-fill"></i> This action cannot be undone.
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <form id="deleteUserForm" method="POST" action="usermanage">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="userId" id="deleteUserIdInput">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Toasts -->
        <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 1055">
            <!-- Add Toast -->
            <div id="successAddToast" class="toast align-items-center text-bg-success border-0 mb-2" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
                <div class="d-flex">
                    <div class="toast-body">✅ New user has been created successfully! Credentials sent to email!</div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
            <div id="successAddToastButNoEmail" class="toast align-items-center text-bg-danger border-0 mb-2" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
                <div class="d-flex">
                    <div class="toast-body">❌ New user has been created successfully! But get error when send credentials to the email!</div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
            <div id="errorAddToast" class="toast align-items-center text-bg-danger border-0 mb-2" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
                <div class="d-flex">
                    <div class="toast-body">❌ Failed to add user! ${sessionScope.showError}</div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
            <div id="errorPhoneAddToast" class="toast align-items-center text-bg-danger border-0 mb-2" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
                <div class="d-flex">
                    <div class="toast-body">❌ Failed to add user! Error case: The phone is existed!</div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
            <div id="errorEmailAddToast" class="toast align-items-center text-bg-danger border-0 mb-2" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
                <div class="d-flex">
                    <div class="toast-body">❌ Failed to add user! Error case: The email is existed!</div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
            <!-- Update Toast -->
            <div id="successUpdateToast" class="toast align-items-center text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
                <div class="d-flex">
                    <div class="toast-body">✅ User updated successfully!</div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
            <div id="errorUpdateToast" class="toast align-items-center text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
                <div class="d-flex">
                    <div class="toast-body">❌ Failed to update user! ${sessionScope.showError}</div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
            <!-- Delete Toast -->
            <div id="successDeleteToast" class="toast align-items-center text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
                <div class="d-flex">
                    <div class="toast-body">🗑️ User has been deleted successfully!</div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
            <div id="errorDeleteToast" class="toast align-items-center text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
                <div class="d-flex">
                    <div class="toast-body">❌ Failed to delete user! ${sessionScope.showError}</div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>

        <script>
            // Show toast
            document.addEventListener('DOMContentLoaded', function () {
            <c:if test="${not empty sessionScope.showToast}">
                <c:choose>
                    <c:when test="${sessionScope.showToast == 'add_success'}">
                var successToast = new bootstrap.Toast(document.getElementById('successAddToast'));
                successToast.show();
                    </c:when>
                    <c:when test="${sessionScope.showToast == 'add_success_no_email'}">
                var successToast = new bootstrap.Toast(document.getElementById('successAddToastButNoEmail'));
                successToast.show();
                    </c:when>
                    <c:when test="${sessionScope.ExceptionError == 'add_failed'}">
                var errorToast = new bootstrap.Toast(document.getElementById('errorAddToast'));
                errorToast.show();
                    </c:when>
                    <c:when test="${sessionScope.showToast == 'add_error_email'}">
                var errorToast = new bootstrap.Toast(document.getElementById('errorEmailAddToast'));
                errorToast.show();
                    </c:when>
                    <c:when test="${sessionScope.showToast == 'add_error_phone'}">
                var errorToast = new bootstrap.Toast(document.getElementById('errorPhoneAddToast'));
                errorToast.show();
                    </c:when>
                    <c:when test="${sessionScope.showToast == 'update_success'}">
                var successToast = new bootstrap.Toast(document.getElementById('successUpdateToast'));
                successToast.show();
                    </c:when>
                    <c:when test="${sessionScope.ExceptionError == 'update_failed'}">
                var errorToast = new bootstrap.Toast(document.getElementById('errorUpdateToast'));
                errorToast.show();
                    </c:when>
                    <c:when test="${sessionScope.showToast == 'delete_success'}">
                var successToast = new bootstrap.Toast(document.getElementById('successDeleteToast'));
                successToast.show();
                    </c:when>
                    <c:when test="${sessionScope.ExceptionError == 'delete_failed'}">
                var errorToast = new bootstrap.Toast(document.getElementById('errorDeleteToast'));
                errorToast.show();
                    </c:when>
                </c:choose>
                <c:remove var="showToast" scope="session"/>
                <c:remove var="ExceptionError" scope="session"/>
            </c:if>
            });

            // Hàm hiện modal delete với thông tin của user
            function showDeleteModal(userId, fullName, email, phone, role) {
                // Set user details in the modal
                document.getElementById('deleteUserName').textContent = fullName;
                document.getElementById('deleteUserEmail').textContent = email;
                document.getElementById('deleteUserPhone').textContent = phone;
                document.getElementById('deleteUserRole').textContent = role;
                document.getElementById('deleteUserIdInput').value = userId;

                // Show the modal
                const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
                deleteModal.show();
            }

            function togglePassword() {
                const input = document.getElementById("passwordField");
                const eyeIcon = document.querySelector(".eye-icon");
                if (input.type === "password") {
                    input.type = "text";
                    eyeIcon.textContent = "🙈"; // Icon khi password hiển thị
                } else {
                    input.type = "password";
                    eyeIcon.textContent = "👁"; // Icon khi password ẩn
                }
            }

            // Hiển thị modal khi có dữ liệu viewUser
            document.addEventListener('DOMContentLoaded', function () {
                // Khởi tạo và hiển thị modal ngay khi trang load xong
            <c:if test="${requestScope.viewUser != null}">
                var viewModal = new bootstrap.Modal(document.getElementById('viewUserModal'));
                viewModal.show();
            </c:if>
                // Xử lý sự kiện khi modal bị ẩn
                document.getElementById('viewUserModal').addEventListener('hidden.bs.modal', function () {
                    // Chuyển hướng về trang quản lý user khi đóng modal
                    window.location.href = 'usermanage?page=${requestScope.currentPage}';
                });

                // Xử lý khi click nút Edit
                document.getElementById('editButton').addEventListener('click', function () {

                    // Bật chỉnh sửa cho các trường được phép
                    document.getElementById('roleField').disabled = false;
                    document.getElementById('statusField').disabled = false;

                    // Thay đổi hiển thị các nút
                    document.getElementById('editButton').classList.add('d-none');
                    document.querySelector('.modal-footer .btn-secondary[data-bs-dismiss="modal"]').classList.add('d-none');
                    document.getElementById('saveButton').classList.remove('d-none');
                    document.getElementById('cancelButton').classList.remove('d-none');
                });

                // Xử lý khi click nút Cancel
                document.getElementById('cancelButton').addEventListener('click', function () {

                    // Tắt chỉnh sửa các trường
                    document.getElementById('roleField').disabled = true;
                    document.getElementById('statusField').disabled = true;
                    // Khôi phục giá trị ban đầu từ server 
                    document.getElementById('roleField').value = '${requestScope.viewUser.role}';
                    document.getElementById('statusField').value = '${requestScope.viewUser.status}';
                    // Thay đổi hiển thị các nút
                    document.getElementById('editButton').classList.remove('d-none');
                    document.querySelector('.modal-footer .btn-secondary[data-bs-dismiss="modal"]').classList.remove('d-none');
                    document.getElementById('saveButton').classList.add('d-none');
                    document.getElementById('cancelButton').classList.add('d-none');
                });
            });

            // Form submission handler
            document.getElementById("addform").addEventListener('submit', function (e) {
                const phoneInput = document.querySelector('input[name="phonenumber"]');
                const phoneRegex = /^[0-9]{10,15}$/;

                if (!phoneRegex.test(phoneInput.value)) {
                    e.preventDefault();
                    phoneInput.classList.add('is-invalid');
                } else {
                    phoneInput.classList.remove('is-invalid');
                }
            });

            // Real-time validation
            document.querySelector('input[name="phonenumber"]').addEventListener('input', function () {
                this.classList.remove('is-invalid');
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <div class="modal fade" id="viewUserModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">View User</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="userForm" action="usermanage" method="POST">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="userId" value="${requestScope.viewUser.user_id}">
                        <div class="modal-body">
                            <form id="userForm">
                                <div class="mb-2"><label>Full Name</label><input type="text" class="form-control" name="fullname" value="${requestScope.viewUser.fullname}" readonly></div>
                                <div class="mb-2"><label>Email</label><input type="text" class="form-control" name="email" value="${requestScope.viewUser.email}" readonly></div>
                                <div class="mb-2"><label>Phone Number</label><input type="text" class="form-control" name="phonenumber" value="${requestScope.viewUser.phonenumber}" readonly></div>

                                <!-- Role field - editable when in edit mode -->
                                <div class="mb-2">
                                    <label>Role</label>
                                    <select class="form-select" name="role" id="roleField" ${param.mode != 'edit' ? 'disabled' : ''}>
                                        <option value="Administrator" ${viewUser.role == 'Administrator' ? 'selected' : ''}>Administrator</option>
                                        <option value="InventoryManager" ${viewUser.role == 'InventoryManager' ? 'selected' : ''}>Inventory Manager</option>
                                        <option value="StoreManager" ${viewUser.role == 'StoreManager' ? 'selected' : ''}>Store Manager</option>
                                        <option value="Salesperson" ${viewUser.role == 'Salesperson' ? 'selected' : ''}>Salesperson</option>
                                    </select>
                                </div>

                                <!-- Status field - editable when in edit mode -->
                                <div class="mb-2">
                                    <label>Status</label>
                                    <select class="form-select" name="status" id="statusField" ${param.mode != 'edit' ? 'disabled' : ''}>
                                        <option value="Active" ${viewUser.status == 'Active' ? 'selected' : ''}>Active</option>
                                        <option value="Suspend" ${viewUser.status == 'Suspend' ? 'selected' : ''}>Suspend</option>
                                    </select>
                                </div>

                                <!-- Các trường khác (readonly) -->
                                <div class="mb-2"><label>Gender</label><input type="text" class="form-control" value="${requestScope.viewUser.gender}" readonly></div>
                                <div class="mb-2"><label>Date of Birth</label><input type="text" class="form-control" value="${requestScope.viewUser.dob}" readonly></div>
                                <div class="mb-2"><label>Address</label><textarea class="form-control" readonly>${requestScope.viewUser.address}</textarea></div>
                                <div class="mb-2 position-relative">
                                    <label>Password</label>
                                    <input type="password" class="form-control" value="${requestScope.viewUser.password}" readonly id="passwordField">
                                    <button type="button" class="password-toggle-btn" onclick="togglePassword()">
                                        <span class="eye-icon">👁</span>
                                    </button>
                                </div>
                        </div>
                        <div class="modal-footer justify-content-between">
                            <c:choose>
                                <c:when test="${param.mode == 'edit'}">
                                    <button type="submit" class="btn btn-success">Save</button>
                                    <a href="usermanage?action=view&userId=${requestScope.viewUser.user_id}" class="btn btn-secondary">Cancel</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="usermanage?action=view&userId=${requestScope.viewUser.user_id}&mode=edit" class="btn btn-warning">Edit</a>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
