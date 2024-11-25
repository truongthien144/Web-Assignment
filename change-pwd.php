<?php
require_once 'site.php';
// require 'connect_db.php';
// if (!empty($_POST['username']) && !empty($_POST['password_cu']) && !empty($_POST['password_moi'])) {
// 	$username = $_POST['username'];
// 	$password_cu = md5($_POST['password_cu']);
// 	$password_moi = md5($_POST['password_moi']);
// 	$sql = "SELECT account_type FROM account WHERE username ='" . $username . "' AND password ='" . $password_cu . "'";
// 	$row = mysqli_query($conn, $sql);
// 	$count = mysqli_num_rows($row);
// 	if ($count > 0) {
// 		$sql_update = mysqli_query($conn, "UPDATE account SET password ='" . $password_moi . "' WHERE username = '$username'");
// 		$type = $row->fetch_assoc()['account_type'];
// 		echo "<script>
//                     alert('Đổi mật khẩu thành công!');
//                     if ($type == 0) {
//                         window.location.href = 'index.php';
//                     } else {
//                         window.location.href = 'admin/index_admin.php';
//                     }
//                 </script>";
// 	} else {
// 		echo "<script>
//                     alert('Sai tài khoản hoặc mật khẩu cũ! Vui lòng nhập lại');
//                     history.back();
//                 </script>";
// 		unset($_POST);
// 	}
// }
loadHeader();
loadMenu();
?>

<section class="container mx-auto mb-5 col-sm-12 col-md-6 col-lg-6 col-xl-4">
        <form method="post" action="" class="doimk" accept-charset="ASCII">
            <h2 class="text-center py-2">Đổi Mật Khẩu</h2>
            <div class="form-group bg-white p-4 border rounded" style="box-shadow: 0px 5px 15px 0px rgba(0, 0, 0, 0.35);">
                <div class="input-group mb-3">
                    <label for="username" class="input-group-text"><i class="fa-solid fa-user"></i></label>
                    <input type="text" name="username" id="username" placeholder="Tài khoản" class="form-control" required>
                </div>
                <div class="input-group mb-3">
                    <label for="password_cu" class="input-group-text"><i class="fa-solid fa-lock"></i></label>
                    <input type="password" name="password_cu" id="password_cu"
                        placeholder="Mật khẩu hiện tại" class="form-control" required>
                </div>
                <div class="input-group mb-3">
                    <label for="password_moi" class="input-group-text"><i class="fa-solid fa-lock"></i></label>
                    <input type="password" id="password_moi" name="password_moi" 
                        placeholder="Mật khẩu mới" class="form-control" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary text-capitalize">Lưu thay đổi</button>
                </div>
            </div>
        </form>
</section>
<?php
loadFooter();
?>
