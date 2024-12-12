<?php
require_once 'site.php';
require_once 'function/load-object.php';
loadHeader();
?>
<div class="container" class="vh-100">
    <div class="div-text">
        <h1 class="text-center my-4">Danh sách sản phẩm</h1>
    </div>
    <table class="table table-striped table-bordered">
        <div>
            <tr class="text">
                <th class="text-center">Mã sản phẩm</th>
                <th class="text-center">Tên sản phẩm</th>
                <th class="text-center">Tên danh mục</th>
                <th class="text-center">Hình ảnh</th>
                <th class="text-center">Đơn giá</th>
                <th class="text-center">Số tiền được giảm</th>
                <th class="text-center">Số lượng</th>
            </tr>
            <?php
            require_once '../connect_db.php';
            require_once 'function/process_search.php';
            if (isset($_GET['key'])) {
                $key = $_GET['key'];
                tim_sanpham($key);
            } else {
                $sql = "SELECT `subcategory_name`, `product_id`, `product_name`,`price`, `discount`, `category_name`, `s`, `m`, `l`, `xl` FROM `subcategory` JOIN `product` ON `subcategory`.`subcategory_id`=`product`.`subcategory_id` JOIN `category` ON `subcategory`.`category_id`=`category`.`category_id` JOIN `size` ON `product`.`product_id`=`size`.`prod_id`";
                $query = mysqli_query($conn, $sql);
                while ($row = mysqli_fetch_array($query)) {
                    load_product($row);
                }
            }
            ?>
        </div>
    </table>
</div>
<?php
loadFooter();
?>