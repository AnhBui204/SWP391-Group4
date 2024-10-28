<%@page import="Model.Theatre"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="Model.Room" %>
<%@page import="Model.RoomDB" %>
<!DOCTYPE html>
<html lang="en">   
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Cinema Schedule</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/movie_styles1.css"/>
    </head>
    <body>        
        <!-- Navbar Start -->
        <div class="container-fluid">
            <div class="container-main row no-gutters">
                <!-- Sidebar -->
                
                <div class="col-12 col-lg-3" id="tempDiv">
                    
                </div>
                
                <div class="col-12 col-lg-3" style="background-color: #eb7d5d; padding-left: 0px ;padding-right: 0px; position: fixed;">
<!--                <div class="col-12 col-lg-3" style="background-color: #eb7d5d;">-->
                    <div class="sidebar" style="height: 100vh;" >
                        <div class="widget widget_collection">
                            <div class="widget-title text-center">
                                CINELUXE
                            </div>
                            <div class="widget_collection_list text-center">
                                <div class="staff-info text-left">
                                    <div class="staff-card d-flex align-items-center justify-content-between p-2" style="background-color: #a8344d; border-radius: 10px; color: white;">
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-user-alt" style="font-size: 24px; margin-right: 10px;"></i>
                                            <div class="staff-details">
                                                <c:if test="${not empty users}">
                                                    <h6 style="margin: 0;">Staff</h6>
                                                    <span class="staff-name" style="font-size: 18px;">
                                                        <span>${users.lName}</span> <span>${users.fName}</span>
                                                    </span>
                                                </c:if>
                                                <c:if test="${empty users}">
                                                    <p>No user information available.</p>
                                                </c:if>
                                            </div>
                                        </div>
                                        <form action="UserServlet?action=logout" method="POST">
                                            <button class="btn btn-link p-0" style="color: white;">
                                                <i class="fas fa-sign-out-alt" style="font-size: 24px;"></i>
                                            </button>
                                        </form>
                                    </div>
                                </div>

                                <div class="menu-items">
                                    <h5><button onclick="location.href = 'crudMV.jsp'">Phim<span class="icon">&#128253;</span></button></h5>    
                                    <h5><button onclick="location.href = 'crudFD.jsp'">Đồ Ăn Nước Uống<span class="icon">&#127871;</span></button></h5>
                                    <h5><button onclick="location.href = 'Offers.jsp'">Thẻ Ưu Đãi<span class="icon">&#127991;</span></button></h5>
                                    <form action="MovieServlet?action=mvList" method="Post">
                                        <h5 style="text-decoration: none">
                                            <button type="submit" class="btn btn-link">
                                                Quản lý lịch chiếu<span class="icon">&#128337;</span>
                                            </button>
                                        </h5>
                                    </form>
                                    <h5><button onclick="location.href = 'ViewWorkHistory.jsp'">Lịch sử hoạt động<span class="icon">&#128221;</span></button></h5> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-lg-9" style="background-color: #f7cf90;">
                    <div class="body-right" style="height: 100vh;">

                        <div class="container-fluid pt-5">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h2 class="section-title px-5 bordered text-left">
                                    <span class="px-2">Quản lý lịch chiếu</span>
                                </h2>

                                <!-- Date and Theatre Name in the same row -->
                                <div class="d-flex align-items-center">
                                    <h2 class="section-title px-5 bordered">
                                        <span class="px-2">Rạp ${theatre.theatreName}</span>
                                    </h2>
                                    <!-- Date filter next to theatre name -->

                                </div>
                                <div class="btn-group text-left">
                                    <label for="filterDate" class="sr-only">Chọn ngày</label> <!-- Hidden label to keep screen readers accessible -->
                                    <input type="date" class="form-control" id="filterDate" name="filterDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>" style="width: auto;">
                                </div>
                            </div>

                            <div class="row px-xl-5 pb-3">
                                <%
                                    Theatre theatres = (Theatre) session.getAttribute("theatre");
                                    RoomDB db = new RoomDB();
                                    List<Room> list = db.getRoomsByCinema(theatres.getTheatreID());
                                    for (Room room : list) {
                                %>
                                <div class="col-md-12 col-sm-12 col-12 pb-3 d-flex justify-content-center row">
                                    <div class="card border-0 mb-4 text-center col-lg-12">
                                        <div class="card-body">
                                            <!-- Button triggers fetching show info -->
                                            <button class="btn btn-outline-primary btn-lg btn-block py-3 room-btn" 
                                                    style="border-radius: 10px; font-size: 18px; width: 100%; margin: 10px 0" 
                                                    data-toggle="modal" data-target="#scheduleModal" data-room-id="<%= room.getRoomID()%>">
                                                <%= room.getRoomName()%>
                                            </button>

                                            <!-- Show info will be displayed here -->
                                            <div id="showInfo_<%= room.getRoomID()%>" class="show-info"></div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>

                            <script>
                                $(document).ready(function () {
                                    // Fetch show info when the date changes
                                    $('#filterDate').change(function () {
                                        var selectedDate = $(this).val();

                                        $('.room-btn').each(function () {
                                            var roomID = $(this).data('room-id');

                                            // Fetch show info via AJAX for each room
                                            $.ajax({
                                                url: 'MovieServlet?action=getShowInfo', // Call your servlet
                                                type: 'POST',
                                                data: {roomID: roomID, date: selectedDate}, // Send Room ID and selected date as parameters
                                                success: function (response) {
                                                    var showInfoContainer = $('#showInfo_' + roomID);
                                                    showInfoContainer.empty(); // Clear previous data

                                                    if (response.length === 0) {
                                                        showInfoContainer.append('<p>No shows available for this room on the selected date.</p>');
                                                    } else {
                                                        $.each(response, function (index, show) {
                                                            showInfoContainer.append('<p>' + show.showDateValue + ' - ' + show.startTime + ' - ' + show.movieName + '</p>');
                                                        });
                                                    }
                                                },
                                                error: function () {
                                                    alert('Error fetching show info');
                                                }
                                            });
                                        });
                                    });
                                });

                                $(document).ready(function () {
                                    var message = '<%= request.getAttribute("message") != null ? request.getAttribute("message") : ""%>';
                                    if (message) {
                                        $('#messageModal').modal('show');
                                    }
                                });

                            </script>
                            <!-- Modal display message -->
                            <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="messageModalLabel">Thông báo</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <%
                                                String message = (String) request.getAttribute("message");
                                                if (message != null) {
                                            %>
                                            <p><%= message%></p>
                                            <%
                                                }
                                            %>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <!-- Modal HTML for scheduling showtime -->
                            <div id="scheduleModal" class="modal fade">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <form action="MovieServlet?action=showSeat&page=showSeat" method="POST">
                                            <div class="modal-header">						
                                                <h4 class="modal-title">Đặt lịch chiếu</h4>
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            </div>
                                            <div class="modal-body">					
                                                <!-- Hidden Room ID -->
                                                <input type="hidden" id="roomID" name="roomID" value="">
                                                <input hidden name="theatreID" value="${theatre.theatreID}" />
                                                <!-- Dropdown for selecting movie -->
                                                <div class="form-group">
                                                    <label for="movieID">Chọn phim</label>
                                                    <select class="form-control" id="movieID" name="movieID" required>
                                                        <option value="" disabled selected>Chọn phim</option>
                                                        <c:forEach var="movie" items="${movieList}">
                                                            <option value="${movie.movieID}" data-image="${movie.imgPortrait}">${movie.movieName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <img id="movieImage" src="" alt="Movie Image" class="img-fluid" style="display:none; width: 30%">
                                                </div>
                                                <!-- Dropdown for selecting showtime -->
                                                <div class="form-group">
                                                    <label for="showtimeID">Chọn suất chiếu</label>
                                                    <select class="form-control" id="showtimeID" name="showtimeID" required>
                                                        <option value="" disabled selected>Chọn suất chiếu</option>
                                                        <!-- The showtimes will be populated via AJAX -->
                                                    </select>     
                                                </div>
                                                <input type="hidden" id="selectedShowtimeID" name="selectedShowtimeID" value="">
                                            </div>
                                            <div class="modal-footer">
                                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                                <input type="submit" class="btn btn-success" value="Set Show">
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <!-- jQuery to populate the Room ID in the modal when a button is clicked -->
                            <script>
                                $(document).ready(function () {
                                    $('#scheduleModal').on('show.bs.modal', function (event) {
                                        var button = $(event.relatedTarget); // Button that triggered the modal
                                        var roomID = button.data('room-id'); // Extract info from data-* attributes
                                        var modal = $(this);
                                        modal.find('#roomID').val(roomID); // Set the Room ID in the modal's hidden field

                                        $('#movieImage').attr('src', '').hide(); // Hide image initially

                                        // Change movie image when a movie is selected
                                        $('#movieID').change(function () {
                                            var selectedOption = $(this).find('option:selected');
                                            var movieImagePath = selectedOption.data('image');
                                            $('#movieImage').attr('src', movieImagePath).show(); // Show selected movie image

                                            // Use AJAX to get showtimes for the selected movie
                                            var movieID = selectedOption.val(); // Get the selected movie ID
                                            $.ajax({
                                                url: 'MovieServlet?action=getShow', // The endpoint to retrieve showtimes
                                                type: 'POST',
                                                data: {movieID: movieID}, // Send movieID as a parameter
                                                success: function (response) {
                                                    // Clear previous showtimes
                                                    $('#showtimeID').empty();
                                                    $('#showtimeID').append('<option value="" disabled selected>Chọn suất chiếu</option>');

                                                    // Loop through the response (assuming it's JSON)
                                                    $.each(response, function (index, show) {
                                                        $('#showtimeID').append('<option value="' + show.showID + '">' + show.showDate + ' - ' + show.showTime + '</option>');
                                                    });

                                                    // When a showtime is selected, set the value in the hidden input
                                                    $('#showtimeID').change(function () {
                                                        var selectedShowtimeID = $(this).val(); // Get the selected showtime ID
                                                        $('#selectedShowtimeID').val(selectedShowtimeID); // Set the hidden input value
                                                    });
                                                },
                                                error: function () {
                                                    alert('Error fetching showtimes');
                                                }
                                            });
                                        });
                                    });
                                });

                            </script>
                        </div>
                    </div>
                </div>    
            </div>
        </div>
    </body>
</html>