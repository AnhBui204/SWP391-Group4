<%-- 
    Document   : logsign
    Created on : 6 Sep 2024, 9:03:56 PM
    Author     : HongD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="css/body_style.css" rel="stylesheet">
    </head>
    <body>
        <div class="signlog">
            <div id="activate_button">
                <button class="btn btn-primary">nút</button>
            </div>
            <div id="box_signlog" class="hidden">
                <div class="logo_signlog">
                    <img src="image/logo/logo.png" alt="alt"/>
                    <p>đăng nhập</p>
                </div>
                <div class="input_layer">
                    <p>username</p>
                    <input type="text" placeholder="username">
                    <p>password</p>
                    <input type="password" placeholder="password">
                </div>
                <div class="login_button">
                    <button class="btn btn-warning">dang nhap</button>
                    <a herf="#">Quên mật khẩu?</a>
                </div>
                <hr>
                <div class="no_account">
                    <p>Bạn chưa có tài khoản?</p>
                    <a href="../signin/signin.jsp" class="btn btn-outline-warning">Đăng kí</a>
                </div>
            </div>
        </div>

        <script>
            document.getElementById('activate_button').addEventListener('click', function () {
                var hiddenElement = document.getElementById('box_signlog');
                if (hiddenElement.classList.contains('hidden')) {
                    hiddenElement.classList.remove('hidden');
                } else {
                    hiddenElement.classList.add('hidden');
                }
            });
        </script>

        <!--        <button id="toggleButton">Click Me</button>
                <div id="hiddenElement" class="hidden">
                    This is a hidden element.
                </div>
        
                <script>
                    document.getElementById('toggleButton').addEventListener('click', function () {
                        var hiddenElement = document.getElementById('hiddenElement');
                        if (hiddenElement.classList.contains('hidden')) {
                            hiddenElement.classList.remove('hidden');
                        } else {
                            hiddenElement.classList.add('hidden');
                        }
                    });
                </script>
        
                <style>
                    .hidden {
                        display: none;
                    }
                </style>-->

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="jvs.js"></script>
    </body>
</html>