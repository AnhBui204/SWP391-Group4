<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String user = (String) session.getAttribute("user");
    String userID = (String) session.getAttribute("id");
    if (user == null) { %>
<%@include file="includes/header.jsp" %>
<% } else { %>
<%@include file="includes/header_user.jsp" %>
<% }%>
<link rel="stylesheet" href="css/headerssj3.css">
<!DOCTYPE html>
<html lang="vi">
    <head>  
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đặt Vé Xem Phim</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
        <link rel="stylesheet" href="./css/Booking.css"/>
        <link rel="stylesheet" href="./css/Seat.css"/>
    </head>
    <body>
        <div class="container mt-4">
            <div class="progress-bar bg-white">
                <ul>
                    <li class="active">Chọn phim / Rạp / Suất</li>
                    <li class="active">Chọn ghế</li>
                    <li>Chọn thức ăn</li>
                </ul>
            </div>

            <div class="row d-flex">
                <div class="col-lg-8">
                    <div class="card mb-3">
                        <div class="card-body p-4">
                            <h5 class="card-title">Chọn ghế</h5>
                            <div class="row d-flex">
                                <div class="col-md-10">
                                    <c:if test="${not empty rowLabels}">
                                        <div class="seats-container">
                                            <c:forEach var="rowLabel" items="${rowLabels}">
                                                <div class="seat-row d-flex align-items-center mb-2">
                                                    <!-- Hiển thị nhãn của dãy ghế -->
                                                    <span class="row-label mr-3 font-weight-bold">${rowLabel}</span>

                                                    <!-- Khởi tạo div chứa ghế -->
                                                    <div class="seat-row-seats d-flex">
                                                        <c:set var="seatCount" value="0" /> <!-- Biến đếm ghế trong hàng -->

                                                        <c:forEach var="seat" items="${availableSeats}">
                                                            <c:if test="${seat.seatName.startsWith(rowLabel)}">
                                                                <c:set var="seatName" value="${seat.seatName}" />
                                                                <c:set var="isAvailable" value="${seat.isAvailables}" />
                                                                <c:set var="price" value="${seat.price}" />

                                                                <button class="seat-button ${isAvailable == 1 ? 'available' : 'unavailable'}"
                                                                        ${isAvailable == 0 ? 'disabled' : ''} 
                                                                        onclick="selectSeat(this, '${price}')">
                                                                    ${seatName}
                                                                </button>

                                                                <c:set var="seatCount" value="${seatCount + 1}" /> <!-- Tăng biến đếm ghế -->

                                                                <c:if test="${seatCount % 10 == 0 && seatCount != 0}">
                                                                </div> <!-- Kết thúc hàng ghế hiện tại -->
                                                                <div class="seat-row-seats d-flex"> <!-- Bắt đầu hàng ghế mới -->
                                                                </c:if>
                                                            </c:if>
                                                        </c:forEach>
                                                    </div> <!-- Kết thúc hàng ghế -->
                                                </div>
                                            </c:forEach>


                                        </div>
                                    </c:if>
                                    <c:if test="${empty availableSeats}">
                                        <p>Không có ghế nào có sẵn.</p>
                                    </c:if>

                                    <div class="col-md-10 mx-auto mt-4">
                                        <div class="row mt-3 justify-content-center">
                                            <div class="screen mx-auto" style="width: 80%; height: 20px; background-color: #333;"></div> 
                                            <div class="screen-text text-center w-100">MÀN HÌNH</div> 
                                        </div>
                                    </div>

                                    <!-- Labels for available and unavailable seats -->
                                    



                                </div>
                                <div class="row mt-3 d-flex justify-content-start">
                                        <div class="col-md-4 text-center">
                                            <div class="rectangle available"></div>
                                            <span class="custom-available fs-6">Có sẵn</span>
                                        </div>
                                        <div class="col-md-4 text-center">
                                            <div class="rectangle unavailable"></div>
                                            <span class="custom-unavailable fs-6">Không có sẵn</span>
                                        </div>
                                        <div class="col-md-4 text-center">
                                            <div class="rectangle selected"></div>
                                            <span class="custom-selected fs-6">Đang chọn</span>
                                        </div>
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card mb-3">
                        <div class="text-center">
                            <h5 id="info-theatre">Rạp: ${sessionScope.theatreName}</h5>
                            <img src="${sessionScope.movieImg}" alt="Poster phim" class="img-fluid my-3" style="max-height: 150px;">
                            <h5 id="info-movie">${sessionScope.movieName}</h5>
                            <h5 id="info-date"> Ngày: ${sessionScope.selectedDate}</h5>
                            <h5 id="info-time">Suất: ${sessionScope.selectedTime}</h5>
                            <h5>Ghế đã chọn: <span id="selected-seats">Chưa chọn ghế</span></h5>
                            <h5>Tổng giá: <span id="selected-price">0 VNĐ</span></h5>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between">
                        <button class="btn btn-light" onclick="window.history.back()">Quay lại</button>
                        <button class="btn btn-warning" onclick="submitSelectedSeats()">Tiếp tục</button>
                    </div>
                </div>
            </div>  
        </div>

        <!-- Modal for alert -->
        <div class="modal fade" id="alertModal" tabindex="-1" aria-labelledby="alertModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="alertModalLabel">Thông báo</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn chỉ có thể chọn tối đa 8 ghế.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="closeModal()">Đóng</button>
                    </div>
                </div>
            </div>
        </div>


        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <script>
                            let selectedSeatNames = [];
                            let selectedSeatPrices = [];

                            window.selectSeat = function (button, price) {
                                const seatName = button.innerText; // Lấy tên ghế
                                const selectedSeats = document.getElementById('selected-seats');
                                const selectedPrice = document.getElementById('selected-price');
                                console.log("Selected seat price:", price); // Lấy phần tử giá
                                const maxSeats = 8;
                                const currentSelectedCount = document.querySelectorAll('.seat-button.selected').length;

                                if (button.classList.contains('selected')) {
                                    // Nếu ghế đã được chọn
                                    button.classList.remove('selected');
                                    // Xóa ghế khỏi danh sách đã chọn
                                    selectedSeatNames = selectedSeatNames.filter(name => name !== seatName);
                                    selectedSeatPrices = selectedSeatPrices.filter(p => p !== parseInt(price));
                                } else {
                                    // Nếu ghế chưa được chọn
                                    if (currentSelectedCount >= maxSeats) {
                                        // Nếu đã chọn đủ số ghế tối đa
                                        const alertModal = new bootstrap.Modal(document.getElementById('alertModal'));
                                        alertModal.show();
                                        return; // Không cho phép chọn thêm ghế
                                    }
                                    button.classList.add('selected');
                                    selectedSeatNames.push(seatName);
                                    selectedSeatPrices.push(parseInt(price));
                                }

                                const updatedSeats = getSelectedSeats();
                                selectedSeats.innerText = updatedSeats.length > 0 ? updatedSeats : 'Chưa chọn ghế';
                                const totalPrice = selectedSeatPrices.reduce((total, price) => total + price, 0);
                                selectedPrice.innerText = totalPrice + ' VNĐ'; // Cập nhật giá
                            };

                            window.getSelectedSeats = function () {
                                const selectedSeats = Array.from(document.querySelectorAll('.seat-button.selected'))
                                        .map(seat => seat.innerText);
                                return selectedSeats.join(', ');
                            };

                            window.submitSelectedSeats = function () {
                                const selectedSeats = getSelectedSeats();
                                const totalPrice = selectedSeatPrices.reduce((total, price) => total + price, 0);
                                const maxSeats = 8;
                                const currentSelectedCount = document.querySelectorAll('.seat-button.selected').length;

                                if (currentSelectedCount === 0) {
                                    // Nếu không chọn ghế nào
                                    const alertModal = new bootstrap.Modal(document.getElementById('alertModal'));
                                    alertModal.show();
                                    document.querySelector('.modal-body').innerText = "Bạn phải chọn ít nhất 1 ghế.";
                                    return;
                                }

                                if (currentSelectedCount > maxSeats) {
                                    // Nếu đã chọn quá số ghế tối đa
                                    const alertModal = new bootstrap.Modal(document.getElementById('alertModal'));
                                    alertModal.show();
                                    document.querySelector('.modal-body').innerText = "Bạn chỉ có thể chọn tối đa 8 ghế.";
                                    return;
                                }

                                const form = document.createElement('form');
                                form.method = 'POST';
                                form.action = 'FoodsAndDrinks';

                                const input = document.createElement('input');
                                input.type = 'hidden';
                                input.name = 'selectedSeats';
                                input.value = selectedSeats;

                                const inputTotalPrice = document.createElement('input');
                                inputTotalPrice.type = 'hidden';
                                inputTotalPrice.name = 'totalPrice';
                                inputTotalPrice.value = totalPrice;

                                const theatreIDInput = document.createElement('input');
                                theatreIDInput.type = 'hidden';
                                theatreIDInput.name = 'theatreID';
                                theatreIDInput.value = '${sessionScope.theatreID}';

                                form.appendChild(input);
                                form.appendChild(inputTotalPrice);
                                form.appendChild(theatreIDInput);
                                document.body.appendChild(form);
                                form.submit();
                            };
                            function closeModal() {
                                const alertModal = new bootstrap.Modal(document.getElementById('alertModal'));
                                alertModal.hide(); // Gọi hàm hide để đóng modal
                            }
                            ;

        </script>
    </body>
    <%@include file="includes/footer.jsp" %>
    <link rel="stylesheet" href="css/footerssj2.css" />
</html>
