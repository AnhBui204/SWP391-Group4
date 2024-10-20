<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Galaxy Cinema</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="../css/headerssj1.css"/>
    </head>
    <body>
        <div class="overlay hidden"></div>
        <header>
            <div class="header-container container-fluid d-flex justify-content-between align-items-center p-3">
                <!-- Logo -->
                <div class="bigLogo d-flex align-items-center ms-n2">
                    <div class="logo me-2">
                        <img src="image/logo/logo.png" alt="FPT Cinema" style="cursor: pointer;" onclick="window.location.href = 'HomePage.jsp';">
                    </div>
                    <h3 class="text mb-0">CineLuxe Cinema</h3>
                </div>
                <!-- Navbar -->
                <nav class="navbar">
                    <ul class="navbar-nav d-flex flex-row">
                        <!--
                                                <li class="nav-item me-3">
                                                    <a class="nav-link" href="MovieServlet?action=booking">Mua Vé</a>
                                                </li>-->

                        <li class="nav-item me-3">
                            <a class="nav-link p-0" href="MovieServlet?action=booking">
                                <div id="raffle-red" class="entry raffle">
                                    <div class="no-scale"></div>
                                </div>
                            </a>
                        </li>
                        <li class="nav-item me-3">
                            <a class="nav-link" href="#">Phim</a>
                        </li>
                        <li class="nav-item me-3">
                            <a class="nav-link" href="#">Ưu Đãi</a>
                        </li>
                        <li class="nav-item me-3">
                            <a class="nav-link" href="#">Rạp/Giá Vé</a>
                        </li>
                    </ul>
                </nav>

                <!-- User Info -->
                <div class="user-info">
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

                </div>

            </div>
        </header>
    </body>
</html>
