<%-- 
    Document   : signin
    Created on : 7 Sep 2024, 11:20:31 AM
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
        <link rel="stylesheet" href="signin.css"/>
    </head>
    <body>

        <div class="logo_signin">
            <a href="" target="target"><img src="../image/logo/logo.png" alt="alt"/></a>
        </div>
        <div class="box_signin">
            <div class="title_signin">
                <p>Đăng Ký</p>
            </div>
            <div class="input_signin">
                <div class="box_1_input">
                    <p class="box_input_title">Username</p>
                    <input type="text" placeholder="Username" class="box_input">
                </div>

                <div class="box_1_input">
                    <p class="box_input_title">Password</p>
                    <input type="text" placeholder="Password" class="box_input">
                </div>

                <div class="box_1_input">
                    <p class="box_input_title">Email</p>
                    <input type="text" placeholder="Email" class="box_input">
                </div>

                <div class="box_1_input_group_1">
                    <div class="box_1_input" id="box_1_input_1">
                        <p class="box_input_title" id="box_input_title_half_1">Phonenumber</p>
                        <input type="text" placeholder="Phonenumber" class="box_input" id="box_input_half_1">
                    </div>

                    <div class="box_1_input" id="box_1_input_2">
                        <p class="box_input_title" id="box_input_title_half_2">Sex</p>
                        <select placeholder="Sex" class="box_input" id="box_input_half_2" >
                            <option>None</option>
                            <option>Nam</option>
                            <option>Nữ</option>
                            <option>Khác</option>
                        </select>
                    </div>
                </div>



                <div class="box_1_input">
                    <p class="box_input_title">Date Of Birth</p>
                    <input type="date" placeholder="Date Of Birth" class="box_input">
                </div>

            </div>
            <hr>
            <div class="confirm_button">
                <button class="btn btn-warning">Đăng Ký</button>
            </div>
        </div>
        <div class="signin_background"></div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    </body>
</html>
