<%@ page import="java.util.List" %>
<%@page import="Model.DatabaseInfo"%>
<%@page import="Model.Cinema"%>
<%@page import="Model.CinemaDB"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width= , initial-scale=1.0">
        <link rel="stylesheet" href="admin.css">
        <link rel="stylesheet"
              href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <title>Document</title>
    </head>
    <style>
        /* Các trang khác */

        .userInfo {
            background-color: var(--clr-white);
            justify-content: center;
            align-items: center;
            padding: var(--card-padding);
            border: var(--card-border-radius);
            box-shadow: var(--box-shadow);
            margin-top: 65px;
        }

        .userInfo h1{
            margin: 10px;
            color: var(--clr-primary);
        }

        .table-container {
            width:100%;
            margin: auto;
        }

        .main-admin table {
            width: 100%;
            height: 100%;
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

        .main-admin tbody tr{
            height: 3.8rem;
            border-bottom: 1px solid var(--clr-white);
            color: var(--clr-dark-variant);
        }

        .main-admin tbody tr:hover {
            background-color: #ddd;
        }

        .main-table tbody td{
            height: 3.8rem;
            border-bottom: 1px solid var(--clr-dark);
        }

        .main-table tbody td:last-child td{
            border: none;
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
    <body>

        <div class="container">
            <aside>

                <div class="top">
                    <div class="log">
                        <h2 class="primary">Cine<span class="danger">Luxe</span></h2>
                    </div>
                    <div class="close" id="close_btn">
                        <span class="material-symbols-outlined">
                            close
                        </span>
                    </div>
                </div>
                <div class="sidebar">
                    <a href="AdminDashBoard.jsp" >
                        <span class="material-symbols-outlined">
                            grid_view
                        </span>
                        <h3>Dashboard</h3>
                    </a>
                    <a href="customer.jsp">
                        <span class="material-symbols-outlined">
                            person
                        </span>
                        <h3>Customer</h3>
                    </a>
                    <a href="cinema.jsp"  class="active">
                        <span class="material-symbols-outlined">
                            movie
                        </span>
                        <h3>Cinema</h3>
                    </a>
                    <a href="ticket.jsp">
                        <span class="material-symbols-outlined">
                            local_activity
                        </span>
                        <h3>Ticket</h3>
                    </a>
                    <a href="UserServlet?action=logout">
                        <span class="material-symbols-outlined">
                            logout
                        </span>
                        <h3>Log out</h3>
                    </a>
                </div>

            </aside>

            <main>
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
            </main>

            <div class="right">
                <div class="top">
                    <button id="menu_bar">
                        <span class="material-symbols-outlined">
                            menu
                        </span>
                    </button>
                    <div class="theme-toggler">
                        <span class="material-symbols-outlined active">light_mode</span>

                        <span class="material-symbols-outlined">dark_mode</span>

                    </div>
                    <div class="profile">
                        <div class="info">
                            <p><b>Babar</b></p>
                            <p>Admin</p>
                            <small class="text-muted"></small>
                        </div>
                        <div class="profile-photo">
                            <img src="image/logo/logo.png" alt="">
                        </div>
                    </div>
                </div>

                <div class="recent_updates">
                    <h2>Recent Update</h2>
                    <div class="updates">
                        <div class="update">
                            <div class="profile-photo">
                                <img src="image/logo/logo.png" alt="">
                            </div>
                            <div class="message"><p><b>Babar</b> Recived his order</p></div>
                        </div>

                        <div class="update">
                            <div class="profile-photo">
                                <img src="image/logo/logo.png" alt="">
                            </div>
                            <div class="message"><p><b>Babar</b> Recived his order</p></div>
                        </div>

                        <div class="update">
                            <div class="profile-photo">
                                <img src="image/logo/logo.png" alt="">
                            </div>
                            <div class="message"><p><b>Babar</b> Recived his order</p></div>
                        </div>
                    </div>

                </div>

                <div class="sales_analytics">
                    <h2>Sales Analytics</h2>

                    <div class="item onlion">
                        <div class="icon">
                            <span class="material-symbols-outlined">shopping_cart</span>
                        </div>
                        <div class="right_text">
                            <div class="info">
                                <h3>Onlion order</h3>
                                <small class="text-muted">Last seen 2 Hours</small>
                            </div>
                            <h5 class="danger">-17%</h5>
                            <h3>3849</h3>
                        </div>
                    </div>

                    <div class="item onlion">
                        <div class="icon">
                            <span class="material-symbols-outlined">shopping_cart</span>
                        </div>
                        <div class="right_text">
                            <div class="info">
                                <h3>Onlion order</h3>
                                <small class="text-muted">Last seen 2 Hours</small>
                            </div>
                            <h5 class="danger">-17%</h5>
                            <h3>3849</h3>
                        </div>
                    </div>

                    <div class="item onlion">
                        <div class="icon">
                            <span class="material-symbols-outlined">shopping_cart</span>
                        </div>
                        <div class="right_text">
                            <div class="info">
                                <h3>Onlion order</h3>
                                <small class="text-muted">Last seen 2 Hours</small>
                            </div>
                            <h5 class="danger">-17%</h5>
                            <h3>3849</h3>
                        </div>
                    </div>
                </div>
                <div class="item add_products">
                    <div>
                        <span class="material-symbols-outlined">add</span>
                    </div>
                </div>
            </div>

        </div>

    </body>
    <script src="admin.js"></script>
</html>