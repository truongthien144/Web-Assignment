<?php
require_once 'site.php';
require_once 'function/load-object.php';
loadHeader();
// echo '<script defer src="../js/search_admin.js"></script>';
?>
<div class="container" style="height: 100%;">
    <div class="div-text"><h1 class="text-center my-4">Thông tin khách hàng</h1></div>
    <table class="table table-striped table-bordered">
        <tr class="text">
            <th class="text-center">Họ tên</th>
            <th class="text-center">Địa chỉ</th>
            <th class="text-center">Email</th>
            <th class="text-center">Số điện thoại</th>
            <th class="text-center">Địa chỉ nhận hàng</th>
        </tr>
            <?php
require '../connect_db.php';
require_once 'function/process_search.php';
if (isset($_GET['key'])) {
	$key = $_GET['key'];
	tim_khachhang($key);
} else {
	$sql = "SELECT * FROM account where account_type = '0'";
	$query = mysqli_query($conn, $sql);
	while ($row = mysqli_fetch_array($query)) {
		load_customer($row);
	}
}
?>
    </table>
</div>
<?php
loadFooter();
?>
