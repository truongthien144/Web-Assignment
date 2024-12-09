<?php
function getSalePercent($price, $discounted_price)
{
    return round(($price - $discounted_price) / $price * 100);
}

function formatPrice($number)
{
    return number_format($number, 0, '', '.');
}
