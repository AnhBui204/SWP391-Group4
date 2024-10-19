<%@page import="Model.Theatre"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.UserDB" %>
<%@ page import="Model.WorkHistory" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="css/movie_styles1.css">
        <title>VWH</title>
        <style>
            body {
                background-color: #f4f4f4;
            }

            main {
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .staff-card {
                padding: 15px;
            }

            h1 {
                color: #333;
                text-align: center;
            }

            table {
                margin-top: 20px;
            }

            th {
                background-color: #5a5959;
                color: #f4f4f4;
            }

            tr:hover {
                background-color: #f1f1f1;
            }
        </style>
    </head>

    <body>

        <div class="container-fluid">
            <div class="container-main row">
                <!-- Sidebar -->
                <div class="col-12 col-lg-3" style="padding-left: 0px; padding-right: 0px;">
                    <div class="sidebar" style="height: 100vh;">
                        <div class="widget widget_collection">
                            <div class="widget-title text-center">
                                CINELUXE
                            </div>
                            <div class="widget_collection_list text-center">
                                <div class="staff-info text-left">
                                    <div class="staff-card d-flex align-items-center justify-content-between p-2" style="background-color: #a8344d; border-radius: 10px; color: white;">
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-user-alt" style="font-size: 24px; margin-right: 10px;"></i>
                                            <div class="staff-details">
                                                <c:if test="${not empty users}">
                                                    <h6 style="margin: 0;">Staff</h6>
                                                    <span class="staff-name" style="font-size: 18px;">
                                                        <span>${users.lName}</span> <span>${users.fName}</span>
                                                    </span>
                                                </c:if>
                                                <c:if test="${empty users}">
                                                    <p>No user information available.</p>
                                                </c:if>
                                            </div>
                                        </div>
                                        <form action="UserServlet?action=logout" method="POST">
                                            <button class="btn btn-link p-0" style="color: white;">
                                                <i class="fas fa-sign-out-alt" style="font-size: 24px;"></i>
                                            </button>
                                        </form>
                                    </div>
                                </div>

                                <div class="menu-items">
                                    <h5><button type="button" onclick="location.href = 'crudMV.jsp'">Phim<span class="icon">&#128253;</span></button></h5>
                                    <h5><button type="button" onclick="location.href = 'crudFD.jsp'">Đồ Ăn Nước Uống<span class="icon">&#127871;</span></button></h5>
                                    <h5><button type="button" onclick="location.href = 'Offers.jsp'">Thẻ Ưu Đãi<span class="icon">&#127991;</span></button></h5>
                                    <form action="MovieServlet?action=mvList" method="Post">
                                        <h5 style="text-decoration: none">
                                            <button type="submit" class="btn btn-link">
                                                Quản lý lịch chiếu<span class="icon">&#128337;</span>
                                            </button>
                                        </h5>
                                    </form>
                                    <h5><button type="button" onclick="location.href = 'ViewWorkHistory.jsp'">Lịch sử hoạt động<span class="icon">&#128221;</span></button></h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-12 col-lg-9" style="padding: 0; background-color: #f7cf90;">
                    <div class="p-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h2 class="section-title px-5 bordered text-left">
                                <span class="px-2">Lịch sử hoạt động</span>
                            </h2>
                            <h2 class="section-title px-5 bordered">
                                <span class="px-2">Rạp ${theatre.theatreName}</span>
                            </h2>
                        </div>
                        <main>
                            <h1>Work History</h1>

                            <div class="form-group">
                                <label for="date">Select Date:</label>
                                <form action="ViewWorkHistory.jsp" method="GET">
                                    <input type="date" class="form-control" id="date" name="date" value="${param.date}">
                                </form>
                            </div>

                            <div class="recent_order">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Work ID</th>
                                            <th>Work Description</th>
                                            <th>Date</th>
                                            <th>Time</th>
                                            <th>Staff ID</th>
                                        </tr>
                                    </thead>
                                    <%
                                        Theatre theatre = (Theatre) session.getAttribute("theatre");
                                        String selectedDate = request.getParameter("date");

                                        if (selectedDate != null && !selectedDate.isEmpty()) {
                                            try {
                                                // Check if the selected date is in the correct format
                                                Date date = Date.valueOf(selectedDate);
                                                UserDB db = new UserDB();
                                                ArrayList<WorkHistory> list = db.listWorkHistoryByDate(theatre.getTheatreID(), selectedDate);

                                                // Display work history
                                    %>
                                    <tbody>
                                        <%            for (WorkHistory workHis : list) {
                                        %>
                                        <tr>
                                            <td><%= workHis.getWorkID()%></td>
                                            <td><%= workHis.getWorkDes()%></td>
                                            <td><%= workHis.getDates()%></td>
                                            <td><%= workHis.getTimes()%></td>
                                            <td><%= workHis.getStaffID()%></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                    <%
                                            } catch (IllegalArgumentException e) {
                                                out.println("<p>Invalid date format. Please select a valid date.</p>");
                                            }
                                        } else {
                                            out.println("<p>Please select a date to view the work history.</p>");
                                        }
                                    %>
                                </table>
                            </div>
                        </main>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            document.getElementById('date').addEventListener('change', function () {
                this.form.submit(); // Automatically submit form on date change
            });
        </script>
    </body>

</html>
