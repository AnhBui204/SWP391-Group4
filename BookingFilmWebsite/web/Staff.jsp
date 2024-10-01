<%-- 
    Document   : Staff
    Created on : Sep 19, 2024, 3:50:42 PM
    Author     : pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff</title>
    <link rel="stylesheet" href="css/Staff_style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="logo">CINELUXE</div>
            
            <div class="user-profile">
                <div class="user-info">
                    <i class="fa-solid fa-user"></i> 
                    <div>
                        <p class="user-title">Staff</p>
                        <p class="user-name">Nguyễn Văn An</p>
                    </div>
                </div>
                <i class="fa-solid fa-right-from-bracket"></i> 
            </div>
            
            <nav>
                <ul>
                    <li><a href="#" class="navigation active">Movie</a></li>
                    <li><a href="#" class="navigation">Foods and Drinks</a></li>
                    <li><a href="#" class="navigation">Voucher</a></li>
                </ul>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="content">
            <div class="movie-section">
                <div class="movie-header">
                    <h1>PHIM</h1>
                    <div class="add-movie">
                        <i class="fa-solid fa-circle-plus"></i>
                        <p>Thêm phim</p>
                    </div>
                </div>
                
                <div class="pagination">
                    <a href="#" class="page-number">&laquo;</a>
                    <a href="#" class="page-number active">1</a>
                    <a href="#" class="page-number">2</a>
                    <a href="#" class="page-number">3</a>
                    <a href="#" class="page-number">4</a>
                    <a href="#" class="page-number">5</a>
                    <a href="#" class="page-number">&raquo;</a>
                </div>

                <div class="movie-grid">
                    <div class="movie-card">
                        <div class="movie-image-container">
                            <div class="movie-image">
                                <img src="https://cdn.galaxycine.vn/media/2024/8/26/lam-giau-voi-ma-2_1724686102964.jpg" alt="Làm Giàu Với Ma">
                            </div>
                            <div class="movie-overlay">
                                <button class="edit-btn" title="Edit"><i class="fa-solid fa-pen"></i></button>
                                <button class="delete-btn" title="Delete"><i class="fa-solid fa-trash"></i></button>
                            </div>
                        </div>
                        <div class="movie-name">
                            <h3>Làm Giàu Với Ma</h3>
                        </div>
                    </div>
                    
                    <div class="movie-card">
                        <div class="movie-image-container">
                            <div class="movie-image">
                                <img src="https://cdn.galaxycine.vn/media/2024/9/9/tim-kiem-tai-nang-am-phu-500-sneak_1725856230189.jpg" alt="Tìm Kiếm Tài Năng Âm Phủ">
                            </div>
                            <div class="movie-overlay">
                                <button class="edit-btn" title="Edit"><i class="fa-solid fa-pen"></i></button>
                                <button class="delete-btn" title="Delete"><i class="fa-solid fa-trash"></i></button>
                            </div>
                        </div>
                        <div class="movie-name">
                            <h3>Tìm Kiếm Tài Năng Âm Phủ</h3>
                        </div>
                    </div>
                    
                    <div class="movie-card">
                        <div class="movie-image-container">
                            <div class="movie-image">
                                <img src="https://cdn.galaxycine.vn/media/2023/12/26/qc-500_1703563648819.jpg" alt="Quỷ Cầu">
                            </div>
                            <div class="movie-overlay">
                                <button class="edit-btn" title="Edit"><i class="fa-solid fa-pen"></i></button>
                                <button class="delete-btn" title="Delete"><i class="fa-solid fa-trash"></i></button>
                            </div>
                        </div>
                        <div class="movie-name">
                            <h3>Quỷ Cầu</h3>
                        </div>
                    </div>
                    
                    <div class="movie-card">
                        <div class="movie-image-container">
                            <div class="movie-image">
                                <img src="https://cdn.galaxycine.vn/media/2024/9/9/speak-no-evil-500_1725875282848.jpg" alt="Không Nói Điều Dữ">
                            </div>
                            <div class="movie-overlay">
                                <button class="edit-btn" title="Edit"><i class="fa-solid fa-pen"></i></button>
                                <button class="delete-btn" title="Delete"><i class="fa-solid fa-trash"></i></button>
                            </div>
                        </div>
                        <div class="movie-name">
                            <h3>Không Nói Điều Dữ</h3>
                        </div> 
                    </div>
                    
                    <div class="movie-card">
                        <div class="movie-image-container">
                            <div class="movie-image">
                                <img src="https://cdn.galaxycine.vn/media/2024/9/13/joker-500_1726217825205.jpg" alt="Joker">
                            </div>
                            <div class="movie-overlay">
                                <button class="edit-btn" title="Edit"><i class="fa-solid fa-pen"></i></button>
                                <button class="delete-btn" title="Delete"><i class="fa-solid fa-trash"></i></button>
                            </div>
                        </div>
                        <div class="movie-name">
                            <h3>Joker</h3>
                        </div> 
                    </div>
                    
                    <div class="movie-card">
                        <div class="movie-image-container">
                            <div class="movie-image">
                                <img src="https://cdn.galaxycine.vn/media/2024/9/5/oddity-1_1725523860091.jpg" alt="Quỷ Án">
                            </div>
                            <div class="movie-overlay">
                                <button class="edit-btn" title="Edit"><i class="fa-solid fa-pen"></i></button>
                                <button class="delete-btn" title="Delete"><i class="fa-solid fa-trash"></i></button>
                            </div>
                        </div>
                        <div class="movie-name">
                            <h3>Quỷ Án</h3>
                        </div> 
                    </div>
                    
                    <div class="movie-card">
                        <div class="movie-image-container">
                            <div class="movie-image">
                                <img src="https://cdn.galaxycine.vn/media/2024/8/30/the-crow-500_1725012333336.jpg" alt="The Crow: Báo Thù">
                            </div>
                            <div class="movie-overlay">
                                <button class="edit-btn" title="Edit"><i class="fa-solid fa-pen"></i></button>
                                <button class="delete-btn" title="Delete"><i class="fa-solid fa-trash"></i></button>
                            </div>
                        </div>
                        <div class="movie-name">
                            <h3>The Crow: Báo Thù</h3>
                        </div> 
                    </div>
                    
                    <div class="movie-card">
                        <div class="movie-image-container">
                            <div class="movie-image">
                                <img src="https://cdn.galaxycine.vn/media/2024/9/5/anh-trai-vuot-moi-tam-tai-500_1725506328067.jpg" alt="Anh Trai Vượt Mọi Tam Tai">
                            </div>
                            <div class="movie-overlay">
                                <button class="edit-btn" title="Edit"><i class="fa-solid fa-pen"></i></button>
                                <button class="delete-btn" title="Delete"><i class="fa-solid fa-trash"></i></button>
                            </div>
                        </div>
                        <div class="movie-name">
                            <h3>Anh Trai Vượt Mọi Tam Tai</h3>
                        </div> 
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

