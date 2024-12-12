<?php
require_once 'site.php';
require_once 'function/load-object.php';
loadHeader();
?>
<div class="container" style="height: 100%;">
    <div class="div-text">
        <h1 class="text-center my-4">Danh sách sản phẩm</h1>
    </div>
    <table class="table table-striped table-bordered">
        <div>
            <tr class="text">
                <th class="text-center">Tên danh mục</th>
                <th class="text-center">Tên sản phẩm</th>
                <th class="text-center">Hình ảnh</th>
                <th class="text-center">Đơn giá</th>
                <th class="text-center">Mã giảm giá</th>
                <th class="text-center">Số tiền được giảm</th>
                <th class="text-center">Số lượng</th>
                <th class="text-center">Ngày nhập</th>
            </tr>
            <?php
require_once '../connect_db.php';
require_once 'function/process_search.php';
if (isset($_GET['key'])) {
	$key = $_GET['key'];
	tim_sanpham($key);
} else {
	$sql = "SELECT `subcategory_name`, `product_id`, `product_name`, `product`.`subcategory_id`, `discount`, `price`, `color`, `description`, `overview`, `category_name` FROM `subcategory` JOIN `product` on `subcategory`.`subcategory_id`=`product`.`subcategory_id` JOIN `category` on `subcategory`.`category_id`=`category`.`category_id`";
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
