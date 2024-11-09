<%@ page import="java.util.List" %>
<%@ page import="Model.Movie" %>
<%@ page import="Model.Voucher" %>
<%@ page import="Model.MovieDB" %>
<%@ page import="Model.VoucherDB" %>
<%@ page import="Model.Theatre" %>
<%@ page import="Model.TheatreDB" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) { %>
<%@include file="includes/header.jsp" %>
<% } else { %>
<%@include file="includes/header_user.jsp" %>
<% }

    // Lấy danh sách phim và rạp
    List<Movie> movies = MovieDB.getAllMovies();
    List<Voucher> vouchers;
    List<Theatre> theatres = TheatreDB.listAllTheatres();

    // Lấy giá trị selectedTheatreID từ request và thiết lập vouchers theo theatreID
    String selectedTheatreID = request.getParameter("theatreID");
    if (selectedTheatreID == null || selectedTheatreID.isEmpty()) {
        vouchers = VoucherDB.getAllVouchers(); // Lấy tất cả nếu theatreID trống
    } else {
        vouchers = VoucherDB.getAllVouchersByTheatreID(selectedTheatreID); // Lọc theo theatreID
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">   
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Cinema Offers Voucher</title>     
        <link rel="stylesheet" href="css/uudai_homepage.css"/>
        <link rel="stylesheet" href="bs/css/bootstrap.css"/>
        <link rel="stylesheet" href="css/headerssj4.css"/>
        <link rel="stylesheet" href="css/bodyssj1.css" />
    </head>
    <style>
        /* Đặt chung cho toàn trang */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
        }

        /* Phần tiêu đề ưu đãi */
        .section-title {
            color: #ff5722;
            font-weight: bold;
            font-size: 1.8rem;
        }

        /* Hiệu ứng card ưu đãi */
        .product-item {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .product-item:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }

        /* Hình ảnh ưu đãi */
        .product-img img {
            border-radius: 8px 8px 0 0;
            object-fit: cover;
        }

        /* Overlay trên ảnh */
        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.6);
            opacity: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: opacity 0.3s ease;
            color: white;
            font-size: 1rem;
            text-align: center;
        }

        .product-item:hover .overlay {
            opacity: 1;
        }

        /* Nội dung overlay */
        .overlay .text {
            padding: 0 15px;
            line-height: 1.5;
            font-weight: bold;
        }

        /* Sidebar - Phim đang chiếu */
        .widget-title {
            font-size: 1.4rem;
            font-weight: bold;
            color: #ff5722;
            margin-bottom: 1rem;
        }

        .product-item-mini {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            transition: transform 0.3s ease;
        }

        .product-item-mini:hover {
            transform: translateX(10px);
        }

        .product-item-mini img {
            width: 60px;
            height: auto;
            border-radius: 5px;
            margin-right: 10px;
        }

        .product-item-mini .product-title {
            font-size: 1rem;
            font-weight: bold;
        }

        /* Tạo responsive cho các card ưu đãi */
        @media (max-width: 768px) {
            .product-item {
                margin-bottom: 20px;
            }

            .product-title {
                font-size: 1.1rem;
            }
        }

        .img{
            min-height: 300px;
            max-height: 300px;
        }

        .section-title {
            font-size: 1.8rem;
            color: #ff5722;
            font-weight: bold;
        }

        .filter-theatre label {
            font-size: 1rem;
            margin-right: 8px;
            color: #333;
        }

        .filter-theatre select {
            font-size: 1rem;
            padding: 6px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

    </style>

    <body>        
        <!-- Navbar Start -->
        <div class="container-main">
            <div class="row">
                <!-- Thanh Slide Bar -->
                <div class="col-12 col-lg-3">
                    <div class="sidebar">
                        <div class="widget widget_collection d-none d-md-block">
                            <div class="widget-title bordered">
                                Phim Đang chiếu
                            </div>
                            <div class="widget_collection_list">
                                <% for (Movie movie : movies) {%>
                                <div class="product-item-mini">
                                    <div class="side-img" style="border: none;">
                                        <form action="MovieDetailServlet" method="post">
                                            <img class="" src="<%= movie.getImgPortrait()%>" alt="<%= movie.getMovieName()%>" style="cursor: pointer;" onclick="this.closest('form').submit();">
                                            <!-- Các trường ẩn để gửi thông tin phim -->
                                            <input type="hidden" name="MovieId" value="<%= movie.getMovieID()%>" />
                                            <input type="hidden" name="MovieName" value="<%= movie.getMovieName()%>" />
                                            <input type="hidden" name="Duration" value="<%= movie.getDuration()%>" />
                                            <input type="hidden" name="Country" value="<%= movie.getCountry()%>" />
                                            <input type="hidden" name="Manufacturer" value="<%= movie.getManufacturer()%>" />
                                            <input type="hidden" name="Director" value="<%= movie.getDirector()%>" />
                                            <input type="hidden" name="ReleaseDate" value="<%= movie.getReleaseDate()%>" />
                                            <input type="hidden" name="ImgP" value="<%= movie.getImgPortrait()%>" />
                                            <input type="hidden" name="ImgL" value="<%= movie.getImgLandscape()%>" />
                                        </form>    
                                    </div>
                                    <div class="product-content">
                                        <!-- Form chuyển tới trang chi tiết phim -->
                                        <form action="MovieDetailServlet" method="post">
                                            <!-- Tên phim, được sử dụng như một nút submit -->
                                            <button type="submit" class="product-title btn btn-link" style="text-decoration: none; color: inherit; cursor: pointer;">
                                                <%= movie.getMovieName()%>
                                            </button>
                                            <!-- Các trường ẩn để gửi thông tin phim -->
                                            <input type="hidden" name="MovieId" value="<%= movie.getMovieID()%>" />
                                            <input type="hidden" name="MovieName" value="<%= movie.getMovieName()%>" />
                                            <input type="hidden" name="Duration" value="<%= movie.getDuration()%>" />
                                            <input type="hidden" name="Country" value="<%= movie.getCountry()%>" />
                                            <input type="hidden" name="Manufacturer" value="<%= movie.getManufacturer()%>" />
                                            <input type="hidden" name="Director" value="<%= movie.getDirector()%>" />
                                            <input type="hidden" name="ReleaseDate" value="<%= movie.getReleaseDate()%>" />
                                            <input type="hidden" name="ImgP" value="<%= movie.getImgPortrait()%>" />
                                            <input type="hidden" name="ImgL" value="<%= movie.getImgLandscape()%>" />
                                        </form>
                                    </div>
                                </div>

                                <% }%>
                            </div>
                        </div>  
                    </div>
                </div>

                <div class="col-12 col-lg-9">
                    <div class="body-right">
                        <div class="container-fluid mb-5">
                            <div class="row border-top px-xl-5">
                                <div class="main-content">
                                    <!-- Products Start -->
                                    <div class="container-fluid pt-5">
                                        <div class="container-fluid pt-5">
                                            <div class="d-flex justify-content-between align-items-center mb-4">
                                                <h2 class="section-title px-5 bordered mr-auto">
                                                    <span class="px-2">Ưu Đãi</span>
                                                </h2>
                                                <!-- Dropdown lọc rạp -->
                                                <div class="filter-theatre d-flex align-items-center">
                                                    <label for="theatreSelect" class="mr-2">Lọc theo rạp:</label>
                                                    <form method="get" action="Offers.jsp" class="mb-0">
                                                        <select name="theatreID" id="theatreSelect" onchange="this.form.submit()" class="form-control">
                                                            <option value="">Tất cả rạp</option>
                                                            <% if (theatres != null) {
                                                                    for (Theatre theatre : theatres) {
                                                                        if (theatre != null) {%>
                                                            <option value=<%= theatre.getTheatreID()%> <%= selectedTheatreID != null && selectedTheatreID.equals(theatre.getTheatreID()) ? "selected" : ""%>>
                                                                <%= theatre.getTheatreName()%>
                                                            </option>
                                                            <% }
                                                                }
                                                            } else { %>
                                                            <option value="">Không có rạp nào khả dụng</option>
                                                            <% } %>
                                                        </select>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row px-xl-5 pb-3">
                                            <% for (Voucher voucher : vouchers) {%>
                                            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                                <div class="card product-item border-0 mb-4">
                                                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                                        <img class="img-fluid w-100 img" src="<%= voucher.getImgPath()%>" alt="<%= voucher.getVoucherName()%>">
                                                        <div class="overlay">
                                                            <div class="text"><%= voucher.getVoucherName()%></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <% }%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>    
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

<%@include file="includes/footer.jsp" %>
<link rel="stylesheet" href="css/footerssj2.css" />