<%-- 
    Document   : Signup
    Created on : 13 Oct 2024, 1:50:59 pm
    Author     : HongD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="bs/css/bootstrap.css"/>
    </head>
    <body style="overflow: hidden;">
        <div class="row" style="background-image: radial-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url(image/temp/Signin_Background_Image.jpg); width: 100vw; height: 100vh;">
            <div class="col-4">
                <img src="image/logo/logo.png" width="150px" height="150px" alt="alt"/>
            </div>
            <div class="row col-4 justify-content-center rounded" style="background-color: #fffaef; width: 40vw; height: 80vh; margin-top: 10vh;">
                <div class="row col-12 align-items-center">
                    <h1 class="text-center m-0">Đăng kí</h1>
                </div>
                <div class="col-12 row justify-content-center">
                    <div class="mt-0 col-12">
                        <p class="m-0">Tên người dùng</p>
                        <input type="text" placeholder="Tên người dùng" class="w-100 fs-5"/>
                    </div>
                    <div class="mt-1 row justify-content-between p-0">
                        <div class="col-6">
                            <p class="m-0">Mật khẩu</p>
                            <input type="password" placeholder="Mật khẩu" class="w-100 fs-5"/>
                        </div>
                        <div class="col-6">
                            <p class="m-0">Xác nhận mật khẩu</p>
                            <input type="password" placeholder="Xác nhận mật khẩu" class="w-100 fs-5"/>
                        </div>
                    </div>
                    <div class="mt-1">
                        <p class="m-0">Họ và tên</p>
                        <input type="text" placeholder="Họ và tên" class="w-100 fs-5"/>
                    </div>
                    <div class="mt-1">
                        <p class="m-0">Email</p>
                        <input type="text" placeholder="Email" class="w-100 fs-5"/>
                    </div>
                    <div class="mt-1 row justify-content-between p-0">
                        <div class="col-6">
                            <p class="m-0">Số điện thoại</p>
                            <input type="text" placeholder="Số điện thoại" class="w-100 fs-5"/>
                        </div>
                        <div class="col-6">
                            <p class="m-0">Giới tính</p>
                            <select class="w-100 fs-5" style="padding: 1px 2px;">
                                <option>Nam</option>
                                <option>Nữ</option>
                            </select>
                        </div>
                    </div>
                    <div class="mt-1">
                        <p class="m-0">Ngày, tháng, năm sinh</p>
                        <input type="date" placeholder="Ngày, tháng, năm sinh" class="w-100 fs-5"/>
                    </div>
                </div>
                <div class="col-12 mt-3">
                    <input type="button" value="Đăng kí" class="bg-warning border-0 w-100 py-2 text-white rounded fs-5"/>
                </div>
            </div>
        </div>
        <script src="bs/js/bootstrap.bundle.js"></script>
    </body>
</html>
