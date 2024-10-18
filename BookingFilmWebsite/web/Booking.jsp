<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="./css/Booking.css"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đặt Vé Xem Phim</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
</head>
<body>
    <div class="container mt-4">
        <div class="progress-bar bg-white">
            <ul>
                <li class="active">Chọn phim / Rạp / Suất</li>
                <li>Chọn ghế</li>
                <li>Chọn thức ăn</li>
                
            </ul>
        </div>
               
        <div class="row d-flex">
            <div class="col-lg-8">
                <!-- Chọn rạp -->
                <div class="card mb-3 ">
                    <div class="card-body p-4">
                        <h5 class="card-title">Chọn rạp</h5>
                        <select id="select-theatre" class="form-control">
                            <option>Chọn rạp</option>
                            <c:forEach var="rap" items="${theatres}">
                                <option value="${rap.theatreID}">${rap.theatreName}</option> 
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- Chọn phim -->
                <div class="card mb-3 ">
                    <div class="card-body p-4">
                        <h5 class="card-title">Chọn phim</h5>
                       
                        <div id="movie-list" class="movie-list">
                            <div id="movie-options" class="movie-options"></div> 
                        </div>
       
                    </div>
                </div>

                <!-- Chọn ngày và suất chiếu -->
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Chọn ngày</h5>
                        <select id="select-date" class="form-control">
                            <option value="">Chọn ngày</option>
                        </select>
                    </div>

                    <div class="card-body">
                        <h5 class="card-title">Chọn suất chiếu</h5>
                        <select id="select-time" class="form-control">
                            <option value="">Chọn suất chiếu</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Bên phải -->
            <div class="col-lg-4">
                <div class="card mb-3">
                    <div class="card-body text-center">
                        <h5>Rạp: <span id="selected-theatre">Chưa chọn rạp</span></h5>
                         <img id="selected-movie-img" src="" alt="Ảnh phim" style="display: none; width: 100px; height: 150px;"/>
                        <h5 id="selected-movie">Chưa chọn phim</h5>
                        <h5 id="selected-date">Ngày: Chưa chọn</h5>
                        <h5 id="selected-time">Giờ chiếu: Chưa chọn</h5>
                    </div>
                </div>
<!-- Modal thông báo -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">Thông báo</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Bạn cần đăng nhập để tiếp tục đặt vé. Hãy đăng nhập ngay!
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                <a href="Login.jsp" class="btn btn-primary">Đăng nhập</a>
            </div>
        </div>
    </div>
</div>

              <form id="bookingForm" action="Seat" method="post">
    <input type="hidden" name="theatreID" id="theatreID" value="" />
     <input type="hidden" name="theatreName" id="theatreName" value="" />
    <input type="hidden" name="movieName" id="movieName" value="" />
    <input type="hidden" name="movieImg" id="movieImg" value="" />

    <input type="hidden" name="movieID" id="movieID" value="" /> 
    <input type="hidden" name="selectedDate" id="selectedDate" value="" />
    <input type="hidden" name="selectedTime" id="selectedTime" value="" />

    <div class="d-flex justify-content-between">
        <button class="btn btn-light" onclick="window.history.back()">Quay lại</button>
        <button type="submit" class="btn btn-warning" onclick="updateHiddenFields(event)">Tiếp tục</button>
    </div>
</form>

            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
document.addEventListener('DOMContentLoaded', function() {
    const selectTheatre = document.getElementById('select-theatre');
    const movieOptions = document.getElementById('movie-options');
    const selectedMovie = document.getElementById('selected-movie');
    const selectedTheatre = document.getElementById('selected-theatre');
    const movieNameInput = document.getElementById('movieName');
    const movieIDInput = document.getElementById('movieID');
    const selectedDate = document.getElementById('selected-date');
    const selectedTime = document.getElementById('selected-time');

    selectTheatre.addEventListener('change', function() {
        const theatreID = this.value;
        selectedTheatre.textContent = theatreID ? this.options[this.selectedIndex].text : 'Chưa chọn rạp';
         document.getElementById('theatreName').value = theatreID ? this.options[this.selectedIndex].text : '';
        movieOptions.innerHTML = ''; 

        if (theatreID) {
            fetch('Sort', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Cache-Control': 'no-cache'
                },
                body: JSON.stringify({ theatreID: theatreID })
            })
            .then(response => response.json())
            .then(data => {
                console.log("Received movies: ", data);
                movieOptions.innerHTML = ''; // Reset danh sách phim

                if (Array.isArray(data) && data.length > 0) {
                    data.forEach(movie => {
                        const movieDiv = document.createElement('div');
                        movieDiv.classList.add('movie-item');
                        movieDiv.setAttribute('data-movie-id', movie.movieID);
                        console.log("Image Path: ", movie.imgPortrait);

                        const movieImg = document.createElement('img');
                        movieImg.src = movie.imgPortrait;
                        movieImg.alt = `Ảnh của ${movie.movieName}`;
                        movieImg.className = "movie-img";
                        movieImg.style.width = "100px";
                        movieImg.style.height = "150px";

                        // Tạo phần tử tên phim
                        const movieName = document.createElement('span');
                        movieName.className = "movie-name";
                        movieName.textContent = movie.movieName;

                        movieDiv.appendChild(movieImg);
                        movieDiv.appendChild(movieName);

                        movieDiv.addEventListener('click', function() {
                            const selectedMovieID = this.getAttribute('data-movie-id'); 
                            selectedMovie.textContent = movie.movieName;
                            movieNameInput.value = movie.movieName;
                            movieIDInput.value = selectedMovieID;

                            // Cập nhật thông tin lên card bên phải
                            selectedMovie.textContent = movie.movieName; // cập nhật tên phim
                            selectedTheatre.textContent = selectTheatre.options[selectTheatre.selectedIndex].text; // cập nhật tên rạp
                         // Thêm ảnh mới vào card bên phải trước tên phim
const movieImgElement = document.createElement('img');
movieImgElement.src = movie.imgPortrait;
movieImgElement.alt = `Ảnh của ${movie.movieName}`;
movieImgElement.className = "movie-img-right";
movieImgElement.style.width = "100px";
movieImgElement.style.height = "150px";
 document.getElementById('movieImg').value = movie.imgPortrait;
 
const cardBodyRight = document.querySelector('.card-body.text-center');

// Xóa ảnh cũ nếu có
const existingImg = cardBodyRight.querySelector('.movie-img-right');
if (existingImg) {
    existingImg.remove();
}

// Thêm ảnh mới trước tên phim
cardBodyRight.insertBefore(movieImgElement, document.getElementById('selected-movie'));

                            // Gọi API để lấy ngày và suất chiếu cho phim đã chọn
                            fetch('SelectMovie', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                body: JSON.stringify({ movieID: selectedMovieID, theatreID: theatreID })
                            })
                            .then(response => response.json())
                            .then(data => {
                                const dateSelect = document.getElementById('select-date');
                                dateSelect.innerHTML = '<option value="">Chọn ngày</option>'; // Reset danh sách ngày

                                if (Array.isArray(data) && data.length > 0) {
                                    data.forEach(date => {
                                        const option = document.createElement('option');
                                        option.value = date;
                                        option.textContent = date;
                                        dateSelect.appendChild(option);
                                    });
                                } else {
                                    dateSelect.innerHTML = '<option value="">Không có ngày nào</option>';
                                }
                            });
                        });

                        movieOptions.appendChild(movieDiv);
                    });
                } else {
                    movieOptions.innerHTML = '<p>Không có phim nào được tìm thấy.</p>';
                }

                movieOptions.style.display = 'block';
            })
            .catch(error => console.error("Error: ", error));
        }
    });

    document.getElementById('select-date').addEventListener('change', function() {
        const movieID = movieIDInput.value; 
        const theatreID = selectTheatre.value;
         const showDate = this.value;  
   selectedDate.textContent = showDate ? `Ngày: `+ showDate : 'Ngày: Chưa chọn';

        if (movieID && theatreID && showDate) {
            fetch('SelectDate', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ movieID: movieID, theatreID: theatreID, showDate: showDate })
            })
            .then(response => response.json())
            .then(data => {
                const startTimeSelect = document.getElementById('select-time');
                startTimeSelect.innerHTML = '<option value="">Chọn suất chiếu</option>'; // Reset danh sách suất chiếu

                if (Array.isArray(data) && data.length > 0) {
                    data.forEach(showTime => {
                        const option = document.createElement('option');
                        option.value = showTime;
                        option.textContent = showTime;
                        startTimeSelect.appendChild(option);
                    });
                } else {
                    startTimeSelect.innerHTML = '<option value="">Không có suất chiếu nào</option>';
                }
            });
        }
    });

    document.getElementById('select-time').addEventListener('change', function() {
        const timeSelected = this.value;
        selectedTime.textContent = timeSelected ? `Suất:` + timeSelected : 'Suất:Chưa chọn';
    });
});

function updateHiddenFields(event) {
    // Ngăn chặn form gửi trước khi cập nhật các trường ẩn
    event.preventDefault();

    const isLoggedIn = <%= (session.getAttribute("user") != null) ? "true" : "false" %>;

    if (!isLoggedIn) {
        // Hiển thị modal đăng nhập
        $('#loginModal').modal('show');
        return;
    }

    const selectedDate = document.getElementById('select-date').value;
    const selectedTime = document.getElementById('select-time').value;
    const theatreID = document.getElementById('select-theatre').value;
    const movieID = document.getElementById('movieID').value;
const movieImg = document.getElementById('movieImg').value;
    console.log("Movie Image: ", movieImg);
    document.getElementById('selectedDate').value = selectedDate;
    document.getElementById('selectedTime').value = selectedTime;
    document.getElementById('theatreID').value = theatreID;
    document.getElementById('movieID').value = movieID;

    // Gửi form sau khi đã cập nhật
    document.getElementById('bookingForm').submit();
}



    </script>
</body>
</html>
