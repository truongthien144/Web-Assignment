let main_img = document.querySelector(".main-image>img");
let thumbnails = document.querySelectorAll(".thumbnails>img");
let zoom = document.querySelector(".gallery-zoom");
let inner_img = document.querySelector(".gallery-content>img");
let exit = document.querySelector(".controller__exit");
let next = document.querySelector(".controller__next");
let prev = document.querySelector(".controller__prev");
let cur_index = 0;
let id = document.querySelector(".product-detail__name").getAttribute("prod_id");

thumbnails.forEach((item, index) => {
    item.onclick = function () {
        cur_index = index;
        main_img.src = thumbnails[cur_index].src;
        let checked_img = document.querySelector("img--checked");
        checked_img.classList.remove("img--checked");
        checked_img.classList.remove("checked");
        thumbnails[cur_index].classList.add("img--checked");
        thumbnails[cur_index].classList.add("checked");
    };
});

main_img.onclick = function () {
    zoom.classList.add("show");
    showMainImg();
};

function showMainImg() {
    inner_img.src = thumbnails[cur_index].src;

    if (cur_index === 0) {
        prev.classList.add = "hide";
    } else {
        prev.classList.remove = "hide";
    }

    if (cur_index === thumbnails.length - 1) {
        next.classList.add = "hide";
    } else {
        next.classList.remove = "hide";
    }
}

next.onclick = function () {
    if (cur_index < thumbnails.length - 1) {
        cur_index++;
        showMainImg();
    }
};

prev.onclick = function () {
    if (cur_index > 0) {
        cur_index--;
        showMainImg();
    }
};

exit.onclick = function () {
    zoom.classList.remove("show");
};

let sizes = document.querySelectorAll(".product-detail__size > button.product-detail__size");
let sizeName = document.querySelector(".product-detail__size--label > span");
let quantityInput = document.querySelector("#quantity");

sizes.forEach(function (item) {
    item.onclick = function () {
        let checked_size = document.querySelector(".size--checked");
        if (checked_size != null) {
            checked_size.classList.remove("size--checked");
            checked_size.classList.remove("checked");
        }
        item.classList.add("size--checked");
        item.classList.add("checked");
        quantityInput.value = 1;
        sizeName.innerHTML = item.innerHTML;
        get_product(id, sizeName.innerHTML);
    };
});

let plus = document.querySelector(".fa-plus");
let minus = document.querySelector(".fa-minus");

plus.onclick = function () {
    soluonginput = parseInt(quantityInput.value);
    soluonginputmax = parseInt(quantityInput.max);
    if (soluonginput < soluonginputmax) {
        quantityInput.value++;
    }
};

minus.onclick = function () {
    soluonginput = parseInt(quantityInput.value);
    soluonginputmax = parseInt(quantityInput.max);
    if (soluonginput > 1) {
        quantityInput.value--;
    }
};

let tab_header = document.querySelectorAll(".tab__header > span");
let tab_content = document.querySelectorAll(".tab__content > div");

tab_header.forEach((item, index) => {
    item.onclick = function () {
        let active_tab_header = document.querySelector(".tab__header--active");
        let active_tab_body = document.querySelector(".tab__content--active");
        active_tab_header.classList.remove("tab__header--active");
        item.classList.add("tab__header--active");
        active_tab_body.classList.remove("tab__content--active");
        tab_content[index].classList.add("tab__content--active");
    };
});

let btn_buy_now = document.querySelector(".product-detail__buy-now");
let btn_add_to_cart = document.querySelector(".product-detail__add-to-cart");

btn_buy_now.onclick = function () {
    if (isLoggedIn()) {
        let size = document.querySelector(".size--checked");
        if (size == null) {
            alert("Vui lòng chọn size");
        } else {
            update_number(id, quantityInput.value, sizeName.innerHTML);
            input_number = parseInt(quantityInput.value);
            window.location.href = "cart.php?prod_id=" + id + "&size=" + sizeName.innerHTML;
        }
    }
};

btn_add_to_cart.onclick = function () {
    if (isLoggedIn()) {
        let size = document.querySelector(".size--checked");
        if (size == null) {
            alert("Vui lòng chọn size");
        } else {
            alert("Đã thêm vào giỏ hàng");
            update_number(id, quantityInput.value, sizeName.innerHTML);
        }
    }
};

function update_number(id, values, size) {
    var xhttp = new XMLHttpRequest();
    xhttp.open("POST", "function/update_product-detail.php");
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

    xhttp.onreadystatechange = function () {
        if (xhttp.readyState === 4) {
            if (xhttp.status != 200) {
                alert("Đã có lỗi xảy ra, vui lòng thử lại sau");
            }
        }
    };
    xhttp.send("U=update&prod_id=" + id + "&quantity=" + values + "&size=" + size);
}

function get_product(id, size) {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            text = this.responseText;
            quantityInput.max = text;
        }
    };
    xhttp.open("POST", "function/process_size.php");
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhttp.send("U=2&prod_id=" + id + "&size=" + size);
}

function isLoggedIn() {
    let login_submenu = document.querySelector(".login-submenu");
    if (login_submenu == null) {
        alert("Vui lòng đăng nhập để thực hiện chức năng này");
        window.location.href = "login.php";
        return false;
    }
    return true;
}
