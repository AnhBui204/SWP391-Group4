<%@ page import="java.util.ArrayList"%>
<%@ page import="Model.Movie"%>
<%@ page import="java.util.List"%>
<%@ page import="Model.MovieDB"%>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
            .skin {
                cursor: pointer;
            }

            .search-bar {
                width: 100%;
                margin-bottom: 20px;
                position: relative;
            }

            .search-bar input {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
                padding: 6px 40px 12px 20px;
                font-size: 1rem;
                border-radius: 8px;
                border: 1px solid #ff5722;
                outline: none;
                background-color: #f9f9f9;
                color: black;
                transition: all 0.3s ease;
            }

            .search-bar input:focus {
                border-color: #ff5722;
                background-color: #ffffff;
                box-shadow: 0px 0px 5px rgba(255, 87, 34, 0.5);
            }

            .search-bar .icon-search {
                position: absolute;
                right: 15px;
                top: 30%;
                transform: translateY(-50%);
                font-size: 1.2rem;
                color: #ff5722;
            }

        </style>
        <%
            String genreS = (String) request.getAttribute("genre");
            String yearS = (String) request.getAttribute("year");

            
            List<Movie> mvList = MovieDB.getAllMovies();

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
                    <div class="search-bar">
                        <input type="text" id="searchInput" placeholder="Tìm kiếm phim...">
                        <span class="icon-search"><i class="fas fa-search"></i></span>
                    </div>
                </div>
            </div>
            <div class="row" id="box2_dangchieu_id">
                <%
                    for (Movie movie : mvList) {
                %>
                <form action="MovieDetailServlet" method="post" class="col-md-3 col-6 mb-4 movie-box" data-title="<%= movie.getMovieName().toLowerCase()%>">
                    <div class="box2-1">
                        <div class="skin" onclick="this.closest('form').submit();">
                            <div class="layer fs-4">
                                <p>Mua vé</p>
                                <p>Trailer</p>
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
                        <img src="<%= movie.getImgPortrait()%>" alt="alt" class="img-fluid small-image" />
                        <div class="box3">
                            <div class="danhgia fs-4">
                                <p><i class="fas fa-star"></i> <%=MovieDB.getAvgRate(movie.getMovieID())%></p>
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
            <div id="noResults" class="no-results">Không tìm thấy phim nào.</div>
            <script>
                // Tìm kiếm
                document.getElementById('searchInput').addEventListener('keyup', function () {
                    const searchValue = this.value.toLowerCase();
                    const movies = document.querySelectorAll('.movie-box');
                    let hasResult = false;

                    movies.forEach(movie => {
                        const title = movie.getAttribute('data-title');
                        if (title.includes(searchValue)) {
                            movie.classList.remove('d-none');
                            hasResult = true;
                        } else {
                            movie.classList.add('d-none');
                        }
                    });

                    document.getElementById('noResults').style.display = hasResult ? 'none' : 'block';
                });
            </script>
        </div>
        <script src="bs/js/bootstrap.bundle.js"></script>
    </body>
</html>
<%@include file="includes/footer.jsp" %>
<link rel="stylesheet" href="css/footerssj2.css" />
