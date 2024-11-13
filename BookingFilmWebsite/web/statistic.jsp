<%@ page import="java.util.List" %>
<%@ page import="Model.DatabaseInfo" %>
<%@ page import="Model.User" %>
<%@ page import="Model.UserDB" %>
<%@page import="Model.Theatre"%>
<%@page import="Model.TheatreDB"%>
<%@page import="Model.Revenue"%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./css/admins2.css">
        <link rel="stylesheet" href="css/statistic.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <title>Revenue Statistic</title>
        <style>
            .optionCinema {
                margin: 20px 0;
                padding: 10px;
                background-color: #f5f5f5;
            }
            .optionCinema .filter {
                display: flex;
                align-items: center;
                padding-left: 14px;
            }
            .optionCinema label {
                font-size: 16px;
                font-weight: 600;
                margin-right: 15px;
                color: #333;
            }
            .optionCinema select, .optionCinema input[type="date"] {
                width: 250px;
                padding: 8px;
                font-size: 14px;
                border-radius: 5px;
                border: 1px solid #ccc;
                background-color: #fff;
                color: #333;
                transition: border-color 0.3s;
            }
            .optionCinema select:focus, .optionCinema input[type="date"]:focus {
                border-color: #41a9c9;
                outline: none;
            }
        </style>
    </head>
    <body>
        <div class="d-flex flex-column flex-lg-row h-lg-full bg-surface-secondary">
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
                                <a class="nav-link" href="UserServlet?action=logout">
                                    <i class="bi bi-box-arrow-left"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <div class="h-screen flex-grow-1 overflow-y-lg-auto">
                <header class="bg-surface-primary border-bottom pt-6">
                    <div class="container-fluid">
                        <h1 class="h2 mb-0 ls-tight">Doanh Thu</h1>
                    </div>
                </header>
                <main class="py-6 bg-surface-secondary">
                    <div class="container-fluid"> 
                        <div class="card shadow border-0 mb-7">
                            <div class="card-header">
                                <h5 class="mb-0">Thống Kê Doanh Thu</h5>
                            </div>
                            <div class="optionCinema">
                                <div class="filter">
                                    <label for="dateSelect">Chọn ngày:</label>
                                    <input type="date" id="dateSelect" />
                                    <label for="cinemaSelect">Select Cinema:</label>


                                    <select id="cinemaSelect">
                                        <%
                                            List<Theatre> list = TheatreDB.listAllTheatres();
                                            for (Theatre ci : list) {
                                        %>
                                        <option value="<%= ci.getTheatreID() %>"><%= ci.getTheatreName() %></option>
                                        <%
                                            }
                                        %>
                                    </select>



                                </div>
                            </div>
                            <div class="charts">
                                <div class="chart doughnut-chart">
                                    <h2>Daily Revenue of Selected Cinema</h2>
                                    <canvas id="barChart"></canvas>
                                </div>
                                <div class="chart">
                                    <h2>Total Revenue by Cinema</h2>
                                    <canvas id="pieChart"></canvas>
                                </div>

                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover table-nowrap">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Theatre ID</th>
                                            <th>Theatre Name</th>
                                            <th>Location</th>
                                            <th>Total revenue</th>
                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (Theatre ci : list) {
                                        %>
                                        <tr>
                                            <td><%= ci.getTheatreID() %></td>
                                            <td><%= ci.getTheatreName() %></td>
                                            <td><%= ci.getTheatreLocation() %></td>
                                            <td>????VND</td>
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
        <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>     
        <script>
            let pieChart, barChart;

            function initializeCharts() {
                const pieChartCtx = document.getElementById('pieChart').getContext('2d');
                const barChartCtx = document.getElementById('barChart').getContext('2d');

                pieChart = new Chart(pieChartCtx, {
                    type: 'pie',
                    data: {
                        labels: [],
                        datasets: [{
                                data: [],
                                backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40'],
                                hoverOffset: 4
                            }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {position: 'top'},
                            tooltip: {
                                callbacks: {
                                    label: function (tooltipItem) {
                                        return tooltipItem.label + ': ' + tooltipItem.raw + ' VND';
                                    }
                                }
                            }
                        }
                    }
                });

                barChart = new Chart(barChartCtx, {
                    type: 'bar',
                    data: {
                        labels: [],
                        datasets: [{
                                label: 'Doanh thu (VND)',
                                data: [],
                                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                borderColor: 'rgba(54, 162, 235, 1)',
                                borderWidth: 1
                            }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            x: {beginAtZero: true}
                        },
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: function (tooltipItem) {
                                        return tooltipItem.label + ': ' + tooltipItem.raw + ' VND';
                                    }
                                }
                            }
                        }
                    }
                });
            }

            document.getElementById("dateSelect").addEventListener("change", fetchData);
            document.getElementById("cinemaSelect").addEventListener("change", fetchData);

            function fetchData() {
                const selectedDate = document.getElementById("dateSelect").value;
                const selectedCinema = document.getElementById("cinemaSelect").value;
                const url = `RevenueServlet`;  // Ensure this is the correct URL for the servlet

                fetch(url, {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({date: selectedDate, theatreID: selectedCinema})
                })
                        .then(response => response.json())
                        .then(data => {
                            console.log('Data received:', data);  // Log the response to check the structure
                            updateCharts(data);  // Update the charts with the new data
                        })
                        .catch(error => {
                            console.error('Lỗi:', error);  // Log any errors that occur during the fetch
                        });
            }

            function updateCharts(data) {
                // Clear previous chart data
                pieChart.data.labels = [];
                pieChart.data.datasets[0].data = [];
                barChart.data.labels = [];
                barChart.data.datasets[0].data = [];

                // Check if total revenue data exists
                if (data.totalRevenue && data.totalRevenue.length > 0) {
                    const totalRevenueData = data.totalRevenue;
                    pieChart.data.labels = ['Total Revenue'];  // Use a generic label if no specific cinema
                    pieChart.data.datasets[0].data = totalRevenueData.map(item => item.totalRevenue || 0);
                    pieChart.update();  // Refresh the pie chart with the new data
                } else {
                    // Handle the case where no total revenue data is available
                    console.log("No total revenue data for the selected date or cinema");
                    pieChart.update();  // Update the chart to show an empty state or a message
                }

                // Check if daily revenue data exists
                if (data.dailyRevenue && data.dailyRevenue.length > 0) {
                    const dailyRevenueData = data.dailyRevenue;
                    barChart.data.labels = dailyRevenueData.map(item => item.bookingDate || 'Unknown');
                    barChart.data.datasets[0].data = dailyRevenueData.map(item => item.totalRevenue || 0);
                    barChart.update();  // Refresh the bar chart with the new data
                } else {
                    // Handle the case where no daily revenue data is available
                    console.log("No daily revenue data for the selected date or cinema");
                    barChart.update();  // Update the chart to show an empty state or a message
                }
            }


            document.addEventListener("DOMContentLoaded", initializeCharts);

        </script>

    </body>
</html>