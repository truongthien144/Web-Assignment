<?php
require_once 'site.php';
loadHeader();
require_once 'function/directToLoginIfNot.php';
echo '<link rel="stylesheet" href="style/cart.css">
    <script defer type="text/javascript" src="js/cart.js"></script>';
loadMenu();
require_once 'function/price.php';
?>

<div id="content" class="content-area page-wrapper" role="main">
    <div class="row row-main">
        <div class="col-main">
            <div class="large-12 col">
                <div class="col-inner">
                    <div class="row row-large row-divided">
                        <?php
                        require 'connect_db.php';
                        $customer = $_SESSION['username'];
                        $check = isset($_GET['prod_id']) ? "true" : "false";
                        $sql = "SELECT cart.*, product.product_name, product.price, product.discount FROM cart JOIN product ON cart.prod_id = product.product_id ";
                        if ($check === "true" && isset($_GET['size'])) {
                            $where = "WHERE cart.username = '$customer' AND cart.prod_id = " . $_GET['prod_id'] . " AND cart.size = '" . $_GET['size'] . "'";
                        } else {
                            $where = "WHERE cart.username = '$customer'";
                        }
                        $sql .= $where;
                        $result = mysqli_query($conn, $sql);
                        require 'function/image.php';
                        if (mysqli_num_rows($result) == 0) {
                            echo "<p>Your cart is empty.</p>";
                        } else {
                            echo <<< CART_CONTENT_HEADER
                                <div class="cart-content col">
                                    <table>
                                    <thead>
                                    <tr>
                                        <th class="product-name">Sản phẩm</th>
                                        <th class="product-price">Giá</th>
                                        <th class="product-quantity">Số lượng</th>
                                        <th class="product-total">Tạm tính</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                CART_CONTENT_HEADER;
                            while ($row = mysqli_fetch_array($result)) {
                                $sql1 = "SELECT * FROM size WHERE prod_id = '" . $row['prod_id'] . "'";
                                $max_quantity = mysqli_query($conn, $sql1);
                                $row_max_quantity = mysqli_fetch_array($max_quantity);
                                $img_path = 'img/product/' . $row['prod_id'];
                                if (!file_exists($img_path)) {
                                    $img_path = 'img/product/DEFAULT';
                                }
                                $images = getImages($img_path);
                                if (empty($images)) {
                                    $images = getImages('img/product/DEFAULT');
                                }
                                if ($row['discount'] > 0) {
                                    $price = getDiscountedPrice($row['price'], $row['discount']);
                                } else {
                                    $price = $row['price'];
                                }
                                $total_price = $price * $row['quantity'];
                                $formatted_price = formatPrice($price);
                                $formatted_total_price = formatPrice($total_price);
                                echo <<< CART_ITEM
                                    <tr class="cart-item" product_id={$row['prod_id']}>
                                            <td class="product-name">
                                                <button class="remove-item" onclick="removeItem(this)" ><i class="fa-solid fa-xmark"></i></button>
                                                <a href="product-detail.php?product_id={$row['prod_id']}">
                                                    <img src="{$img_path}/{$images[0]}" alt="{$row['product_name']}">
                                                    <span>{$row['product_name']} - {$row['size']}</span>
                                                </a>
                                                <span class="size" product_size={$row['size']}></span>
                                            </td>
                                            <td class="product-price">
                                                <span>{$formatted_price} đ</span>
                                            </td>
                                            <td>
                                                <i class="fa-solid fa-minus"></i>
                                                <input type="number" class="quantity" value="{$row['quantity']}" min="1" max="{$row_max_quantity[strtolower($row['size'])]}" readonly>
                                                <i class="fa-solid fa-plus"></i>
                                            </td>
                                            <td class="product-total">
                                                <span>{$formatted_total_price} đ</span>
                                            </td>
                                        <tr>
                                CART_ITEM;
                            }
                            echo <<< CART_PRICE_1
                                        </tbody>
                                        </table>
                                        <button class="back-to-shop" onclick="window.location.href='index.php'">Tiếp tục mua hàng</button>
                                    </div>
                            <div class="cart-collaterals col">
                                <div>
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Cộng giỏ hàng</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Tổng sản phẩm: </td>
                            CART_PRICE_1;
                            if ($check === "true" && isset($_GET['size'])) {
                                $sql2 = "SELECT quantity FROM cart WHERE username = '$customer' AND prod_id = " . $_GET['prod_id'] . " AND size = '" . $_GET['size'] . "' LIMIT 1";
                            } else {
                                $sql2 = "SELECT SUM(quantity) FROM cart WHERE username = '$customer' LIMIT 1";
                            }
                            $result2 = $conn->query($sql2);
                            $row2 = $result2->fetch_array();
                            $total_quantity = 0;
                            if ($result2->num_rows > 0 && $row2[0] != null) {
                                $total_quantity = $row2[0];
                            }
                            echo <<< CART_PRICE_2
                                                <td class="total-quantity"><span>$total_quantity</span></td>
                                            </tr>
                                            <tr>
                                                <td>Tổng tiền: </td>
                            CART_PRICE_2;
                            $sql3 = "SELECT cart.quantity, product.price, product.discount FROM cart JOIN product ON cart.prod_id = product.product_id ";
                            if ($check === "true" && isset($_GET['size'])) {
                                $sql3 .= "WHERE cart.username = '$customer' AND cart.prod_id = " . $_GET['prod_id'] . " AND cart.size = '" . $_GET['size'] . "'";
                            } else {
                                $sql3 .= "WHERE cart.username = '$customer'";
                            }
                            $result3 = $conn->query($sql3);
                            $row3 = $result3->fetch_all(MYSQLI_ASSOC);
                            $final_price = 0;
                            foreach ($row3 as $item) {
                                if ($item['discount'] > 0) {
                                    $price = getDiscountedPrice($item['price'], $item['discount']);
                                } else {
                                    $price = $item['price'];
                                }
                                $final_price += $price * $item['quantity'];
                            }
                            $formatted_final_price = formatPrice($final_price);

                            echo <<< CART_PRICE_3
                                                <td class="final-price"><span>$formatted_final_price đ</span></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="checkout-button">
                                    <input type="button" value="Đặt Hàng" class="btn btn-primary" onclick="redirectToCheckout($check);">
                                </div>
                            </div>
                        CART_PRICE_3;
                        }
                        ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<?php
loadFooter();
?>