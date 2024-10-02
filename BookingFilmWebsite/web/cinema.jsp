<%@ page import="java.util.List" %>
<%@page import="Model.DatabaseInfo"%>
<%@page import="Model.Theatre"%>
<%@page import="Model.TheatreDB"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width= , initial-scale=1.0">
        <link rel="stylesheet" href="admins.css">
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
            width:95%;
            margin: auto;
        }

        .main-admin table {
            width: 90%;
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
                    <a href="customer.jsp" class="active">
                        <span class="material-symbols-outlined">
                            person
                        </span>
                        <h3>Customer</h3>
                    </a>
                    <a href="cinema.jsp">
                        <span class="material-symbols-outlined">
                            movie
                        </span>
                        <h3>Theatre</h3>
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
                    </div>
                    <div class="main-admin">
                        <div class="userInfo">
                            <h1>Theatre Information</h1>
                            <table class="table-container">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Location</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        TheatreDB cinemaDB = new TheatreDB();
                                        List<Theatre> list = TheatreDB.listAllTheatres();
                                        for (Theatre ci : list) {
                                    %>
                                    <tr>
                                        <td><%= ci.getTheatreID()%></td>
                                        <td><%= ci.getTheatreName()%></td>
                                        <td><%= ci.getTheatreLocation()%></td>
                                        <td>
                                            <!-- Update and Delete buttons -->
                                            <form action="TheatreServlet" method="POST">
                                                <input type="hidden" name="cinemaID" value="<%= ci.getTheatreID()%>">
                                                <button style="background-color: var(--clr-primary)" type="submit" name="action" value="update">Update</button>
                                                <button style="background-color: var(--clr-danger)" type="submit" name="action" value="delete">Delete</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                            <div class="action-buttons">
                                <form action="addTheatre.jsp" method="GET">
                                    <button style="background-color: green; margin-top: 10px" type="submit">Add New Theatre</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </main>



        </div>

    </body>
    <script src="admin.js"></script>
</html>