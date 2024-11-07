<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Kết Quả Thanh Toán</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
        <style>
            body {
                background-color: #f8f3e9; /* Màu nền trắng sữa */
            }
            .card-header {
                background-color: #f8f9fa;
                border-bottom: 1px solid #dee2e6;
            }
            .card-body {
                background-color: #f8f9fa;
            }
            .text{
                color:red;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center">Kết Quả Thanh Toán</h2>

            <c:choose>
                <c:when test="${not empty sessionScope.message}">
                    <div class="card text mb-3">
                        <div class="card-header text-center">Thông báo</div>
                        <div class="card-body text-center">
                            <p class="card-text">${sessionScope.message}</p>
                        </div>
                    </div>
                    <c:remove var="message" scope="session" />
                </c:when>

                <c:otherwise>
                    <div class="card text bg-success mb-3">
                        <div class="card-header text-center">Thông báo</div> <!-- Căn giữa tiêu đề -->
                        <div class="card-body text-center"> <!-- Căn giữa văn bản -->
                            <h5 class="card-title">Thành công!</h5>
                            <p class="card-text">Thanh toán của bạn chưa được xử lí! Vui lòng đặt lại.</p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="text-center mt-4">
                <button class="btn btn-primary" onclick="window.location.href = 'HomePage.jsp'">Quay lại trang chủ</button>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
