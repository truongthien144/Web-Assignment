<?php
    require_once('../connect_db.php');
    require_once('../function/price.php');
    echo '<table class="table  table-striped table-bordered">
    <tr class="header-text-cthd text">
        <th class="text-center">Mã sản phẩm</th>
        <th class="text-center">Kích thước</th>
        <th class="text-center">Đơn giá</th>
        <th class="text-center">Số lượng</th>
    </tr>';
    $id=$_POST['prod_id'];
    update_number($id, $conn);

    function update_number($id, $conn){
    $sql1="SELECT `prod_id`,`size`,`price`,`quantity` FROM `order-detail`  where `order-detail`.`order_id`='".$id."'";
    $query1= mysqli_query($conn,$sql1);
       while($row=mysqli_fetch_array($query1)){
        echo '
        <tr class="text text1">
            <td class="text-center">'.$row['prod_id'].'</td>
            <td class="text-center size">'.$row['size'].'</td>
            <td class="text-center">'.formatPrice($row['price']).'đ</td>
            <td class="text-center">'.$row['quantity'].'</td>
        </tr>';
    }
    echo '</table>';
    }
?>
