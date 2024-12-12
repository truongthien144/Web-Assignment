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
            <a class="navbar-brand mr-auto ms-5" href="./">
                <img src="./img/sneaker-shop.jpg" alt="" width="120" height="120">
            </a>
            <form class="d-flex order-lg-1" action="products.php" method="GET">
                <input type="hidden" name="filter" value="product_name">
                <input class="form-control" name="value" id="input1" type="search" placeholder="Tìm kiếm" aria-label="Search">
                <button class="btn" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                <div class="dropdown">
                    <?php
                    if (isset($_SESSION['username'])) {
                        echo '
                        <a class="btn dropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-user"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-lg-end login-submenu">
                        <li><a class="dropdown-item" onclick="dangxuat();">Đăng xuất</a></li>
                        <li><a class="dropdown-item" href="change-pwd.php">Đổi mật khẩu</a></li>
                        </ul>
                        ';
                    } else {
                        echo '
                        <a class="btn" href="login.php">
                        <i class="fa-solid fa-user"></i>
                        </a>
                        ';
                    }
                    ?>
                </div>
                <a class="fa--shopping-bag btn me-0" href="cart.php" title="Xem giỏ hàng"><i class="fa-solid fa-cart-shopping"></i></a>
            </form>
            <div class="collapse navbar-collapse ms-3" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link active text-uppercase fs-6 fw-bold mx-2" aria-current="page" href="./">Home</a>
                    </li>
                    <?php
                    require 'connect_db.php';
                    $sql = "SELECT c.category_name, s.subcategory_name, s.subcategory_id, c.category_id
                            FROM category c
                            JOIN subcategory s ON c.category_id = s.category_id
                            ORDER BY c.category_name, s.subcategory_name";
                    $result = $conn->query($sql);

                    if ($result->num_rows > 0) {
                        while ($row = $result->fetch_assoc()) {
                            $categories[$row['category_name']][] = [
                                'subcategory_name' => $row['subcategory_name'],
                                'subcategory_id' => $row['subcategory_id'],
                                'category_id' => $row['category_id']
                            ];
                        }
                    } else {
                        echo "No categories found.";
                    }
                    foreach ($categories as $category_name => $subcategories): ?>
                        <li class="nav-item dropdown">
                            <a class="nav-link active text-uppercase fw-bold fs-6 mx-2 dropdown-toggle" href="products.php?filter=category_id&value=<?php echo htmlspecialchars($subcategories[0]['category_id']); ?>" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"><?php echo htmlspecialchars($category_name); ?></a>
                            <ul class="dropdown-menu bg-muted rounded-0" aria-labelledby="navbarDropdown">
                                <?php foreach ($subcategories as $subcategory): ?>
                                    <li>
                                        <a class="dropdown-item text-uppercase" href="products.php?filter=subcategory_id&value=<?php echo htmlspecialchars($subcategory['subcategory_id']); ?>">
                                            <?php echo htmlspecialchars($subcategory['subcategory_name']); ?> </a>
                                    </li> <?php endforeach; ?>
                            </ul>
                        </li>
                    <?php endforeach; ?>
                    <li class="nav-item">
                        <a class="nav-link active text-uppercase fw-bold fs-6 mx-2" aria-current="page" href="products.php?filter=discount&value=1">SALE</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active text-uppercase fw-bold fs-6 mx-2" aria-current="page" href="https://www.google.com/">BLOG</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div>