<?php
require_once '../function/price.php';
require_once '../function/image.php';

function load_product($row)
{
    $directory = "../img/product/" . $row['product_id'];
    if (!file_exists($directory)) {
        $directory = "../img/product/DEFAULT";
    }
    if (empty($directory)) {
        $hinh = getImages('img/product/DEFAULT');
    }
    $hinh = getImages($directory);
    $price = $row['price'];
    $price = $price == 0 ? '' : $price;
    $max_quantity = $row['s'] + $row['m'] + $row['l'] + $row['xl'];
    echo '
        <tr class="text text2">
            <td class="text-center">' . $row['product_id'] . '</td>
            <td class="text-center">' . $row['product_name'] . '</td>
            <td class="text-center">' . $row['subcategory_name'] . '</td>
            <td class="text-center"><img style="max-height:50px;" class="hinhanh_sp img-thumbnail" src="' . $directory . '/' . $hinh[0] . '" alt=""></td>
            <td class="text-center">' . formatPrice($row['price']) . 'đ</td>
            <td class="text-center">' . formatPrice($row['discount']) . '</td>
            <td class="text-center">' . $max_quantity . '</td>
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
