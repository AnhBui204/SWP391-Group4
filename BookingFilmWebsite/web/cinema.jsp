<%@ page import="java.util.List" %>
<%@page import="Model.DatabaseInfo"%>
<%@page import="Model.Theatre"%>
<%@page import="Model.TheatreDB"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Đưa CSS hoặc link đến các file CSS vào đây -->
        <meta charset="UTF-8">
        <link rel="stylesheet" href="./css/admins2.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <title>Cinema Management</title>
    </head>
    <style>
        /* Modal container */
        .modal-container {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        /* Modal content */
        .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            width: 600px;
            text-align: center;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        /* Close button */
        .close-btn {
            background-color: red;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 3px;
            float: right;
        }

        /* Delete button */
        .delete-btn {
            background-color: #e74c3c;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        /* Open modal button */
        .open-btn {
            padding: 5px 15px;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 3px;
        }

        /* Feedback Modal */
        .feedback-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .feedback-modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            width: 400px;
            text-align: center;
        }

        .action-cell {
            width: 40%; /* Điều chỉnh độ rộng ô này */
        }
    </style>
    <body>

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
                                    <h1 class="h2 mb-0 ls-tight">Quản Lý Rạp Phim</h1>
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
                            <div class="card-header d-flex align-items-center justify-content-between">
                                <h5 class="mb-0">Rạp Phim</h5>
                                <div class="card-footer border-0 py-2">
                                    <div class="action-buttons">
                                        <form action="addTheatre.jsp" method="GET">
                                            <button class="open-btn" style="background-color: green;" type="submit">Add New Theatre</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover table-nowrap">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Location</th>
                                            <th>Action</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Theatre> list = TheatreDB.listAllTheatres();
                                            for (Theatre ci : list) {
                                        %>
                                        <tr>
                                            <td><%= ci.getTheatreID()%></td>
                                            <td><%= ci.getTheatreName()%></td>
                                            <td><%= ci.getTheatreLocation()%></td>
                                            <td class="d-flex">
                                                <!-- Update and Delete buttons -->
                                                <!--<form action="AdminReport" method="POST" style="display: inline;">-->
                                                <form action="updateTheatre.jsp" method="GET" class="me-2">
                                                    <input type="hidden" name="theatreID" value="<%= ci.getTheatreID()%>">
                                                    <button class="btn btn-warning btn-sm w-100" type="submit">Update</button>
                                                </form>
                                                <!-- Open Modal Button -->
                                                <form action="TheatreServlet?action=delete" method="POST">
                                                    <input type="hidden" name="theatreID" value="<%= ci.getTheatreID()%>">
                                                    <button class="btn btn-danger btn-sm w-100" type="button" id="openModal-<%= ci.getTheatreID()%>">Delete</button>

                                                    <!-- Modal -->
                                                    <div class="modal-container" id="myModal-<%= ci.getTheatreID()%>">
                                                        <div class="modal-content">
                                                            <h2>Are you sure you want to delete <%= ci.getTheatreID()%>?</h2>
                                                            <div class="button-container">
                                                                <button class="btn btn-secondary btn-sm w-100" id="closeModal-<%= ci.getTheatreID()%>">Cancel</button>
                                                                <button class="btn btn-danger btn-sm w-100" type="submit" id="openModal-<%= ci.getTheatreID()%>">Delete</button>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <script>
                                                        // Get modal elements for this specific theatre
                                                        const modal<%= ci.getTheatreID()%> = document.getElementById("myModal-<%= ci.getTheatreID()%>");
                                                        const openModalBtn<%= ci.getTheatreID()%> = document.getElementById("openModal-<%= ci.getTheatreID()%>");
                                                        const closeModalBtn<%= ci.getTheatreID()%> = document.getElementById("closeModal-<%= ci.getTheatreID()%>");
                                                        // Open modal on button click
                                                        openModalBtn<%= ci.getTheatreID()%>.addEventListener("click", () => {
                                                            modal<%= ci.getTheatreID()%>.style.display = "flex";
                                                        });
                                                        // Close modal on button click
                                                        closeModalBtn<%= ci.getTheatreID()%>.addEventListener("click", (event) => {
                                                            event.preventDefault();
                                                            modal<%= ci.getTheatreID()%>.style.display = "none";
                                                        });
                                                        // Close modal when clicking outside the modal content
                                                        window.addEventListener("click", (event) => {
                                                            if (event.target === modal<%= ci.getTheatreID()%>) {
                                                                modal<%= ci.getTheatreID()%>.style.display = "none";
                                                            }
                                                        });
                                                    </script>
                                                </form>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="js/admin.js"></script>

    </body>
</html>
