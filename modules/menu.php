</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <button
                class="navbar-toggler order-lg-2"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent"
                aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <a class="navbar-brand mr-auto ms-5" href="#">
                <img src="./img/download.png" alt="" width="112" height="112">
            </a>
            <form class="d-flex order-lg-1">
                <input class="form-control" name="tim" id="input1" type="search" placeholder="Tìm kiếm" aria-label="Search">
                <button class="btn" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                <div class="dropdown">
                    <a class="btn dropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-user"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" onclick="dangxuat();">Đăng xuất</a></li>
                        <li><a class="dropdown-item" href="change-pwd.php">Đổi mật khẩu</a></li>
                    </ul>
                </div>
                <a class="fa--shopping-bag btn me-0" href="giohang.php" title="Xem giỏ hàng"><i class="fa-solid fa-cart-shopping"></i></a>
            </form>
            <div class="collapse navbar-collapse ms-3" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link active text-uppercase fs-6 fw-bold mx-2" aria-current="page" href="#">Home</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link active dropdown-toggle text-uppercase fs-6 fw-bold mx-2" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            FOOTWEAR
                        </a>
                        <ul class="dropdown-menu bg-muted rounded-0" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item text-uppercase mx-2" href="#">BASKETBALL</a></li>
                            <li><a class="dropdown-item text-uppercase mx-2" href="#">SNEAKERS</a></li>
                            <li><a class="dropdown-item text-uppercase mx-2" href="#">RUNNING</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link active dropdown-toggle text-uppercase fw-bold fs-6 mx-2" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            ACCESSORIES
                        </a>
                        <ul class="dropdown-menu bg-muted rounded-0" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item text-uppercase mx-2" href="#">BALL</a></li>
                            <li><a class="dropdown-item text-uppercase mx-2" href="#">SOCK</a></li>
                            <li><a class="dropdown-item text-uppercase mx-2" href="#">BACKPACKS</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link active dropdown-toggle text-uppercase fw-bold fs-6 mx-2" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Black friday sale
                        </a>
                        <ul class="dropdown-menu bg-muted rounded-0" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item text-uppercase mx-2" href="#">Mã giảm 10%</a></li>
                            <li><a class="dropdown-item text-uppercase mx-2" href="#">Mã giảm 100k</a></li>
                            <li><a class="dropdown-item text-uppercase mx-2" href="#">Mã giảm 50k</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active text-uppercase fw-bold fs-6 mx-2" aria-current="page" href="https://www.google.com/">BLOG</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>