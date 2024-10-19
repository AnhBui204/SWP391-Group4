
<%@page import="Model.Theatre"%>
<%@page import="Model.Voucher"%>
<%@page import="java.util.List"%>
<%@page import="Model.VoucherDB"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/Style_Promotion.css"/>
    </head>
    <body>        
        <!-- Navbar Start -->
        <div class="container-fluid">
            <div class="container-main row">
                <!-- Sidebar -->
                <div class="col-12 col-lg-3" style="padding-left: 0px ;padding-right: 0px; ">
                    <div class="sidebar" style="height: 190vh;" >
                        <div class="widget widget_collection">
                            <div class="widget-title text-center">
                                CINELUXE
                            </div>
                            <div class="widget_collection_list text-center">
                                <div class="staff-info text-left">
                                    <div class="staff-card d-flex align-items-center justify-content-between p-2" style="background-color: #a8344d; border-radius: 10px; color: white;">
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-user-alt" style="font-size: 24px; margin-right: 10px;"></i>
                                            <div class="staff-details">
                                                <c:if test="${not empty users}">
                                                    <h6 style="margin: 0;">Staff</h6>
                                                    <span class="staff-name" style="font-size: 18px;">
                                                        <span>${users.lName}</span> <span>${users.fName}</span>
                                                    </span>
                                                </c:if>
                                                <c:if test="${empty users}">
                                                    <p>No user information available.</p>
                                                </c:if>
                                            </div>
                                        </div>
                                        <form action="UserServlet?action=logout" method="POST">
                                            <button class="btn btn-link p-0" style="color: white;">
                                                <i class="fas fa-sign-out-alt" style="font-size: 24px;"></i>
                                            </button>
                                        </form>
                                    </div>
                                </div>

                                <div class="menu-items">
                                    <h5><button onclick="location.href = 'crudMV.jsp'">Phim<span class="icon">&#128253;</span></button></h5>    
                                    <h5><button onclick="location.href = 'crudFD.jsp'">Đồ Ăn Nước Uống<span class="icon">&#127871;</span></button></h5>
                                    <h5><button onclick="location.href = 'Offers.jsp'">Thẻ Ưu Đãi<span class="icon">&#127991;</span></button></h5>
                                    <form action="MovieServlet?action=mvList" method="Post">
                                        <h5 style="text-decoration: none">
                                            <button type="submit" class="btn btn-link">
                                                Quản lý lịch chiếu<span class="icon">&#128337;</span>
                                            </button>
                                        </h5>
                                    </form>
                                    <h5><button onclick="location.href = 'ViewWorkHistory.jsp'">Lịch sử hoạt động<span class="icon">&#128221;</span></button></h5> 

                                </div>
                            </div>
                        </div>
                    </div>
                </div>



                <div class="col-12 col-lg-9 " style="padding-left: 0px ;padding-right: 0px; background-color: #f7cf90; " >
                    <div class="body-right" style="height: 150vh;">

                        <div class="container-fluid mb-5">
                            <div class="row border-top px-xl-5">
                                <div class="main-content">
                                    <!-- Products Start -->
                                    <div class="container-fluid pt-5">
                                        <div class="d-flex justify-content-between align-items-center mb-4">
                                            <h2 class="section-title px-5 bordered text-left">
                                                <span class="px-2">Ưu Đãi</span>
                                            </h2>
                                            <h2 class="section-title px-5 bordered">
                                                <span class="px-2">Rạp ${theatre.theatreName}</span>
                                            </h2>
                                            <div class="btn-group text-left">
                                                <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal">
                                                    <i class="material-icons">&#xE147;</i> <span>Thêm Voucher mới</span>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Tính toán phân trang -->
                                        <%
                                            int mvPage = 1; // Trang hiện tại
                                            int vouchersPerPage = 8; // Số voucher mỗi trang
                                            if (request.getParameter("mvPage") != null) {
                                                mvPage = Integer.parseInt(request.getParameter("mvPage"));
                                            }

                                            Theatre theatre = (Theatre) session.getAttribute("theatre");
                                            VoucherDB voucherDB = new VoucherDB();
                                            List<Voucher> listVC = voucherDB.getVouchersByPage(theatre.getTheatreID(), mvPage, vouchersPerPage); // Lấy danh sách voucher theo trang
                                            int totalVouchers = voucherDB.getTotalVouchersByTheatre(theatre.getTheatreID()); // Tổng số voucher
                                            int totalPages = (int) Math.ceil(totalVouchers / (double) vouchersPerPage); // Tính tổng số trang
%>

                                        <!-- Phân trang và thanh tìm kiếm -->
                                        <div class="pagination-container d-flex justify-content-between align-items-center mb-4">
                                            <nav aria-label="Page navigation">
                                                <ul class="pagination">
                                                    <li class="page-item <%= (mvPage == 1) ? "disabled" : ""%>">
                                                        <a class="page-link" href="?mvPage=<%= mvPage - 1%>" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                    <% for (int i = 1; i <= totalPages; i++) {%>
                                                    <li class="page-item <%= (i == mvPage) ? "active" : ""%>">
                                                        <a class="page-link" href="?mvPage=<%= i%>"><%= i%></a>
                                                    </li>
                                                    <% }%>
                                                    <li class="page-item <%= (mvPage == totalPages) ? "disabled" : ""%>">
                                                        <a class="page-link" href="?mvPage=<%= mvPage + 1%>" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>

                                            <!-- Search Bar -->
                                            <div class="search-container">
                                                <form action="/search_voucher" method="GET">
                                                    <input type="text" placeholder="Tìm Kiếm..." name="search">
                                                    <button type="submit"><i class="fa fa-search"></i></button>
                                                </form>
                                            </div>
                                        </div>

                                        <!-- Danh sách Voucher -->
                                        <div class="row px-xl-5 pb-3">
                                            <%
                                                for (Voucher voucher : listVC) {
                                            %>
                                            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                                <div class="card product-item border-0 mb-4">
                                                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                                        <img class="img-fluid w-100" src="<%= voucher.getImgPath()%>" alt="">
                                                        <div class="overlay"> <!-- Thêm overlay -->
                                                            <div class="text"><%= voucher.getVoucherName()%></div>
                                                            <div class="icon-actions"> <!-- Action icons -->
                                                                <a href="#editEmployeeModal" 
                                                                   class="edit" 
                                                                   data-toggle="modal"
                                                                   data-id="<%= voucher.getVoucherID()%>" 
                                                                   data-name="<%= voucher.getVoucherName()%>" 
                                                                   data-price="<%= voucher.getPrice()%>" 
                                                                   data-expirydate="<%= voucher.getExpiryDate()%>">
                                                                    <i class="material-icons" data-toggle="tooltip" title="Update" style="background-color: green;">&#xE254;</i></a>
                                                                <a href="#deleteEmployeeModal" 
                                                                   class="delete" 
                                                                   data-toggle="modal"
                                                                   data-id="<%= voucher.getVoucherID()%>">
                                                                    <i class="material-icons" data-toggle="tooltip" title="Delete" style="background-color: red;">&#xE872;</i>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <% }
                                                String nextID = voucherDB.getNextVoucherID();%>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>    
                    </div>
                </div>
            </div>

            <!--             Add Modal HTML -->
            <div id="addEmployeeModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="VoucherServlet?action=add" method="POST" enctype="multipart/form-data">
                            <div class="modal-header">						
                                <h4 class="modal-title">Thêm Voucher mới</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">					
                                <div class="form-group">
                                    <label for="voucherID">Voucher ID</label>
                                    <input type="text" class="form-control" value="<%= nextID%>" name="voucherID" id="voucherID" readonly>
                                    <input hidden type="text" value="${theatre.theatreID}" name="theatreID" />
                                </div>
                                <div class="form-group">
                                    <label for="voucherName">Name</label>
                                    <input type="text" name="voucherName" id="voucherName" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Price</label>
                                    <input type="text" name="price" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="expiryDate">Expiry Date</label>
                                    <input type="date" name="expiryDate" id="expiryDate" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="voucherImage">
                                        <i class="fa fa-file-image-o" aria-hidden="true" style="margin-right: 5px;"></i>Image:
                                    </label>
                                    <input type="file" id="voucherImage" name="voucherImage" style="padding: 5px; margin-bottom: 10px; border-radius: 5px; border: none; box-shadow: 0 0 5px gray;">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                <input type="submit" class="btn btn-success" value="Add">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!--             Edit Modal HTML -->
            <div id="editEmployeeModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="VoucherServlet?action=update" method="POST" enctype="multipart/form-data">
                            <div class="modal-header">						
                                <h4 class="modal-title">Cập Nhật Voucher</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">					
                                <div class="form-group">
                                    <label for="voucherID">Voucher ID</label>
                                    <input type="text" name="voucherID" id="voucherID" value="" class="form-control" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="voucherName">Name</label>
                                    <input type="text" name="voucherName" id="voucherName" value="" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="price">Price</label>
                                    <input type="text" name="price" id="price" value="" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="expiryDate">Expiry Date</label>
                                    <input type="date" name="expiryDate" id="expiryDate" value="" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="voucherImage">
                                        <i class="fa fa-file-image-o" aria-hidden="true" style="margin-right: 5px;"></i> Image:
                                    </label>
                                    <input type="file" id="voucherImage" name="voucherImage" style="padding: 5px; margin-bottom: 10px; border-radius: 5px; border: none; box-shadow: 0 0 5px gray;">
                                    <!-- Optionally display the existing image -->
                                    <img src="${voucher.image}" alt="Voucher Image" style="width:100px; margin-top:5px;">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                <input type="submit" class="btn btn-info" value="Update">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!--             Delete Modal HTML -->
            <div id="deleteEmployeeModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="VoucherServlet?action=delete" method="post">
                            <div class="modal-header">						
                                <h4 class="modal-title">Xóa Voucher</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">					
                                <p>Bạn có chắc chắn muốn xóa Voucher này không?</p>
                                <input type="hidden" name="voucherID" id="deleteVoucherID" value="">
                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                <input type="submit" class="btn btn-danger" value="Delete">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <script>
                // Edit Voucher
                $(document).on('click', '.edit', function () {
                    var voucherID = $(this).data('id');
                    var voucherName = $(this).data('name');
                    var price = $(this).data('price');
                    var expiryDate = $(this).data('expirydate');

                    // Fill data into the edit modal
                    $('#editEmployeeModal input[name="voucherID"]').val(voucherID);
                    $('#editEmployeeModal input[name="voucherName"]').val(voucherName);
                    $('#editEmployeeModal input[name="price"]').val(price);
                    $('#editEmployeeModal input[name="expiryDate"]').val(expiryDate);
                });

                // Delete Voucher
                $(document).on('click', '.delete', function () {
                    var voucherID = $(this).data('id');
                    $("#deleteVoucherID").val(voucherID);
                });

                $(document).ready(function () {
                    var message = '<%= request.getAttribute("message") != null ? request.getAttribute("message") : ""%>';
                    if (message) {
                        $('#messageModal').modal('show');
                    }
                });

            </script>
            <!-- Modal display message -->
            <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="messageModalLabel">Thông báo</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <%
                                String message = (String) request.getAttribute("message");
                                if (message
                                        != null) {
                            %>
                            <p><%= message%></p>
                            <%
                                }
                            %>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>