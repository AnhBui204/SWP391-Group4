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
            String bookingID = request.getParameter("bookingID");
            List<ShowInfo1> tickets = TicketDB.getShowInfoByUserIDAndBookingID(userID, bookingID);
            request.setAttribute("tickets", tickets);
        %>

        <c:if test="${not empty tickets}">
            <table class="table table-striped">
                <thead class="text-center" style="background-color: #f7cf90">
                    <tr>
                        <th>Rạp</th>
                        <th>Phim</th>
                        <th>Ghế</th>
                        <th>Ngày Chiếu</th>
                        <th>Giờ Chiếu</th>
                        <th>Phòng</th>
                        <th>Giá (VND)</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
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
                            <td>${ticket.status}</td>
                           <td>
    <c:if test="${ticket.status != 'Đang chờ' && ticket.status != 'Chấp thuận' && ticket.status != 'Từ chối'}">
        <a href="#refundTicketModal" 
           class="btn btn-danger btn-sm" 
           data-toggle="modal" 
           data-ticketid="${ticket.ticketID}">
           Hủy Vé
        </a>
    </c:if>
</td>

                        </tr>
                    </c:forEach> <!-- Đảm bảo đóng thẻ forEach ở đây -->
                </tbody>
            </table>
        </c:if>

        <c:if test="${empty tickets}">
            <p class="text-center">Chưa có vé nào được đặt.</p>
        </c:if>

        <div class="text-center">
            <a href="summaryBooking.jsp" class="btn btn-primary">Quay lại</a>
        </div>
    </div>

    <!-- Refund Modal HTML -->
    <div id="refundTicketModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="TicketServlet" method="post">
                    <input type="hidden" name="action" value="requestRefund"> 
                    <input type="hidden" name="ticketID" value="">
                    <div class="modal-header">
                        <h4 class="modal-title">Hủy Vé</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p>Bạn có chắc chắn muốn hủy vé này không?</p>
                        <p>(Nếu hủy vé, tiền sẽ được hoàn lại vào ví)</p>
                        <p class="text-warning"><small>Hành động này không thể hoàn tác sau khi thực hiện.</small></p>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                        <input type="submit" class="btn btn-primary" value="Hủy Vé">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <script>
        $('#refundTicketModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Nút đã kích hoạt modal
            
            // Lấy thông tin từ data-* attributes
            var ticketID = button.data('ticketid'); // Lấy ticketID từ data-* attribute

            // Gán ticketID vào input hidden trong modal
            var modal = $(this);
            modal.find('input[name="ticketID"]').val(ticketID);
        });
    </script>

</body>
</html>
