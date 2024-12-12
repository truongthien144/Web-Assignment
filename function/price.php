<?php
function getSalePercent($price, $discount)
{
    return round($discount / $price * 100);
}

function getDiscountedPrice($price, $discount)
{
    return $price - $discount;
}

function formatPrice($number)
{
    return number_format($number, 0, '', '.');
}
