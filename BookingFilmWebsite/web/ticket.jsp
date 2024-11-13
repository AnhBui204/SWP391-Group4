<%@page import="Model.BookingInfo"%>
<%@page import="Model.ShowInfo1"%>
<%@page import="java.util.List"%>
<%@page import="Model.DatabaseInfo"%>
<%@page import="Model.TicketDB"%>
<%@page import="Model.TicketDetails"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Đưa CSS hoặc link đến các file CSS vào đây -->
        <meta charset="UTF-8">
        <link rel="stylesheet" href="./css/admins2.css">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">

        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <title>Ticket Management</title>
    </head>
    <style>
        .action-buttons {
            display: flex;
            gap: 10px; /* Thêm khoảng cách giữa hai nút */
            justify-content: center;
        }

        .btn-approve, .btn-reject {
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-approve {
            background-color: #28a745;
            color: white;
        }

        .btn-approve:hover {
            background-color: #218838;
        }

        .btn-reject {
            background-color:  #e74c3c;
            color: white;
        }

        .btn-reject:hover {
            background-color: #e0a800;
        }

    </style>
    <body>
        <%
            List<BookingInfo> booking = TicketDB.getBookingDetails();
            System.out.println("Tickets size: " + booking.size());
            request.setAttribute("booking", booking);
        %>



        <!-- Dashboard -->
        <div class="d-flex flex-column flex-lg-row h-lg-full bg-surface-secondary">
            <!-- Vertical Navbar -->
            <nav class="navbar show navbar-vertical h-lg-screen navbar-expand-lg px-0 py-3 navbar-light bg-white border-bottom border-bottom-lg-0 border-end-lg" id="navbarVertical">
                <div class="container-fluid">
                    <a class="navbar-brand py-lg-2 mb-lg-5 px-lg-6 me-0" href="HomePage.jsp">
                        <span style="font-size: 1.5rem; font-weight: bold; color: #333;">Cineluxe</span>             
                    </a>
                    <div class="collapse navbar-collapse" id="sidebarCollapse">
                        <!-- Navigation -->
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="statistic.jsp">
                                    <i class="bi bi-bar-chart"></i> Doanh Thu
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="cinema.jsp">
                                    <i class="bi bi-film"></i> Rạp phim
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="AdminReport.jsp">
                                    <i class="bi bi-chat"></i> Phản Hồi
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ticket.jsp">
                                    <i class="bi bi-card-checklist"></i> Đơn Hàng
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="customer.jsp">
                                    <i class="bi bi-people"></i> Tài khoản
                                </a>
                            </li>
                        </ul>
                        <!-- Divider -->
                        <hr class="navbar-divider my-5 opacity-20">
                        <!-- Push content down -->
                        <div class="mt-auto"></div>
                        <!-- User (md) -->
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="UserServlet?action=logout">
                                    <i class="bi bi-box-arrow-left"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <!-- Main content -->
            <div class="h-screen flex-grow-1 overflow-y-lg-auto">
                <!-- Header -->
                <header class="bg-surface-primary border-bottom pt-6">
                    <div class="container-fluid">
                        <div class="mb-npx">
                            <div class="row align-items-center">
                                <div class="col-sm-6 col-12 mb-4 mb-sm-0">
                                    <!-- Title -->
                                    <h1 class="h2 mb-0 ls-tight">Quản Lý Đơn Hàng</h1>
                                </div>
                            </div>
                            <!-- Nav -->
                            <ul class="nav nav-tabs mt-4 overflow-x border-0">
                            </ul>
                        </div>
                    </div>
                </header>
                <!-- Main -->
                <main class="py-6 bg-surface-secondary">
                    <div class="container-fluid"> 
                        <div class="card shadow border-0 mb-7">
                            <div class="card-header">
                                <h5 class="mb-0">Thông tin Đơn Hàng</h5>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover table-nowrap">
                                    <thead class="thead-light">
                                        <tr>
                                            <th scope="col">Mã đơn hàng</th>
                                            <th scope="col">Ngày đặt</th>
                                            <th scope="col">Tổng giá</th>
                                            <th scope="col">Trạng thái</th>
                                            <th scope="col">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="book" items="${booking}">
                                            <tr>
                                                <td>${book.bookingID}</td> <!-- Add the necessary details here -->
                                                <td>${book.bookingDate}</td>
                                                <td>${book.totalPrice}</td>
                                                <td>${book.status}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${book.status == 'Đang chờ'}">
                                                            <div class="action-buttons">
                                                                <!-- Nút Chấp thuận -->
                                                                <a href="#" onclick="confirmAction('approve', '${book.bookingID}')" class="btn-approve">
                                                                    Chấp thuận
                                                                </a>
                                                                <!-- Nút Từ chối -->
                                                                <a href="#" onclick="confirmAction('reject', '${book.bookingID}')" class="btn-reject">
                                                                    Từ chối
                                                                </a>
                                                            </div>

                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="card-footer border-0 py-5">
                                <span class="text-muted text-sm">Show more</span>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <!-- Modal xác nhận -->
        <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmModalLabel">Xác nhận</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn muốn thực hiện hành động này?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <a id="confirmAction" href="#" class="btn btn-primary">Xác nhận</a>
                    </div>
                </div>
            </div>
        </div>

        <script src="js/admin.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                                    function confirmAction(action, bookingID) {
                                                                        // Đặt liên kết xác nhận vào nút "Xác nhận" trong modal
                                                                        var confirmLink = document.getElementById("confirmAction");
                                                                        confirmLink.href = "TicketServlet?action=" + action + "&bookingID=" + bookingID;

                                                                        // Hiển thị modal
                                                                        var myModal = new bootstrap.Modal(document.getElementById('confirmModal'));
                                                                        myModal.show();
                                                                    }
        </script>

    </body>
</html>