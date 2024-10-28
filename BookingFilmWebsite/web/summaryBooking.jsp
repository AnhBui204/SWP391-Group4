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
<link rel="stylesheet" href="css/headerssj3.css" />
<!DOCTYPE html>
<html>
    <head>

        <link rel="stylesheet" href="css/headerssj2.css" />
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
                    <h1 class="col-12 mb-4 display-5">Chỉnh sửa hồ sơ</h1>
                    <div class="col-md-4 col-12 d-flex flex-column justify-content-center shadow-lg rounded" style="background-color: rgb(255, 247, 229);">
                        <div class="d-flex justify-content-center pt-5 pb-2">
                            <img src="<%= users.getAvatar() %>" alt="Profile Image" class="img-fluid rounded-circle" style="height: 100px; width: 100px;"/>
                            <div class="d-flex align-items-center px-3">
                                <% if (moneyLeft != null) {%>
                                <p class="m-0 px-2 fs-6 text-success">Số tiền: <strong><%= moneyLeftInt%></strong></p>
                                <% } else { %>
                                <p class="m-0 px-2 fs-6">Số tiền: <strong>Không có dữ liệu</strong></p>
                                <% }%>
                            </div>

                        </div>
                        <hr class="w-75 mx-auto">
                        <div class="text-center mt-3 d-flex flex-column">
                            <h3 class="bg-white p-3">Chỉnh sửa hồ sơ</h3>
                            <a class="h3 mt-4 p-3 d-block" href="summaryBooking.jsp">Lịch sử giao dịch</a>
                            <h3 class="my-4 p-3">Quà tặng tích điểm</h3>
                            <h3 class="mt-4 p-3"><a href="report.jsp?userID=<%= users.getUserID()%>">Báo cáo</a></h3>

                        </div>
                    </div>
                    <div class="col-1"></div>
                    <div class="col-7 row">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover">
                                <thead class="thead-dark text-center" style="background-color: #f7cf90">
                                    <tr>
                                        <th scope="col">Mã đơn hàng</th>
                                        <th scope="col">Ngày đặt</th>
                                        <th scope="col">Tổng giá</th>
                                        <th scope="col">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody class="text-center">
                                    <c:if test="${empty booking}">
                                    <p>No bookings found for this user.</p>
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