<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login and Signup</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="css/body.css" rel="stylesheet">
        <style>
            .hidden {
                display: none;
            }
            .signlog {
                max-width: 400px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .logo_signlog img {
                max-width: 100px;
                display: block;
                margin: 0 auto;
            }
            .input_layer input {
                width: 100%;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
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

        <script>
            document.getElementById('activate_button').addEventListener('click', function () {
                var hiddenElement = document.getElementById('box_signlog');
                hiddenElement.classList.toggle('hidden');
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="jvs.js"></script>
    </body>
</html>
