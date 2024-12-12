<?php
require_once('site.php');
loadHeader();
// echo '<link rel="stylesheet" href="style/base.css">
//     <link rel="stylesheet" href="style/register.css"/>
//     <script defer src="js/register.js"></script>">';
loadMenu();
if (isset($_POST['btn-register'])) {
    $username = $_POST['username'];
    $password = md5($_POST['password']);
    $repassword = md5($_POST['re-password']);
    $fullname = $_POST['fullname'];
    $currentaddress = $_POST['current-address'];
    $email = $_POST['email'];
    $phonenumber = $_POST['phone-number'];
    $shippingaddress  = $_POST['shipping-address'];
    require 'connect_db.php';

    $sql = "SELECT * FROM account WHERE username = '$username' OR email = '$email' OR phone_number = '$phonenumber' LIMIT 1";
    $result = mysqli_query($conn, $sql);
    if (mysqli_num_rows($result) > 0) {
        echo '<script>alert("Tên đăng ký, email hoặc số điện thoại đã được sử dụng!"); history.back();</script>';
    } else {
        $sql =  "INSERT INTO account VALUES ('$username','$password', FALSE,'$fullname','$currentaddress','$email','$phonenumber','$shippingaddress')";
        mysqli_query($conn, $sql);
        echo '<script>alert("Đăng ký thành công!"); window.location="login.php";</script>';
        exit();
    }
}
?>
<section class="container mx-auto mb-5 col-sm-12 col-md-6 col-lg-6 col-xl-4">
    <form method="post" action="" class="register" onsubmit="return validateForm();">
        <h2 class="text-center py-2">Tạo tài khoản mới</h2>
        <div class="form-group bg-white p-4 border rounded" style="box-shadow: 0px 5px 15px 0px rgba(0, 0, 0, 0.35);">
            <div class="user__detail">
                <h3 class="text-center mb-3 text-primary">Thông tin</h3>
                <div class="input-group mb-3">
                    <label for="fullname" class="input-group-text col-2 fw-bold">Họ tên<span class="text-danger">*</span></label>
                    <input type="text" class="form-control col-9" name="fullname" id="fullname"
                        placeholder="Nhập họ và tên">
                    <span class="form-message"></span>
                </div>
                <div class="input-group mb-3">
                    <label for="email" class="input-group-text text-center fw-bold col-2">Email<span class="text-danger">*</span></label>
                    <input type="email" class="form-control col-9" name="email" id="email"
                        placeholder="Nhập email">
                    <span class="form-message"></span>
                </div>
                <div class="input-group mb-3">
                    <label for="phone-number" class="input-group-text text-center fw-bold col-2">SĐT<span class="text-danger">*</span></label>
                    <input type="tel" name="phone-number" id="phone-number" class="form-control col-9"
                        title="Số điện thoại bao gồm 10 chữ số bắt đầu bằng số 0"
                        placeholder="Nhập số điện thoại">
                    <span class="form-message"></span>
                </div>
                <div class="mb-3">
                    <label for="current-address" class="form-label fw-bold">Chỗ ở hiện tại <span class="text-danger">*</span></label>
                    <textarea class="form-control" name="current-address" id="current-address"
                        placeholder="Địa chỉ-Đường-Phường-Quận/Huyện-Tỉnh/TP"></textarea>
                    <span class="form-message"></span>
                </div>
                <div class="mb-3">
                    <label for="shipping-address" class="form-label fw-bold">Địa chỉ giao hàng <span class="text-danger">*</span></label>
                    <textarea class="form-control" name="shipping-address" id="shipping-address"
                        placeholder="Địa chỉ-Đường-Phường-Quận/Huyện-Tỉnh/TP"></textarea>
                    <span class="form-message"></span>
                </div>
            </div>
            <div class="account__detail">
                <h3 class="text-center mb-3 text-primary">Tài khoản</h3>
                <div class="input-group flex-nowrap mb-3">
                    <label for="username" class="input-group-text"><i class="fa-solid fa-user"></i></label>
                    <input type="text" class="form-control" name="username" id="username"
                        placeholder="Nhập tên tài khoản" title="Bao gồm 5-20 kí tự, chỉ chứa A-Z, a-z, 0-9">
                    <span class="form-message"></span>
                </div>
                <div class="input-group flex-nowrap mb-3">
                    <label for="password" class="input-group-text"><i class="fa-solid fa-lock"></i></label>
                    <input type="password" class="form-control" name="password" id="password"
                        placeholder="Tạo mật khẩu mới" title="Bao gồm 5-20 kí tự, chỉ chứa A-Z, a-z, 0-9">
                    <span class="form-message"></span>
                </div>
                <div class="input-group flex-nowrap mb-3">
                    <label for="re-password" class="input-group-text"><i class="fa-solid fa-lock"></i></label>
                    <input type="password" class="form-control" name="re-password" id="re-password" placeholder="Nhập lại mật khẩu">
                    <span class="form-message"></span>
                </div>
            </div>
            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" id="gridCheck">
                <label class="form-check-label" for="gridCheck">
                    Gửi cho tôi khi có thông báo mới.
                </label>
            </div>
            <div class="form-group d-grid">
                <button type="submit" name="btn-register" id="btn-register" class="btn btn-success text-capitalize">Đăng Ký</button>
            </div>
        </div>
    </form>
</section>
<?php
loadFooter();
?>