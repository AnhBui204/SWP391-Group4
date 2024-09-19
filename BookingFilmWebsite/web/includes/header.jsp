<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Galaxy Cinema</title>
        <link rel="stylesheet" href="../css/headers.css"/>
        <link rel="stylesheet" href="../css/body.css"/>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        <!-- Overlay for the darkened background -->
        <div class="overlay hidden"></div>

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
                        <li><a href="#">Mua Vé</a></li>
                        <li><a href="#">Phim</a></li>
                        <li><a href="#">Góc Điện Ảnh</a></li>
                        <li><a href="#">Sự Kiện</a></li>
                        <li><a href="#">Rạp/Giá Vé</a></li>
                    </ul>
                </nav>
                <!-- User Info -->
                <div class="signlog">
                    <a href="Login.jsp" class="btn btn-custom">Login</a>
                </div>
            </div>
        </header>

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
    </body>
</html>
