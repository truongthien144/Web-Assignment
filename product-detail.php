<?php
require_once 'site.php';
loadHeader();
echo '<link rel="stylesheet" href="style/product-detail.css">
    <script defer type="text/javascript" src="js/product-detail.js"></script>';
loadMenu();
require_once 'function/price.php';
require_once 'function/image.php';
require 'connect_db.php';
$product_id = $_GET['product_id'];
$sql = "SELECT product.*, size.s, size.m, size.l, size.xl FROM product JOIN size ON product.product_id = size.prod_id WHERE product.product_id = '" . $product_id . "'";
$result = mysqli_query($conn, $sql);
if ($row = mysqli_fetch_array($result)) {
    $price = formatPrice($row['price']);
    if ($row['discount'] > 0) {
        $discounted_price = formatPrice(getDiscountedPrice($row['price'], $row['discount']));
        $sale_percennt = getSalePercent($row['price'], $row['discount']);
    }
    $img_path = 'img/product/' . $row['product_id'];
    if (!file_exists($img_path)) {
        $img_path = 'img/product/DEFAULT';
    }
    $images = getImages($img_path);
    if (empty($images)) {
        $images = getImages('img/product/DEFAULT');
    }
}
?>
<div class="product-detail container">
    <div class="row">
        <div class="col-sm-12 col-md-6 col-lg-6 col-xl-6">
            <div class="product-detail__gallery">
                <div class="main-image" id="main-image">
                    <?php echo '<img src="' . $img_path . '/' . $images[0] . '" alt="">'; ?>
                </div>
                <div class="thumbnails">
                    <?php
                    $img_count = count($images);
                    if ($img_count > 5) {
                        echo '<img src="' . $img_path . '/' . $images[0] . '" alt="Ảnh sản phẩm" class="option img--checked checked">';
                        for ($i = 1; $i < 4; $i++) {
                            echo '<img src="' . $img_path . '/' . $images[$i] . '" alt="Ảnh sản phẩm" class="option">';
                        }
                    } else if ($img_count < 5 && $img_count > 0) {
                        echo '<img src="' . $img_path . '/' . $images[0] . '" alt="Ảnh sản phẩm" class="option img--checked checked">';
                        for ($i = 1; $i < $img_count; $i++) {
                            echo '<img src="' . $img_path . '/' . $images[$i] . '" alt="Ảnh sản phẩm" class="option">';
                        }
                    }
                    ?>
                </div>
            </div>
        </div>
    </div>
    <div class="product-detail__info">
        <?php echo
        '<h2 prod_id=' . $row['product_id'] . ' class="product-detail__name">' . $row['product_name'] . '</h2>'
        ?>
        <div class="product-detail__price">
            <?php
            if ($row['discount'] > 0) {
                echo <<< PROD_PRICE
                    <span class="product__price--discounted">$discounted_price đ</span>
                    <span class="product__price--original">$price đ</span>
                    <span class="product__price--sale">-$sale_percennt%</span>
                    PROD_PRICE;
            } else {
                echo <<< PROD_PRICE
                    <span class="product__price--discounted">$price đ</span>
                PROD_PRICE;
            }
            ?>
        </div>
        <div class="product-detail__size">
            <!-- <span class="product-detail__size--label">Size: <span></span></span> -->
            <p class="product-detail__size--label">Size: <span></span></p>
            <?php
            $max = 0;
            $sizes = ['s' => $row['s'], 'm' => $row['m'], 'l' => $row['l'], 'xl' => $row['xl']];
            foreach ($sizes as $size => $quantity) {
                if ($quantity == 0) {
                    echo '<span class="product-detail__size--disabled">' . strtoupper($size) . '</span>';
                } else {
                    echo '<span class="product-detail__size" data-size="' . $size . '">' . strtoupper($size) . '</span>';
                    if ($quantity > $max) {
                        $max = $quantity;
                    }
                }
            }
            ?>
            <div class="product-detail__quantity">
                <div class="product-detail__quantity--label my-2">Số lượng:</div>
                <div class="rounded-3">
                    <i class="fa-solid fa-minus"></i>
                    <?php echo '<input type="number" name="quantity" id="quantity" value="1" min="1" max="' . $max . '" readonly>'; ?>
                    <i class="fa-solid fa-plus"></i>
                </div>
            </div>
        </div>
        <div class="product-detail__purchasing">
            <button class="product-detail__buy-now btn btn-dark mb-0" id="buy-now" data-product-id="<?php echo $product_id; ?>">Mua ngay</button>
            <button class="product-detail__add-to-cart btn btn-light btn-outline-secondary text-dark" id="add-to-cart" data-product-id="<?php echo $product_id; ?>">Thêm vào giỏ hàng</button>
        </div>
    </div>
</div>
<div class="gallery-zoom">
    <div class="controller controller__exit">
        <i class="fa-solid fa-xmark"></i>
    </div>
    <div class="gallery-content">
        <img src="" alt="Ảnh sản phẩm">
    </div>
    <div class="controller controller__prev">
        <i class="fa-solid fa-chevron-left"></i>
    </div>
    <div class="controller controller__next">
        <i class="fa-solid fa-chevron-right"></i>
    </div>
</div>
<div class="product-detail__description">
    <div class="tab__header">
        <span class="tab__header--active">Giới thiệu</span>
        <span class="">Chi tiết</span>
    </div>
    <div class="tab__content">
        <?php
        echo '<div class="tab__content--active">' . $row['overview'] . '</div>';
        echo '<div>' . $row['description'] . '</div>';
        ?>
    </div>
</div>

<?php
loadFooter();
?>