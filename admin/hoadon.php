<?php
require_once 'site.php';
loadHeader();
?>
<div class="container order-container" style="height: 100%;">
    <div class="order-info">
        <div class="div-text">
            <h1 class="text-center my-4">Danh sách hóa đơn</h1>
        </div>
        <table class="table table-striped table-bordered">
            <tr class="text">
                <td class="text-center">ID Hóa đơn</td>
                <td class="text-center">Khách hàng</td>
                <td class="text-center">Người nhận hàng</td>
                <td class="text-center">SĐT nhận hàng</td>
                <td class="text-center">Địa chỉ nhận hàng</td>
                <td class="text-center">Số lượng</td>
                <td class="text-center">Tổng tiền</td>
                <td class="text-center">Ngày thanh toán</td>
            </tr>
            <?php
require_once '../connect_db.php';
require_once 'function/process_search.php';
if (isset($_GET['key'])) {
	$key = $_GET['key'];
	tim_hoadon($key);
} else {
	$sql = "SELECT `order`.* ,`quantity` *`price` AS 'tien',SUM('tien') ,SUM(`quantity`) AS 'soluong' FROM `order_detail` ,`order` where `order_detail`.`order_id`=`order`.`order_id` GROUP BY `order_detail`.`order_id`";
	$query = mysqli_query($conn, $sql);
	while ($row = mysqli_fetch_array($query)) {
		load_order($row);
	}
}
?>
        </table>
    </div>
    <div class="order-detail-info">
        <div class="div-text">
            <p class="text-title">Chi tiết hóa đơn</p>
        </div>
        <div class="heder-cthd"></div>
    </div>
</div>
<script src="js/hoadon_admin.js"></script>
<?php
loadFooter();
?>
