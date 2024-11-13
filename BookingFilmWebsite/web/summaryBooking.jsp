<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="Model.User"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="Model.UserDB"%>
<%@page import="Model.BookingInfo"%>
<%@page import="Model.TicketDB"%>
<%@page import="Model.BookingDB"%>
<%@page import="Model.Booking"%>
<%@page import="java.util.List"%>
<%
    String user = (String) session.getAttribute("user");
    String userID = (String) session.getAttribute("id");
    User users = UserDB.getUsersByID(userID);
    BigDecimal moneyLeft = UserDB.getCurrentBalance(userID);
    int moneyLeftInt = (moneyLeft != null) ? moneyLeft.intValue() : 0;
    List<BookingInfo> booking = BookingDB.getBookingDetailsByUserID(userID);
    Set<String> uniqueBookingIDs = new HashSet<>();
    List<BookingInfo> uniqueBookingList = new ArrayList<>();

    for (BookingInfo book : booking) {
        if (uniqueBookingIDs.add(book.getBookingID())) {
            uniqueBookingList.add(book);
        }
    }
    request.setAttribute("booking", uniqueBookingList);
    if (user == null) { %>
<%@include file="includes/header.jsp" %>
<% } else { %>
<%@include file="includes/header_user.jsp" %>
<% }%>
<!DOCTYPE html>
<html>
    <head>

        <link rel="stylesheet" href="css/headerssj4.css" />
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css"/>
        <link rel="stylesheet" href="css/CustomerProfile_css.css">
    </head>
    <body>
        <div class="container my-5">
            <c:if test="${not empty user}">
                <div class="row">
                    <div class="col-md-4 col-12 d-flex flex-column justify-content-center shadow-lg rounded" style="background-color: rgb(255, 247, 229);">
                        <div class="d-flex justify-content-center pt-5 pb-2">
                            <img src="<%= users.getAvatar()%>" alt="Profile Image" class="img-fluid rounded-circle" style="height: 100px; width: 100px;"/>
                            <div class="d-flex flex-column align-items-center justify-content-center mt-3 px-3">
                                <% if (moneyLeft != null) {%>
                                <p class="m-0 px-2 fs-6 text-success">Số tiền: <strong><%= moneyLeftInt%> VNĐ</strong></p>
                                <% } else { %>
                                <p class="m-0 px-2 fs-6 text-success">Số tiền: <strong> 0 VNĐ</strong></p>
                                <% }%>
                                <a href="charge.jsp?userID= <%= userID%>" class="btn btn-success" >
                                    Nạp tiền
                                </a>
                            </div>

                        </div>
                        <hr class="w-75 mx-auto">
                        <div class="text-center mt-3 d-flex flex-column">
                            <a class="h3 mt-4 p-3 d-block text-decoration-none" href="UserServlet?action=db">Chỉnh sửa hồ sơ</a>
                            <a class="h3 mt-4 p-3 d-block bg-white text-decoration-none rounded" href="summaryBooking.jsp">Lịch sử giao dịch</a>
                            <a class="h3 mt-4 p-3 d-block text-decoration-none" href="report.jsp?userID=<%= users.getUserID()%>">Báo cáo</a>
                        </div>
                    </div>
                    <div class="col-1"></div>
                    <div class="col-7">
                        <!-- Outer container for max height and scrollable body -->
                        <div class="table-responsive" style="max-height: 550px; overflow-y: auto;">
                            <table class="table table-striped table-bordered table-hover">
                                <!-- Table Header (Fixed) -->
                                <thead class="text-center pt-2" style="background-color: #f7cf90; position: sticky; top: 0; z-index: 1">
                                    <tr>
                                        <th scope="col">Mã đơn hàng</th>
                                        <th scope="col">Ngày đặt</th>
                                        <th scope="col">Tổng giá</th>
                                        <th scope="col">Trạng thái</th>
                                        <th scope="col">Hành động</th>
                                    </tr>
                                </thead>

                                <!-- Scrollable Table Body -->

                                <tbody class="text-center">
                                    <c:if test="${empty booking}">
                                        <tr>
                                            <td colspan="4">No bookings found for this user.</td>
                                        </tr>
                                    </c:if>
                                    <c:forEach var="book" items="${booking}">
                                        <tr>
                                            <td>${book.bookingID}</td>
                                            <td>${book.bookingDate}</td>
                                            <td>${book.totalPrice}</td>
                                            <td>${book.status}</td>
                                            <td>
                                                <a href="HistoryBooking.jsp?bookingID=${book.bookingID}" class="btn btn-primary btn-sm">Xem chi tiết</a>
                                                <c:if test="${book.status == 'Đã đặt'}">
                                                    <a href="#refundBookingModal" class="btn btn-danger btn-sm" data-toggle="modal" data-bookingid="${book.bookingID}">
                                                        Hủy Vé
                                                    </a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>


                                </tbody>
                            </table>
                        </div>
                    </div>



                </div>
            </div>
        </c:if>
        <c:if test="${empty user}">
            <p>No user information available.</p>
        </c:if>
    </div>

    <div id="refundBookingModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="TicketServlet" method="post">
                    <input type="hidden" name="action" value="requestRefund"> 
                    <input type="hidden" name="bookingID" value="">

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
</body>
<script src="bs/js/bootstrap.bundle.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $('#refundBookingModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var bookingID = button.data('bookingid');
        var modal = $(this);
        modal.find('input[name="bookingID"]').val(bookingID);

    });

</script>

</html>
<%@include file="includes/footer.jsp" %>
<link rel="stylesheet" href="css/footerssj2.css" /> 