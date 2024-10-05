<%@include file="includes/header.jsp" %>
<link rel="stylesheet" href="css/headers.css" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css"/>
        <link rel="stylesheet" href="css/CustomerProfile_css.css">
    </head>
    <body>
        <div class="container my-5">
            <div class="row">
                <h1 class="col-12 mb-4 display-5">Chỉnh sửa hồ sơ</h1>
                <div class="col-4 d-flex flex-column justify-content-center shadow-lg rounded" style="background-color: rgb(255, 247, 229);">
                    <div class="d-flex justify-content-center pt-5  pb-2">
                        <img src="image/temp/meo.jpg" alt="alt" class="img-fluid rounded-circle" style="height: 100px; width: 100px;"/>
                        <div class="d-flex align-items-center px-3">
                            <i class="fa-solid fa-gift fa-2x"></i>
                            <p class="m-0 px-2 fs-3">0 Stars</p>
                        </div>
                    </div>
                    
                        <hr class="w-75 mx-auto">
                    
                    
                    <div class="text-center mt-3 d-flex flex-column">
                        <h3 class="bg-white p-3">Chỉnh sửa hồ sơ</h3>
                        <h3 class="mt-4 p-3">Lịch sử giao dịch</h3>
                        <h3 class="my-4 p-3">Quà tặng tích điểm</h3>
                    </div>
                </div>
                <div class="col-1"></div>
                <div class="col-7 row">
                    <div class="col-12 row" style="padding-right: 0;">
                        <div class="col-7">
                            <h5>Tên người dùng</h5>
                            <div class="input-group">
                                  <span class="input-group-text"><i class="fa-solid fa-user"></i></span>

                                  <input type="text" value="MrZing" class="form-control fs-4" disabled>
                            </div>
                        </div>
                        <div class="col-1"></div>
                        <div class="col-4 px-0">
                            <h5>Giới tính</h5>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-venus-mars"></i></span>
                                
                                <input type="text" value="Nam" class="form-control fs-4" disabled>
                            </div>
                        </div>
                    </div>
                    <div class="pt-3">
                        <h5>Họ và tên</h5>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-address-card"></i></span>
                            <input type="text" value="Nguyễn Hồng Diện" class="form-control fs-4" disabled>
                        </div>
                    </div>
                    <div class="pt-3">
                        <h5>Email</h5>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                            <input type="text" value="fptcinema@gmail.com" class="form-control fs-4" disabled>
                            <span class="input-group-text"><p class="m-0">Thay đổi</p></span>
                        </div>
                    </div>
                    <div class="pt-3">
                        <h5>Số điện thoại</h5>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                            <input type="text" value="0123456789" class="form-control fs-4" disabled>
                        </div>
                    </div>
                    <div class="pt-3">
                        <h5>Mật khẩu</h5>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                            <input type="password" value="12345678" class="form-control fs-4" disabled>
                            <span class="input-group-text"><p class="m-0">Thay đổi</p></span>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script src="bs/js/bootstrap.bundle.js"></script>
</html>
<%@include file="includes/footer.jsp" %>
<link rel="stylesheet" href="css/footer.css" />