<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin</title>
    <link type="image/png" sizes="32x32" rel="icon" href="https://img.icons8.com/?size=100&id=YYb851RUsG0r&format=png&color=000000">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
</head>

<body style="height: 100vh;">
    <nav class="navbar navbar-dark bg-dark navbar-expand-lg">
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
            <a class="navbar-brand mr-auto ms-2" href="./">
                <i class="fa-solid fa-house"></i>
            </a>
            <form class="d-flex order-lg-1">
                <input class="form-control" type="text" placeholder="Tìm kiếm" id="input-search" aria-label="Search">
                <button class="btn" type="submit"><i class="fa-solid fa-magnifying-glass text-white"></i></button>
                <div class="dropdown">
                    <a class="btn dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-user"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-lg-end">
                        <li><a class="dropdown-item" href="./dangxuat.php">Đăng xuất</a></li>
                        <li><a class="dropdown-item" href="../change-pwd.php">Đổi mật khẩu</a></li>
                    </ul>
                </div>
            </form>
            <div class="collapse navbar-collapse ms-3" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link active text-uppercase fs-6 fw-bold mx-2" aria-current="page" href="./">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active text-uppercase fs-6 fw-bold mx-2" aria-current="page" href="khachhang.php">Khách hàng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active text-uppercase fs-6 fw-bold mx-2" aria-current="page" href="sanpham.php">Sản phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active text-uppercase fs-6 fw-bold mx-2" aria-current="page" href="hoadon.php">Hóa đơn</a>
                    </li>
                    <!-- <li class="nav-item">
                        <a class="nav-link active text-uppercase fs-6 fw-bold mx-2" aria-current="page" href="magiamgia.php">Mã giảm giá</a>
                    </li> -->
                </ul>
            </div>
        </div>
    </nav>