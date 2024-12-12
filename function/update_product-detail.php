<?php
session_start();
require_once "../connect_db.php";
$customer = $_SESSION['username'];
$prod_id = $_POST['prod_id'];
$prod_size = $_POST['size'];
$quantity = $_POST['quantity'];

if (check($conn)) {
    update_number($customer, $conn);
} else {
    insert_pro($customer, $conn);
}

function update_number($customer, $conn)
{
    $sql1 = "UPDATE cart SET quantity= " . $_POST['quantity'] . " + quantity WHERE username='" . $customer . "' AND prod_id='" . $_POST['prod_id'] . "' AND size='" . $_POST['size'] . "' ";
    mysqli_query($conn, $sql1);
}

function insert_pro($customer, $conn)
{
    $sql1 = "INSERT INTO `cart`(`username`, `prod_id`, `size`, `quantity`) VALUES ('" . $customer . "','" . $_POST['prod_id'] . "','" . $_POST['size'] . "','" . $_POST['quantity'] . "')";
    mysqli_query($conn, $sql1);
}

function check($conn)
{
    $sql1 = "SELECT prod_id FROM cart WHERE prod_id='" . $_POST['prod_id'] . "' AND size='" . $_POST['size'] . "' ";
    $query = mysqli_query($conn, $sql1);
    return mysqli_num_rows($query) > 0;
}
