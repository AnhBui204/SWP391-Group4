<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>CineLuxe Cinema</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
    <style>
        .nav-item.dropdown:hover .dropdown-menu {
            display: block;
            margin-top: 0; /* Remove default margin */
        }

        /* Optional: Adjust dropdown link colors on hover */
        .nav-item .dropdown-menu a:hover {
            background-color: #f7cf90; /* Custom background color */
            color: #333; /* Text color */
        }
    </style>
    <body>
        <!-- Overlay for the darkened background -->
        <div class="overlay hidden"></div>

        <header>
            <div class="header-container container-fluid d-flex justify-content-between align-items-center row px-3">
                <!-- Logo -->
                <div class="bigLogo d-flex flex-column align-items-center col-md-4 text-center">
                    <div class="logo">
                        <img src="image/logo/logo.png" alt="FPT Cinema" style="cursor: pointer;" onclick="window.location.href = 'HomePage.jsp';">
                    </div>
                    <h3 class="text mb-0">CineLuxe Cinema</h3>
                </div>

                <!-- Navbar -->
                <nav class="navbar col-md-6 d-flex justify-content-center">
                    <ul class="navbar-nav d-flex flex-row">
                        <li class="nav-item me-3">
                            <a class="nav-link p-0" href="MovieServlet?action=booking">
                                <div id="raffle-red" class="entry raffle">
                                    <div class="no-scale"></div>
                                </div>
                            </a>
                        </li>
                        <li class="nav-item dropdown me-3">
                            <a class="nav-link dropdown-toggle" href="#" id="phimDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Phim
                            </a>
                            <div class="dropdown-menu" aria-labelledby="phimDropdown">
                                <a class="dropdown-item" href="movie1.jsp">Phim 1</a>
                                <a class="dropdown-item" href="movie2.jsp">Phim 2</a>
                                <a class="dropdown-item" href="movie3.jsp">Phim 3</a>
                                <!-- Add more movies as needed -->
                            </div>
                        </li>

                        <!-- Ưu Đãi Dropdown -->
                        <li class="nav-item dropdown me-3">
                            <a class="nav-link dropdown-toggle" href="uudai_homepage.jsp" id="uudaiDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Ưu Đãi
                            </a>
                            <div class="dropdown-menu" aria-labelledby="uudaiDropdown">
                                <a class="dropdown-item" href="voucher1.jsp">Voucher 1</a>
                                <a class="dropdown-item" href="voucher2.jsp">Voucher 2</a>
                                <a class="dropdown-item" href="voucher3.jsp">Voucher 3</a>
                                <!-- Add more vouchers as needed -->
                            </div>
                        </li>
                        <li class="nav-item me-3">
                            <a class="nav-link" href="#">Rạp/Giá Vé</a>
                        </li>
                    </ul>
                </nav>

                <!-- User Info -->
                <div class="user-info col-md-2 d-flex justify-content-end">
                    <div class="signlog">
                        <a href="Login.jsp" class="btn btn-custom">Login</a>
                    </div>
                </div>
            </div>
        </header>


        <script>
            document.getElementById('activate_button').addEventListener('click', function () {
                var hiddenElement = document.getElementById('box_signlog');
                hiddenElement.classList.toggle('hidden');
            });
        </script>
    </body>

</html>