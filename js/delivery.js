document.addEventListener("DOMContentLoaded", function () {
    const qrCodeImage = document.querySelector('img[alt="QR code"]');
    const codRadio = document.getElementById("cod");
    const qrRadio = document.getElementById("qr");

    function toggleQRCode() {
        if (qrRadio.checked) {
            qrCodeImage.style.display = "block";
        } else {
            qrCodeImage.style.display = "none";
        }
    }

    codRadio.addEventListener("change", toggleQRCode);
    qrRadio.addEventListener("change", toggleQRCode);

    toggleQRCode();
});
