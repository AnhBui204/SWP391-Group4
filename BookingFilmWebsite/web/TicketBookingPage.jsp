<%-- 
    Document   : TicketBookingPage
    Created on : Sep 10, 2024, 8:10:34 PM
    Author     : ANH BUI
--%>
<%@include file="includes/header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ticket Booking Page</title>
        <link rel="stylesheet" href="css/tkBooking.css"/>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet" />
    </head>
    <body>
        <div class="container my-4">
            <!-- Step Progress Bar -->
            <nav>
                <div class="nav nav-tabs bookingProcess" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-movie-tab" href="#">Chọn phim / Rạp / Suất</a>
                    <a class="nav-item nav-link disabled" href="#">Chọn ghế</a>
                    <a class="nav-item nav-link disabled" href="#">Chọn thức ăn</a>
                    <a class="nav-item nav-link disabled" href="#">Thanh toán</a>
                    <a class="nav-item nav-link disabled" href="#">Xác nhận</a>
                </div>
            </nav>

            <div class="row mt-4 tbody">
                <!-- Left Section: Movie Selection -->
                <div class="col-md-8 left">
                    <!-- Location Selection -->
                    <div class="location-selection mb-4 card">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5>Chọn Rạp - Đà Nẵng</h5>
                            <button class="btn btn-primary mb-3" type="button" id="toggleCinemaList">&#9660</button>
                        </div>

                        <!-- Collapsible Content -->
                        <div id="cinemaList" style="display: none;">
                            <div class="btn-group btn-group-toggle list" data-toggle="buttons">
                                <label class="btn btn-outline-primary">Starlight Đà Nẵng</label>
                                <label class="btn btn-outline-primary">Rio Đà Nẵng</label>
                                <label class="btn btn-outline-primary">CGV Vĩnh Trung Plaza</label>
                                <label class="btn btn-outline-primary">CGV Vincom Đà Nẵng</label>
                                <label class="btn btn-outline-primary">Lotte Đà Nẵng</label>
                                <label class="btn btn-outline-primary">Galaxy Đà Nẵng</label>
                                <label class="btn btn-outline-primary">Metiz Cinema</label>
                                <label class="btn btn-outline-primary">IF Đà Nẵng</label>
                            </div>
                        </div>
                    </div>

                    <script>
                        document.getElementById("toggleCinemaList").addEventListener("click", function () {
                            var cinemaList = document.getElementById("cinemaList");
                            if (cinemaList.style.display === "none") {
                                cinemaList.style.display = "block";
                                this.textContent = "Ẩn các rạp";
                            } else {
                                cinemaList.style.display = "none";
                                this.textContent = "Hiển thị các rạp";
                            }
                        });
                    </script>

                    <!-- Movie Selection -->
                    <div class="movie-selection mb-4 card">
                        <button class="btn btn-light">
                            Chọn phim <span id="mvName"></span>
                            <span class="dropdown">&#9660;</span>
                        </button>
                        <div class="mvList row">
                            <!-- Dynamically load movie posters -->
                            <div class="mv col-md-3">
                                <img class="img-fluid imgs" src="image/temp/mv1.jpg" alt="alt"/>
                                <h5>Làm giàu với ma</h5> 
                            </div>
                            <div class="mv col-md-3">
                                <img class="img-fluid imgs" src="image/temp/mv1.jpg" alt="alt"/>
                                <h5>Làm giàu với ma</h5> 
                            </div>
                            <div class="mv col-md-3">
                                <img class="img-fluid imgs" src="image/temp/mv1.jpg" alt="alt"/>
                                <h5>Làm giàu với ma</h5> 
                            </div>
                            <div class="mv col-md-3">
                                <img class="img-fluid imgs" src="image/temp/mv1.jpg" alt="alt"/>
                                <h5>Làm giàu với ma</h5> 
                            </div>
                            <div class="mv col-md-3">
                                <img class="img-fluid imgs" src="image/temp/mv1.jpg" alt="alt"/>
                                <h5>Làm giàu với ma</h5> 
                            </div><div class="mv col-md-3">
                                <img class="img-fluid imgs" src="image/temp/mv1.jpg" alt="alt"/>
                                <h5>Làm giàu với ma</h5> 
                            </div>
                            <div class="mv col-md-3">
                                <img class="img-fluid imgs" src="image/temp/mv1.jpg" alt="alt"/>
                                <h5>Làm giàu với ma</h5> 
                            </div>
                            <div class="mv col-md-3">
                                <img class="img-fluid imgs" src="image/temp/mv1.jpg" alt="alt"/>
                                <h5>Làm giàu với ma</h5> 
                            </div>
                            
                            
                            <!-- Repeat movie poster elements -->
                        </div>
                    </div>

                    <!-- Showtime Selection -->
                    <div class="showtime-selection card p-4">
                        <h5>Chọn suất</h5>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <button class="btn btn-outline-primary" id="prevDateBtn">&#9664;</button>
                            <div class="date-selection d-flex" id="dateSelection">
                                <!-- Dates will be populated here -->
                            </div>
                            <button class="btn btn-outline-primary" id="nextDateBtn">&#9654;</button>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="cinema-name">
                                <strong>Galaxy Đà Nẵng</strong>
                                <p>2D Phụ Đề</p>
                            </div>
                            <div>
                                <select class="form-control">
                                    <option selected>Tất cả các rạp</option>
                                    <option>Galaxy Đà Nẵng</option>
                                    <option>Starlight Đà Nẵng</option>
                                </select>
                            </div>
                        </div>

                        <div class="showtimes">
                            <div class="d-flex flex-wrap">
                                <button class="btn btn-outline-secondary m-2">10:00</button>
                                <button class="btn btn-outline-secondary m-2">10:45</button>
                                <button class="btn btn-outline-secondary m-2">11:30</button>
                                <!-- Repeat showtime buttons -->
                            </div>
                        </div>
                    </div>
                </div>

                <script>
                    // Get today's date
                    const today = new Date();
                    const weekdays = ['Chủ Nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy'];

                    // Format date as DD/MM
                    function formatDate(date) {
                        let day = date.getDate();
                        let month = date.getMonth() + 1;
                        return (day < 10 ? '0' : '') + day + '/' + (month < 10 ? '0' : '') + month;
                    }

                    // Update date buttons
                    function populateDays(offset = 0) {
                        const dateSelection = document.getElementById('dateSelection');
                        dateSelection.innerHTML = '';
                        
                        // Generate 7 days starting from today
                        for (let i = 0; i < 7; i++) {
                            let currentDate = new Date();
                            currentDate.setDate(today.getDate() + i + offset);

                            // Create a button
                            let dayButton = document.createElement('button');
                            dayButton.classList.add('btn', 'mx-1');
                            
                            // Highlight today
                            if (i === 0 && offset === 0) {
                                dayButton.classList.add('btn-primary');
                            } else {
                                dayButton.classList.add('btn-outline-secondary');
                            }

                            dayButton.innerHTML = `${weekdays[currentDate.getDay()]}<br>${formatDate(currentDate)}`;
                            dateSelection.appendChild(dayButton);
                        }
                    }

                    // Initial population
                    populateDays();

                    // Handle date navigation
                    let offset = 0;
                    document.getElementById('prevDateBtn').addEventListener('click', function () {
                        offset -= 7;
                        populateDays(offset);
                    });
                    document.getElementById('nextDateBtn').addEventListener('click', function () {
                        offset += 7;
                        populateDays(offset);
                    });
                </script>

                <!-- Right Section: Movie Summary -->
                <div class="col-md-4 right">
                    <div class="movie-summary">
                        <img src="movie-poster.jpg" alt="Movie Poster" class="img-fluid mb-3">
                        <h6>Longlegs: Thảm Kịch Dị Giáo</h6>
                        <span class="badge badge-warning">T18</span>
                        <hr>
                        <div class="total-cost">
                            <span>Tổng cộng</span>
                            <span>0 đ</span>
                        </div>
                        <div class="mt-3 d-flex justify-content-between">
                            <a href="#" class="btn btn-link">Quay lại</a>
                            <button class="btn btn-warning">Tiếp tục</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
