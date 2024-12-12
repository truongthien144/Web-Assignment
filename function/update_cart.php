<?php
session_start();
require "../connect_db.php";
$customer = $_SESSION['username'];
if ($_POST['U'] == 'update') {
    update_number($customer, $conn);
}
if ($_POST['U'] == 'delete') {
    delete_prod($customer, $conn);
}
function update_number($customer, $conn)
{
    $sql1 = "UPDATE cart SET quantity='" . $_POST['quantity'] . "' where username='" . $customer . "' AND prod_id='" . $_POST['prod_id'] . "' AND size='" . $_POST['size'] . "' ";
    mysqli_query($conn, $sql1);
}
function delete_prod($customer, $conn)
{
    $sql2 = "DELETE FROM cart WHERE username='" . $customer . "' AND prod_id='" . $_POST['prod_id'] . "' AND size='" . $_POST['size'] . "'";
    mysqli_query($conn, $sql2);
}
