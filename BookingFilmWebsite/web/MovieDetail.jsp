<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="Model.ShowDB"%>
<%@page import="java.util.List"%>
<%@ page import="Model.MovieDB" %>
<%
    String movieId = (String) request.getAttribute("movieId");
    HashMap<String, HashMap<String, List<String>>> hmDay = MovieDB.getTimelineDB(movieId);
    List<String> dayArr = new ArrayList<>();
    if (!hmDay.isEmpty()) {
        for (String day : hmDay.keySet()) {
            dayArr.add(day);
        }
    }
    String showIdTable = "";
%>
﻿<div id="rate" class="d-flex justify-content-center align-items-center d-none">
    <div id="rate_box" class="bg-white text-center rounded">
        <div class="d-flex justify-content-end" style="padding-top: 3.5rem">
            <button type="button" class="btn-close" aria-label="Close" style="margin-bottom: 1rem;" onclick="cancel_rate_movie(this)"></button>
        </div>
        <h2 class="display-4">Đánh giá</h2>
        <div class="position-relative mt-4">
            <i class="fa-solid fa-star text-warning fa-7x"></i>
            <div id="ratio">
                <h1 class="m-0 text-white">8.0</h1>
            </div>
        </div>
        <div class=" mt-4">
            <i id="star1" class="fa-regular fa-star text-warning fa-3x" onmouseover="mouseOverFunction(this)"></i>
            <i id="star2" class="fa-regular fa-star text-warning fa-3x" onmouseover="mouseOverFunction(this)"></i>
            <i id="star3" class="fa-regular fa-star text-warning fa-3x" onmouseover="mouseOverFunction(this)"></i>
            <i id="star4" class="fa-regular fa-star text-warning fa-3x" onmouseover="mouseOverFunction(this)"></i>
            <i id="star5" class="fa-regular fa-star text-warning fa-3x" onmouseover="mouseOverFunction(this)"></i>
        </div>
        <p class=" mt-2 text-grey">1234 votes</p>
    </div>
</div>
<%@include file="includes/header.jsp" %>
<link rel="stylesheet" href="css/headerssj1.css" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css"/>
        <link rel="stylesheet" href="css/MovieDetail_css.css"/>
    </head>
    <style>
        #poster_landscape img {
            width: 1513px;  
            height: 738px; 
            object-fit: cover; 
            filter: brightness(50%);
        }
    </style>
    <body>
        <div class="bg-black z-n1">
            <div class="container">
                <div id="background_page" class="position-absolute w-100 start-0 z-0">
                    <div id="poster_landscape">
                        <img src="<%=request.getAttribute("imgL")%>" alt="alt" class="img-fluid"/>
                    </div>
                </div>

                <div id="group_1" class="z-1 position-relative">
                    <div id="main_info_area" class="row mt-3">
                        <div id="poster_portrait_1" class="col-3 p-0">
                            <img src="<%=request.getAttribute("imgP")%>" alt="alt" class="img-fluid"/>
                        </div>
                        <div id="main_info" class="col-9 align-self-start py-5 mt-4" style="background-color: rgba(255,255,255,0.5);">
                            <h1 class="display-4 bg-secondary-subtle d-inline p-2 rounded"><%=request.getAttribute("movieName")%></h1>
                            <div class="mt-3">
                                <div class="bg-secondary-subtle d-inline p-2 rounded">
                                    <div class="d-inline"><i class="fa-solid fa-clock d-inline"></i><p class="d-inline mx-1"><%=request.getAttribute("duration")%> phút</p></div>
                                    <div class="d-inline mx-2"><i class="fa-regular fa-calendar d-inline"></i><p class="d-inline mx-1"><%=request.getAttribute("releaseDate")%></p></div>
                                </div>
                            </div>
                            <div class="mt-2">
                                <div class="bg-secondary-subtle d-inline fs-1 p-1 rounded" id="rate_button">
                                    <i class="fa-solid fa-star text-warning fa-1x d-inline"></i>
                                    <h3 class="d-inline fs-1" onclick="rate_movie()">8.0</h3>
                                </div>
                                <p class="d-inline mx-2 h5">(1234 votes)</p>
                            </div>
                            <div class="mt-2">
                                <div class="mt-2 bg-secondary-subtle d-inline fs-4 p-2 rounded"><p class="d-inline fs-4">Quốc gia: </p><p class="d-inline fs-4 fw-bold"><%= request.getAttribute("country")%></p></div>
                            </div>
                            <div class="mt-3">
                                <div class="mt-2 bg-secondary-subtle d-inline fs-4 p-2 rounded"><p class="d-inline fs-4">Nhà sản xuất: </p><p class="d-inline fs-4 fw-bold"><%= request.getAttribute("manufacturer")%></p></div>
                            </div>
                            <div class="mt-3">
                                <div class="mt-2 bg-secondary-subtle d-inline fs-4 p-2 rounded"><p class="d-inline fs-4">Thể loại: </p><%
                                    String Id = (String) request.getAttribute("movieId");
                                    for (String genre : MovieDB.getMovieGenre(Id)) {
                                    %>
                                    <p class="d-inline fs-4 fw-bold"><%=genre%>, </p>
                                    <%
                                        }

                                    %></div>
                            </div>
                            <div class="mt-3">
                                <div class="mt-2 bg-secondary-subtle d-inline fs-4 p-2 rounded"><p class="d-inline fs-4">Đạo diễn: </p><p class="d-inline fs-4 fw-bold"><%= request.getAttribute("director")%></p></div>
                            </div>
                            <div class="mt-3">
                                <div class="mt-2 bg-secondary-subtle d-inline fs-4 p-2 rounded"><p class="d-inline fs-4">Diễn viên: </p><p class="d-inline fs-4 fw-bold">người 1, người 2, người 3</p></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="movie_introduction" class="row z-1 position-relative" style="background-color: rgba(255,255,255,0.5); margin-top: 250px;">
                    <h1 class="col-12 display-5 pt-5 px-4">Giới Thiệu Phim</h1>
                    <p class="col-12 fs-4 fw-medium px-5 pb-4">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed a venenatis nulla. Nullam malesuada dignissim augue, at lobortis urna fermentum sed. Sed a facilisis leo. Aliquam dapibus augue sem, sed finibus nisi elementum non. Aliquam sollicitudin tincidunt odio eget ornare. Aenean non ornare dolor. Mauris non lorem vitae erat rhoncus ullamcorper eget fermentum leo. Vivamus bibendum tellus sit amet velit gravida, ut pharetra tellus aliquet. Nunc ac nisi et turpis consequat tempor.</p>
                </div>

                <div id="movie_schedule" class="row mt-5 mb-5 pb-5" style="background-color: rgba(255,255,255,0.5);">
                    <div id="movie_schedule_title" class="col-12">
                        <h1 class="display-5 pt-5 px-4 text-white">Lịch Chiếu</h1>
                    </div>
                    <div id="time_and_place" class="col-12 row mt-4">
                        <div class="col-1"></div>

                        <div id="two_weeks" class="col-7 text-center d-flex p-0">
                            <%
                                for (String day : dayArr) {
                            %>
                            <div id="D_<%=day%>" class="each_day d-flex align-items-center flex-wrap border-end bg-white mx-2 p-0 rounded" onclick="show_table('time_schedule_<%=day%>', this)">
                                <!--<h5 class="w-100 fs-3">Thứ 4</h5>-->
                                <p class="w-100 m-0 fs-4 px-4"><%=day%></p>
                            </div>
                            <%
                                }
                            %>
                        </div>

                        <div class="col-1"></div>
                        <div id="district" class="col-2 fs-4 fw-bold">
                            <select style="width: 100%;">
                                <option>Quận Cẩm Lệ</option>
                                <option>Quận Hải Châu</option>
                                <option>Huyện Hòa Vang</option>
                                <option>Huyện Hoàng Sa</option>
                                <option>Quận Liên Chiểu</option>
                                <option>Quận Ngũ Hành Sơn</option>
                                <option>Quận Sơn Trà</option>
                                <option>Quận Thanh Khê</option>
                            </select>
                        </div>
                        <div class="col-1"></div>
                    </div>

                    <div id="table_and_poster" class="row mt-5">
                        <div class="col-1"></div>
                        <%
                            for (String day : dayArr) {
                                HashMap<String, List<String>> hmTheatre = hmDay.get(day);
                                List<String> theatreArr = new ArrayList<>();
                                for (String str : hmTheatre.keySet()) {
                                    theatreArr.add(str);
                                }
                        %>
                        <div id="time_schedule_<%=day%>" class="col-7 bg-white d-none" style="height: 300px;overflow: scroll;">
                            <%
                                for (String theatre : theatreArr) {
                            %>
                            <div class="theater row my-4" id="<%=theatre%>">
                                <div class="col-4 p-0 d-flex justify-content-center">
                                    <h1 class="fs-3 m-0 align-self-center"><%=theatre%></h1>
                                </div>

                                <div class="col-8 d-flex align-items-center p-0">
                                    <div style="width: 1px; height: 100%; background-color: #dee2e6; padding: 0;"></div>
                                    <%
                                        List<String> hourArr = hmTheatre.get(theatre);
                                        for (String hour : hourArr) {
                                    %>
                                    <div class="mx-3 border rounded p-2 session fs-5" id="<%=hour%>">
                                        <p class="m-0"><%=hour%></p>
                                    </div>
                                    <%
                                        }
                                    %>
                                    <!--
                                    <div class="mx-3 border rounded p-2 session">
                                        <p class="m-0">14:00 - 16:10</p>
                                    </div>
                                    <div class="mx-3 border rounded p-2 session">
                                        <p class="m-0">20:00 - 22:10</p>
                                    </div>
                                    -->
                                </div>
                            </div>
                            <%
                                }
                            %>
                            <!--                            <div class="theater row my-4">
                                                            <div class="col-2 p-0 d-flex justify-content-center">
                                                                <h1 class="fs-3 m-0 align-self-center">Rạp số 1</h1>
                                                            </div>
                            
                                                            <div class="col-10 d-flex align-items-center p-0">
                                                                <div style="width: 1px; height: 100%; background-color: #dee2e6; padding: 0;"></div>
                                                                <div class="mx-3 border rounded p-2 session">
                                                                    <p class="m-0">14:00 - 16:10</p>
                                                                </div>
                                                                <div class="mx-3 border rounded p-2 session">
                                                                    <p class="m-0">20:00 - 22:10</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="theater row my-4">
                                                            <div class="col-2 p-0 d-flex justify-content-center">
                                                                <h1 class="fs-3 m-0 align-self-center"">Rạp số 2</h1>
                                                            </div>
                            
                                                            <div class="col-10 d-flex align-items-center p-0">
                                                                <div style="width: 1px; height: 100%; background-color: #dee2e6; padding: 0;"></div>
                                                                <div class="mx-3 border rounded p-2 session">
                                                                    <p class="m-0">14:00 - 16:10</p>
                                                                </div>
                                                                <div class="mx-3 border rounded p-2 session">
                                                                    <p class="m-0">20:00 - 22:10</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="theater row my-4">
                                                            <div class="col-2 p-0 d-flex justify-content-center">
                                                                <h1 class="fs-3 m-0 align-self-center">Rạp số 3</h1>
                                                            </div>
                            
                                                            <div class="col-10 d-flex align-items-center p-0">
                                                                <div style="width: 1px; height: 100%; background-color: #dee2e6; padding: 0;"></div>
                                                                <div class="mx-3 border rounded p-2 session">
                                                                    <p class="m-0">14:00 - 16:10</p>
                                                                </div>
                                                                <div class="mx-3 border rounded p-2 session">
                                                                    <p class="m-0">20:00 - 22:10</p>
                                                                </div>
                                                            </div>
                                                        </div>-->
                        </div>
                        <%
                            }
                        %>
                        <div class="col-1"></div>
                        <div id="poster_portrait_2" class="col-2">
                            <img src="${param.ImgP}" alt="alt" class="img-fluid"/>
                        </div>
                        <div class="col-1"></div>
                    </div>
                </div>
            </div>
        </div>
        <script>

            function mouseOverFunction(chung) {
                const chung_id = chung.id;
                let parts = chung_id.split(/(\d+)/);
                let id_number = parseInt(parts[1]);

                for (let i = id_number + 1; i <= 5; i++) {
                    let temp_id = "star" + i;
                    const the_star = document.getElementById(temp_id);
                    if (the_star.classList.contains("fa-solid")) {
                        the_star.classList.remove("fa-solid");
                        the_star.classList.add("fa-regular");
                    }

                }

                for (let i = id_number; i >= 0; i--) {
                    let temp_id = "star" + i;
                    const the_star = document.getElementById(temp_id);

                    if (the_star.classList.contains("fa-regular")) {
                        the_star.classList.remove("fa-regular");
                        the_star.classList.add("fa-solid");
                    }

                }

            }

            const rate_button = document.getElementById("rate");

            function rate_movie() {
                rate_button.classList.remove("d-none");
            }

            function cancel_rate_movie() {
                rate_button.classList.add("d-none");
            }

            let showIdTableJs; // table xuat hien hien tai
            let dayPass;

            document.addEventListener("DOMContentLoaded", function () {
            <%showIdTable = "time_schedule_" + dayArr.get(0);%>
                let showId = 'D_<%=dayArr.get(0)%>';
                const timeScheduleTablefirstD = document.getElementById(showId);
                const timeScheduleTablefirst = document.getElementById("time_schedule_<%=dayArr.get(0)%>");
                timeScheduleTablefirst.classList.remove("d-none");
                timeScheduleTablefirstD.classList.add("border");
                timeScheduleTablefirstD.classList.add("border-warning");
                showIdTableJs = '<%=showIdTable%>';
            });

            function show_table(id_table, chung) {
                if (id_table === showIdTableJs) {
                    return;
                }
                chung.classList.add("border");
                chung.classList.add("border-warning");
                const timeScheduleTable = document.getElementById(id_table); // table se xuat hien
                const timeScheduleTableShow = document.getElementById(showIdTableJs); //table xuat hien
                timeScheduleTable.classList.remove("d-none");
                timeScheduleTableShow.classList.add("d-none");
                showIdTableJs = id_table;
                dayPass = chung;
            }

        </script>
        <script src="bootstrap/js/bootstrap.bundle.js"></script>
    </body>
</html>
<%@include file="includes/footer.jsp" %>
<link rel="stylesheet" href="css/footer.css" />