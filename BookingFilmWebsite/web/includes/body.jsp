

<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Movie" %>
<%@ page import="Model.MovieDB" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Homepage</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="" rel="stylesheet">
    </head>
    <style>

        .box2-1 .skin{
            opacity: 0%;
            position: absolute;
            height: 100%;
            width: 100%;
            top: 0;
            background-color: rgba(0,0,0,0.3);
            border-radius: 5%;
            border: solid #d5d5d5;
        }

        .box2-1 .skin p,input{
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

        .box2-1 .skin .layer{
            width: 100%;
            position: absolute;
            top: 35%;
        }

        .box2-1 .skin:hover{
            opacity: 100%;
        }

        .box2-1 .skin p,input:hover{
            background-color: #ffa75a;
        }
    </style>
    <body>
        <div class="text-movie text-center mt-2 mb-2"> <!-- Center the title and add margin -->
            <h2>------- Phim Đang Chiếu -------</h2>
        </div>
        <div class="container">
            <div class="row" id="box2_dangchieu_id">
            <!--<form action="MovieDetailServlet" method="POST" class="row" id="box2_dangchieu_id">-->
                <%
                    MovieDB movieDB = new MovieDB();
                    List<Movie> mvList = movieDB.getAllMovies();
                    for (Movie movie : mvList) {
                %> 
                <div class="col-md-3 col-6 mb-4"> <!-- col-md-3 for larger screens, col-6 for mobile -->
                    <div class="box2-1">
                        <div class="skin">
                            <div class="layer fs-4">
                                <p>Mua vé</p>
                                <form action="MovieDetailServlet" method="post" class="d-flex justify-content-center">
                                <input type="text" name="MovieId" value="<%=movie.getMovieID()%>" hidden/>
                                <input type="text" name="MovieName" value="<%=movie.getMovieName()%>" hidden/>
                                <input type="text" name="Duration" value="<%=movie.getDuration()%>" hidden/>
                                <input type="text" name="Country" value="<%=movie.getCountry()%>" hidden/>
                                <input type="text" name="Manufacturer" value="<%=movie.getManufacturer()%>" hidden/>
                                <input type="text" name="Director" value="<%=movie.getDirector()%>" hidden/>
                                <!--<input type="text" name="MovieType" value="<%//=movie.getMovieType()%>" hidden/>-->
                                <input type="text" name="ReleaseDate" value="<%=movie.getReleaseDate()%>" hidden/>
                                <input type="text" name="ImgP" value="<%=movie.getImgPortrait()%>" hidden/>
                                <input type="text" name="ImgL" value="<%=movie.getImgLandscape()%>" hidden/>
                                <input type="text" name="Rate" value="<%//=movie.getRate()%>" hidden/>
                                
                                <input type="submit" value="Trailer"/>
                                <!--<p>Trailer</p>-->
                                </form>
                            </div>
                        </div>
                        <img src="<%= movie.getImgPortrait()%>" alt="alt" class="img-fluid small-image" />
                        <div class="box3">
                            <div class="danhgia fs-4">
                                <p><i class="fas fa-star"></i> 8.0</p>
                            </div>
                            <div class="dotuoi fs-4">
                                <p>T16</p>
                            </div>
                        </div>
                    </div> 
                </div>
                <%
                    }
                %>
<!--            </form>-->
            </div>
        </div>

        <style>
            /* Custom CSS for small images on mobile */
            @media (max-width: 576px) {
                .small-image {
                    width: 50%; /* Adjust this percentage as needed for smaller images */
                    height: auto; /* Maintain aspect ratio */
                }
            }
        </style>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="jvs.js"></script>
        <script>

            document.querySelectorAll('#box2_dangchieu_id').forEach(form => {
                form.addEventListener('click', function () {
                    this.submit();  // Gửi form khi người dùng nhấn vào
                });
            });
        </script>
    </body>



</html>



