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
                    <?php
                    require 'connect_db.php';
                    $customer = $_SESSION['username'];
                    $check = isset($_GET['prod_id']) ? "true" : "false";
                    $sql = "SELECT cart.*, product.product_name, product.price, product.discount FROM cart JOIN product ON cart.prod_id = product.prod_id";
                    ?>
                    <!-- <div class="cart-content">

                    </div>
                    <div class="cart-collaterals">

                    </div> -->
                </div>
            </div>
        </div>


        <?php
        loadFooter();
        ?>