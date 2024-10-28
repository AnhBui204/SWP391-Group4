<%-- 
    Document   : report
    Created on : Oct 23, 2024, 11:32:48 AM
    Author     : ANH BUI
--%>

<%@page import="Model.User"%>
<%@page import="Model.UserDB"%>
<%@page import="Model.Report"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Model.ReportDB"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Kiểm tra session hiện tại
    HttpSession currentSession = request.getSession(false);
    if (currentSession == null || currentSession.getAttribute("id") == null) {
        // Nếu không có session hoặc session không hợp lệ, chuyển hướng về trang đăng nhập hoặc thông báo lỗi
        response.sendRedirect("Login.jsp");
        return;
    }

    String userID = (String) currentSession.getAttribute("id");

    // Lấy lịch sử báo cáo từ cơ sở dữ liệu
    ReportDB reportDB = new ReportDB();
    List<Report> reportHistory = reportDB.getReportHistory(userID);
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Lịch Sử Phản Hồi</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: white;
                color: #333;
                margin: 0;
                padding: 20px;
            }

            h1 {
                text-align: center;
                color: #333;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 12px;
                text-align: left;
                border: 1px solid #ddd;
            }

            th {
                background-color: #ff6969;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            /* Modal styles */
            #reportModal {
                display: none; /* Initially hidden */
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
            }

            .modal-content {
                background: white;
                padding: 20px;
                border-radius: 10px;
                width: 400px;
                max-width: 90%;
                box-sizing: border-box;
            }

            input[type="text"], textarea {
                width: calc(100% - 20px);
                padding: 10px;
                margin-top: 5px;
                box-sizing: border-box;
            }

            .modal-button {
                background-color: #ff6969;
                color: white;
                border: none;
                padding: 10px;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 15px;
            }

            .close-button {
                background-color: #ccc;
                color: black;
                border: none;
                padding: 10px;
                border-radius: 5px;
                cursor: pointer;
            }

            /* Responsive design */
            @media (max-width: 600px) {
                table {
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body>
        <h1>Lịch Sử Phản Hồi</h1>
        <button id="createReportBtn" style="margin-bottom: 20px; padding: 10px 15px; background-color: #ff6969; color: white; border: none; border-radius: 5px; cursor: pointer;">
            Tạo Phản Hồi
        </button>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tiêu Đề</th>
                    <th>Mô Tả</th>
                    <th>Ngày Tạo</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (reportHistory != null && !reportHistory.isEmpty()) {
                        for (Report report : reportHistory) {
                %>
                <tr>
                    <td><%= report.getReportId()%></td>
                    <td><%= report.getReportTitle()%></td>
                    <td><%= report.getReportDescription()%></td>
                    <td><%= report.getTimeCreate()%></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="4">Không có phản hồi nào.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <!-- Modal -->
        <div id="reportModal">
            <div class="modal-content">
                <h2>Tạo Phản Hồi</h2>
                <form id="reportForm" action="ReportServlet" method="post">
                    <div>
                        <label for="title">Tiêu Đề:</label>
                        <input type="text" id="title" name="title" required />

                    </div>
                    <div style="margin-top: 10px;">
                        <label for="description">Mô Tả:</label>
                        <input type="text" id="description" name="description" required></input>
                    </div>
                    <button type="submit" style="margin-top: 15px;" class="modal-button">Gửi</button>
                    <button type="button" onclick="closeModal()" class="close-button">Đóng</button>
                </form>
                <div id="reportMessage" style="margin-top: 15px; color: red;"></div> <!-- Ensure this element exists -->
            </div>
        </div>

        <div class="text-center mt-4">
            <form action="UserServlet?action=db" method ="POST" class="btn btn-primary">
                <button type="submit" class="btn btn-primary">Quay lại</button>
            </form>
    </div>

    <script>
        // Mở modal khi nhấn nút
        document.getElementById('createReportBtn').onclick = function () {
            document.getElementById('reportModal').style.display = 'flex';
        };

        // Đóng modal
        function closeModal() {
            document.getElementById('reportModal').style.display = 'none';
        }
        document.getElementById('reportForm').onsubmit = function (event) {
            event.preventDefault(); // Prevent the default form submission

            const title = document.getElementById('title').value;
            const description = document.getElementById('description').value;

            // Optionally, use AJAX for form submission
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'ReportServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onload = function () {
                console.log("Response status:", xhr.status); // Log status
                console.log("Response text:", xhr.responseText); // Log response text
                if (xhr.status === 200) {
                    if (xhr.responseText === 'success') {
                        document.getElementById('reportMessage').textContent = 'Báo cáo đã được gửi thành công!';
                        document.getElementById('reportMessage').style.color = 'green';

                        setTimeout(closeModal, 3000);
                        setTimeout(function () {
                            location.reload(); // This will refresh the page
                        }, 3000);
                    } else {
                        // Update the modal with an error message
                        document.getElementById('reportMessage').textContent = 'Đã xảy ra lỗi khi gửi báo cáo. Vui lòng thử lại.';
                        document.getElementById('reportMessage').style.color = 'red'; // Optional: Change text color to red for error
                    }
                } else {
                    // Handle error response
                    document.getElementById('reportMessage').textContent = 'Đã xảy ra lỗi khi gửi báo cáo. Vui lòng thử lại.';
                    document.getElementById('reportMessage').style.color = 'red'; // Optional: Change text color to red for error
                }
            };

            xhr.send('title=' + encodeURIComponent(title) + '&description=' + encodeURIComponent(description));
        };



    </script>
</body>
</html>

