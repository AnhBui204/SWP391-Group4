<div id="OTP" class="position-fixed row dnone">
    <div id="box" class="row justify-content-center">
        <div id="box_icon" class="col-5 text-center align-self-center">
            <i class="fa-solid fa-envelope fa-8x"></i>
        </div>
        
        <div class="col-12" style="height: 15%;">
            <p class="text-center fs-2">Nhập mã OTP được gửi về email</p>
        </div>
        
        <div class="col-12 row flex-row justify-content-center">
            <input type="text" maxlength="1" required class="form-comtrol col-2 fs-1 mx-1 text-center" autofocus="">
            <input type="text" maxlength="1" required class="form-comtrol col-2 fs-1 mx-1 text-center">
            <input type="text" maxlength="1" required class="form-comtrol col-2 fs-1 mx-1 text-center">
            <input type="text" maxlength="1" required class="form-comtrol col-2 fs-1 mx-1 text-center">
        </div>

        <div class="col-12 text-center mt-5">
            <p class="d-inline mx-2 fs-5">Gửi lại mã mới sau 60 giây</p>
            <a class="d-inline mx-2 fs-5">Gửi lại</a>
        </div>
    </div>
</div>
<%@include file="includes/header.jsp" %>
<link rel="stylesheet" href="css/headers.css" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css"/>
        <link rel="stylesheet" href="css/ForgetPassword_css.css"/>
    </head>
    <body>
        <div class="container row m-auto justify-content-center"">
            <div class="col-12 mt-5">
                <h1 class="display-4 text-center fw-semibold">Quên mật khẩu</h1>
            </div>
            <div class="row col-md-7 mt-4" style="height: 50px;">
                <span class="col-1 input-group-text justify-content-center" id="basic-addon1"><i class="fa-solid fa-envelope"></i></span>
                <input type="text" name="name" placeholder="Nhập địa chỉ email" class="form-control fs-3 h-100 col">
            </div>

            <div class="col-md-7 mt-4 text-warning">
                <i class="fa-solid fa-triangle-exclamation d-inline mx-3"></i>
                <p class="d-inline">Email không được đăng ký sẽ không được gửi mã OTP</p>
            </div>

            <hr class="col-md-6 mt-3 mb-0">

            <div class="col-6 justify-content-center d-flex my-5">
                <input type="button" value="Gửi" class="btn btn-warning text-white fs-3 py-2 px-5" id="butt">
            </div>
        </div>

        <script>
            var page = document.getElementById('OTP');
            
            document.getElementById('butt').addEventListener('click', function () {
                page.classList.remove('dnone');

            });
        </script>
        <script src="bs/js/bootstrap.bundle.js"></script>
    </body>
</html>
<%@include file="includes/footer.jsp" %>
<link rel="stylesheet" href="css/footer.css" />
