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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/Style_Promotion.css"/>
    </head>
    <body>        
        <!-- Navbar Start -->
        <div class="container-main">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-12 col-lg-3" style="padding-left: 0px ;padding-right: 0px; ">
                    <div class="sidebar" style="height: 150vh;" >
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
                                                <h6 style="margin: 0;">Staff</h6>
                                                <span class="staff-name" style="font-size: 18px;">Nguyễn Văn An</span>
                                            </div>
                                        </div>
                                        <button class="btn btn-link p-0" style="color: white;">
                                            <i class="fas fa-sign-out-alt" style="font-size: 24px;"></i>
                                        </button>
                                    </div>
                                </div>

                                <div class="menu-items">
                                    <h5><button onclick="location.href = 'crudMV.jsp'">Phim<span class="icon">&#128253;</span></button></h5>    
                                    <h5><button onclick="location.href = 'crudFD.jsp'">Đồ Ăn Nước Uống<span class="icon">&#127871;</span></button></h5>
                                    <h5><button onclick="location.href = 'Offers.jsp'">Thẻ Ưu Đãi<span class="icon">&#127991;</span></button></h5>
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
                                            <div class="btn-group text-left">
                                                <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal">
                                                    <i class="material-icons">&#xE147;</i> <span>Thêm Voucher mới</span>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Pagination -->
                                        <div class="pagination-container d-flex justify-content-between align-items-center mb-4">
                                            <nav aria-label="Page navigation">
                                                <ul class="pagination">
                                                    <li class="page-item">
                                                        <a class="page-link" href="#" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                                    <li class="page-item"><a class="page-link" href="#">4</a></li>
                                                    <li class="page-item"><a class="page-link" href="#">5</a></li>
                                                    <li class="page-item">
                                                        <a class="page-link" href="#" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>

                                            <!-- Search Bar -->
                                            <div class="search-container">
                                                <form action="/action_page.php">
                                                    <input type="text" placeholder="Tìm Kiếm..." name="search">
                                                    <button type="submit"><i class="fa fa-search"></i></button>
                                                </form>
                                            </div>


                                        </div>


                                        <div class="row px-xl-5 pb-3">
                                            <div  class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                                <div class="card product-item border-0 mb-4">
                                                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                                        <img class="img-fluid w-100" src="image/o1.jpg" alt="">
                                                        <div class="overlay"> <!-- Thêm overlay -->
                                                            <div class="text">Điểm Tích Luỹ - Khám Phá Phim</div>
                                                            <div class="icon-actions"> <!-- Action icons -->
                                                                <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Update" style="background-color: green;">&#xE254;</i></a>
                                                                <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete" style="background-color: red;">&#xE872;</i></a>
                                                            </div>
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
                                                            <div class="icon-actions"> <!-- Action icons -->
                                                                <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Update" style="background-color: green;">&#xE254;</i></a>
                                                                <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete" style="background-color: red;">&#xE872;</i></a>
                                                            </div>
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
                                                            <div class="icon-actions"> <!-- Action icons -->
                                                                <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Update" style="background-color: green;">&#xE254;</i></a>
                                                                <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete" style="background-color: red;">&#xE872;</i></a>
                                                            </div>
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
                                                            <div class="icon-actions"> <!-- Action icons -->
                                                                <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Update" style="background-color: green;">&#xE254;</i></a>
                                                                <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete" style="background-color: red;">&#xE872;</i></a>
                                                            </div>
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
                                                            <div class="icon-actions"> <!-- Action icons -->
                                                                <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Update" style="background-color: green;">&#xE254;</i></a>
                                                                <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete" style="background-color: red;">&#xE872;</i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                                <div class="card product-item border-0 mb-4">
                                                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                                        <img class="img-fluid w-100" src="image/o7.jpg" alt="">
                                                        <div class="overlay"> <!-- Thêm overlay -->
                                                            <div class="text">Đón Chào Năm Mới Với Ưu Đãi Đặc Biệt Chỉ 129K</div>
                                                            <div class="icon-actions"> <!-- Action icons -->
                                                                <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Update" style="background-color: green;">&#xE254;</i></a>
                                                                <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete" style="background-color: red;">&#xE872;</i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                                <div class="card product-item border-0 mb-4">
                                                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                                        <img class="img-fluid w-100" src="image/o10.jpg" alt="">
                                                        <div class="overlay"> <!-- Thêm overlay -->
                                                            <div class="text">Special voucher - Double click</div>
                                                            <div class="icon-actions"> <!-- Action icons -->
                                                                <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Update" style="background-color: green;">&#xE254;</i></a>
                                                                <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete" style="background-color: red;">&#xE872;</i></a>
                                                            </div>
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
                                                            <div class="icon-actions"> <!-- Action icons -->
                                                                <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Update" style="background-color: green;">&#xE254;</i></a>
                                                                <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete" style="background-color: red;">&#xE872;</i></a>
                                                            </div>
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
                                                            <div class="icon-actions"> <!-- Action icons -->
                                                                <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Update" style="background-color: green;">&#xE254;</i></a>
                                                                <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete" style="background-color: red;">&#xE872;</i></a>
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

            <!--             Add Modal HTML -->
            <div id="addEmployeeModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form>
                            <div class="modal-header">						
                                <h4 class="modal-title"> Thêm Voucher mới</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">					
                                <div class="form-group">
                                    <label>Voucher ID</label>
                                    <input type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Price</label>
                                    <input type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Name</label>
                                    <input type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Expiry Date</label>
                                    <input type="date" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="myFile">
                                        <i class="fa fa-file-image-o" aria-hidden="true" style="margin-right: 5px;"></i> Image:
                                    </label>
                                    <input type="file" id="myFile" name="filename" style="padding: 5px;
                                           margin-bottom: 10px;
                                           border-radius: 5px;
                                           border: none;
                                           box-shadow: 0 0 5px gray;">
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
                        <form>
                            <div class="modal-header">						
                                <h4 class="modal-title">Cập Nhật Voucher</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">					
                                <div class="form-group">
                                    <label>Voucher ID</label>
                                    <input type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Price</label>
                                    <input type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Name</label>
                                    <input type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Expiry Date</label>
                                    <input type="date" class="form-control" required>
                                </div>	
                                <div class="form-group">
                                    <label for="myFile">
                                        <i class="fa fa-file-image-o" aria-hidden="true" style="margin-right: 5px;"></i> Image:
                                    </label>
                                    <input type="file" id="myFile" name="filename" style="padding: 5px;
                                           margin-bottom: 10px;
                                           border-radius: 5px;
                                           border: none;
                                           box-shadow: 0 0 5px gray;">
                                </div>	
                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                <input type="submit" class="btn btn-info" value="Save">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!--             Delete Modal HTML -->
            <div id="deleteEmployeeModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form>
                            <div class="modal-header">						
                                <h4 class="modal-title">Xóa Voucher</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">					
                                <p>Bạn có chắc chắn muốn xóa Voucher này không?</p>
                                <p class="text-warning"><small>Hành động này không thể hoàn tác.</small></p>
                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                <input type="submit" class="btn btn-danger" value="Delete">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
    </body>
</html>