<%-- 
    Document   : otp_authentication
    Created on : Oct 26, 2024, 8:34:25 PM
    Author     : pc
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="Model.*,OTP.*,java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Xác thực OTP</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                padding: 20px;
            }
            .otp-form {
                max-width: 400px;
                margin: 0 auto;
                margin-bottom: 50px;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .otp-form h2 {
                color: #333;
            }
            .otp-form p {
                margin-bottom: 10px;
            }
            .otp-form input[type="text"] {
                width: calc(100% - 80px);
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
            }
            .otp-form .button-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 10px;
            }
            .otp-form button[type="submit"] {
                color:#000;
                background-color:#F97D5B;
                border-color:#F97D5B;

            }
            .otp-form button[type="submit"]:hover {
                background-color: #FECF8F;
            }
            .otp-form button[type="submit"]:focus {
                border: 1px solid #FECF8F;
            }
            .error-message {
                color: red;
            }
            .success-message {
                color: green;
            }
            a.disabled {
                pointer-events: none;
            }
        </style>
    </head>
    <body>
        <jsp:include page="includes/header.jsp"></jsp:include>
            <link rel="stylesheet" href="./css/headerssj4.css"/>
            <div class="otp-form" style="margin-top: 50px">
                <h2 class="text-primary">Xác nhận mã OTP</h2>
            <% 
                String verificationError = (String) session.getAttribute("verificationError");
                if (verificationError != null) {
                    out.println("<p class='error-message'>" + verificationError + "</p>");
                    session.removeAttribute("verificationError");
                }
            %>
            <form id="OTP" action="VerifyOtpServlet" method="post">
                Nhập OTP:
                <input type="text" name="otp" required>


                <div class="button-container">
                    <button class="btn btn-primary" type="submit">Xác minh OTP</button>
                    <div>
                        <button disabled="true" id="btnResend" class="btn btn-primary" style="width: 133px" onclick="timer()" type="submit" class="resend" formnovalidate>
                            05:00
                        </button>
                    </div>
                </div>
            </form>
        </div>
        <jsp:include page="includes/footer.jsp"></jsp:include>
        <script>
            window.onload = function(){
                fetch('SendOtp', {
                method: 'POST'
            });
            }
            
            var countDownTime = 5 * 60;
            var timerInterval = setInterval(updateTimer, 1000);
            updateTimer();

            function timer() {
                countDownTime = 5 * 60 - 1;
                timerInterval = setInterval(updateTimer, 1000);
                document.getElementById('btnResend').innerHTML = "05:00";
                document.getElementById('btnResend').disabled = true;
                
                var formData = new FormData(document.getElementById('OTP'));

            // Send AJAX request to servlet endpoint
                fetch('ResendOtpServlet', {
                method: 'POST',
                body: formData
            });
            }
            function updateTimer() {
                var minutes = Math.floor(countDownTime / 60);
                var seconds = countDownTime % 60;

                document.getElementById('btnResend').innerHTML = ('0' + minutes).slice(-2) + ':' + ('0' + seconds).slice(-2);

                countDownTime--;

                if (countDownTime < 0) {
                    clearInterval(timerInterval); // Stop the countdown
                    document.getElementById('btnResend').disabled = false;
                    document.getElementById('btnResend').innerHTML = "Gửi lại";
                }
            }
        </script>
        <link rel="stylesheet" href="./css/footerssj2.css"/>
    </body>
</html>