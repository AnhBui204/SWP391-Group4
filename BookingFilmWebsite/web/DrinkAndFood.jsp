<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đặt Vé Xem Phim</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="./css/Booking.css"/>
    <link rel="stylesheet" href="./css/FoodsAndDrinks.css"/>
</head>
<body>
    <div class="container mt-4">
        <div class="progress-bar bg-white">
            <ul>
                <li class="active">Chọn phim / Rạp / Suất</li>
                <li class="active">Chọn ghế</li>
                <li class="active">Chọn thức ăn</li>
               
            </ul>
        </div>
        <div class="row">
            <!-- Card hiển thị combo bên trái -->
            <div class="col-lg-8">
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Combo </h5>
                        <c:choose>
                            <c:when test="${not empty foodMenu}">
                                <ul class="list-group">
                                    <c:forEach var="foodItem" items="${foodMenu}">
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            <img src="${foodItem.imagePath}" alt="${foodItem.comboName}" style="width: 50px; height: 50px; margin-right: 10px;">
                                            ${foodItem.comboName} - Giá: ${foodItem.price}
                                            <button class="btn btn-primary btn-sm" onclick="selectFood('${foodItem.comboName}', '${foodItem.price}')">Chọn</button>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:when>
                            <c:otherwise>
                                <p>Chưa có món ăn nào được chọn.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Khu vực thông tin bên phải -->
            <div class="col-lg-4">
                <div class="card mb-3">
                    <div class="card-body text-center">
                        <h5 id="info-theatre">Rạp: ${sessionScope.theatreName}</h5>
                        <input type="hidden" name="theatreID" value="${sessionScope.theatreID}" />
                        <img src="${sessionScope.movieImg}" alt="Poster phim" class="img-fluid my-3" style="max-height: 150px;">
                        <h5 id="info-movie">${sessionScope.movieName}</h5>
                        <h5 id="info-date">Ngày: ${sessionScope.selectedDate}</h5>
                        <h5 id="info-time">Suất: ${sessionScope.selectedTime}</h5>
                        <h5 id="info-seat">Ghế đã chọn: ${sessionScope.selectedSeats}</h5>

                        <h5>Thời gian giữ ghế: <span id="seat-hold-timer">10:00</span></h5>

                        <h5>Món ăn đã chọn: <span id="selected-food">Chưa chọn món</span></h5>
                        <h5>Giá món ăn: <span id="selected-food-price">0</span></h5>
                    </div>
                </div>

                <!-- Nút điều hướng -->
                <div class="d-flex justify-content-between">
                    <button class="btn btn-light" onclick="window.history.back()">Quay lại</button>
                    <button class="btn btn-warning" onclick="continueBooking()">Tiếp tục</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Thư viện JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        // Hàm chọn món ăn
        function selectFood(foodName, foodPrice) {
            const selectedFood = document.getElementById('selected-food');
            const selectedFoodPrice = document.getElementById('selected-food-price');
            selectedFood.innerText = foodName;
            selectedFoodPrice.innerText = foodPrice;
        }

        // Hàm chuyển về trang chủ sau khi hết thời gian giữ ghế
        function redirectToHome() {
            window.location.href = 'HomePage.jsp'; // Đường dẫn tới trang chủ
        }

        // Hàm đếm ngược thời gian giữ ghế
        function startCountdown(duration) {
            var timer = duration, minutes, seconds;
            var countdownElement = document.getElementById('seat-hold-timer');

            var interval = setInterval(function () {
                minutes = parseInt(timer / 60, 10);
                seconds = parseInt(timer % 60, 10);

                minutes = minutes < 10 ? "0" + minutes : minutes;
                seconds = seconds < 10 ? "0" + seconds : seconds;

                countdownElement.textContent = minutes + ":" + seconds;

                if (--timer < 0) {
                    clearInterval(interval);
                    redirectToHome(); // Hết giờ thì chuyển về trang chủ
                }
            }, 1000);
        }

        window.onload = function () {
            var seatHoldTime = 600; 
            startCountdown(seatHoldTime);
        };

        // Hàm điều hướng tiếp tục
        function continueBooking() {
            window.location.href = 'nextPage.jsp'; 
        }
    </script>
</body>
</html>
