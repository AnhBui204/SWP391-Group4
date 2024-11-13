


<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="Model.MovieDB" %>
<%@page import="Model.Movie" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Galaxy Cinema</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
    <style>
            /* Đảm bảo hình ảnh swiper chiếm 100% chiều rộng */
            .swiper-slide img {
                border-radius: 10px;
                min-height: 355px;
                max-height: 355px;
            }
        </style>
    <body> 
        <div class="swiper mySwiper">
            <div class="swiper-wrapper">
                <% 
                    List<Movie> list = MovieDB.getAllMovies();
                    for(Movie movies : list){
                %>
                <div class="swiper-slide">
                    <img src="<%= movies.getImgPortrait() %>" alt="">
                </div>
                <%
                    }
                %>
            </div>
        </div>

            
        <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
        <script>
                    var swiper = new Swiper(".mySwiper", {
                        effect: "coverflow",
                        grabCursor: true,
                        centeredSlides: true,
                        slidesPerView: "auto",
                        coverflowEffect: {
                            rotate: 15,
                            stretch: 0,
                            depth: 300,
                            modifier: 1,
                            slideShadows: true,
                        },
                        loop: true,
                        autoplay: {
                            delay: 2000, // Transition every 3 seconds
                            disableOnInteraction: false, // Allow autoplay to continue after user interactions
                        },
                    });
        </script>



    </body>
</html>
