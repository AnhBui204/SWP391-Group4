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
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Kết Quả Thanh Toán</h2>

        <c:choose>
            <c:when test="${paymentSuccess}">
                <div class="alert alert-success" role="alert">
                    Thanh toán của bạn đã được xử lý thành công! Cảm ơn bạn đã đặt vé xem phim.
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                </div>
            </c:otherwise>
        </c:choose>

        <div class="text-center">
            <button class="btn btn-primary" onclick="window.location.href='HomePage.jsp'">Quay lại trang chủ</button>
        </div>
    </div>
</body>
</html>
