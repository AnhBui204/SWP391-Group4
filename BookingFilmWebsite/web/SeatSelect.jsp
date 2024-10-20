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
    <link rel="stylesheet" href="./css/Seats.css"/>
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
                                <c:forEach var="rowLabel" items="${rowLabels}">
                                    <div class="seat-row d-flex align-items-center">
                                        <div class="seat-label">${rowLabel}</div>

                                        <c:forEach var="seat" items="${availableSeats}">
                                            <c:if test="${seat.startsWith(rowLabel)}">
                                                <div class="seat-container">
                                                    <button class="seat-button" 
                                                            data-seat-id="${seat}" 
                                                            onclick="selectSeat(this)">
                                                        ${seat}
                                                    </button>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </c:forEach>
                                <div class="col-md-10 mx-auto mt-4">
                                    <div class="screen"></div>
                                    <div class="screen-text text-center">MÀN HÌNH</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card mb-3">
                    <div class="card-body text-center">
                        <h5 id="info-theatre">Rạp: ${sessionScope.theatreName}</h5>
                        <img src="${sessionScope.movieImg}" alt="Poster phim" class="img-fluid my-3" style="max-height: 150px;">
                        <h5 id="info-movie">${sessionScope.movieName}</h5>
                        <h5 id="info-date"> Ngày: ${sessionScope.selectedDate}</h5>
                        <h5 id="info-time">Suất: ${sessionScope.selectedTime}</h5>
                        <h5>Ghế đã chọn: <span id="selected-seats">Chưa chọn ghế</span></h5>
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
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>


    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    window.selectSeat = function(button) {
        const seatID = button.getAttribute('data-seat-id'); 
        const selectedSeats = document.getElementById('selected-seats');
        const maxSeats = 8;
        const currentSelectedCount = document.querySelectorAll('.seat-button.selected').length;

        if (button.classList.contains('selected')) {
            // Nếu ghế đã được chọn
            button.classList.remove('selected'); 
        } else {
            // Nếu ghế chưa được chọn
            if (currentSelectedCount >= maxSeats) {
                // Nếu đã chọn đủ số ghế tối đa
                const alertModal = new bootstrap.Modal(document.getElementById('alertModal'));
                alertModal.show();
                return; // Không cho phép chọn thêm ghế
            } 
            button.classList.add('selected');  
        }

        const updatedSeats = getSelectedSeats();
        selectedSeats.innerText = updatedSeats.length > 0 ? updatedSeats : 'Chưa chọn ghế';
    };

    window.getSelectedSeats = function() {
        const selectedSeats = Array.from(document.querySelectorAll('.seat-button.selected'))
                                   .map(seat => seat.getAttribute('data-seat-id'));
        return selectedSeats.join(', ');
    };

    window.submitSelectedSeats = function() {
        const selectedSeats = getSelectedSeats();
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
        
        const theatreIDInput = document.createElement('input');
        theatreIDInput.type = 'hidden';
        theatreIDInput.name = 'theatreID';
        theatreIDInput.value = '${sessionScope.theatreID}';
        
        form.appendChild(input);
        form.appendChild(theatreIDInput);
        document.body.appendChild(form);
        form.submit();
    };
</script>


</body>
</html>