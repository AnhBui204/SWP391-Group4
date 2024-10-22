<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CineLuxe Cinema</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="bs/css/bootstrap.css"/>
        <link rel="stylesheet" href="css/headerDienCss.css" />
    </head>
    <body>
        <!-- Overlay for the darkened background -->
        <!--<div class="overlay hidden"></div>-->
        <style>
            .logo{
                border-radius: 50%;
                background-color: #FFD08E;
            }
            .logo img {
                border: 2px solid #FF8C00;
                border-radius: 50%;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                background: none;
            }
            .logo img:hover {
                transform: scale(1.1);
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.3);
            }
        </style>
        <div style="background: linear-gradient(135deg, #F4A460, #FFE4B5);">
        <header class="container">
            <div class="row">
                <!-- Logo -->
                <div class="col-3">
                    <div class="logo" style="width: 150px; height: 150px;margin: 0 auto;">
                        <img src="image/logo/logo.png" alt="FPT Cinema" style="cursor: pointer; height: 100%;" onclick="window.location.href = 'HomePage.jsp';" class="img-fluid">
                    </div>
                    <h1 class="text-center mt-3 mb-5 display-5 w-100" style="color: #61164e; font-weight: bold;">CineLuxe Cinema</h1>
                </div>
                <!-- Navbar -->
                <nav class="col-7 d-flex align-items-center">
                    <ul class="w-100 d-flex justify-content-evenly m-0" style="list-style: none;">
                        <li>
                            <a href="MovieServlet?action=booking">
                                <div id="raffle-red" class="entry raffle">
                                    <div class="no-scale"></div>
                                </div>
                            </a>
                        </li>
                        <li class="d-flex justify-content-center align-items-center">
                            <a href="#" class="text-decoration-none fs-1" style="color: #61164e; font-weight: bold;">Phim</a>
                        </li>
                        <li class="d-flex justify-content-center align-items-center">
                            <a href="#" class="text-decoration-none fs-1" style="color: #61164e; font-weight: bold;">Ưu Đãi</a>
                        </li>
                        <li class="d-flex justify-content-center align-items-center">
                            <a href="#" class="text-decoration-none fs-1" style="color: #61164e; font-weight: bold;">Rạp/Giá Vé</a>
                        </li>
                    </ul>
                </nav>

                <!-- User Info -->
                <div class="col-2 d-flex justify-content-center align-items-center">
                    <div class="text-center">
                        <a href="Login.jsp" class="btn btn-primary fs-3">Login</a>
                    </div>
                </div>
            </div>
        </header>
            </div>
        <script>
            document.getElementById('activate_button').addEventListener('click', function () {
                var hiddenElement = document.getElementById('box_signlog');
                hiddenElement.classList.toggle('hidden');
            });
        </script>
        <script src="bs/js/bootstrap.bundle.js"></script>
    </body>

</html>