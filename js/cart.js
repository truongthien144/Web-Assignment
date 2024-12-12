var quantity = document.querySelectorAll(".quantity");
var total_price = document.querySelectorAll(".product-total>span");
var total_quantity = document.querySelector(".total-quantity>span");
var final_price = document.querySelector(".final-price>span");
var btn_checkout = document.querySelector(".checkout-button");

var cartTableBody = document.querySelector(".cart-content>table>tbody");
var cartTableHead = document.querySelector(".cart-content>table>thead");

function setWidthCartTableHead() {
    if (cartTableBody.scrollHeight > cartTableBody.clientHeight) {
        cartTableHead.style.setProperty("width", "calc(100% - 1em)");
    } else {
        cartTableHead.style.setProperty("width", "100%");
    }
}
setWidthCartTableHead();

function redirectToCheckout(check) {
    if (total_quantity.innerHTML > 0) {
        if (check == false) {
            window.location.href = "delivery.php";
        } else {
            var id = document.querySelector(".cart-item");
            var size = document.querySelector(".size");
            var get_id = id.getAttribute("product_id");
            var get_size = size.getAttribute("product_size");
            window.location.href = "delivery.php?prod_id=" + get_id + "&size=" + get_size;
        }
    } else {
        alert("Giỏ hàng của bạn đang trống");
    }
}

function removeItem(x) {
    var confirmation = confirm("Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng không?");
    if (confirmation == true) {
        var tr = x.parentElement.parentElement;
        var item_quantity = tr.children[4].children[1].value;
        var prod_total = tr.children[5].children[0].innerHTML
            .replaceAll(".", "")
            .replaceAll("đ", "");

        var old_total_quantity = total_quantity.innerHTML;
        var current_total_quantity = old_total_quantity - item_quantity;
        total_quantity.innerHTML = current_total_quantity;

        var old_final_price = final_price.innerHTML.replaceAll(".", "").replaceAll("đ", "");
        var current_final_price = old_final_price - prod_total;
        final_price.innerHTML = current_final_price.toLocaleString("de-DE") + "đ";

        tr.remove();
        id = tr.getAttribute("product_id");
        size1 = tr.children[2].children[0].children[1].getAttribute("product_size");
        deleteItem(id, size1);
        setWidthCartTableHead();
    }
    quantity = document.querySelectorAll(".quantity");
    total_price = document.querySelectorAll(".product-total>span");
}

function deleteItem(id, size) {
    var xhttp = new XMLHttpRequest();
    xhttp.open("POST", "function/update_cart.php", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhttp.send("U=delete&prod_id=" + id + "&size=" + size);
}

function onChangeValue(item) {
    console.log(item.value);
    var so_luong = parseInt(item.value);
    var quantity_col = item.parentElement;
    var price = quantity_col.previousElementSibling.children[0].innerHTML;
    price = price.replaceAll(".", "").replaceAll("đ", "");
    console.log(price);
    var new_price = so_luong * price;
    quantity_col.nextElementSibling.children[0].innerHTML = new_price.toLocaleString("de-DE") + "đ";
    var tong_slsp = totalItem(quantity);
    total_quantity.innerHTML = tong_slsp;
    var tong_tien = totalPrice(total_price);

    final_price.innerHTML = tong_tien.toLocaleString("de-DE") + "đ";
    id = quantity_col.parentElement.getAttribute("product_id");
    size1 =
        quantity_col.parentElement.children[2].children[0].children[1].getAttribute("product_size");
    update_quantity(id, size1, so_luong);
}

function update_quantity(id, size, quantity) {
    var xhttp = new XMLHttpRequest();
    xhttp.open("POST", "function/update_cart.php", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhttp.send("U=update&prod_id=" + id + "&quantity=" + quantity + "&size=" + size);
}

function totalItem(quantity) {
    var total = 0;
    for (var i = 0; i < quantity.length; i++) {
        total += parseInt(quantity[i].value);
    }
    return total;
}

function totalPrice(total_price) {
    var total = 0;
    for (var i = 0; i < total_price.length; i++) {
        var price = total_price[i].innerHTML;
        price = price.replaceAll(".", "").replaceAll("đ", "");
        total += parseInt(price);
    }
    return total;
}

let plus = document.querySelectorAll(".fa-plus");
let minus = document.querySelectorAll(".fa-minus");
plus.forEach((item) => {
    item.onclick = function () {
        let quantityInput = item.previousElementSibling;
        soluonginput = parseInt(quantityInput.value);
        soluonginputmax = parseInt(quantityInput.max);
        if (soluonginput < soluonginputmax) {
            quantityInput.value++;
            onChangeValue(quantityInput);
        }
    };
});

minus.forEach((item) => {
    item.onclick = function () {
        let quantityInput = item.nextElementSibling;
        soluonginput = parseInt(quantityInput.value);
        soluonginputmax = parseInt(quantityInput.max);
        if (soluonginput > 1) {
            quantityInput.value--;
            onChangeValue(quantityInput);
        }
    };
});
