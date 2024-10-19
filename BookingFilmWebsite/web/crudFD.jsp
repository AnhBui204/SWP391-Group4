
<%@page import="Model.Theatre"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="Model.FoodAndDrink" %>
<%@page import="Model.FoodAndDrinkDB" %>
<!DOCTYPE html>
<html lang="en">   
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Cinema food & drinks</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/food_drink.css"/>
    </head>
    <style>
        .combo-image {
            width: 200px; 
            min-height: 300px; 
            max-height: 300px;
            object-fit: cover;
        }
    </style>
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
                    <div class="body-right" style="height: 150vh; ">

                        <div class="container-fluid mb-5">
                            <div class="row border-top px-xl-5">
                                <div class="main-content">
                                    <!-- Products Start -->
                                    <div class="container-fluid pt-5">
                                        <div class="d-flex justify-content-between align-items-center mb-4">
                                            <h2 class="section-title px-5 bordered text-left">
                                                <span class="px-2">ĐỒ ĂN NƯỚC UỐNG</span>
                                            </h2>
                                            <h2 class="section-title px-5 bordered">
                                                <span class="px-2">Rạp ${theatre.theatreName}</span>
                                            </h2>
                                            <div class="btn-group text-left" >
                                                <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal">
                                                    <i class="material-icons">&#xE147;</i> <span>Thêm Đồ Ăn Nước Uống</span>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Pagination -->
                                        <%
                                            int mvPage = 1; // Trang hiện tại
                                            int combosPerPage = 8; // Số combo mỗi trang
                                            if (request.getParameter("mvPage") != null) {
                                                mvPage = Integer.parseInt(request.getParameter("mvPage"));
                                            }

                                            Theatre theatre = (Theatre) session.getAttribute("theatre");
                                            FoodAndDrinkDB db = new FoodAndDrinkDB();
                                            List<FoodAndDrink> list = db.getCombosByPage(theatre.getTheatreID(), mvPage, combosPerPage); // Lấy danh sách combo theo trang
                                            int totalCombos = db.getTotalCombosByTheatre(theatre.getTheatreID()); // Tổng số combo
                                            int totalPages = (int) Math.ceil(totalCombos / (double) combosPerPage); // Tính tổng số trang
                                        %>

                                        <!-- Phân trang -->
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
                                                <form action="/action_page.php">
                                                    <input type="text" placeholder="Tìm Kiếm..." name="search">
                                                    <button type="submit"><i class="fa fa-search"></i></button>
                                                </form>
                                            </div>
                                        </div>

                                        <!-- Danh sách combo -->
                                        <div class="row px-xl-5 pb-3">
                                            <%
                                                for (FoodAndDrink cb : list) {
                                            %>
                                            <div  class="col-lg-3 col-md-6 col-sm-12 pb-1">
                                                <div class="card product-item border-0 mb-4">
                                                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                                                        <img class="combo-image" src="<%= cb.getImagePath()%>" alt="">
                                                        <div class="overlay"> <!-- Thêm overlay -->
                                                            <div class="text"><%= cb.getComboName()%></div>
                                                            <div class="icon-actions"> <!-- Action icons -->
                                                                <a href="#editEmployeeModal" 
                                                                   class="edit" 
                                                                   data-toggle="modal" 
                                                                   data-id="<%= cb.getComboID()%>" 
                                                                   data-name="<%= cb.getComboName()%>" 
                                                                   data-price="<%= cb.getPrice()%>">
                                                                    <i class="material-icons" data-toggle="tooltip" title="Update" style="background-color: green;">&#xE254;</i>
                                                                </a>
                                                                <a href="#deleteEmployeeModal"
                                                                   class="delete" data-toggle="modal"
                                                                   data-id="<%= cb.getComboID()%>">
                                                                    <i class="material-icons" data-toggle="tooltip" title="Delete" style="background-color: red;">&#xE872;</i>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <% 
                                                }
                                                String nextID = FoodAndDrinkDB.getNextComboID();
                                            %>
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
                        <form action="FoodAndDrinkServlet?action=add" method="POST" enctype="multipart/form-data">
                            <div class="modal-header">						
                                <h4 class="modal-title">Thêm Combo</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">					
                                <div class="form-group">
                                    <label for="comboID">Combo ID</label>
                                    <input type="text" class="form-control" value="<%= nextID%>" id="comboID" name="comboID" readonly>
                                    <input hidden type="text" value="${theatre.theatreID}" name="theatreID" />
                                </div>
                                <div class="form-group">
                                    <label for="comboName">Combo Name</label>
                                    <input type="text" class="form-control" id="comboName" name="comboName" required>
                                </div>
                                <div class="form-group">
                                    <label for="price">Price</label>
                                    <input type="text" class="form-control" name="price" id="price" required>
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
                        <form action="FoodAndDrinkServlet?action=update" method="POST" enctype="multipart/form-data">
                            <div class="modal-header">						
                                <h4 class="modal-title">Cập Nhật Combo</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">					
                                <div class="form-group">
                                    <label for="comboID">Combo ID</label>
                                    <input type="text" class="form-control" value="" id="comboID" name="comboID" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="comboName">Combo Name</label>
                                    <input type="text" class="form-control" value="" id="comboName" name="comboName" required>
                                </div>
                                <div class="form-group">
                                    <label for="price">Price</label>
                                    <input type="text" class="form-control" value="" name="price" id="price" required>
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
                                <input type="submit" class="btn btn-success" value="Update">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!--             Delete Modal HTML -->
            <div id="deleteEmployeeModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="FoodAndDrinkServlet?action=delete" method="POST">
                            <div class="modal-header">						
                                <h4 class="modal-title">Xóa Combo</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">					
                                <p>Bạn có chắc chắn muốn xóa combo này không ?</p>
                                <p class="text-warning"><small>Hành động này không thể hoàn tác.</small></p>
                                <input type="hidden" name="comboID" id="deleteComboID" value="">
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
                // Edit combo
                $(document).on('click', '.edit', function () {
                    var comboID = $(this).data('id');
                    var comboName = $(this).data('name');
                    var price = $(this).data('price');

                    // Fill data into the edit modal
                    $('#editEmployeeModal input[name="comboID"]').val(comboID);
                    $('#editEmployeeModal input[name="comboName"]').val(comboName);
                    $('#editEmployeeModal input[name="price"]').val(price);
                });

                // Delete combo
                $(document).on('click', '.delete', function () {
                    var comboID = $(this).data('id');
                    $("#deleteComboID").val(comboID);
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
                                if (message != null) {
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