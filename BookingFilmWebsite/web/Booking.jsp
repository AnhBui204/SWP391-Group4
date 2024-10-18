<%@ page pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="css/BookingCSS.css"/>
<script src="js/jvs.js"></script>
<script src="js/voucher.js"></script>
<%
                String user = (String) session.getAttribute("user");
                if (user == null) { %>
<%@include file="includes/header.jsp" %>
<% } else { %>
<%@include file="includes/header_user.jsp" %>
<% }%>
<link rel="stylesheet" href="css/headers.css" />
<link rel="stylesheet" href="css/footer.css" />
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đặt Vé Xem Phim</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
        <link rel="stylesheet" href="css/BookingCSS.css"/>
    </head>
    <body>
        <div class="container bk_body mt-4">
            <div class="container mt-4">
                <div class="progress" style="height: 30px;">
                    <!-- Step 1 -->
                    <div class="progress-bar progress-bar-striped bg-warning" role="progressbar" style="width: 20%;">
                        Chọn phim / Rạp / Suất
                    </div>
                    <!-- Step 2 -->
                    <div class="progress-bar bg-secondary" role="progressbar" style="width: 20%;">
                        Chọn ghế
                    </div>
                    <!-- Step 3 -->
                    <div class="progress-bar bg-secondary" role="progressbar" style="width: 20%;">
                        Chọn thức ăn
                    </div>
                    <!-- Step 4 -->
                    <div class="progress-bar bg-secondary" role="progressbar" style="width: 20%;">
                        Thanh toán
                    </div>
                    <!-- Step 5 -->
                    <div class="progress-bar bg-secondary" role="progressbar" style="width: 20%;">
                        Xác nhận
                    </div>
                </div>
            </div>

            <%--Card trái --%>
            <div class="row d-flex">
                <div class="col-lg-8">
                    <!-- Chọn vị trí -->
                    <div class="card mb-3">
                        <div class="card-body p-4">
                            <h5 class="card-title">Chọn rạp</h5>
                            <select id="select-theatre" class="form-control">
                                <option>Chọn rạp</option>
                                <c:forEach var="rap" items="${theatre}">
                                    <option>${rap.theatreName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <!-- Chọn phim -->
                    <div class="card mb-3 ">
                        <div class="card-body p-4">
                            <h5 class="card-title">Chọn phim</h5>
                            <select id="select-movie" class="form-control">
                                <option value="">Chọn phim</option>
                                <c:forEach var="movie" items="${movie}">
                                    <option value="${movie.movieName}">${movie.movieName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Chọn ngày</h5>
                            <select id="select-date" class="form-control">
                                <option value="">Chọn ngày</option>
                                <c:forEach var="show" items="${shows}">
                                    <option value="${show.showDate}">${show.showDate}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="card-body">
                            <h5 class="card-title">Chọn suất chiếu</h5>
                            <select id="select-time" class="form-control">
                                <option value="">Chọn suất chiếu</option>
                                <c:forEach var="show" items="${shows}">
                                    <option value="${show.startTime}">${show.startTime}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Bên phải -->
                <div class="col-lg-4">
                    <div class="card mb-3">
                        <div class="card-body text-center">
                            <h5>Rạp: <span id="selected-theatre">Chưa chọn rạp</span></h5>
                            <h5 id="selected-movie">Chưa chọn phim</h5>
                            <p id="selected-date">Ngày: Chưa chọn</p>
                            <p id="selected-time">Giờ chiếu: Chưa chọn</p>
                        </div>
                    </div>


                    <!-- Nút điều hướng -->
                    <div class="d-flex justify-content-between">
                        <button class="btn btn-light">Quay lại</button>
                        <button class="btn btn-warning">Tiếp tục</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            document.getElementById('select-theatre').addEventListener('change', function () {
                document.getElementById('selected-theatre').innerText = this.value || 'Chưa chọn rạp';
            });

            document.getElementById('select-movie').addEventListener('change', function () {
                document.getElementById('selected-movie').innerText = this.value || 'Chưa chọn phim';
            });

            document.getElementById('select-date').addEventListener('change', function () {
                document.getElementById('selected-date').innerText = 'Ngày: ' + (this.value || 'Chưa chọn');
            });

            document.getElementById('select-time').addEventListener('change', function () {
                document.getElementById('selected-time').innerText = 'Giờ chiếu: ' + (this.value || 'Chưa chọn');
            });



        </script>
    </body>
</html>
<%@include file="includes/footer.jsp" %>