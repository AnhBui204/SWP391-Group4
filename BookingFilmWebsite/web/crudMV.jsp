
<%@page import="Model.Show"%>
<%@page import="Model.ShowDB"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="Model.Movie" %>
<%@page import="Model.MovieDB" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">   
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>CINELUXE Movie</title>
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
            <div class="container-main row">
                <!-- Sidebar -->
                <div class="col-12 col-lg-3" id="tempDiv">

                </div>

                <div class="col-12 col-lg-3" style="padding-left: 0px ;padding-right: 0px; position: fixed;">
                    <div class="sidebar" style="height: 190vh;" >
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
                                            <button type="submit" class="btn btn-link">Quản lý lịch chiếu<span class="icon">&#128337;</span>
                                            </button>
                                        </h5>
                                    </form>
                                    <h5><button onclick="location.href = 'ViewWorkHistory.jsp'">Lịch sử hoạt động<span class="icon">&#128221;</span></button></h5> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>



                <div class="col-12 col-lg-9 " style="padding-left: 0px ;padding-right: 0px; background-color: #f7cf90; " >
                    <div class="body-right" style="height: 190vh; ">

                        <div class="container-fluid mb-5">
                            <div class="row border-top px-xl-5">
                                <div class="main-content">
                                    <!-- Products Start -->
                                    <div class="container-fluid pt-5">
                                        <div class="d-flex justify-content-between align-items-center mb-4">
                                            <h2 class="section-title px-5 bordered text-left">
                                                <span class="px-2">PHIM</span>
                                            </h2>
                                            <div class="mb-4"></div>
                                            <h2 class="section-title px-5 bordered">
                                                <span class="px-2">Rạp ${theatre.theatreName}</span>
                                            </h2>

                                            <div class="btn-group text-left" >
                                                <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal">
                                                    <i class="material-icons">&#xE147;</i> <span>Thêm Phim</span>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Pagination -->
                                        <!-- Tính toán phân trang -->
                                        <%
                                            int mvPage = 1;
                                            int moviesPerPage = 8; // Số phim mỗi trang
                                            if (request.getParameter("mvPage") != null) {
                                                mvPage = Integer.parseInt(request.getParameter("mvPage"));
                                            }

                                            MovieDB movieDB = new MovieDB();

                                            int totalMovies = movieDB.getTotalMovies();
                                            int totalPages = (int) Math.ceil(totalMovies / (double) moviesPerPage);

                                            String searchKey = request.getParameter("search");
                                            List<Movie> listMV = new ArrayList<>();

                                            if (searchKey == null || searchKey.trim().isEmpty()) {
                                                listMV = movieDB.getAllMoviesByPage(mvPage, moviesPerPage);
                                            } else {
                                                listMV = (List<Movie>) request.getAttribute("searchResults");
                                            }

                                            // Retrieve the search key directly from the request
                                            //if (listMV != null && !listMV.isEmpty()) { 
                                            //for (Movie movie : listMV) { 
%>

                                        <!-- Hiển thị phân trang (đưa lên đầu) -->
                                        <div class="pagination-container d-flex justify-content-between align-items-center mb-4">
                                            <nav aria-label="Page navigation">
                                                <ul class="pagination">
                                                    <li class="page-item <%= (mvPage == 1) ? "disabled" : ""%>">
                                                        <a class="page-link" href="?mvPage=<%= mvPage - 1%>" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                    <% for (int i = 1; i <= totalPages; i++) {%>
                                                    <li class="page-item <%= (i == mvPage) ? "active" : ""%>">
                                                        <a class="page-link" href="?mvPage=<%= i%>"><%= i%></a>
                                                    </li>
                                                    <% }%>
                                                    <li class="page-item <%= (mvPage == totalPages) ? "disabled" : ""%>">
                                                        <a class="page-link" href="?mvPage=<%= mvPage + 1%>" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>

                                            <!-- Search Bar (cũng sẽ hiển thị phía trên nếu muốn) -->
                                            <div class="search-container">
                                                <form action="MovieServlet?action=search" method="post">
                                                    <input type="text" placeholder="Tìm Kiếm..." name="search" required>
                                                    <button type="submit"><i class="fa fa-search"></i></button>
                                                </form>
                                            </div>
                                        </div>



                                        <!-- Danh sách phim -->
                                        <div class="row px-xl-5 pb-3">
                                            <%
                                                if (listMV != null && !listMV.isEmpty()) {
                                                    for (Movie movie : listMV) {
                                                        // Render each movie
%>
                                            <div  class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                                <div class="card product-item border-0 mb-4">
                                                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                                        <input type="hidden" name="movieID" value="<%= movie.getMovieID()%>" />
                                                        <img class="img-fluid w-100" src="<%= movie.getImgPortrait()%>" alt="">
                                                        <div class="overlay"> <!-- Thêm overlay -->
                                                            <div class="icon-actions"> <!-- Action icons -->
                                                                <a href="#editEmployeeModal" 
                                                                   class="edit" 
                                                                   data-toggle="modal" 
                                                                   data-id="<%= movie.getMovieID()%>" 
                                                                   data-name="<%= movie.getMovieName()%>" 
                                                                   data-duration="<%= movie.getDuration()%>" 
                                                                   data-country="<%= movie.getCountry()%>" 
                                                                   data-manufacturer="<%= movie.getManufacturer()%>" 
                                                                   data-director="<%= movie.getDirector()%>" 
                                                                   data-rldate="<%= movie.getReleaseDate()%>" 
                                                                   data-des="<%= movie.getDescription()%>">
                                                                    <i class="material-icons rounded" data-toggle="tooltip" title="Update" style="background-color: green;">&#xE254;</i>
                                                                </a>
                                                                <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons rounded" data-toggle="tooltip" title="Delete" style="background-color: red;">&#xE872;</i></a>
                                                            </div>
                                                            <div class="icon-actions"> <!-- Action icons -->
                                                                <a href="#setShowEmployeeModal" 
                                                                   class="setShow" 
                                                                   data-toggle="modal" 
                                                                   data-id="<%= movie.getMovieID()%>" 
                                                                   data-name="<%= movie.getMovieName()%>">
                                                                    <i class="material-icons rounded" data-toggle="tooltip" title="Set Show" style="background-color: grey;">&#xe878;</i>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <p class="movie-title"><%= movie.getMovieName()%></p>
                                            </div>
                                            <%
                                                }
                                            } else if (searchKey != null && !searchKey.trim().isEmpty()) { // Check if searchKey is provided and not empty
%>
                                            <p>Không tìm thấy kết quả nào cho từ khóa: <%= searchKey%>.</p>
                                            <%
                                                }
                                            %>
                                            <%
                                                String getNextID = movieDB.getNextMovieID();
                                                String getNextShowID = ShowDB.getNextShowID();
                                            %>
                                        </div>


                                    </div>
                                </div>
                            </div>
                        </div>    
                    </div>
                </div>

            </div>

            <!--Add Modal HTML -->
            <div id="addEmployeeModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="MovieServlet?action=add&page=movie" method="POST" enctype="multipart/form-data">
                            <div class="modal-header">						
                                <h4 class="modal-title">Thêm Phim</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">					
                                <div class="form-group">
                                    <label>Movie ID: </label>
                                    <input type="text" value="<%= getNextID%>" class="form-control" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="movieName">Movie Name: </label>
                                    <input type="text" name="movieName" id="movieName" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="duration">Duration: </label>
                                    <input type="text" name="duration" id="duration" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="country">Country: </label>
                                    <input type="text" name="country" id="country" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="manufacturer"> Manufacturer: </label>
                                    <input type="text" name="manufacturer" id="manufacturer" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="director"> Director: </label>
                                    <input type="text" name="director" id="director" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="myFile">
                                        <i class="fa fa-file-image-o" aria-hidden="true" style="margin-right: 5px;"></i>Portrait Image:
                                    </label>
                                    <input type="file" id="myFile" name="imageP" style="padding: 5px;
                                           margin-bottom: 10px;
                                           border-radius: 5px;
                                           border: none;
                                           box-shadow: 0 0 5px gray;">
                                </div>
                                <div class="form-group">
                                    <label for="myFiles">
                                        <i class="fa fa-file-image-o" aria-hidden="true" style="margin-right: 5px;"></i>Landscape Image:
                                    </label>
                                    <input type="file" id="myFiles" name="imageL" style="padding: 5px;
                                           margin-bottom: 10px;
                                           border-radius: 5px;
                                           border: none;
                                           box-shadow: 0 0 5px gray;">
                                </div>
                                <div class="form-group">
                                    <label for="rldate">Release Date: </label>
                                    <input type="date" name="rldate" class="form-control id=rldate" required>
                                </div>	
                                <div class="form-group">
                                    <label for="movieDes">Description: </label>
                                    <textarea name="movieDes" id="movieDes" class="form-control" rows="4" required></textarea>
                                </div>


                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                <input type="submit" class="btn btn-success" value="Add">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Update Modal HTML -->
            <div id="editEmployeeModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="MovieServlet?action=update&page=movie" method="POST" enctype="multipart/form-data">
                            <div class="modal-header">						
                                <h4 class="modal-title">Cập Nhật Phim</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">					
                                <div class="form-group">
                                    <label>Movie ID: </label>
                                    <input type="text" name="movieID" id="movieID" value="" class="form-control" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="movieName">Movie Name: </label>
                                    <input type="text" name="movieName" id="movieName" value="" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="duration">Duration: </label>
                                    <input type="text" name="duration" id="duration" value="" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="country">Country: </label>
                                    <input type="text" name="country" id="country" value="" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="manufacturer"> Manufacturer: </label>
                                    <input type="text" name="manufacturer" id="manufacturer" value="" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="director"> Director: </label>
                                    <input type="text" name="director" id="director" value="" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="myFile">
                                        <i class="fa fa-file-image-o" aria-hidden="true" style="margin-right: 5px;"></i>Portrait Image:
                                    </label>
                                    <input type="file" id="myFile" name="imageP" style="padding: 5px;
                                           margin-bottom: 10px;
                                           border-radius: 5px;
                                           border: none;
                                           box-shadow: 0 0 5px gray;">
                                    <!-- Optionally display the existing portrait image -->
                                    <img src="${movie.imageP}" alt="Portrait Image" style="width:100px; margin-top:5px;">
                                </div>
                                <div class="form-group">
                                    <label for="myFiles">
                                        <i class="fa fa-file-image-o" aria-hidden="true" style="margin-right: 5px;"></i>Landscape Image:
                                    </label>
                                    <input type="file" id="myFiles" name="imageL" style="padding: 5px;
                                           margin-bottom: 10px;
                                           border-radius: 5px;
                                           border: none;
                                           box-shadow: 0 0 5px gray;">
                                    <!-- Optionally display the existing landscape image -->
                                    <img src="${movie.imageL}" alt="Landscape Image" style="width:100px; margin-top:5px;">
                                </div>
                                <div class="form-group">
                                    <label for="rldate">Release Date: </label>
                                    <input type="date" name="rldate" id="rldate" value="" class="form-control" required>
                                </div>	
                                <div class="form-group">
                                    <label for="movieDes">Description: </label>
                                    <textarea name="movieDes" id="movieDes" class="form-control" rows="4" required></textarea>
                                </div>


                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                <input type="submit" class="btn btn-success" value="Update">
                            </div>
                        </form>
                    </div>
                </div>
            </div>


            <!--Delete Modal HTML -->
            <div id="deleteEmployeeModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="MovieServlet?action=delete&page=movie" method="post">
                            <div class="modal-header">						
                                <h4 class="modal-title">Xóa Phim</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">					
                                <p>Bạn có chắc muốn xóa phim này?</p>
                                <input type="hidden" name="movieID" id="deleteMovieID" value="">
                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                <input type="submit" class="btn btn-danger" value="Delete">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!--Set Show Modal HTML -->
            <div id="setShowEmployeeModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="MovieServlet?action=setShow" method="POST">
                            <div class="modal-header">						
                                <h4 class="modal-title">Đặt suất chiếu</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">					
                                <div class="form-group">
                                    <label>Show ID: </label>
                                    <input type="text" value="<%= getNextShowID%>" class="form-control" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="showDate">Date: </label>
                                    <input type="date" name="showDate" id="showDate" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="showTime">Time: </label>
                                    <input type="time" name="showTime" id="showTime" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="movieName">Movie: </label>
                                    <input type="text" name="movieName" id="movieName" value="" class="form-control" readonly>
                                    <input hidden name="movieID" id="movieID" value="" />
                                </div>

                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                <input type="submit" class="btn btn-success" value="SetShow">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>

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
    </div>
</body>
<script>
    $(document).on('click', '.setShow', function () {
        var movieID = $(this).data('id');
        var movieName = $(this).data('name');

        $('#setShowEmployeeModal input[name="movieID"]').val(movieID);
        $('#setShowEmployeeModal input[name="movieName"]').val(movieName);
    });

    $(document).on("click", ".delete", function () {
        var movieID = $(this).closest('.product-item').find('input[name="movieID"]').val();
        $("#deleteMovieID").val(movieID);
    });


    $(document).on('click', '.edit', function () {
        var movieID = $(this).data('id');
        var movieName = $(this).data('name');
        var duration = $(this).data('duration');
        var country = $(this).data('country');
        var manufacturer = $(this).data('manufacturer');
        var director = $(this).data('director');
        var rldate = $(this).data('rldate');
        var des = $(this).data('des');

        // Điền dữ liệu vào modal
        $('#editEmployeeModal input[name="movieID"]').val(movieID);
        $('#editEmployeeModal input[name="movieName"]').val(movieName);
        $('#editEmployeeModal input[name="duration"]').val(duration);
        $('#editEmployeeModal input[name="country"]').val(country);
        $('#editEmployeeModal input[name="manufacturer"]').val(manufacturer);
        $('#editEmployeeModal input[name="director"]').val(director);
        $('#editEmployeeModal input[name="rldate"]').val(rldate);
        $('#editEmployeeModal textarea[name="movieDes"]').val(des);
    });

    $(document).ready(function () {
        var message = '<%= request.getAttribute("message") != null ? request.getAttribute("message") : ""%>';
        if (message) {
            $('#messageModal').modal('show');
        }
    });
    if (window.location.href.includes("action=add")) {
        window.location.href = "crudMV.jsp";
    }

    if (window.location.href.includes("action=update")) {
        window.location.href = "crudMV.jsp";
    }

    if (window.location.href.includes("action=delete")) {
        window.location.href = "crudMV.jsp";
    }


</script>
</html>



