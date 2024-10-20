


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
        <link rel="stylesheet" href="../css/headerssj2.css"/>
    </head>
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


        <div class="booking-steps">
            <form action="book" method="post" onsubmit="return validateForm()">
                <div class="form-content">
                    <div class="select-container">
                        <div class="select-wrapper">
                            <label for="lang-select"></label>
                            <select name="lang" id="lang-select" onchange="checkSelection()">
                                <option value="" hidden>Chọn phim</option>
                                <option value="CGV">CGV</option>
                                <option value="Galaxy">Galaxy</option>
                                <option value="FPT">FPT</option>
                                <option value="HDD">HDD</option>
                                <option value="YT">HelloYoutube</option>
                                <option value="Ok">Ok</option>
                            </select>
                            <span class="error-message" id="lang-error"></span>
                        </div>

                        <div class="select-wrapper">
                            <label for="cinema-select"></label>
                            <select name="cinema" id="cinema-select" disabled onchange="checkSelection()">
                                <option value="" disabled selected hidden>Chọn rạp</option>
                                <option value="cg">CGV</option>
                                <option value="gx">Galaxy</option>
                                <option value="fp">FPT</option>
                                <option value="hd">HDD</option>
                                <option value="yt">HelloYoutube</option>
                                <option value="ok">Ok</option>
                            </select>
                            <span class="error-message" id="cinema-error"></span>
                        </div>

                        <div class="select-wrapper">
                            <label for="date-select"></label>
                            <select name="date" id="date-select" disabled onchange="checkSelection()">
                                <option value="" disabled selected hidden>Chọn ngày</option>
                                <option value="2024-09-10">10/09/2024</option>
                                <option value="2024-09-11">11/09/2024</option>
                                <option value="2024-09-12">12/09/2024</option>
                            </select>
                            <span class="error-message" id="date-error"></span>
                        </div>

                        <div class="select-wrapper">
                            <label for="time-select"></label>
                            <select name="time" id="time-select" disabled onchange="checkSelection()">
                                <option value="" disabled selected hidden>Chọn suất</option>
                                <option value="morning">Sáng</option>
                                <option value="afternoon">Chiều</option>
                                <option value="evening">Tối</option>
                            </select>
                            <span class="error-message" id="time-error"></span>
                        </div>
                    </div>

                    <div class="quick-booking">
                        <button type="submit" id="submit-button" value="submit" >Mua vé nhanh</button>
                        <label id="result"></label>
                    </div>
                </div>
            </form>
        </div>

        <script>
            function checkSelection() {
                const langSelect = document.getElementById("lang-select");
                const cinemaSelect = document.getElementById("cinema-select");
                const dateSelect = document.getElementById("date-select");
                const timeSelect = document.getElementById("time-select");
                const submitButton = document.getElementById("submit-button");

                cinemaSelect.disabled = !langSelect.value;
                dateSelect.disabled = !cinemaSelect.value;
                timeSelect.disabled = !dateSelect.value;


            }

            function validateForm() {
                const langSelect = document.getElementById("lang-select");
                const cinemaSelect = document.getElementById("cinema-select");
                const dateSelect = document.getElementById("date-select");
                const timeSelect = document.getElementById("time-select");
                const resultLabel = document.getElementById("result");


                document.querySelectorAll('.select-wrapper').forEach(wrapper => wrapper.classList.remove('invalid'));

                let valid = true;

                if (!langSelect.value) {
                    langSelect.parentElement.classList.add('invalid');
                    valid = false;
                }
                if (!cinemaSelect.value) {
                    cinemaSelect.parentElement.classList.add('invalid');
                    valid = false;
                }
                if (!dateSelect.value) {
                    dateSelect.parentElement.classList.add('invalid');
                    valid = false;
                }
                if (!timeSelect.value) {
                    timeSelect.parentElement.classList.add('invalid');
                    valid = false;
                }

                resultLabel.innerHTML = valid ? "" : "Vui lòng hoàn tất các lựa chọn.";
                return valid;
            }

            document.addEventListener('DOMContentLoaded', checkSelection);

        </script> 
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
