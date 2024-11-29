<?php
    require_once('site.php');
    loadHeader();
    echo '<link rel="stylesheet" href="style/index.css">';
    loadMenu();
?>
    <div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active" data-bs-interval="10000">
            <img src="img/slider/banner1.jpg" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item" data-bs-interval="2000">
            <img src="img/slider/banner2.jpg" class="d-block w-100" alt="...">
            
            </div>
            <div class="carousel-item">
            <img src="img/slider/banner3.jpg" class="d-block w-100" alt="...">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>

    <div class="news-grid container my-5">
        <h2 class="text-center fw-bold text-uppercase">Tin tức mới</h2>
        <div class="row">
            <div class="col-12 col-md-4 mt-4">
                <div class="card">
                    <img src="img/news/post3.png" class="card-img-top mx-auto" alt="...">
                    <h6 class='card-subtitle my-2 text-secondary text-center'>Chương Trình Khuyến Mãi đến 29/02/2025</h6>
                    <h5 class="card-title text-center text-uppercase my-2">TẾT NÀY MANG GÌ ?</h5>
                    <div class="card-body">
                        <p class="card-text">Đón chào tết 2025 với chương trình sale "TẾT ĐẾN, SHOP SALE HẾT" 
                            từ ngày 26.01 đến ngày 29.02 hoà chung không khí rộn ràng của mùa xuân…</p>
                        <a href="post3.php" class="btn btn-outline-dark d-grid">Xem thêm</a>
                    </div>
                </div>
            </div>   
            <div class="col-12 col-md-4 mt-4">
                <div class="card">
                    <img src="img/news/post2.png" class="card-img-top mx-auto" alt="...">
                    <h6 class='card-subtitle my-2 text-secondary text-center'>Tin tức số 12 - Số ngày 20/11/2024</h6>
                    <h5 class="card-title text-center my-2">Những mẫu giày Underrated (Kì 1)</h5>
                    <div class="card-body">
                        <p class="card-text">Bên cạnh những mẫu giày đỉnh cao hay gây thất vọng, 
                            luôn tồn tại những cái tên bị đánh giá sai, có thể vì nhiều nguyên do từ brand...</p>
                        <a href="post2.php" class="btn btn-outline-dark d-grid">Xem thêm</a>    
                    </div>
                </div>
            </div>          
            <div class="col-12 col-md-4 mt-4">
                <div class="card">
                    <img src="img/news/post1.png" class="card-img-top mx-auto" alt="...">
                    <h6 class='card-subtitle my-2 text-secondary text-center'>Tin tức số 13 - Số ngày 25/11/2024</h6>
                    <h5 class="card-title text-center my-2">Sneaker Vintage News</h5>
                    <div class="card-body">
                        <p class="card-text">Sneaker Vintage News là nơi bạn có thể tìm thấy những thông tin về những mẫu giày mới, 
                            bao gồm câu chuyện về phối màu, thiết kế, ngày ra mắt...</p>
                        <a href="post1.php" class="btn btn-outline-dark d-grid">Xem thêm</a>    
                    </div>
                </div>
            </div>   
        </div>
    </div>
<?php
    loadFooter();
?>