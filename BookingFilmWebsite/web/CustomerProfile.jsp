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
<link rel="stylesheet" href="css/headerssj4.css">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>

        <link rel="stylesheet" href="css/headerssj4.css" />
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chỉnh sửa hồ sơ</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <link rel="stylesheet" href="css/CustomerProfile_css.css">
    </head>
    <body>
        <div class="container my-5">
            <c:if test="${not empty user}">
                <div class="row">
                    <div class="col-md-4 col-12 d-flex flex-column justify-content-center shadow-lg rounded" style="background-color: rgb(255, 247, 229);">
                        <div class="d-flex justify-content-center pt-5 pb-2">
                            <img src="${user.avatar}" alt="Profile Image" class="img-fluid rounded-circle" style="height: 100px; width: 100px;"/>
                            <div class="d-flex flex-column align-items-center justify-content-center mt-3 px-3">
                                <% if (moneyLeft != null) {%>
                                <p class="m-0 px-2 fs-6 text-success">Số tiền: <strong><%= moneyLeftInt%> VNĐ</strong></p>
                                <% } else { %>
                                <p class="m-0 px-2 fs-6 text-success">Số tiền: <strong> 0 VNĐ</strong></p>
                                <% }%>
                                <a href="charge.jsp?userID=${user.userID}" class="btn btn-success" >
                                    Nạp tiền
                                </a>
                            </div>

                        </div>
                        <hr class="w-75 mx-auto">
                        <div class="text-center mt-3 d-flex flex-column">
                            <a class="h3 mt-4 p-3 d-block bg-white text-decoration-none rounded" href="UserServlet?action=db">Chỉnh sửa hồ sơ</a>
                            <a class="h3 mt-4 p-3 d-block text-decoration-none" href="summaryBooking.jsp">Lịch sử giao dịch</a>
                            <a class="h3 mt-4 p-3 d-block text-decoration-none" href="report.jsp?userID=${user.userID}">Phản hồi</a>
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
                                <button type="button" class=" btn-warning text-dark rounded" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
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
                            <input type="hidden" name="email" value="${user.email}"/>
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
                        // Tự động load lại trang sau 3 giây
                        setTimeout(function () {
                            location.reload();
                        }, 100); // 3000 ms = 3 giây
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
//                            alert(response.message);
//                            $('#changePasswordModal').modal('hide');  // Đóng modal khi thành công
//                            $('#changePasswordForm')[0].reset();  // Xóa hết dữ liệu trong form
                            window.location.href = "http://localhost:8080/BookingFilmWebsite/otp_authentication.jsp";
                        } else {
                            alert(response.message); // Hiển thị thông báo lỗi mà không đóng modal
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