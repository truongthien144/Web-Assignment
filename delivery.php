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

<section class="container mx-auto mb-5 col-sm-12 col-md-6 col-lg-6 col-xl-4">
    <form class="delivery-formbg-white p-4 border rounded" style="box-shadow: 0px 5px 15px 0px rgba(0, 0, 0, 0.35);" method="POST">
        <div class="">
            <div class="delivery-form__input py-2">
                <h2 class="text-center text-primary">Thông tin thanh toán</h2>
                <div>
                    <div class="input-group mb-3">
                        <label class="item-input-1 input-group-text fw-bold" for="Fullname">Họ và tên <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="Fullname" id="Fullname" value="<?php echo $Fullname; ?>" required>
                    </div>
                    <div class="input-group mb-3">
                        <label class="item-input-2 input-group-text fw-bold" for="PhoneNumber">Số điện thoại<span class="text-danger"> *</span></label>
                        <input
                            type="tel"
                            class="form-control"
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
                    <div class="mb-1">
                        <label class="item-input-3 form-label fw-bold" for="ShippingAddress">Địa chỉ giao hàng<span class="text-danger"> *</span> </label>
                        <textarea name="ShippingAddress" class="form-control" id="ShippingAddress" required><?php echo $ShippingAddress; ?></textarea>
                    </div>
                </div>
            </div>
            <div class="delivery-form__information">
                <div class="">
                    <h2 class="text-primary text-center">Đơn hàng của bạn</h2>
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
                                <th class="summary">
                                    <span>Tổng cộng</span>
                                </th>
                                <td class="product-price-final fw-bold">
                                    <span><?php echo formatPrice($total_price); ?> đ</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div>
                        <label for="payment_method" class="text-primary fs-5">Phương thức thanh toán</label>
                        <div>
                            <input type="radio" id="cod" name="payment_method" value="cod" checked>
                            <label for="cod">Thanh toán khi nhận hàng (COD)</label>
                        </div>
                        <div>
                            <input type="radio" id="qr" name="payment_method" value="qr">
                            <label for="qr">Thanh toán qua QR code</label>
                            <img src="img/qr.png" alt="QR code" class="mx-auto" style="max-width: 80%;">
                        </div>
                    </div>
                </div>
                <div class="delivery-form__button d-flex justify-content-center mt-3">
                    <button name="" type="submit" class="btn btn-dark">Đặt hàng</button>
                </div>
            </div>
        </div>
    </form>
</section>


<?php
loadFooter();
?>