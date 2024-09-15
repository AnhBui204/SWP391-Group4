<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Galaxy Cinema</title>
        <link rel="stylesheet" href="../css/header.css"/>
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
                        <img src="../image/logo/logo.png" alt="FPT Cinema">
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
                    <div id="activate_button">
                        <button class="btn btn-primary">Toggle Login</button>
                    </div>
                    <div id="box_signlog" class="hidden">
                        <div class="logo_signlog">
                            <img src="image/logo/logo.png" alt="Logo"/>
                            <p>Login</p>
                        </div>
                        <form action="UserServlet" method="post">
                            <div class="input_layer">
                                <label for="username">Username</label>
                                <input type="text" id="username" name="uname" placeholder="Username" required>
                                <label for="password">Password</label>
                                <input type="password" id="password" name="psw" placeholder="Password" required>
                            </div>
                            <div class="login_button">
                                <button type="submit" class="btn btn-warning">Login</button>
                                <a href="#">Forgot Password?</a>
                            </div>
                            <hr>
                            <div class="no_account">
                                <p>Don't have an account?</p>
                                <a href="../signin/signin.jsp" class="btn btn-outline-warning">Sign Up</a>
                            </div>
                        </form>
                    </div>
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
