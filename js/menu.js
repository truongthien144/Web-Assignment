let sp_timkiem = document.querySelector(".sp_timkiem");
let keyword_input = document.getElementById("input1");
function search(event) {
    event.preventDefault();
    const input = document.getElementById("input1").value;
    const url = `products.php?filter=prod_name&value=${encodeURIComponent(input)}`;
    window.location.href = url;
}

function dangxuat(){
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            window.location.href = "login.php";
       }
    };
    xhttp.open("POST", "function/logout.php", true);
    xhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhttp.send('');
}
