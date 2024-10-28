<%@page import="java.math.BigDecimal"%>
<%@page import="Model.UserDB"%>
<%
    String user = (String) session.getAttribute("user");
    String userID = (String) session.getAttribute("id");

    BigDecimal moneyLeft = UserDB.getCurrentBalance(userID);
    int moneyLeftInt = (moneyLeft != null) ? moneyLeft.intValue() : 0;
    if (user == null) { %>
<%@include file="includes/header.jsp" %>
<% } else { %>
<%@include file="includes/header_user.jsp" %>
<% }%>
<link rel="stylesheet" href="css/headerssj3.css">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chỉnh sửa hồ sơ</title>
        <link rel="stylesheet" href="bs/css/bootstrap.min.css"/>

        <link rel="stylesheet" href="css/CustomerProfile_css.css">
    </head>
    <body>
        <div class="container my-5">
            <c:if test="${not empty user}">
                <div class="row">
                    <h1 class="col-12 mb-4 display-5">Chỉnh sửa hồ sơ</h1>
                    <div class="col-md-4 col-12 d-flex flex-column justify-content-center shadow-lg rounded" style="background-color: rgb(255, 247, 229);">
                        <div class="d-flex justify-content-center pt-5 pb-2">
                            <img src="${user.avatar}" alt="Profile Image" class="img-fluid rounded-circle" style="height: 100px; width: 100px;"/>
                            <div class="d-flex align-items-center px-3">
                                <% if (moneyLeft != null) {%>
                                <p class="m-0 px-2 fs-6 text-success">Số tiền: <strong><%= moneyLeftInt%></strong></p>
                                <% } else { %>
                                <p class="m-0 px-2 fs-6">Số tiền: <strong>Không có dữ liệu</strong></p>
                                <% }%>
                            </div>

                        </div>
                        <hr class="w-75 mx-auto">
                        <div class="text-center mt-3 d-flex flex-column">
                            <h3 class="bg-white p-3">Chỉnh sửa hồ sơ</h3>
                            <a class="h3 mt-4 p-3 d-block" href="summaryBooking.jsp">Lịch sử giao dịch</a>
                            <h3 class="my-4 p-3">Quà tặng tích điểm</h3>
                            <h3 class="mt-4 p-3"><a href="report.jsp?userID=${user.userID}">Báo cáo</a></h3>

                        </div>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="col-md-7 col-12">
                        <div class="row">
                            <div class="col-md-8 mb-3"> <!-- Thêm mb-3 để tạo khoảng cách dưới -->
                                <h5>Tên người dùng</h5>

                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                    <input type="text" value="${user.username}" class="form-control fs-4" disabled />
                                </div>


                            </div>
                            <div class="col-md-4">
                                <h5>Giới tính</h5>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa-solid fa-venus-mars"></i></span>
                                    <input type="text" value="${user.sex}" class="form-control fs-4" disabled>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6"> <!-- Thêm mb-3 để tạo khoảng cách dưới -->
                                <h5>Tên</h5>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                    <input type="text" value="${user.fName}" class="form-control fs-4" disabled />
                                </div>
                            </div>
                            <div class="col-md-6"> <!-- Thêm mb-3 để tạo khoảng cách dưới -->
                                <h5>Họ</h5>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                    <input type="text" value="${user.lName}" class="form-control fs-4" disabled />
                                </div>
                            </div>
                        </div>

                        <div class="pt-3">
                            <h5>Email</h5>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                                <input type="text" value="${user.email}" class="form-control fs-4" disabled>
                                <button type="button" class="input-group-text" data-bs-toggle="modal" data-bs-target="#changeEmailModal">Thay đổi</button>
                            </div>
                        </div>
                        <div class="pt-3">
                            <h5>Số điện thoại</h5>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                                <input type="text" value="${user.phone}" class="form-control fs-4" disabled>
                            </div>
                        </div>
                        <div class="pt-3">
                            <h5>Mật khẩu</h5>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                                <input type="password" value="${user.password}" class="form-control fs-4" disabled>
                                <button type="button" class="input-group-text btn btn-warning" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                                    Đổi mật khẩu
                                </button>

                            </div>
                        </div>

                        <button type="button" class="btn btn-warning mt-3" data-bs-toggle="modal" data-bs-target="#updateProfileModal">
                            Cập nhật
                        </button>

                    </div>
                </div>
            </c:if>
            <c:if test="${empty user}">
                <p>No user information available.</p>
            </c:if>
        </div>



        <div class="modal" id="updateProfileModal" tabindex="-1" aria-labelledby="simpleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updateProfileModalLabel">Cập nhật thông tin cá nhân</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>


                    <div class="modal-body d-flex">
                        <div class="col-md-6">
                            <form id="updateProfileForm" action="UserServlet?action=updateProfile" method="POST">
                                <!-- Profile Update Fields -->
                                <div class="mb-3">
                                    <label for="firstName" class="form-label">Tên <span class="text-danger">*</span></label>
                                    <input type="text" required name="firstName" placeholder="${user.fName}" class="form-control" />
                                </div>
                                <div class="mb-3">
                                    <label for="lastName" class="form-label">Họ <span class="text-danger">*</span></label>
                                    <input type="text" required name="lastName" placeholder="${user.lName}" class="form-control" />
                                </div>
                                <div class="mb-3">
                                    <label for="phone" class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                    <input type="tel" id="phone" name="phone"  placeholder="${user.phone}" class="form-control" />
                                </div>
                                <div class="mb-3">
                                    <label for="gender" class="form-label">Giới tính</label>
                                    <select name="gender" class="form-select">
                                        <option>Nam</option>
                                        <option>Nữ</option>
                                        <option>Khác</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="dob" class="form-label">Ngày sinh <span class="text-danger">*</span></label>
                                    <input type="date" id="dob" name="dob" placeholder="${user.dob}" class="form-control" />
                                </div>
                                <input type="hidden" name="userID" value="${user.userID}" />
                                <button type="button" class="btn btn-primary" id="saveProfileButton">Lưu thay đổi</button>
                            </form>
                        </div>

                        <!-- Separate Image Upload Form -->
                        <div class="col-md-6 text-center">
                            <form id="uploadForm" enctype="multipart/form-data">
                                <img src="${user.avatar}" alt="Profile Image" class="img-fluid rounded-circle" style="height: 150px; width: 150px;"/>
                                <div class="mt-3">
                                    <input type="hidden" name="userID" value="${user.userID}" />
                                    <input type="file" class="form-control" name="profileImage" id="profileImage" />
                                    <button type="submit" id="uploadButton" class="btn btn-warning mt-2">Đổi Ảnh</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Change Password Modal -->
        <div class="modal" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="changePasswordModalLabel">Đổi mật khẩu</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="changePasswordForm" action="UserServlet?action=changePassword" method="POST">
                            <div class="mb-3">
                                <label for="currentPassword" class="form-label">Mật khẩu hiện tại</label>
                                <input type="password" name="currentPassword" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">Mật khẩu mới</label>
                                <input type="password" name="newPassword" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="confirmNewPassword" class="form-label">Xác nhận mật khẩu mới</label>
                                <input type="password" name="confirmNewPassword" class="form-control" required>
                            </div>
                            <input type="hidden" name="userID" value="${user.userID}" />
                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Change Password Modal -->
        <div class="modal" id="changeEmailModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="changePasswordModalLabel">Đổi Email</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="changeEmailForm" action="UserServlet?action=changeEmail" method="POST">
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">Email mới</label>
                                <input type="text" name="newEmail" class="form-control" required>
                            </div>
                            <input type="hidden" name="userID" value="${user.userID}" />
                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>



    </body>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="bs/js/bootstrap.bundle.js"></script>
    <script>
        $(document).ready(function () {
            // Upload Image
            $('#uploadForm').submit(function (event) {
                event.preventDefault(); // Prevent default form submission

                var formData = new FormData(this);
                $.ajax({
                    url: 'UserServlet?action=uploadProfileImage',
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        $('img[alt="Profile Image"]').attr('src', response.newAvatarPath); // Update image
                        alert(response.message);
                    },
                    error: function () {
                        alert('Upload failed.');
                    }
                });
            });

            $('#saveProfileButton').click(function () {
                var formData = new FormData($('#updateProfileForm')[0]);

                $.ajax({
                    url: 'UserServlet?action=updateprofile',
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        if (response === "success") {
                            alert('Cập nhật thành công.');
                            $('#updateProfileModal').modal('hide');
                            setTimeout(function () {
                                location.reload(); // Refresh the page after a delay
                            }, 3000);
                        } else {
                            alert('Cập nhật thất bại.');
                        }
                    },
                    error: function () {
                        alert('Cập nhật thất bại.');
                    }
                });
            });

            $('#changePasswordForm').submit(function (e) {
                e.preventDefault();

                $.ajax({
                    url: 'UserServlet?action=changePassword',
                    type: 'POST',
                    data: $(this).serialize(),
                    dataType: 'json',
                    success: function (response) {
                        if (response.message === "Đổi mật khẩu thành công.") {
                            alert(response.message);
                            $('#changePasswordModal').modal('hide');  // Đóng modal khi thành công
                            $('#changePasswordForm')[0].reset();  // Xóa hết dữ liệu trong form
                        } else {
                            alert(response.message);  // Hiển thị thông báo lỗi mà không đóng modal
                        }
                    },
                    error: function (xhr) {
                        var response = JSON.parse(xhr.responseText);
                        alert(response.message || 'Đổi mật khẩu thất bại.');
                    }
                });
            });


        });


    </script>

    <%@include file="includes/footer.jsp" %>
    <link rel="stylesheet" href="css/footerssj2.css" />
</html>