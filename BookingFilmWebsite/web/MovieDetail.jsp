<div id="rate" class="d-flex justify-content-center align-items-center d-none">
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
<link rel="stylesheet" href="css/headers.css" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="bs/css/bootstrap.css"/>
        <link rel="stylesheet" href="css/MovieDetail_css.css"/>
    </head>
    <body>
        <div class="bg-black z-n1">
            <div class="container">
                <div id="background_page" class="position-absolute w-100 start-0 z-0">
                    <div id="poster_landscape">

                    </div>
                </div>

                <div id="group_1" class="z-1 position-relative">
                    <div id="main_info_area" class="row mt-3">
                        <div id="poster_portrait_1" class="col-3 p-0">
                            <img src="image/temp/temp2.jpg" alt="alt" class="img-fluid"/>
                        </div>
                        <div id="main_info" class="col-9 align-self-start py-5 mt-4" style="background-color: rgba(255,255,255,0.5);">
                            <h1 class="display-4 bg-secondary-subtle d-inline p-2 rounded">Chuyện Deadline</h1>
                            <div class="mt-3">
                                <div class="bg-secondary-subtle d-inline p-2 rounded">
                                    <div class="d-inline"><i class="fa-solid fa-clock d-inline"></i><p class="d-inline mx-1">120 phút</p></div>
                                    <div class="d-inline mx-2"><i class="fa-regular fa-calendar d-inline"></i><p class="d-inline mx-1">02/09/1975</p></div>
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
                                <div class="mt-2 bg-secondary-subtle d-inline fs-4 p-2 rounded"><p class="d-inline fs-4">Quốc gia: </p><p class="d-inline fs-4 fw-bold">Việt Nam</p></div>
                            </div>
                            <div class="mt-3">
                                <div class="mt-2 bg-secondary-subtle d-inline fs-4 p-2 rounded"><p class="d-inline fs-4">Nhà sản xuất: </p><p class="d-inline fs-4 fw-bold">anhbui's studio</p></div>
                            </div>
                            <div class="mt-3">
                                <div class="mt-2 bg-secondary-subtle d-inline fs-4 p-2 rounded"><p class="d-inline fs-4">Thể loại: </p><p class="d-inline fs-4 fw-bold">Haiya</p></div>
                            </div>
                            <div class="mt-3">
                                <div class="mt-2 bg-secondary-subtle d-inline fs-4 p-2 rounded"><p class="d-inline fs-4">Đạo diễn: </p><p class="d-inline fs-4 fw-bold">người 123</p></div>
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
                        <h1 class="display-5 pt-5 px-4">Lịch Chiếu</h1>
                    </div>
                    <div id="time_and_place" class="col-12 row mt-4">
                        <div class="col-1"></div>
                        <i class="fa-solid fa-arrow-left col-1 fa-4x border-end bg-white text-center pt-1" id="arrow_left_button" onclick="goLeft()"></i>
                        <div id="two_weeks" class="col-5 text-center bg-white pt-1">

                            <div class="each_day d-flex align-items-center flex-wrap border-end">
                                <h5 class="w-100 fs-3">Hôm Nay</h5>
                                <p class="w-100 m-0 fs-4">10/9</p>
                            </div>
                            <div class="each_day d-flex align-items-center flex-wrap border-end">
                                <h5 class="w-100 fs-3">Thứ 4</h5>
                                <p class="w-100 m-0 fs-4">11/9</p>
                            </div>
                            <div class="each_day d-flex align-items-center flex-wrap border-end">
                                <h5 class="w-100 fs-3">Thứ 5</h5>
                                <p class="w-100 m-0 fs-4">12/9</p>
                            </div>
                            <div class="each_day d-flex align-items-center flex-wrap border-end">
                                <h5 class="w-100 fs-3">Thứ 6</h5>
                                <p class="w-100 m-0 fs-4">13/9</p>
                            </div>
                            <div class="each_day d-flex align-items-center flex-wrap border-end">
                                <h5 class="w-100 fs-3">Thứ 7</h5>
                                <p class="w-100 m-0 fs-4">14/9</p>
                            </div>
                            <div class="each_day d-flex align-items-center flex-wrap border-end">
                                <h5 class="w-100 fs-3">Chủ Nhật</h5>
                                <p class="w-100 m-0 fs-4">15/9</p>
                            </div>
                            <div class="each_day d-flex align-items-center flex-wrap border-end">
                                <h5 class="w-100 fs-3">Thứ 2</h5>
                                <p class="w-100 m-0 fs-4">16/9</p>
                            </div>
                            <div class="each_day d-flex align-items-center flex-wrap border-end">
                                <h5 class="w-100 fs-3">Thứ 3</h5>
                                <p class="w-100 m-0 fs-4">17/9</p>
                            </div>
                            <div class="each_day d-flex align-items-center flex-wrap border-end">
                                <h5 class="w-100 fs-3">Thứ 4</h5>
                                <p class="w-100 m-0 fs-4">18/9</p>
                            </div>
                            <div class="each_day d-flex align-items-center flex-wrap border-end">
                                <h5 class="w-100 fs-3">Thứ 5</h5>
                                <p class="w-100 m-0 fs-4">19/9</p>
                            </div>
                            <div class="each_day d-flex align-items-center flex-wrap border-end">
                                <h5 class="w-100 fs-3">Thứ 6</h5>
                                <p class="w-100 m-0 fs-4">20/9</p>
                            </div>
                            <div class="each_day d-flex align-items-center flex-wrap border-end">
                                <h5 class="w-100 fs-3">Thứ 7</h5>
                                <p class="w-100 m-0 fs-4">21/9</p>
                            </div>
                            <div class="each_day d-flex align-items-center flex-wrap border-end">
                                <h5 class="w-100 fs-3">Chủ Nhật</h5>
                                <p class="w-100 m-0 fs-4">22/9</p>
                            </div>
                            <div class="each_day d-flex align-items-center flex-wrap border-end">
                                <h5 class="w-100 fs-3">Thứ 2</h5>
                                <p class="w-100 m-0 fs-4">23/9</p>
                            </div>
                        </div>
                        <i class="fa-solid fa-arrow-right col-1 fa-4x bg-white text-center pt-1" id="arrow_right_button" onclick="goRight()"></i>
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

                    <div id="table_and_poster" class="row">
                        <div class="col-1"></div>
                        <div class="day_time border-end col-1 bg-white">
                            <h3>07:00</h3>
                            <h3>10:00</h3>
                            <h3>13:00</h3>
                            <h3>16:00</h3>
                            <h3>19:00</h3>
                            <h3>22:00</h3>
                        </div>
                        <div id="day_time_table" class="col-5">

                            <div class="day border-end" id="day_time_id">
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                            </div>
                            <div class="day border-end">
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                            </div>
                            <div class="day border-end">
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                            </div>
                            <div class="day border-end">
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                            </div>
                            <div class="day border-end">
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                            </div>
                            <div class="day border-end">
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                            </div>
                            <div class="day border-end">
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                            </div>
                            <div class="day border-end">
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                            </div>
                            <div class="day border-end">
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                            </div>
                            <div class="day border-end">
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                            </div>
                            <div class="day border-end">
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                            </div>
                            <div class="day border-end">
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                            </div>
                            <div class="day border-end">
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                            </div>
                            <div class="day border-end">
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                                <i class="fa-solid fa-ticket fa-3x"></i>
                            </div>

                        </div>
                        <div class="col-1 bg-white"></div>
                        <div class="col-1"></div>
                        <div id="poster_portrait_2" class="col-2">
                            <img src="image/temp/temp2.jpg" alt="alt" class="img-fluid"/>
                        </div>
                        <div class="col-1"></div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            const element1 = document.getElementById("day_time_id");
            const width = element1.offsetWidth;
            const elements1 = document.getElementById("day_time_table");
            const elements2 = document.getElementById("two_weeks");

            function goRight() {

                elements1.scrollLeft += width;
                elements2.scrollLeft += width;
            }

            function goLeft() {

                elements1.scrollLeft -= width;
                elements2.scrollLeft -= width;

            }

            function mouseOverFunction(chung) {
                const chung_id = chung.id;
                let parts = chung_id.split(/(\d+)/);
                let id_number = parseInt(parts[1]);

                for (let i = id_number+1; i <= 5; i++) {
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
            
            function rate_movie(){
                rate_button.classList.remove("d-none");
            }
            
            function cancel_rate_movie(){
                rate_button.classList.add("d-none");
            }
        </script>
        <script src="bs/js/bootstrap.bundle.js"></script>
    </body>
</html>
<%@include file="includes/footer.jsp" %>
<link rel="stylesheet" href="css/footer.css" />