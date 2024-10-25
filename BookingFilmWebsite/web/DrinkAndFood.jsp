
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
        ${foodItem.comboName} - Giá: ${foodItem.price} VND
        <div class="btn-group" role="group">
            <!-- Sử dụng data attributes để truyền dữ liệu -->
            <button class="btn btn-danger btn-sm" onclick="updateQuantity(this, '${foodItem.price}', -1,'${foodItem.comboName}')">-</button>
            <span id="quantity-${foodItem.comboName}" class="mx-2">0</span>
            <button class="btn btn-primary btn-sm" onclick="updateQuantity(this, '${foodItem.price}', 1, '${foodItem.comboName}')">+</button>
        </div>
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

                        <h5>Món ăn đã chọn: <span id="selected-food-name">Chưa chọn món</span></h5>
                        <h5>Tổng tiền: <span id="selected-food-price">${sessionScope.totalPrice}</span></h5>
                    </div>
                </div>
<form id="bookingForm" action="Payment.jsp" method="post">
    <input type="hidden" name="theatreID" value="${sessionScope.theatreID}" />
    <input type="hidden" name="movieName" value="${sessionScope.movieName}" />
    <input type="hidden" name="selectedDate" value="${sessionScope.selectedDate}" />
    <input type="hidden" name="selectedTime" value="${sessionScope.selectedTime}" />
    <input type="hidden" name="selectedSeats" value="${sessionScope.selectedSeats}" />
    <input type="hidden" name="selectedFood" id="selected-food-input" value="" />
    <input type="hidden" name="totalPrice" id="total-price-input" value="${sessionScope.totalPrice}" />
  
</form>

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
    let totalPrice = parseInt('${sessionScope.totalPrice}') || 0;
let selectedFoods = []; 
function updateQuantity(button, foodPrice, change, foodName) {
    const quantityElement = button.parentNode.querySelector('span');
    let quantity = parseInt(quantityElement.innerText) || 0;
      if (change > 0 && quantity >= 10) {
        return; // Không cho phép tăng thêm nếu đã đạt giới hạn 10
    }
    if (change < 0 && quantity === 0) {
        return; // Không cho phép giảm xuống âm
    }

    quantity += change;
    if (quantity < 0) {
        quantity = 0; 
    }
    quantityElement.innerText = quantity;

    const foodPriceNum = parseInt(foodPrice) || 0;
    totalPrice += change * foodPriceNum;

    // Cập nhật tổng tiền
    document.getElementById('selected-food-price').innerText = totalPrice + " VND";

    // Cập nhật số lượng món ăn trong mảng
    if (quantity > 0) {
        const existingFood = selectedFoods.find(food => food.name === foodName);
        if (existingFood) {
            existingFood.quantity = quantity; // Cập nhật số lượng nếu món ăn đã có trong mảng
        } else {
            selectedFoods.push({ name: foodName, quantity: quantity }); 


        }
    } else {
        // Nếu số lượng là 0 và món ăn đã tồn tại, xóa món ăn khỏi mảng
        selectedFoods = selectedFoods.filter(item => item.name !== foodName);
    }
 console.log(selectedFoods);
    displaySelectedFoods(); // Cập nhật hiển thị danh sách món ăn đã chọn
}

function displaySelectedFoods() {
    const selectedFoodList = document.getElementById('selected-food-name');

    // Check the contents of selectedFoods
    console.log('Selected Foods:', selectedFoods); // Log to check

    // Clear the previous content
    selectedFoodList.innerHTML = '';

    // If no foods are selected, display a message
    if (selectedFoods.length === 0) {
        selectedFoodList.innerText = 'Chưa chọn món'; // If no foods selected
        return;
    }

    // Loop through each food item and create a separate entry for each
    selectedFoods.forEach(food => {
        console.log('Current food object:', food);
        const listItem = document.createElement('li');  // Create a list item
        listItem.innerText = food.name + ' (' + food.quantity + ')';  // Concatenate name and quantity
        selectedFoodList.appendChild(listItem);  // Append the list item to the UL
    });
}



function selectFood(foodName, foodPrice) {
    const selectedFood = document.getElementById('selected-food-name');
    const selectedFoodPrice = document.getElementById('selected-food-price');
    selectedFood.innerText = foodName;
    selectedFoodPrice.innerText = foodPrice;
}

function redirectToHome() {
    window.location.href = 'HomePage.jsp'; // Đường dẫn tới trang chủ
}

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

function continueBooking() {
    // Prepare to send selected food items
    const foodData = selectedFoods.map(food => {
        return food.name  + '('+food.quantity+')'; // Format as "comboName:quantity"
    }).join(', '); // Join by comma

    // Update hidden inputs for form submission
    document.getElementById('selected-food-input').value = foodData; // Update food names and quantities
    document.getElementById('total-price-input').value = totalPrice; // Update total price

    // Submit the form
    document.getElementById('bookingForm').submit();
}

    </script>
</body>
</html>
