<%@page import="Model.ShowInfo1"%>
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
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Danh Sách Vé Đặt</h2>

        <%
            String userID = (String) session.getAttribute("id");
            List<ShowInfo1> tickets = TicketDB.getShowInfoByUserID(userID);
            request.setAttribute("tickets", tickets); // Đặt danh sách vé vào request scope
        %>

        <c:if test="${not empty tickets}">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Rạp</th>
                        <th>Ghế</th>
                        <th>Ngày Chiếu</th>
                        <th>Giờ Chiếu</th>
                        <th>Phòng</th>
                        <th>Giá (VND)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ticket" items="${tickets}">
                        <tr>
                            <td>${ticket.theatreName}</td>
                            <td>${ticket.seatName}</td>
                            <td>${ticket.showDate}</td>
                            <td>${ticket.startTime}</td>
                            <td>${ticket.roomName}</td>
                            <td>${ticket.price}</td>
                        </tr>
                    </c:forEach> <!-- Đảm bảo đóng thẻ forEach ở đây -->
                </tbody>
            </table>
        </c:if>

        <c:if test="${empty tickets}">
            <p class="text-center">Chưa có vé nào được đặt.</p>
        </c:if>

        <div class="text-center">
            <a href="HomePage.jsp" class="btn btn-primary">Quay lại</a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>