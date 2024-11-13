<%@ page contentType="text/html; charset=UTF-8" %>


<!DOCTYPE html>
<html>
<head>
    <title>Quên mật khẩu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="bs/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/ForgetPassword_css.css"/>
    <link rel="stylesheet" href="css/headerssj4.css"/>
    <style>
        /* Modal OTP Styles */
        #OTP {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        #box {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 500px;
            text-align: center;
        }

        .form-control {
            width: 50px;
            height: 50px;
            font-size: 1.5rem;
            text-align: center;
            margin: 0 5px;
        }
    </style>
</head>
<body>
    <% String user = (String) session.getAttribute("user");
    if (user == null) { %>
        <%@include file="includes/header.jsp" %>
    <% } else { %>
        <%@include file="includes/header_user.jsp" %>
    <% } %>

    <div class="container row m-auto mt-5 mb-5 justify-content-center bg-light h-50">
        <div class="col-12 mt-5">
            <h1 class="display-4 text-center fw-semibold">Quên mật khẩu</h1>
        </div>
        <!-- Form gửi email tới ForgetPasswordServlet -->
        <form action="ForgetPasswordServlet" method="POST" class="row col-md-7 mt-4">
            <div class="input-group">
                <span class="input-group-text justify-content-center" id="basic-addon1">
                    <i class="fa-solid fa-envelope"></i>
                </span>
                <input type="email" name="email" placeholder="Nhập địa chỉ email" class="form-control fs-3 h-100" required>
            </div>
            <div class="col-md-7 mt-4 text-warning">
                <i class="fa-solid fa-triangle-exclamation d-inline mx-3"></i>
                <p class="d-inline">Email không được đăng ký sẽ không được gửi mã OTP</p>
            </div>

            <hr class="col-md-6 mt-3 mb-0">

            <div class="col-6 justify-content-center d-flex my-5">
                <input type="submit" value="Gửi" class="btn btn-warning text-white fs-3 py-1 px-5" id="butt">
            </div>
        </form>
    </div>

    <!-- OTP Modal -->
    <div id="OTP" class="d-flex">
        <div id="box">
            <div id="box_icon" class="text-center mb-3">
                <i class="fa-solid fa-envelope fa-4x text-warning"></i>
            </div>
            <p class="text-center fs-4">Nhập mã OTP được gửi về email</p>
            <div class="d-flex justify-content-center">
                <input type="text" maxlength="1" required class="form-control" autofocus="">
                <input type="text" maxlength="1" required class="form-control">
                <input type="text" maxlength="1" required class="form-control">
                <input type="text" maxlength="1" required class="form-control">
            </div>
            <div class="text-center mt-4">
                <p class="d-inline mx-2 fs-6">Gửi lại mã mới sau <span id="timer">60</span> giây</p>
                <a href="#" id="resendLink" class="d-inline mx-2 fs-6 text-primary" style="cursor: pointer;">Gửi lại</a>
            </div>
            <button type="button" class="btn btn-secondary mt-3" onclick="closeModal()">Đóng</button>
        </div>
    </div>

    <script>
        // Show OTP Modal
        document.getElementById('butt').addEventListener('click', function (e) {
            e.preventDefault(); // Prevent form submit to show OTP modal for demonstration
            document.getElementById('OTP').style.display = 'flex';
            startTimer();
        });

        // Close OTP Modal
        function closeModal() {
            document.getElementById('OTP').style.display = 'none';
            resetTimer();
        }

        // Timer for resend OTP
        let timerInterval;
        function startTimer() {
            let timeLeft = 60;
            timerInterval = setInterval(function () {
                if (timeLeft <= 0) {
                    clearInterval(timerInterval);
                    document.getElementById('resendLink').style.display = 'inline';
                    document.getElementById('timer').textContent = "0";
                } else {
                    document.getElementById('timer').textContent = timeLeft;
                    timeLeft -= 1;
                }
            }, 1000);
            document.getElementById('resendLink').style.display = 'none';
        }

        function resetTimer() {
            clearInterval(timerInterval);
            document.getElementById('timer').textContent = "60";
            document.getElementById('resendLink').style.display = 'none';
        }

        // Resend OTP Handler
        document.getElementById('resendLink').addEventListener('click', function () {
            resetTimer();
            startTimer();
            alert('OTP mới đã được gửi lại!');
        });
    </script>

    <script src="bs/js/bootstrap.bundle.js"></script>
</body>
</html>
<%@include file="includes/footer.jsp" %>
<link rel="stylesheet" href="css/footerssj2.css" />
