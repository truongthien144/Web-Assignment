<?php
require_once 'site.php';
loadHeader();
?>
<div class="container order-container vh-100">
    <div class="order-info">
        <div class="div-text">
            <h1 class="text-center my-4">Danh sách hóa đơn</h1>
        </div>
        <table class="table table-bordered table-hover">
            <tr class="text table-secondary">
                <td class="text-center fw-bold">ID Hóa đơn</td>
                <td class="text-center fw-bold">Khách hàng</td>
                <td class="text-center fw-bold">Người nhận hàng</td>
                <td class="text-center fw-bold">SĐT nhận hàng</td>
                <td class="text-center fw-bold">Địa chỉ nhận hàng</td>
                <td class="text-center fw-bold">Số lượng</td>
                <td class="text-center fw-bold">Tổng tiền</td>
                <td class="text-center fw-bold">Ngày thanh toán</td>
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
    <div class="order-detail-info bg-light">
        <div class="div-text">
            <h3 class="text-center my-2 p-2">Chi tiết hoá đơn</h3>
        </div>
        <div class="header-cthd"></div>
    </div>
</div>
<script src="js/hoadon_admin.js"></script>

<?php
loadFooter();
?>