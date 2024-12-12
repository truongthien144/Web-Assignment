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
            $sql = "INSERT INTO order (username, fullname, phone_number, shipping_address, pay_date) VALUES ('$customer', '$fullname', '$phone_number', '$shipping_address', CURRENT_TIMESTAMP)";
            $conn->query($sql);
            $sql = "SELECT order_id FROM order ORDER BY order_id DESC LIMIT 1";
            $result1 = $conn->query($sql)->fetch_array();
            $last_order_id = $result['order_id'];
            while ($row = $result->fetch_array()) {
                $cart_quantity = $row['quantity'];
                $item_price = $row['price'];
                $item_discount = $row['discount'];
                $item_discounted_price = getDiscountedPrice($item_price, $item_discount);

                $sql = "INSERT INTO `order_detail` (`order_id`, `prod_id`, `size`, `price`, `quantity`) VALUES ('$last_order_id', '" . $row['product_id'] . "', '" . $row['size'] . "', '$item_discounted_price', '$cart_quantity')";
                $conn->query($sql);

                $sql = "UPDATE product INNER JOIN cart ON product.product_id = cart.prod_id SET product.quantity = product.quantity - cart.quantity WHERE product.product_id = '$row[product_id]' AND username = '$customer'";
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
            echo '<script>alert("Order successfully!"); location.href="./"</script>';
        } else {
            echo '<script>alert("Order failed!"); location.href="./"</script>';
        }
    }
}
