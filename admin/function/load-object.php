<?php
require_once '../function/price.php';
require_once '../function/image.php';

function load_product($row)
{
    $directory = "../images/products/" . $row['product_id'];
    $hinh = getImages($directory);
    $calc = getCalcUnit($row['calc_unit']);
    $price = formatPrice($row['promo_price']);
    $price = $price == 0 ? '' : $price;
    echo '
        <tr class="text text2">
            <td class="text-center">' . $row['cate_name'] . '</td>
            <td class="text-center">' . $row['prod_name'] . '</td>
            <td class="text-center"><img class="hinhanh_sp" src="' . $directory . '/' . $hinh[0] . '" alt=""></td>
            <td class="text-center">' . formatPrice($row['price']) . 'đ</td>
            <td class="text-center">' . $row['promo_code'] . '</td>
            <td class="text-center">' . $price . $calc . '</td>
            <td class="text-center">' . $row['quantity'] . '</td>
            <td class="text-center">' . $row['date_added'] . '</td>
        </tr>';
}

function load_customer($row)
{
    echo '
        <tr class="text">
            <td class="text-center">' . $row['fullname'] . '</td>
            <td class="text-left">' . $row['current_address'] . '</td>
            <td class="text-left">' . $row['email'] . '</td>
            <td class="text-center">' . $row['phone_number'] . '</td>
            <td class="text-left">' . $row['shipping_address'] . '</td>
        </tr>';
}

function load_order($row)
{
    echo '
        <tr class="text text1 text2" id_order="' . $row['order_id'] . '" style="cursor: pointer">
            <td class="text-center">' . $row['order_id'] . '</td>
            <td class="text-left">' . $row['username'] . '</td>
            <td class="text-left">' . $row['fullname'] . '</td>
            <td class="text-center">' . $row['phone_number'] . '</td>
            <td class="text-left">' . $row['shipping_address'] . '</td>
            <td class="text-center">' . $row['soluong'] . '</td>
            <td class="text-center">' . formatPrice($row['tien']) . 'đ</td>
            <td class="text-center">' . $row['pay_date'] . '</td>
        </tr>';
}

function convertVNKey($key)
{
    $key = "CONCAT('%', CONVERT('$key', BINARY), '%')";
    return $key;
}
