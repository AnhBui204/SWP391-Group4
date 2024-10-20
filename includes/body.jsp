

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

.box2-1 .skin p{
    width: 50%;
    margin: auto;
    margin-bottom: 20px;
    color: black;
    border: solid #f47f19;
    text-align: center;
    background-color: #eb7d5d;
    padding: 8px 15px;
}

.box2-1 .skin .layer{
    width: 100%;
    position: absolute;
    top: 35%;
}

.box2-1 .skin:hover{
    opacity: 100%;
}

.box2-1 .skin p:hover{
    background-color: #ffa75a;
}
    </style>
    <body>
        <div class="text-movie text-center mt-2 mb-2"> <!-- Center the title and add margin -->
            <h2>------- Phim Đang Chiếu -------</h2>
        </div>
        <div class="container">

            <div class="row" id="box2_dangchieu_id">
                <%
                    MovieDB movieDB = new MovieDB();
                    List<Movie> mvList = movieDB.getAllMovies();
                    for (Movie movie : mvList) {
                %> 
                <div class="col-md-3 col-6 mb-4"> <!-- col-md-3 for larger screens, col-6 for mobile -->
                    <div class="box2-1">
                        <div class="skin">
                            <div class="layer">
                                <p>Mua vé</p>
                                <p>Trailer</p>
                            </div>
                        </div>
                        <img src="<%= movie.getImgPortrait()%>" alt="alt" class="img-fluid small-image" />
                        <div class="box3">
                            <div class="danhgia">
                                <p><i class="fas fa-star"></i> 8.0</p>
                            </div>
                            <div class="dotuoi">
                                <p>T16</p>
                            </div>
                        </div>
                    </div> 
                </div>
                <%
                    }
                %>
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
            var glowbutton1 = document.getElementById('dangchieu_button');
            var glowbutton2 = document.getElementById('sapchieu_button');
            var glowbutton3 = document.getElementById('PhimIMAX_button');
            var hiddenElement1 = document.getElementById('box2_dangchieu_id');
            var hiddenElement2 = document.getElementById('box2_sapchieu_id');
            var hiddenElement3 = document.getElementById('box2_IMAX_id');

            document.getElementById('dangchieu_button').addEventListener('click', function () {
                glowbutton1.classList.add('glow');
                glowbutton2.classList.remove('glow');
                glowbutton3.classList.remove('glow');
                hiddenElement1.classList.remove('hidden');
                hiddenElement2.classList.add('hidden');
                hiddenElement3.classList.add('hidden');
            });

            document.getElementById('sapchieu_button').addEventListener('click', function () {
                glowbutton1.classList.remove('glow');
                glowbutton2.classList.add('glow');
                glowbutton3.classList.remove('glow');
                hiddenElement1.classList.add('hidden');
                hiddenElement2.classList.remove('hidden');
                hiddenElement3.classList.add('hidden');
            });

            document.getElementById('PhimIMAX_button').addEventListener('click', function () {
                glowbutton1.classList.remove('glow');
                glowbutton2.classList.remove('glow');
                glowbutton3.classList.add('glow');
                hiddenElement1.classList.add('hidden');
                hiddenElement2.classList.add('hidden');
                hiddenElement3.classList.remove('hidden');
            });
        </script>
    </body>



</html>




<!--            <div class="box1" style="">
                            <div class="title">
                                <h2>PHIM</h2>
                            </div>
                            <div class="danhsach">
                                <h5 id="dangchieu_button" class="glow">Đang chiếu</h5>
                                <h5 id="sapchieu_button">Sắp chiếu</h5>
                                <h5 id="PhimIMAX_button">Phim IMAX</h5>
                            </div>
            
                            <div class="location">
                                <p data-bs-toggle="popover" data-bs-placement="top" data-bs-trigger="hover focus" data-bs-content="Vị trí hiện tại ở Toàn quốc">Toàn quốc</p>
                            </div>
            
                        </div>-->