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
    </head>
    <body>
        <header>
            <div class="header-container">
                <!-- Logo -->
                <div class="bigLogo">
                    <div class="logo">
                        <img src="image/logo/logo.png" alt="FPT Cinema" style="cursor: pointer;" onclick="window.location.href='HomePage.jsp';">
                    </div>
                    <h3 class="text">FPT CINEMA</h3>
                </div>
                <!-- Navbar -->
                <nav class="navbar">
                    <ul>
                        <li><a href="MovieServlet?action=booking">Mua Vé</a></li>
                        <li><a href="#">Phim</a></li>
                        <li><a href="#">Góc Điện Ảnh</a></li>
                        <li><a href="#">Sự Kiện</a></li>
                        <li><a href="#">Rạp/Giá Vé</a></li>
                    </ul>
                </nav>
                <!-- User Info -->
                <div class="user-info">
                    <div class="profile-container">
                        <div class="profile">
                            <img src="image/logo/logo.png" alt="Avatar" class="avatar">
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
