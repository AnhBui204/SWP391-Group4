<<<<<<< Updated upstream

=======
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
>>>>>>> Stashed changes
<%@include file="includes/header_user.jsp" %>
<link rel="stylesheet" href="css/headerssj2.css" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chỉnh sửa hồ sơ</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css"/>
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
                                <i class="fa-solid fa-gift fa-2x"></i>
                                <p class="m-0 px-2 fs-3">0 Stars</p>
                                 <% if (moneyLeft != null) { %>
                            <p class="m-0 px-2 fs-4">Số tiền: <strong><%= moneyLeftInt %></strong></p>
                        <% } else { %>
                            <p class="m-0 px-2 fs-4">Số tiền: <strong>Không có dữ liệu</strong></p>
                        <% } %>
                            </div>

                        </div>
                        <div class="d-flex justify-content-center mt-3">
                            <form id="uploadForm"  enctype="multipart/form-data">
                                <input type="file" class="text-center" name="profileImage" id="profileImage" />
                                <input type="hidden" name="userID" value="${user.userID}" />
                                <button type="button" id="uploadButton">Upload Image</button>
                            </form>
                        </div>
                        <hr class="w-75 mx-auto">
                        <div class="text-center mt-3 d-flex flex-column">
                            <h3 class="bg-white p-3">Chỉnh sửa hồ sơ</h3>
<<<<<<< Updated upstream
                            <h3 class="mt-4 p-3">Lịch sử giao dịch</h3>
=======
                            <a class="h3 mt-4 p-3 d-block" href="summaryBooking.jsp">Lịch sử giao dịch</a>
>>>>>>> Stashed changes
                            <h3 class="my-4 p-3">Quà tặng tích điểm</h3>
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
                                <button class="input-group-text">Thay đổi</button>
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
                                <button class="input-group-text">Thay đổi</button>
                            </div>
                        </div>
                        <button class="btn btn-warning mt-5">Cập nhật thông tin</button>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty user}">
                <p>No user information available.</p>
            </c:if>
        </div>
        <script src="bs/js/bootstrap.bundle.js"></script>
    </body>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#uploadButton').click(function () {
                var formData = new FormData($('#uploadForm')[0]);

                $.ajax({
                    url: 'UserServlet?action=uploadProfileImage',
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        // Cập nhật lại ảnh đại diện trên trang
                        $('#profileImageDisplay').attr('src', response.newAvatarPath);
                        alert(response.message);
                    },
                    error: function () {
                        alert('Upload failed.');
                    }
                });
            });
        });
    </script>

    <%@include file="includes/footer.jsp" %>
    <link rel="stylesheet" href="css/footer.css" />
</html>
