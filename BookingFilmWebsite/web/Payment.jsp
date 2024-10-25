<%@page import="org.json.JSONObject"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Thanh Toán - Đặt Vé Xem Phim</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="./css/Payment.css"/>
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Thông Tin Thanh Toán</h2>
        <div class="row">
            <!-- Cột bên trái: Lựa chọn phương thức thanh toán -->
            <div class="col-lg-4">
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Phương Thức Thanh Toán</h5>
                        <form id="paymentForm">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="onlineWallet" value="onlineWallet" checked>
                                <label class="form-check-label" for="onlineWallet">
                                    Ví Online
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="banking" value="banking">
                                <label class="form-check-label" for="banking">
                                    Ngân Hàng
                                </label>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- Cột bên phải: Thông tin đặt vé -->
            <div class="col-lg-8">
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Thông Tin Phim</h5>
                        <p><strong>Phim:</strong> ${sessionScope.movieName}</p>
                        <p><strong>Rạp:</strong> ${sessionScope.theatreName}</p>
                        <p><strong>Ngày:</strong> ${sessionScope.selectedDate}</p>
                        <p><strong>Suất:</strong> ${sessionScope.selectedTime}</p>
                        <p><strong>Ghế đã chọn:</strong> ${sessionScope.selectedSeats}</p>
                    </div>
                </div>
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Món Ăn Đã Chọn</h5>
                        <c:choose>
                            <c:when test="${not empty param.selectedFood}">
                                <ul class="list-group" id="food-list">
                                  <c:forEach var="foodItem" items="${fn:split(param.selectedFood, ',')}">
    <li class="list-group-item" data-name="${foodItem}" data-quantity="${fn:substringAfter(foodItem, '(')}">
        ${foodItem}                                           
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
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Tổng Tiền</h5>
                        <p><strong>Tổng tiền: </strong> <span id="total-price">${param.totalPrice} VND</span></p>
                    </div>
                </div>
                <!-- Nút điều hướng -->
                <div class="d-flex justify-content-between">
                    <button class="btn btn-light" onclick="window.history.back()">Quay lại</button>
                    <button class="btn btn-success" onclick="confirmPayment()">Xác Nhận Thanh Toán</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal xác nhận thanh toán -->
    <div class="modal fade" id="confirmPaymentModal" tabindex="-1" role="dialog" aria-labelledby="confirmPaymentLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmPaymentLabel">Xác Nhận Thanh Toán</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn thanh toán không?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary" onclick="submitPayment()">Xác Nhận</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal thông báo thành công -->
    <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="successModalLabel">Thanh Toán Thành Công</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Thanh toán của bạn đã được xử lý thành công! Cảm ơn bạn đã đặt vé xem phim.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                    <button type="button" class="btn btn-primary" onclick="redirectHome()">Quay lại trang chủ</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Thư viện JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        function confirmPayment() {
    // Hiển thị modal xác nhận
    $('#confirmPaymentModal').modal('show');
}
function submitPayment() {
    const paymentForm = document.createElement("form");
    paymentForm.method = "POST";
    paymentForm.action = "PaymentServlet"; 
    const foodItems = document.querySelectorAll('#food-list li');
    const selectedFoodData = [];
    foodItems.forEach(item => {
      const foodName =item.getAttribute('data-name').replace(/\s*\(\d+\)\s*/, ''); // Remove " (number)" including surrounding spaces
        const foodQuantity = item.getAttribute('data-quantity').replace(')', '').trim(); // Extract quantity without ')'
        // Add food item to the selectedFoodData array
        selectedFoodData.push({ name: foodName, quantity: foodQuantity });
    });
    // Convert selected food data to JSON string
    const selectedFoodString = JSON.stringify(selectedFoodData);
    // Create a hidden input to hold the selected food data
    const selectedFoodInput = document.createElement("input");
    selectedFoodInput.type = "hidden";
    selectedFoodInput.name = "selectedFood"; // Input name to access in servlet
    selectedFoodInput.value = selectedFoodString; // JSON string
    paymentForm.appendChild(selectedFoodInput);
    // Append other necessary inputs (theatreID, totalPrice, etc.)
    const infoList = [
        { name: "theatreID", value: "${sessionScope.theatreID}" },
        { name: "movieName", value: "${sessionScope.movieName}" },
        { name: "selectedDate", value: "${sessionScope.selectedDate}" },
        { name: "selectedTime", value: "${sessionScope.selectedTime}" },
        { name: "selectedSeats", value: "${sessionScope.selectedSeats}" },
        { name: "totalPrice", value: "${param.totalPrice}" },
        { name: "paymentMethod", value: document.querySelector('input[name="paymentMethod"]:checked').value }
    ];
    
    // Create and append input fields for each piece of info
    infoList.forEach(info => {
        const input = document.createElement("input");
        input.type = "hidden";
        input.name = info.name; // Input name
        input.value = info.value; // Corresponding value
        paymentForm.appendChild(input);
    });
    document.body.appendChild(paymentForm); // Append the form to the body
    // Submit the payment form
    paymentForm.submit();
}
        function redirectHome() {
            window.location.href = "HomePage.jsp"; // Redirect to your home page or any other page
        }
    </script>
</body>
</html>