<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login and Signup</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="css/body.css" rel="stylesheet">
        <style>
            /* Body Styling */
            body {
                background-color: #f8f9fa;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
                font-family: Arial, sans-serif;
            }

            /* Container for the form */
            .signlog {
                max-width: 600px;
                background-color: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin: 20px;
            }

            /* Logo Styling */
            .logo_signlog {
                text-align: center;
                margin-bottom: 20px;
            }

            .logo_signlog img {
                max-width: 80px;
                margin-bottom: 10px;
            }

            .logo_signlog p {
                font-size: 24px;
                font-weight: bold;
                color: #ff6f00;
            }

            /* Input Fields */
            .input_layer {
                margin-bottom: 20px;
            }

            .input_layer label {
                font-weight: bold;
                color: #555;
                margin-bottom: 5px;
                display: block;
            }

            .input_layer input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 5px;
                margin-bottom: 15px;
                font-size: 16px;
            }

            /* Buttons */
            .login_button {
                text-align: center;
                margin-bottom: 20px;
            }

            .login_button button {
                width: 100%;
                padding: 10px;
                font-size: 16px;
                background-color: #ff6f00;
                border: none;
                color: #fff;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .login_button button:hover {
                background-color: #e65c00;
            }

            /* Links and Divider */
            .login_button a {
                display: block;
                margin-top: 10px;
                color: #007bff;
                text-decoration: none;
            }

            .login_button a:hover {
                text-decoration: underline;
            }

            hr {
                border: none;
                border-top: 1px solid #ddd;
                margin: 20px 0;
            }

            /* Sign Up Section */
            .no_account {
                text-align: center;
            }

            .no_account p {
                margin-bottom: 10px;
                color: #555;
            }

            .no_account a {
                text-decoration: none;
                font-size: 16px;
                color: #ff6f00;
                border: 2px solid #ff6f00;
                padding: 10px 20px;
                border-radius: 5px;
                transition: all 0.3s;
            }

            .no_account a:hover {
                background-color: #ff6f00;
                color: #fff;
            }
        </style>
    </head>
    <body>
        <div class="signlog">
            <div id="box_signlog">
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
