<%-- 
    Document   : Offers
    Created on : Sep 13, 2024, 8:04:02 PM
    Author     : DELL
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">   
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Cinema Offers Voucher</title>
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="css/uudai_homepage.css"/>
  <link rel="stylesheet" href="css/headerssj2.css"/>
</head>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) { %>
<%@include file="includes/header.jsp" %>
<% } else { %>
<%@include file="includes/header_user.jsp" %>
<% }%>
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

                        <div class="product-item-mini">
                            <div class="side-img" style="border: none;">
                                <a href=" ">
                                    <img class="" src="image/n1.jpg"  alt="Làm giàu với ma" >
                                </a>    
                            </div>
                            <div class="product-content">
                                <h2 class="product-title">
                                    <a href=" " title="Làm giàu với ma">
                                        Làm giàu với ma
                                    </a>
                                </h2>
                            </div>
                        </div>  
                        <div class="product-item-mini">
                            <div class="side-img" style="border: none;">
                                <a href=" ">
                                    <img class="" src="image/n2.jpg"  alt="Đẹp Trai Thấy Sai Sai" >
                                </a>    
                            </div>
                            <div class="product-content">
                                <h2 class="product-title">
                                    <a href=" " title="Đẹp Trai Thấy Sai Sai">
                                        Đẹp Trai Thấy Sai Sai
                                    </a>
                                </h2>
                            </div>
                        </div>
                        <div class="product-item-mini">
                            <div class="side-img" style="border: none;">
                                <a href=" ">
                                    <img class="" src="image/n4.jpg"  alt="Ma Da" >
                                </a>    
                            </div>
                            <div class="product-content">
                                <h2 class="product-title">
                                    <a href=" " title="Ma Da">
                                        Ma Da
                                    </a>
                                </h2>
                            </div>
                        </div>
                        <div class="product-item-mini">
                            <div class="side-img" style="border: none;">
                                <a href=" ">
                                    <img class="" src="image/n5.jpg"  alt="Hai Muối" >
                                </a>    
                            </div>
                            <div class="product-content">
                                <h2 class="product-title">
                                    <a href=" " title="Hai Muối">
                                        Hai Muối
                                    </a>
                                </h2>
                            </div>
                        </div>
                        <div class="product-item-mini">
                            <div class="side-img" style="border: none;">
                                <a href=" ">
                                    <img class="" src="image/n6.jpg"  alt="Nhật ký khủng long" >
                                </a>    
                            </div>
                            <div class="product-content">
                                <h2 class="product-title">
                                    <a href=" " title="Nhật ký khủng long">
                                        Nhật ký khủng long
                                    </a>
                                </h2>
                            </div>
                        </div>
     
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
                            <div class="text-left mb-4">
                                <h2 class="section-title px-5 bordered">
                                    <span class="px-2">Ưu Đãi</span></h2>
                            </div>
                            <div class="row px-xl-5 pb-3">
                                <div  class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                    <div class="card product-item border-0 mb-4">
                                        <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                            <img class="img-fluid w-100" src="image/o1.jpg" alt="">
                                            <div class="overlay"> <!-- Thêm overlay -->
                                                <div class="text">Điểm Tích Luỹ - Khám Phá Phim</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                    <div class="card product-item border-0 mb-4"> 
                                        <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                            <img class="img-fluid w-100" src="image/o12.jpg" alt="">
                                            <div class="overlay"> <!-- Thêm overlay -->
                                                <div class="text">Khuyến Mãi Vàng Xem Phim - Mua 1 tặng 1</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                    <div class="card product-item border-0 mb-4">
                                        <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                            <img class="img-fluid w-100" src="image/o9.jpg" alt="">
                                            <div class="overlay"> <!-- Thêm overlay -->
                                                <div class="text">Đêm Điện Ảnh Đặc Biệt - Members's Promotion</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                    <div class="card product-item border-0 mb-4">
                                        <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                            <img class="img-fluid w-100" src="image/o8.jpg" alt="">
                                            <div class="overlay"> <!-- Thêm overlay -->
                                                <div class="text">Mùa Hè Rực Rỡ Cùng Cặp vé FPT cinema</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                    <div class="card product-item border-0 mb-4">
                                        <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                            <img class="img-fluid w-100" src="image/o5.jpg" alt="">
                                            <div class="overlay"> <!-- Thêm overlay -->
                                                <div class="text">Combo Gia Đình - Xem Phim Thoải Mái</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                    <div class="card product-item border-0 mb-4">
                                        <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                             <a href="ProDetail.jsp">
                                            <img class="img-fluid w-100" src="image/o7.jpg" alt="">
                                            <div class="overlay"> <!-- Thêm overlay -->
                                                <div class="text">Đón Chào Năm Mới Với Ưu Đãi Đặc Biệt Chỉ 129K</div>
                                            </div>
                                             </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                    <div class="card product-item border-0 mb-4">
                                        <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                            <img class="img-fluid w-100" src="image/o10.jpg" alt="">
                                            <div class="overlay"> <!-- Thêm overlay -->
                                                <div class="text">Special voucher - Double click</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                    <div class="card product-item border-0 mb-4">
                                        <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                            <img class="img-fluid w-100" src="image/o11.jpg" alt="">
                                            <div class="overlay"> <!-- Thêm overlay -->
                                                <div class="text">Trọn Gói Cùng Người Thương  Đặc Quyền Cặp Đôi</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                    <div class="card product-item border-0 mb-4">
                                        <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                            <img class="img-fluid w-100" src="image/o15.jpg" alt="">
                                            <div class="overlay"> <!-- Thêm overlay -->
                                                <div class="text">Bom Tấn Kịch Tính - Đỉnh Nóc Kịch Trần</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
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


