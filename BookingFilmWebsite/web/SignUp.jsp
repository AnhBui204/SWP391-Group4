<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.User" %>
<%@page import="Model.UserDB" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css"/>
        <style>
            .error-message {
                color: red;
                font-size: 14px;
                margin-top: 5px;
                display: none; /* Ẩn thông báo lỗi ban đầu */
            }
            .form-container {
                background-color: #fffaef;
                width: 40vw;
                min-height: 80vh; /* Sử dụng min-height để cho phép form mở rộng */
                margin: 10vh 0;
                padding: 20px; /* Thêm padding để có không gian cho nội dung mở rộng */
            }
        </style>
        <script>
            function validateForm() {
                const username = document.getElementById("username").value;
                const usernameError = document.getElementById("usernameError");
                const password = document.getElementById("password").value;
                const confirmPassword = document.getElementById("confirmPassword").value;
                const passwordError = document.getElementById("passwordError");
                const confirmPasswordError = document.getElementById("confirmPasswordError");
                const passwordPattern = /^(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$/;
                const email = document.getElementById("email").value;
                const emailError = document.getElementById("emailError");
                const phone = document.getElementById("phone").value;
                const phoneError = document.getElementById("phoneError");
                
                const existingUsernames = <%= UserDB.listAllUsers().stream().map(user -> "\"" + user.getUsername() + "\"").collect(Collectors.joining(",", "[", "]"))%>;
                const existingEmails = <%= UserDB.listAllUsers().stream().map(user -> "\"" + user.getEmail() + "\"").collect(Collectors.joining(",", "[", "]"))%>;
                const existingPhoneNumbers = <%= UserDB.listAllUsers().stream().map(user -> "\"" + user.getPhone() + "\"").collect(Collectors.joining(",", "[", "]"))%>;

                // Reset error messages
                usernameError.style.display = 'none';
                emailError.style.display = 'none';
                phoneError.style.display = 'none';

                // Validate username
                if (existingUsernames.includes(username)) {
                    usernameError.textContent = "Tên đăng nhập đã được sử dụng.";
                    usernameError.style.display = 'inline-block';
                    return false; // Ngăn form submit
                }
                

                // Reset error messages
                passwordError.style.display = 'none';
                confirmPasswordError.style.display = 'none';

                // Check if password is empty
                if (password.trim() === "") {
                    passwordError.textContent = "Mật khẩu không được để trống.";
                    passwordError.style.display = 'inline-block';
                    return false;
                }

                // Validate password format
                if (!passwordPattern.test(password)) {
                    passwordError.textContent = "Mật khẩu phải có ít nhất 8 kí tự và chứa ít nhất một kí tự đặc biệt.";
                    passwordError.style.display = 'inline-block';
                    return false;
                }

                // Validate password match
                if (password !== confirmPassword) {
                    confirmPasswordError.textContent = "Mật khẩu và xác nhận mật khẩu không khớp.";
                    confirmPasswordError.style.display = 'inline-block';
                    return false;
                }
                // Validate email
                if (existingEmails.includes(email)) {
                    emailError.textContent = "Email đã được sử dụng.";
                    emailError.style.display = 'inline-block';
                    return false; // Ngăn form submit
                }

                // Validate phone
                if (existingPhoneNumbers.includes(phone)) {
                    phoneError.textContent = "Số điện thoại đã được sử dụng.";
                    phoneError.style.display = 'inline-block';
                    return false; // Ngăn form submit
                }



                const dob = document.getElementById("dob").value;
                const dobError = document.getElementById("dobError");

                // Kiểm tra nếu ngày sinh không rỗng
                if (dob) {
                    const dobDate = new Date(dob);
                    const today = new Date();

                    // Tính toán số tuổi
                    let age = today.getFullYear() - dobDate.getFullYear();
                    const monthDiff = today.getMonth() - dobDate.getMonth();
                    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dobDate.getDate())) {
                        age--;
                    }

                    // Kiểm tra nếu tuổi dưới 18
                    if (age < 18) {
                        dobError.textContent = "Bạn phải đủ 18 tuổi để đăng ký.";
                        dobError.style.display = 'inline-block';
                        return false; // Ngăn form submit
                    } else {
                        dobError.style.display = 'none'; // Ẩn thông báo lỗi nếu hợp lệ
                    }
                }
                return true; // Form is valid, allow submission
            }
        </script>
    </head>
    <body style="overflow: hidden;">
        <div class="row" style="background-image: radial-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url(image/temp/Signin_Background_Image.jpg); width: 100vw; height: 100vh;">
            <div class="col-4">
                <img src="image/logo/logo.png" width="150px" height="150px" alt="alt"/>
            </div>
            <div class="row col-4 justify-content-center rounded form-container">
                <form action="UserServlet?action=signup" method="POST" onsubmit="return validateForm()">
                    <div class="row col-12 align-items-center">
                        <h1 class="text-center m-0">Đăng kí</h1>
                    </div>
                    <div class="col-12 row justify-content-center">
                        <div class="mt-0 col-12">
                            <p class="m-0">Tên người dùng <span class="text-danger">*</span></p>
                            <input type="text" id="username" name="username" required placeholder="Tên người dùng" class="w-100 fs-5"/>
                            <p id="usernameError" class="error-message">Tên đăng nhập đã được sử dụng.</p>
                        </div>
                        <div class="mt-0 col-12">
                            <p class="m-0">Mật khẩu <span class="text-danger">*</span></p>
                            <input type="password" id="password" name="password" placeholder="Mật khẩu" class="w-100 fs-5"/>
                            <p id="passwordError" class="error-message">Mật khẩu phải có ít nhất 8 kí tự và chứa ít nhất một kí tự đặc biệt.</p> 
                        </div>
                        <div class="mt-0 col-12">
                            <p class="m-0">Xác nhận mật khẩu <span class="text-danger">*</span></p>
                            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Xác nhận mật khẩu" class="w-100 fs-5"/>
                            <p id="confirmPasswordError" class="error-message">Mật khẩu và xác nhận mật khẩu không khớp.</p> 
                        </div>
                        <div class="mt-1 row justify-content-between p-0">
                            <div class="col-6">
                                <p class="m-0">Tên <span class="text-danger">*</span></p>
                                <input type="text" required name="firstName" placeholder="Tên" class="w-100 fs-5"/>
                            </div>
                            <div class="col-6">
                                <p class="m-0">Họ <span class="text-danger">*</span></p>
                                <input type="text" required name="lastName" placeholder="Họ" class="w-100 fs-5"/>
                            </div>
                        </div>
                        <div class="mt-1 col-12">
                            <p class="m-0">Email <span class="text-danger">*</span></p>
                            <input type="email" id="email" name="email" required placeholder="Email" class="w-100 fs-5"/>
                            <p id="emailError" class="error-message">Email đã được sử dụng.</p>
                        </div>
                        <div class="mt-1 row justify-content-between p-0">
                            <div class="col-6">
                                <p class="m-0">Số điện thoại <span class="text-danger">*</span></p>
                                <input type="tel" id="phone" name="phone" required placeholder="Số điện thoại" class="w-100 fs-5"/>
                                <p id="phoneError" class="error-message">Số điện thoại đã được sử dụng.</p>
                            </div>
                            <div class="col-6">
                                <p class="m-0">Giới tính</p>
                                <select name="gender" class="w-100 fs-5" style="padding: 1px 2px;">
                                    <option>Nam</option>
                                    <option>Nữ</option>
                                    <option>Khác</option>
                                </select>
                            </div>
                        </div>
                        <div class="mt-1 col-12">
                            <p class="m-0">Ngày sinh <span class="text-danger">*</span></p>
                            <input type="date" id="dob" name="dob" required class="w-100 fs-5"/>
                            <p id="dobError" class="error-message">Bạn phải đủ 18 tuổi để đăng ký.</p>
                        </div>
                    </div>
                    <div class="row mt-2 justify-content-center">
                        <button type="submit" class="btn btn-warning fs-5">Đăng kí</button>
                    </div>
                    <div class="row justify-content-center mt-2">
                        <p class="text-center">Bạn đã có tài khoản? <a href="login.jsp" class="text-decoration-none">Đăng nhập</a></p>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
