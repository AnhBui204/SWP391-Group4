<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login and Signup</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>

    <body>
        <script>
            function hideNotification() {
                const notification = document.getElementById("notification");
                if (notification) {
                    setTimeout(() => {
                        notification.style.display = 'none';
                    }, 2000);
                }
            }
            window.onload = hideNotification;
        </script>

        <section class="h-100 gradient-form" style="background-color: #f0f2f5;">
            <c:if test="${not empty sessionScope.successMessage}">
                <div id="notification" class="alert alert-success text-center">
                    ${sessionScope.successMessage}
                </div>
                <c:remove var="successMessage" scope="session" />
            </c:if>

            <c:if test="${not empty requestScope.errorMessage}">
                <div id="notification" class="alert alert-danger text-center">
                    ${requestScope.errorMessage}
                </div>
                <c:remove var="errorMessage" scope="request" />
            </c:if>

            <div class="container py-4">
                <div class="row d-flex justify-content-center align-items-center h-100 pb-5 mt-4">
                    <div class="col-lg-6">
                        <div class="card shadow-lg rounded-3 border-0 text-black">
                            <div class="card-body p-md-5">
                                <div class="text-center mb-4">
                                    <img src="image/logo/logo.png" alt="Logo" style="width: 160px;">
                                    <h4 class="mt-2">Login</h4>
                                </div>

                                <form action="UserServlet" method="post">
                                    <p class="text-center">Please login to your account</p>

                                    <div class="form-outline mb-3">
                                        <input type="text" id="uname" name="uname" class="form-control" placeholder="Username" required>
                                        <label class="form-label" for="uname">Username</label>
                                    </div>

                                    <div class="form-outline mb-3">
                                        <input type="password" id="password" name="psw" class="form-control" placeholder="Password" required>
                                        <label class="form-label" for="password">Password</label>
                                    </div>

                                    <div class="text-center pt-1 mb-4">
                                        <button type="submit" class="btn btn-warning w-100">Login</button>
                                        <br>
<!--                                        <a href="ForgetPassword.jsp" class="text-secondary mt-3 d-inline-block">Forgot Password?</a>-->
                                    </div>

                                    <hr>

                                    <div class="d-flex align-items-center justify-content-center">
                                        <p class="mb-0 me-2">Don't have an account?</p>
                                        <a href="SignUp.jsp" class="btn btn-outline-warning">Sign Up</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
