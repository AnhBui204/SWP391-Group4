<%-- 
    Document   : ListMovie
    Created on : 29 Oct 2024, 7:53:15 pm
    Author     : HongD
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Movie"%>
<%@page import="java.util.List"%>
<%@page import="Model.MovieDB"%>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) { %>
<%@include file="includes/header.jsp" %>
<% } else { %>
<%@include file="includes/header_user.jsp" %>
<% }%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Movie List Page</title>
        <link rel="stylesheet" href="bs/css/bootstrap.css"/>
        <link rel="stylesheet" href="css/headerssj4.css"/>
        <link rel="stylesheet" href="css/bodyssj1.css" />
    </head>
    <body>
        <style>
            .box2-1 .skin {
                opacity: 0%;
                position: absolute;
                height: 100%;
                width: 100%;
                top: 0;
                background-color: rgba(0, 0, 0, 0.3);
                border-radius: 5%;
                border: solid #d5d5d5;
            }
            .box2-1 .skin p, input {
                width: 50%;
                margin: auto;
                margin-bottom: 20px;
                color: white;
                border: solid #f47f19;
                text-align: center;
                background-color: #f5821e;
                padding: 8px 15px;
                border-radius: 10px;
            }
            .box2-1 .skin .layer {
                width: 100%;
                position: absolute;
                top: 35%;
            }
            .box2-1 .skin:hover {
                opacity: 100%;
            }
            .box2-1 .skin p, input:hover {
                background-color: #ffa75a;
            }
            .skin{
                cursor: pointer;
            }
        </style>
        <%
            String genreS = (String) request.getAttribute("genre");
            String yearS = (String) request.getAttribute("year");

            List<Movie> mvList = new ArrayList<>();
            mvList = (List<Movie>) request.getAttribute("listMovie");
            if (mvList == null) {
                MovieDB movieDB = new MovieDB();
                mvList = movieDB.getAllMovies();
            }

        %>
        <div class="container my-5">
            <div class="mb-4">
                <div>
                    <h1>Danh sách phim</h1>
                </div>
                <div class="d-flex mt-3">
                    <div class="dropdown me-1">
                        <button class="btn btn-secondary dropdown-toggle fs-4 bg-white text-dark-emphasis px-4" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Thể loại
                        </button>
                        <ul class="dropdown-menu fs-5">
                            <li><a class="dropdown-item" href="MovieServlet?action=filtermovie<%if (yearS != null) {%>&year=<%=yearS%><%}%>" style="max-width: none;">Chọn thể loại</a></li>
                                <%
                                    List<String> gernesList = MovieDB.getGernesList();
                                    for (String genre : gernesList) {
                                %>
                            <li><a class="dropdown-item" href="MovieServlet?action=filtermovie&genre=<%=genre%><%if (yearS != null) {%>&year=<%=yearS%><%}%>" style="max-width: none;"><%=genre%></a></li>
                                <%
                                    }
                                %>
                            <!--                            <li><a class="dropdown-item" href="#">Action</a></li>
                                                        <li><a class="dropdown-item" href="#">Another action</a></li>
                                                        <li><a class="dropdown-item" href="#">Something else here</a></li>-->
                        </ul>
                    </div>
                    <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle fs-4 bg-white text-dark-emphasis px-4" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Năm
                        </button>
                        <ul class="dropdown-menu fs-5">
                            <li><a class="dropdown-item" href="MovieServlet?action=filtermovie<%if (genreS != null) {%>&genre=<%=genreS%><%}%>" style="max-width: none;">Chọn năm</a></li>
                                <%
                                    List<String> yearsList = MovieDB.getYearsList();
                                    for (String year : yearsList) {
                                %>
                            <li><a class="dropdown-item" href="MovieServlet?action=filtermovie&year=<%=year%><%if (genreS != null) {%>&genre=<%=genreS%><%}%>" style="max-width: none;"><%=year%></a></li>
                                <%
                                    }
                                %>
                            <!--                            <li><a class="dropdown-item" href="#">Action</a></li>
                                                        <li><a class="dropdown-item" href="#">Another action</a></li>
                                                        <li><a class="dropdown-item" href="#">Something else here</a></li>-->
                        </ul>
                    </div>
                    <div class="search-container">
                        <form action="MovieServlet?action=search" method="post">
                            <input type="text" placeholder="Tìm Kiếm..." name="search" required>
                            <input type="hidden" name="redirectPage" value="ListMovie.jsp" />
                            <button type="submit"><i class="fa fa-search"></i></button>
                        </form>
                    </div>

                </div>
            </div>
            <div class="row" id="box2_dangchieu_id">
                <%
                    int maxDisplay = 8;
                    for (int i = 0; i < mvList.size(); i++) {
                        Movie movie = mvList.get(i);
                        String hiddenClass = (i >= maxDisplay) ? "d-none" : ""; // Hide movies after the 8th one
%>
                <form action="MovieDetailServlet" method="post" class="col-md-3 col-6 mb-4 movie-box <%= hiddenClass%>">
                    <!-- col-md-3 for larger screens, col-6 for mobile -->
                    <div class="box2-1">
                        <!-- Thêm onclick vào lớp skin -->
                        <div class="skin" onclick="this.closest('form').submit();">
                            <div class="layer fs-4">
                                <p>Mua vé</p>
                                <p>Trailer</p>
                                <!-- Các trường hidden để gửi dữ liệu phim -->
                                <input type="text" name="MovieId" value="<%= movie.getMovieID()%>" hidden />
                                <input type="text" name="MovieName" value="<%= movie.getMovieName()%>" hidden />
                                <input type="text" name="Duration" value="<%= movie.getDuration()%>" hidden />
                                <input type="text" name="Country" value="<%= movie.getCountry()%>" hidden />
                                <input type="text" name="Manufacturer" value="<%= movie.getManufacturer()%>" hidden />
                                <input type="text" name="Director" value="<%= movie.getDirector()%>" hidden />
                                <input type="text" name="ReleaseDate" value="<%= movie.getReleaseDate()%>" hidden />
                                <input type="text" name="ImgP" value="<%= movie.getImgPortrait()%>" hidden />
                                <input type="text" name="ImgL" value="<%= movie.getImgLandscape()%>" hidden />
                            </div>
                        </div>
                        <!-- Hình ảnh phim -->
                        <img src="<%= movie.getImgPortrait()%>" alt="alt" class="img-fluid small-image" />
                        <!-- Thông tin đánh giá và độ tuổi -->
                        <div class="box3">
                            <div class="danhgia fs-4">
                                <p><i class="fas fa-star"></i> 8.0</p>
                            </div>
                            <div class="dotuoi fs-4">
                                <p>T16</p>
                            </div>
                        </div>
                    </div>
                </form>
                <%
                    }
                %>
            </div>
            <div class="text-center mt-2 mb-4">
                <button id="viewMoreBtn" class="btn btn-primary">Xem thêm</button>
                <button id="collapseBtn" class="btn btn-secondary d-none">Thu gọn</button> <!-- Collapse button initially hidden -->
            </div>
            <script>
                document.getElementById('viewMoreBtn').addEventListener('click', function () {
                    document.querySelectorAll('.movie-box.d-none').forEach(function (el) {
                        el.classList.remove('d-none'); // Show hidden movie boxes
                    });
                    this.style.display = 'none'; // Hide the 'View More' button
                    document.getElementById('collapseBtn').classList.remove('d-none'); // Show the collapse button
                });

                document.getElementById('collapseBtn').addEventListener('click', function () {
                    document.querySelectorAll('.movie-box').forEach(function (el, index) {
                        if (index >= 8) {
                            el.classList.add('d-none'); // Hide additional movie boxes
                        }
                    });
                    this.classList.add('d-none'); // Hide the collapse button
                    document.getElementById('viewMoreBtn').style.display = 'inline-block'; // Show the 'View More' button again
                });
            </script>
        </div>
        <script src="bs/js/bootstrap.bundle.js"></script>
    </body>
</html>
<%@include file="includes/footer.jsp" %>
<link rel="stylesheet" href="css/footerssj2.css" />