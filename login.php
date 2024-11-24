<?php
    require_once('site.php');
    loadHeader();
    // if (isset($_POST['username']) && isset($_POST['password'])) {
    //     $username = $_POST['username'];
    //     $password = md5($_POST['password']);
    //     require_once('connect_db.php');
    //     $sql = "SELECT password, account_type FROM account WHERE username='$username' AND password='$password' LIMIT 1";
    //     $result = $conn->query($sql);
    //     if ($row = $result->fetch_array())
    //     {
    //         $_SESSION['username'] = $username;
    //          if ($row['account_type'] == 0) {
    //             header('location: ./');
    //             exit();
    //         } else {
    //             header('location: admin/index.php');
    //             exit();
    //         }
    //     } else {
    //         echo "<script>
    //                 history.back();
    //                 alert('Sai tên đăng nhập hoặc mật khẩu!');
    //             </script>";
    //         unset($_POST);
    //         exit();
    //     }
    // }
    // echo '<link rel="stylesheet" href="style/login.css">';
    loadMenu();
?>
<section class="container mx-auto mb-5 col-sm-12 col-md-6 col-lg-6 col-xl-4">
        <form method="POST" class="dangnhap" accept-charset="ASCII">
            <h2 class="text-center py-2">Đăng nhập</h2>
            <div class="form-group bg-white p-4 border rounded" style="box-shadow: 0px 5px 15px 0px rgba(0, 0, 0, 0.35);">
                <input type="text" name="username" id="username" placeholder="Username" class="form-control my-3" required>
                <input type="password" name="password" id="password" placeholder="Password" class="form-control my-3" required>
                <div class="btdangnhap d-grid">
                    <button type="submit" name="dangky" class="login btn btn-primary text-capitalize">Đăng nhập</button>
                </div>
                <div class="d-flex align-items-center my-3">
                    <hr class="flex-grow-1 border-secondary">
                    <span class="mx-2 text-muted">or</span>
                    <hr class="flex-grow-1 border-secondary">
                </div>
                <div class="btdangky mx-auto text-center">
                    <button type="button" name="dangky" class="register btn btn-success text-capitalize" onclick="window.location.href='register.php';">Đăng ký tài khoản mới</button>
                </div>
            </div>
        </form>
</section>
<?php
    loadFooter();
?>
