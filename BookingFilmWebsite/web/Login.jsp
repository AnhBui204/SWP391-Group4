<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login and Signup</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="" rel="stylesheet">
        <script src="https://apis.google.com/js/platform.js" async defer></script>
    </head>
    <body>
        <section class="h-100 gradient-form" style="background-color: #eee;">
            <div class="container py-1 h-70">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-xl-10">
                        <div class="card rounded-3 text-black">
                            <div class="row g-0">
                                <div class="col-lg-6">
                                    <div class="card-body p-md-5 mx-md-4">
                                        <div class="text-center">
                                            <img src="image/logo/logo.png" alt="Logo" style="width: 185px;">
                                            <h4 class="mt-1 mb-5 pb-1">Login</h4>
                                        </div>

                                        <form action="UserServlet" method="post">
                                            <p>Please login to your account</p>

                                            <div class="form-outline mb-4">
                                                <input type="text" id="uname" name="uname" class="form-control" placeholder="Username" required>
                                                <label class="form-label" for="uname">Username</label>
                                            </div>

                                            <div class="form-outline mb-4">
                                                <input type="password" id="password" name="psw" class="form-control" placeholder="Password" required>
                                                <label class="form-label" for="password">Password</label>
                                            </div>

                                            <div class="text-center pt-1 mb-5 pb-1">
                                                <button type="submit" class="btn btn-warning">Login</button>
                                                <br>
                                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/BookingFilmWebsite/Login.jsp&response_type=code
                                                   &client_id=375465691355-c20ocp2cb0lnhhept5ssqsrgjukm3ceq.apps.googleusercontent.com&approval_prompt=force">Login With Google</a> 
                                                <br>
                                                <a href="ForgetPassword.jsp">Forgot Password?</a>
                                            </div>

                                            <div class="text-center mb-4">
                                                <div class="g-signin2" data-onsuccess="onSignIn"></div>
                                            </div>

                                            <hr>

                                            <div class="d-flex align-items-center justify-content-center pb-4">
                                                <p class="mb-0 me-2">Don't have an account?</p>
                                                <a href="../signin/signin.jsp" class="btn btn-outline-warning">Sign Up</a>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div class="col-lg-6 d-flex align-items-center gradient-custom-2" style="background-color: grey; border-radius: 5px;">
                                    <div class="text-white px-3 py-4 p-md-5 mx-md-4" style="border-radius: 10px;">
                                        <h4 class="mb-4">Welcome to Cineluxe Cinema</h4>
                                        <p class="small mb-0">
                                            Chúng tôi rất vui được chào đón bạn đến với thế giới điện ảnh tuyệt vời của chúng tôi! 
                                            Tại đây, chúng tôi cung cấp cho bạn những bộ phim mới nhất, 
                                            các chương trình khuyến mãi hấp dẫn và trải nghiệm xem phim tuyệt vời.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script>
            function onSignIn(googleUser) {
                // Handle sign-in logic here.
                var profile = googleUser.getBasicProfile();
                console.log('ID: ' + profile.getId());
                console.log('Name: ' + profile.getName());
                console.log('Image URL: ' + profile.getImageUrl());
                console.log('Email: ' + profile.getEmail());
            }
        </script>
    </body>
</html>
