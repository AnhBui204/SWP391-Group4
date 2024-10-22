<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Cineluxe Cinema</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="bs/css/bootstrap.css"/>
        <link rel="stylesheet" href="css/headerDienCss.css" />
    </head>
    <body>
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
            .avatar{
                width: 40px;
                height: 40px;
                border-radius: 50%;
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
                        <div class="text-center w-100">
                            <div class="d-flex justify-content-evenly align-items-center">
                                <div class="dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img src="${users.avatar}" alt="Avatar" class="avatar">



                                </div>
                                <ul class="dropdown-menu">
                                    <li><a href="UserServlet?action=db" class="dropdown-item">Tài Khoản</a></li>
                                    <li><a href="#" class="dropdown-item">Lịch Sử</a></li>
                                    <li><a href="UserServlet?action=logout" class="dropdown-item">Đăng Xuất</a></li>
                                </ul>
                                <span class="username">${users.username}</span>
                                <span class="stars">0 Stars</span>
                            </div>

                            <!--                            <div class="dropdown-menu">
                                                            <a href="UserServlet?action=db" class="dropdown-item">Tài Khoản</a>
                                                            <a href="#" class="dropdown-item">Lịch Sử</a>
                                                            <a href="UserServlet?action=logout" class="dropdown-item">Đăng Xuất</a>
                                                        </div>-->
                        </div>
                    </div>
                    <!--                    <div class="user-info">
                                            <div class="profile-container">
                                                <div class="profile">
                                                    <img src="${users.avatar}" alt="Avatar" class="avatar">
                                                    <span class="username">${users.username}</span>
                                                    <span class="stars">0 Stars</span>
                                                </div>
                                                <div class="dropdown-menu">
                                                    <a href="UserServlet?action=db" class="dropdown-item">Tài Khoản</a>
                                                    <a href="#" class="dropdown-item">Lịch Sử</a>
                                                    <a href="UserServlet?action=logout" class="dropdown-item">Đăng Xuất</a>
                                                </div>
                                            </div>
                                            
                                                                    <div class="dropdown">
                                                                        <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                            Dropdown button
                                                                        </button>
                                                                        <ul class="dropdown-menu">
                                                                            <li><a class="dropdown-item" href="#">Action</a></li>
                                                                            <li><a class="dropdown-item" href="#">Another action</a></li>
                                                                            <li><a class="dropdown-item" href="#">Something else here</a></li>
                                                                        </ul>
                                                                    </div>
                    
                                        </div>-->


                </div>
            </header>
        </div>
    </body>
</html>
