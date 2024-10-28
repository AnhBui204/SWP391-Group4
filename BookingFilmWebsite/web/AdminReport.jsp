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
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/admins1.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    <title>Report Management</title>
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

    .userInfo h1 {
        margin: 10px;
        color: var(--clr-primary);
    }

    .table-container {
        width: 95%;
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

    .main-admin tbody tr {
        height: 3.8rem;
        border-bottom: 1px solid var(--clr-white);
        color: var(--clr-dark-variant);
    }

    .main-admin tbody tr:hover {
        background-color: #ddd;
    }

    .main-table tbody td {
        height: 3.8rem;
        border-bottom: 1px solid var(--clr-dark);
    }

    .main-table tbody td:last-child td {
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
        width: 400px;
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
        padding: 10px 20px;
        background-color: green;
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
    <div class="container">
        <aside>
            <div class="top">
                <div class="log">
                    <h2 class="primary">Cine<span class="danger">Luxe</span></h2>
                </div>
                <div class="close" id="close_btn">
                    <span class="material-symbols-outlined"> close </span>
                </div>
            </div>
            <div class="sidebar">
<!--                <a href="AdminDashBoard.jsp">
                    <span class="material-symbols-outlined"> grid_view </span>
                    <h3>Dashboard</h3>
                </a>-->
                <a href="customer.jsp">
                    <span class="material-symbols-outlined"> person </span>
                    <h3>Customer</h3>
                </a>
                <a href="cinema.jsp">
                    <span class="material-symbols-outlined"> movie </span>
                    <h3>Cinema</h3>
                </a>
                <a href="ticket.jsp">
                    <span class="material-symbols-outlined"> local_activity </span>
                    <h3>Ticket</h3>
                </a>
                <a href="AdminReport.jsp" class="active">
                    <span class="material-symbols-outlined"> local_activity </span>
                    <h3>Report</h3>
                </a>
                <a href="statistic.jsp">
                        <span class="material-symbols-outlined">
                            trending_up 
                        </span>
                        <h3>Revenue Statistic</h3>
                    </a>
                <a href="UserServlet?action=logout">
                    <span class="material-symbols-outlined"> logout </span>
                    <h3>Log out</h3>
                </a>
            </div>
        </aside>

        <main>
            <div class="right">
                <div class="top">
                    <button id="menu_bar">
                        <span class="material-symbols-outlined"> menu </span>
                    </button>
                    <div class="theme-toggler">
                        <span class="material-symbols-outlined active"> light_mode </span>
                        <span class="material-symbols-outlined"> dark_mode </span>
                    </div>
                </div>
            </div>
            <div class="main-admin">
                <div class="userInfo">
                    <h1>Report Information</h1>
                    <table class="table-container">
                        <thead>
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
                                        <button style="background-color: var(--clr-primary)" type="submit" name="action" value="view">View</button>
                                    </form>
                                    <!-- Open Modal Button -->
                                    <button class="open-btn" style="background-color: var(--clr-danger)" type="button" data-modal="myModal-<%= report.getReportId()%>">Delete</button>
                                    <!-- Feedback Button -->
                                    <button class="open-btn" style="background-color: #f39c12" type="button" data-modal="feedbackModal-<%= report.getReportId()%>">Feedback</button>

                                    <!-- Modal for Deletion -->
                                    <div class="modal-container" id="myModal-<%= report.getReportId()%>">
                                        <div class="modal-content">
                                            <h2>Are you sure you want to delete <%= report.getReportTitle()%>?</h2>
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
                                            <form action="FeedbackServlet" method="POST">
                                                <input type="hidden" name="reportID" value="<%= report.getReportId()%>">
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
            </div>
        </main>
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
