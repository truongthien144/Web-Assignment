<?php
require_once 'site.php';
loadHeader();
echo '<link rel="stylesheet" href="style/delivery.css">
    <script defer type="text/javascript" src="js/delivery.js"></script>';
loadMenu();
require_once 'function/price.php';
require 'connect_db.php';
$customer = $_SESSION['username'];
$isBuyNow = isset($_GET['prod_id']) && isset($_GET['size']);
$sql = "SELECT fullname, phone_number, shipping_address FROM account WHERE username = '$customer'";
$result = $conn->query($sql);
if ($rows = $result->fetch_array()) {
    $Fullname = $rows['fullname'];
    $PhoneNumber = $rows['phone_number'];
    $ShippingAddress = $rows['shipping_address'];
    if (!empty($_POST)) {
        $fullname = $_POST['Fullname'];
        $phone_number = $_POST['PhoneNumber'];
        $shipping_address = $_POST['ShippingAddress'];
        $sql = "UPDATE account SET fullname = '$fullname', phone_number = '$phone_number', shipping_address = '$shipping_address' WHERE username = '$customer'";
        $conn->query($sql);

        $sql = "SELECT product.product_id, cart.size, cart.quantity, product.price, product.discount FROM cart JOIN product ON cart.prod_id = product.product_id WHERE username = '$customer'";
        if ($isBuyNow) {
            $sql .= "AND product.product_id = " . $_GET['prod_id'] . " AND cart.size = '" . $_GET['size'] . "'";
        }
        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
            $sql = "INSERT INTO `order` (username, fullname, phone_number, shipping_address, pay_date) VALUES ('$customer', '$fullname', '$phone_number', '$shipping_address', CURRENT_TIMESTAMP)";
            $conn->query($sql);
            $sql = "SELECT order_id FROM `order` ORDER BY order_id DESC LIMIT 1";
            $result1 = $conn->query($sql)->fetch_array();
            $last_order_id = $result1['order_id'];
            while ($row = $result->fetch_array()) {
                $cart_quantity = $row['quantity'];
                $item_price = $row['price'];
                $item_discount = $row['discount'];
                $item_discounted_price = getDiscountedPrice($item_price, $item_discount);

                $sql = "INSERT INTO `order_detail` (`order_id`, `prod_id`, `size`, `price`, `quantity`) VALUES ('$last_order_id', '" . $row['product_id'] . "', '" . $row['size'] . "', '$item_discounted_price', '$cart_quantity')";
                $conn->query($sql);

                $sql = "UPDATE size INNER JOIN cart ON size.prod_id = cart.prod_id SET size.$row[size] = size.$row[size] - cart.quantity WHERE cart.prod_id = '$row[product_id]' AND cart.username = '$customer'";
                $conn->query($sql);
            }
            if (!isset($_GET['prod_id']) && !isset($_GET['size']) && !isset($_GET['quantity'])) {
                $sql = "DELETE FROM cart WHERE username = '$customer'";
            } else {
                $sql = "DELETE FROM cart WHERE username = '$customer' AND prod_id = " . $_GET['prod_id'] . " AND size = '" . $_GET['size'] . "'";
            }
            $conn->query($sql);
            echo '<script>alert("Đặt hàng thành công!"); location.href="./"</script>';
        } else {
            echo '<script>alert("Có lỗi xảy ra khi đặt hàng. Vui lòng thử lại sau."); location.href="./"</script>';
        }
    }
}
?>

<section>
    <form class="delivery-form" method="POST">
        <div class="">
            <div class="delivery-form__input">
                <h1>Thông tin thanh toán</h1>
                <div>
                    <div>
                        <label class="item-input-1" for="Fullname">Họ và tên*</label>
                        <input type="text" name="Fullname" id="Fullname" value="<?php echo $Fullname; ?>" required>
                    </div>
                    <div>
                        <label class="item-input-2" for="PhoneNumber">Số điện thoại*</label>
                        <input
                            type="tel"
                            name="PhoneNumber"
                            id="PhoneNumber"
                            value="<?php echo $PhoneNumber; ?>"
                            pattern="[0-9]{10}"
                            title="Số điện thoại phải có 10 chữ số"
                            required
                            inputmode="numeric"
                            maxlength="10"
                            oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 10);">

                    </div>
                </div>
                <div>
                    <div>
                        <label class="item-input-3" for="ShippingAddress">Địa chỉ giao hàng*</label>
                        <textarea name="ShippingAddress" id="ShippingAddress" required><?php echo $ShippingAddress; ?></textarea>
                    </div>
                </div>
            </div>
            <div class="delivery-form__information">
                <div class="">
                    <h1>Đơn hàng của bạn</h1>
                    <table>
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Tạm tính</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            require 'connect_db.php';
                            $sql = "SELECT product.product_name, cart.quantity, cart.size, product.price, product.discount FROM cart JOIN product ON cart.prod_id = product.product_id WHERE username = '$customer' ";
                            if ($isBuyNow) {
                                $sql .= "AND cart.prod_id = " . $_GET['prod_id'] . " AND cart.size = '" . $_GET['size'] . "'";
                            }
                            $result = $conn->query($sql);
                            if ($result->num_rows > 0) {
                                $total_price = 0;
                                while ($row = $result->fetch_array()) {
                                    $cart_quantity = $row['quantity'];
                                    $item_price = $row['price'];
                                    $item_discount = $row['discount'];
                                    $item_discounted_price = getDiscountedPrice($item_price, $item_discount);
                                    $total_price += $item_discounted_price * $cart_quantity;
                                    $formatted_item_discounted_price = formatPrice($item_discounted_price);
                                    echo <<< CART_ITEM
                                        <tr>
                                            <td>
                                                $row[product_name] - $row[size] x $cart_quantity
                                            </td>
                                            <td class="product-price">
                                                <span>{$formatted_item_discounted_price} đ</span>
                                            </td>
                                        <tr>
                                        CART_ITEM;
                                }
                            }
                            ?>
                            <tr>
                                <th>
                                    <span>Tổng cộng</span>
                                </th>
                                <td class="product-price">
                                    <span><?php echo formatPrice($total_price); ?> đ</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div>
                        <label for="payment_method">Phương thức thanh toán</label>
                        <div>
                            <input type="radio" id="cod" name="payment_method" value="cod" checked>
                            <label for="cod">Thanh toán khi nhận hàng (COD)</label>
                        </div>
                        <div>
                            <input type="radio" id="qr" name="payment_method" value="qr">
                            <label for="qr">Thanh toán qua QR code</label>
                            <img src="img/qr.png" alt="QR code">
                        </div>
                    </div>
                </div>
                <div class="delivery-form__button">
                    <button name="" type="submit">Đặt hàng</button>
                </div>
            </div>
        </div>
    </form>
</section>


<?php
loadFooter();
?>