<%@page import="Model.ShowInfo"%>
<%@page import="java.util.List"%>
<%@page import="Model.DatabaseInfo"%>
<%@page import="Model.Ticket"%>
<%@page import="Model.TicketDB"%>
<%@page import="Model.TicketDetails"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/admins.css">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    <title>Thông Tin Vé</title>
    <style>
        /* Các trang khác */

        .userInfo {
            background-color: var(--clr-white);
            justify-content: center;
            align-items: center;
            padding: var(--card-padding);
            border-radius: var(--card-border-radius);
            box-shadow: var(--box-shadow);
            margin-top: 65px;
        }

        .userInfo h1 {
            margin: 10px;
            color: var(--clr-primary);
        }

        .table-container {
            width: 100%;
            margin: auto;
        }

        .main-admin table {
            width: 100%;
            background-color: var(--clr-white);
            padding: var(--card-padding);
            border-radius: var(--card-border-radius);
            text-align: center;
            transition: all .3s ease;
            color: var(--clr-dark);
        }

        .main-admin table, th, td {
            border: 1px solid #ddd;
        }

        .main-admin th, td {
            padding: 15px;
            text-align: center;
            color: var(--clr-dark);
        }

        .main-admin th {
            background-color: var(--clr-primary);
            color: white;
            font-weight: bold;
        }

        .main-admin tbody tr {
            height: 3.8rem;
            border-bottom: 1px solid var(--clr-white);
            color: var(--clr-dark-variant);
        }

        .main-admin tbody tr:hover {
            background-color: #ddd;
        }

        /* Button Styling */
        .main-admin button {
            padding: 5px 10px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .main-admin button:hover {
            background-color: #2980b9;
        }
    </style>
</head>

<body>
    
<%
    List<Ticket> tickets = TicketDB.listAllTickets();
    System.out.println("Tickets size: " + tickets.size()); // In ra kích thước của danh sách vé
    request.setAttribute("tickets", tickets); 
%>

    <div class="container">
        <aside>
            <div class="top">
                <div class="log">
                    <h2 class="primary">Cine<span class="danger">Luxe</span></h2>
                </div>
                <div class="close" id="close_btn">
                    <span class="material-symbols-outlined">close</span>
                </div>
            </div>
            <div class="sidebar">
                <a href="AdminDashBoard.jsp">
                    <span class="material-symbols-outlined">grid_view</span>
                    <h3>Dashboard</h3>
                </a>
                <a href="customer.jsp">
                    <span class="material-symbols-outlined">person</span>
                    <h3>Customer</h3>
                </a>
                <a href="cinema.jsp">
                    <span class="material-symbols-outlined">movie</span>
                    <h3>Cinema</h3>
                </a>
                <a href="ticket.jsp" class="active">
                    <span class="material-symbols-outlined">local_activity</span>
                    <h3>Ticket</h3>
                </a>
                <a href="AdminReport.jsp">
                    <span class="material-symbols-outlined">local_activity</span>
                    <h3>Report</h3>
                </a>
                <a href="statistic.jsp">
                        <span class="material-symbols-outlined">
                            trending_up 
                        </span>
                        <h3>Revenue Statistic</h3>
                </a>
                <a href="UserServlet?action=logout">
                    <span class="material-symbols-outlined">logout</span>
                    <h3>Log out</h3>
                </a>
            </div>
        </aside>

        <main>
            <div class="right">
                <div class="top">
                    <button id="menu_bar">
                        <span class="material-symbols-outlined">menu</span>
                    </button>
                    <div class="theme-toggler">
                        <span class="material-symbols-outlined active">light_mode</span>
                        <span class="material-symbols-outlined">dark_mode</span>
                    </div>
                </div>
            </div>
            <div class="main-admin">
                <div class="userInfo">
                    <h1>Thông Tin Vé</h1>
                    <table class="table-container">
                        <thead>
                            <tr>
                                <th>Ticket ID</th>
                                <th>User ID</th>
                                <th>Booking ID</th>
                                <th>Booking Seat ID</th>
                                <th>Room ID</th>
                                <th>Booking Combo ID</th>
                                <th>Booking Date</th>
                                <th>Total Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="ticket" items="${tickets}">
                                <tr>
                                    <td>${ticket.ticketID}</td>
                                    <td>${ticket.userID}</td>
                                    <td>${ticket.bookingID}</td>
                                    <td>${ticket.bookingSeatID}</td>
                                    <td>${ticket.roomID}</td>
                                    <td>${ticket.bookingComboID}</td>
                                    <td>${ticket.bookingDate}</td>
                                    <td>${ticket.totalPrice}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
    <script src="js/admin.js"></script>
</body>
</html>
