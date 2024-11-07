<%-- 
    Document   : summaryBooking
    Created on : Oct 24, 2024, 11:07:27 AM
    Author     : ADMIN
--%>

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
    request.setAttribute("booking", booking);
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
                                <p class="m-0 px-2 fs-6 text-success">Số tiền: <strong><%= moneyLeftInt%></strong></p>
                                <% } else { %>
                                <p class="m-0 px-2 fs-6 text-success">Số tiền: <strong> 0 VNĐ</strong></p>
                                <% }%>
                                <a href="charge.jsp?userID=$<%= users.getUserID()%>" class="btn btn-success" >
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
                        <div class="table-responsive" style="max-height: 350px; overflow-y: auto;">
                            <table class="table table-striped table-bordered table-hover">
                                <!-- Table Header (Fixed) -->
                                <thead class="text-center pt-2" style="background-color: #f7cf90; position: sticky; top: 0; z-index: 1">
                                    <tr>
                                        <th scope="col">Mã đơn hàng</th>
                                        <th scope="col">Ngày đặt</th>
                                        <th scope="col">Tổng giá</th>
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
                                            <td>
                                                <a href="HistoryBooking.jsp?bookingID=${book.bookingID}" class="btn btn-primary btn-sm">Xem chi tiết</a>
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


</body>
<script src="bs/js/bootstrap.bundle.js"></script>
</html>
<%@include file="includes/footer.jsp" %>
<link rel="stylesheet" href="css/footerssj2.css" />