<?php
session_start();
$valid = true;
if (!isset($_SESSION['username'])) {
    $valid = false;
} else {
    require 'connect_db.php';
    $user = $_SESSION['username'];
    $sql = "SELECT account_type FROM account WHERE username = '$user'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $type = $result->fetch_assoc()['account_type'];
        if ($type == 0) {
            $valid = false;
        }
    } else {
        $valid = false;
    }
}

if ($valid) {
    header('location: ./admin/index.php');
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sneaker Vintage</title>
    <link type="image/png" sizes="32x32" rel="icon" href="https://img.icons8.com/?size=100&id=YYb851RUsG0r&format=png&color=000000">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="./style/footer.css">
    <link rel="stylesheet" href="./style/menu.css">
    <script defer src="./js/menu.js"></script>