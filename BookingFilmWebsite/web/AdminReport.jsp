<%-- 
    Document   : AdminReport
    Created on : Oct 23, 2024, 11:26:14 AM
    Author     : ANH BUI
--%>

<%@ page import="java.util.List" %>
<%@page import="Model.DatabaseInfo"%>
<%@page import="Model.Report"%>
<%@page import="Model.ReportDB"%>
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
        <title>Report Management</title>
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
                    <!-- Toggler -->
                    <button class="navbar-toggler ms-n2" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarCollapse" aria-controls="sidebarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <!-- Brand -->
                    <a class="navbar-brand py-lg-2 mb-lg-5 px-lg-6 me-0" href="HomePage.jsp">
                        <span style="font-size: 1.5rem; font-weight: bold; color: #333;">Cineluxe</span>             
                    </a>
                    <!-- User menu (mobile) -->
                    <div class="navbar-user d-lg-none">
                        <!-- Dropdown -->
                        <div class="dropdown">
                            <!-- Toggle -->
                            <a href="#" id="sidebarAvatar" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <div class="avatar-parent-child">
                                    <img alt="Image Placeholder" src="https://images.unsplash.com/photo-1548142813-c348350df52b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=3&w=256&h=256&q=80" class="avatar avatar- rounded-circle">
                                    <span class="avatar-child avatar-badge bg-success"></span>
                                </div>
                            </a>
                            <!-- Menu -->
                            <div class="dropdown-menu dropdown-menu-end" aria-labelledby="sidebarAvatar">
                                <a href="#" class="dropdown-item">Profile</a>
                                <a href="#" class="dropdown-item">Settings</a>
                                <a href="#" class="dropdown-item">Billing</a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">Logout</a>
                            </div>
                        </div>
                    </div>
                    <!-- Collapse -->
                    <div class="collapse navbar-collapse" id="sidebarCollapse">
                        <!-- Navigation -->
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="cinema.jsp">
                                    <i class="bi bi-film"></i> Rạp phim
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="statistic.jsp">
                                    <i class="bi bi-bar-chart"></i> Doanh Thu
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
                                    <i class="bi bi-people"></i> Khách Hàng
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
                                <a class="nav-link" href="CustomerProfile.jsp">
                                    <i class="bi bi-person-square"></i> Account
                                </a>
                            </li>
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
                                    <h1 class="h2 mb-0 ls-tight">Quản Lý Phản Hồi</h1>
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
                                <h5 class="mb-0">Phản hồi</h5>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover table-nowrap">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>Issue Title</th>
                                            <th>Action</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            ReportDB reportDB = new ReportDB();
                                            List<Report> list = reportDB.listAllReports();
                                            for (Report report : list) {
                                        %>
                                        <tr>
                                            <td><%= report.getReportId()%></td>
                                            <td><%= report.getReportTitle()%></td>
                                            <td class="action-cell">
                                                <!-- Update and Delete buttons -->
                                                <form action="AdminReport" method="POST" style="display: inline;">
                                                    <input type="hidden" name="reportID" value="<%= report.getReportId()%>">
                                                    <button class="open-btn" style="background-color: #eb7d5d" type="submit" name="action" value="view">View</button>
                                                </form>
                                                <!-- Open Modal Button -->
                                                <button class="open-btn" style="background-color: #DC3545" type="button" data-modal="myModal-<%= report.getReportId()%>">Delete</button>
                                                <!-- Feedback Button -->
                                                <button class="open-btn" style="background-color: #198754" type="button" data-modal="feedbackModal-<%= report.getReportId()%>">Feedback</button>

                                                <!-- Modal for Deletion -->
                                                <div class="modal-container" id="myModal-<%= report.getReportId()%>">
                                                    <div class="modal-content">
                                                        <h3>Are you sure you want to delete <%= report.getReportTitle()%>?</h3>
                                                        <form action="AdminReport" method="POST">
                                                            <input type="hidden" name="reportID" value="<%= report.getReportId()%>">
                                                            <button type="submit" class="delete-btn" name="action" value="delete">Delete</button>
                                                            <button type="button" class="close-btn" onclick="closeModal('myModal-<%= report.getReportId()%>')">Cancel</button>
                                                        </form>
                                                    </div>
                                                </div>

                                                <!-- Feedback Modal -->
                                                <div class="feedback-modal" id="feedbackModal-<%= report.getReportId()%>">
                                                    <div class="feedback-modal-content">
                                                        <h2>Feedback for <%= report.getReportTitle()%></h2>
                                                        <form action="FeedBackServlet" method="POST">
                                                            <input type="hidden" name="reportID" value="<%= report.getReportId()%>">
                                                            <input type="hidden" name="userID" value="<%= report.getUserId()%>">
                                                            <input type="hidden" name="action" value="delete">
                                                            <textarea name="feedback" required placeholder="Enter your feedback..." rows="4" style="width: 100%;"></textarea>
                                                            <button type="submit" class="open-btn" style="margin-top: 10px;">Submit Feedback</button>
                                                            <button type="button" class="close-btn" onclick="closeModal('feedbackModal-<%= report.getReportId()%>')">Close</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <div class="card-footer border-0 py-5">
                                <span class="text-muted text-sm">Show more </span>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script>
            function closeModal(modalId) {
                document.getElementById(modalId).style.display = 'none';
            }

            document.querySelectorAll('.open-btn').forEach(button => {
                button.addEventListener('click', () => {
                    const modalId = button.getAttribute('data-modal');
                    document.getElementById(modalId).style.display = 'flex';
                });
            });
        </script>
    </body>
</html>