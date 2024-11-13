<%@ page import="java.util.List" %>
<%@ page import="Model.Movie" %>
<%@ page import="Model.Voucher" %>
<%@ page import="Model.MovieDB" %>
<%@ page import="Model.VoucherDB" %>
<%@ page import="Model.Theatre" %>
<%@ page import="Model.TheatreDB" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) { %>
<%@include file="includes/header.jsp" %>
<% } else { %>
<%@include file="includes/header_user.jsp" %>
<% }

    // Lấy danh sách các rạp
    List<Theatre> theatres = TheatreDB.listAllTheatres();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">   
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Danh Sách Các Rạp</title>     
        <link rel="stylesheet" href="css/uudai_homepage.css"/>
        <link rel="stylesheet" href="bs/css/bootstrap.css"/>
        <link rel="stylesheet" href="css/headerssj4.css"/>
        <link rel="stylesheet" href="css/bodyssj1.css" />
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet" />

        <style>
            /* Đặt chung cho toàn trang */
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f8f9fa;
                color: #333;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            .page-title {
                text-align: center;
                color: #ff5722;
                font-size: 2.5rem;
                font-weight: bold;
                margin-bottom: 40px;
                position: relative;
                text-transform: uppercase;
            }

            /* Đường gạch chân tiêu đề */
            .page-title::after {
                content: "";
                position: absolute;
                width: 50px;
                height: 4px;
                background-color: #ff5722;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
            }

            /* Thanh tìm kiếm */
            .search-bar {
                width: 100%;
                margin-bottom: 30px;
            }

            .search-bar input {
                width: 100%;
                padding: 12px;
                font-size: 1rem;
                border-radius: 8px;
                border: 1px solid #ccc;
                margin-bottom: 15px;
            }

            .theatre-list {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: 20px;
            }

            .theatre-item {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                padding: 20px;
                flex: 1 1 45%;
                max-width: 45%;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                display: flex;
                align-items: center;
            }

            .theatre-item:hover {
                transform: scale(1.05);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            /* Thêm biểu tượng */
            .theatre-icon {
                font-size: 2.5rem;
                color: #ff5722;
                margin-right: 15px;
            }

            .theatre-details {
                flex-grow: 1;
            }

            .theatre-name {
                color: #ff5722;
                font-size: 1.5rem;
                margin: 0;
                font-weight: bold;
                line-height: 1.2;
            }

            .theatre-location {
                font-size: 1rem;
                margin-top: 10px;
                color: #666;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1 class="page-title">Danh Sách Các Rạp</h1>

            <!-- Thanh tìm kiếm -->
            <div class="search-bar">
                <input type="text" placeholder="Tìm kiếm rạp chiếu..." id="search-input">
            </div>

            <!-- Kiểm tra nếu danh sách các rạp không rỗng -->
            <% if (theatres != null && !theatres.isEmpty()) { %>
            <div class="theatre-list" id="theatre-list">
                <% for (Theatre theatre : theatres) { %>
                <!-- Kiểm tra null để tránh lỗi NullPointerException -->
                <% if (theatre != null) {%>
                <div class="theatre-item">
                    <!-- Icon rạp chiếu -->
                    <div class="theatre-icon">
                        <i class="fas fa-film"></i>
                    </div>
                    <div class="theatre-details">
                        <h2 class="theatre-name"><%= theatre.getTheatreName()%></h2>
                        <p class="theatre-location"><strong>Địa điểm:</strong> <%= theatre.getTheatreLocation()%></p>
                    </div>
                </div>
                <% } %>
                <% } %>
            </div>
            <% } else { %>
            <p>Hiện tại không có thông tin về các rạp.</p>
            <% }%>
        </div>

        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <script src="bs/js/bootstrap.bundle.js"></script>
        <script>
            // Tìm kiếm
            document.getElementById("search-input").addEventListener("keyup", function () {
                const searchValue = this.value.toLowerCase();
                const theatres = document.querySelectorAll(".theatre-item");

                theatres.forEach(theatre => {
                    const theatreName = theatre.querySelector(".theatre-name").innerText.toLowerCase();
                    if (theatreName.includes(searchValue)) {
                        theatre.style.display = "flex";
                    } else {
                        theatre.style.display = "none";
                    }
                });
            });
        </script>
    </body>
</html>

<%@include file="includes/footer.jsp" %>
<link rel="stylesheet" href="css/footerssj2.css" />
