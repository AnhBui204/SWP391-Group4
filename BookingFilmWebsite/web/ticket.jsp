<%@ page import="java.util.List" %>
<%@page import="Model.DatabaseInfo"%>
<%@page import="Model.Cinema"%>
<%@page import="Model.CinemaDB"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vn">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer</title>
        <link rel="stylesheet" href="css/admindb.css"/>
    </head>
    <style>
        .userInfo {
            margin-top: 50px;
            justify-content: center;
            align-items: center;
        }
        
        .userInfo h1{
            margin: 10px;
        }

        .table-container {
            width:95%;
            margin: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 40px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 15px;
            text-align: center;
            color: #333;
        }

        th {
            background-color: #3498db;
            color: white;
            font-weight: bold;
        }

        tbody tr{
            background-color: #f2f2f2;
        }

        tbody tr:hover {
            background-color: #ddd;
        }

        /* Button Styling */
        button {
            padding: 5px 10px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #2980b9;
        }

        /* Responsive Table */
        @media screen and (max-width: 768px) {
            .table-container {
                display: block;
                width: 100%;
            }

            table, thead, tbody, th, td, tr {
                display: block;
            }

            th {
                display: none; /* Hide table headers for small screens */
            }

            tr {
                margin-bottom: 10px;
            }

            td {
                text-align: right;
                padding-left: 50%;
                position: relative;
            }

            td::before {
                content: attr(data-label);
                position: absolute;
                left: 0;
                width: 50%;
                padding-left: 15px;
                font-weight: bold;
                text-align: left;
                color: #fff;
            }
        }
    </style>
    <body>
        <div class="container">
            <div class="navigation-admin">
                <ul>
                    <li class="logo">
                        <div class="topbar-admin">
                            <a href="AdminDashBoard.jsp">
                                <h3 class="logo-text">Cineluxe</h3>
                            </a>
                        </div>
                    </li>
                    <li class="dep">
                        <a href="AdminDashBoard.jsp">
                            <span class="icon">
                                <img src="image/logo/dashboard.png" alt="Dashboard">
                            </span>
                            <span class="title">Dashboard</span>
                        </a>
                    </li>
                    <li class="dep">
                        <a href="customer.jsp">
                            <span class="icon">
                                <img src="image/logo/customer.png" alt="Customers">
                            </span>
                            <span class="title">Customers</span>
                        </a>
                    </li>
                    <li class="dep">
                        <a href="cinema.jsp">
                            <span class="icon">
                                <img src="image/logo/cinema.png" alt="Cinema">
                            </span>
                            <span class="title">Cinema</span>
                        </a>
                    </li>
                    <li class="dep">
                        <a href="ticket.jsp">
                            <span class="icon">
                                <img src="image/logo/order.png" alt="Orders">
                            </span>
                            <span class="title">Orders</span>
                        </a>
                    </li>
                    <li class="dep">
                        <a href="HomePage.jsp">
                            <span class="icon">
                                <img src="image/logo/logout.png" alt="Messages">
                            </span>
                            <span class="title">Log out</span>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="main-admin">
                <div class="userInfo">
                    <h1>Cinema Information</h1>
                    <table class="table-container">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Location</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                CinemaDB cinemaDB = new CinemaDB();
                                List<Cinema> list = CinemaDB.listAllCinemas();
                                for (Cinema ci : list) {
                            %>
                            <tr>
                                <td><%= ci.getCinemaID()%></td>
                                <td><%= ci.getCinemaName()%></td>
                                <td><%= ci.getCinemaLocation()%></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </body>
</html>
