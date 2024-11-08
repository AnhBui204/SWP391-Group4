<%@page import="Model.ShowInfo1"%>
<%@page import="Model.Combo"%>
<%@page import="java.util.List"%>
<%@page import="Model.TicketDB"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Thông Tin Vé</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
     <style>      
        .table-bordered th, .table-bordered td {
            border: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Danh Sách Vé Đặt</h2>

        <%
            String userID = (String) session.getAttribute("id");
            String bookingID = request.getParameter("bookingID");

            List<ShowInfo1> tickets = TicketDB.getShowInfoByUserIDAndBookingID(userID, bookingID);
            request.setAttribute("tickets", tickets);

            List<Combo> combos = TicketDB.getCombosByBookingID(bookingID);
            request.setAttribute("combos", combos);
        %>

        <!-- Hiển thị bảng vé -->
        <c:if test="${not empty tickets}">
            <table class="table table-striped table-bordered">
                <thead class="text-center" style="background-color: #f7cf90">
                    <tr>
                        <th>Rạp</th>
                        <th>Phim</th>
                        <th>Ghế</th>
                        <th>Ngày Chiếu</th>
                        <th>Giờ Chiếu</th>
                        <th>Phòng</th>
                        <th>Giá (VND)</th>
                                                       
                    </tr>
                </thead>
                <tbody class="text-center">
                    <c:forEach var="ticket" items="${tickets}">
                        <tr>
                            <td>${ticket.theatreName}</td>
                            <td>${ticket.movieName}</td>
                            <td>${ticket.seatName}</td>
                            <td>${ticket.showDate}</td>
                            <td>${ticket.startTime}</td>
                            <td>${ticket.roomName}</td>
                            <td>${ticket.price}</td>
                            
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${empty tickets}">
            <p class="text-center">Chưa có vé nào được đặt.</p>
        </c:if>

  
        <h2 class="text-center mt-5">Danh Sách Combo</h2>
<c:if test="${not empty combos}">
    <table  class="table table-striped table-bordered">
        <thead class="text-center" style="background-color: #f7cf90">
            <tr>
                <th>Combo</th>
                <th>Số Lượng</th>
                <th>Giá(VND)</th>
            </tr>
        </thead>
        <tbody class="text-center">
            <c:forEach var="combo" items="${combos}">
                <tr>
                    <td>${combo.comboName != null ? combo.comboName : 'N/A'}</td>
                    <td>${combo.quantity != null ? combo.quantity : 'N/A'}</td>
                    <td>${combo.comboPrice != 0 ? combo.comboPrice : 'N/A'}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>

     <c:if test="${empty combos}">
    <p class="text-center">Chưa có combo nào được chọn.</p>
</c:if>


        <div class="text-center">
            <a href="summaryBooking.jsp" class="btn btn-primary">Quay lại</a>
        </div>
    </div>

   

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
 
</body>
</html>