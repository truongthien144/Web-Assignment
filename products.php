<?php
require_once 'site.php';
loadHeader();
echo '<link rel="stylesheet" href="style/products.css">
    <script defer type="text/javascript" src="js/products.js"></script>';
loadMenu();
require_once 'function/price.php';
require_once 'function/image.php';
if (empty($_GET['filter']) || empty($_GET['value'])) {
    echo '<script>window.location.href = "./"</script>';
}
$filter = $_GET['filter'];
$value = $_GET['value'];
$field = !empty($_GET['field']) ? $_GET['field'] : '';
$sort = !empty($_GET['sort']) ? $_GET['sort'] : '';
$current_page = !empty($_GET['page']) && $_GET['page'] > 0 ? $_GET['page'] : 1;
?>

<section class="products">
    <div class="products-top">
        <div class="products-category">
            <span class="filter-phrase"></span>
            <span class="keyword"></span>
            <span class="subkeyword"></span>
            <span class="quantity"></span>
        </div>
        <form class="products-sort-by" method="GET" onsubmit="SortProductsPage();">
            <input type="hidden" name="filter" value="<?php echo $filter; ?>">
            <input type="hidden" name="value" value="<?php echo $value; ?>">
            <input type="hidden" name="field" value="<?php echo $field; ?>">
            <input type="hidden" name="sort" value=<?php echo $sort; ?>>
            <select id="order">
                <option value="">Sắp xếp</option>
                <option value="product name" <?php if ($field === 'productName') echo 'selected'; ?>>Tên sản phẩm</option>
                <option value="price asc" <?php if ($field === 'Price' && $sort === 'asc') echo 'selected'; ?>>Giá tăng dần</option>
                <option value="price desc" <?php if ($field === 'Price' && $sort === 'desc') echo 'selected'; ?>>Giá giảm dần</option>
            </select>
            <button type="submit" class="btn btn-info">Lọc</button>
            <input type="hidden" name="page" value=<?php echo $current_page; ?>>
        </form>
    </div>
    <div class="products-content">
        <?php
        require 'connect_db.php';
        switch ($filter) {
            case 'prod_name':
                $where = "WHERE UPPER(productName) LIKE UPPER('%$value%')";
                $keyword = $value;
                break;
            case 'category_id':
                $sql = "SELECT category_name FROM category WHERE $filter = '$value' LIMIT 1";
                $result = $conn->query($sql);
                $keyword = $result->fetch_array()[0];
                $where = "WHERE Category_id = '$value'";
                break;
            case 'subcategory_id':
                $sql = "SELECT subcategory_name FROM subcategory WHERE $filter = '$value' LIMIT 1";
                $result = $conn->query($sql);
                $subkeyword = $result->fetch_array()[0];
                $sql = "SELECT category_name FROM category WHERE category_id = (SELECT category_id FROM subcategory WHERE $filter = '$value')";
                $result = $conn->query($sql);
                $keyword = $result->fetch_array()[0];
                $where = "WHERE Subcategory_id = '$value'";
                break;
            case 'sale':
                $where = "WHERE Discount > 0";
                $keyword = 'Khuyến mãi';
                break;
            default:
                $where = "WHERE 1";
                break;
        }
        $sql = "SELECT product_id, Category_id, Subcategory_id, productName, Stock, Price, Discount, PriceWithDiscount FROM product" . $where;
        $result = $conn->query($sql);
        $total_products = $result->num_rows;
        $products_per_page = 12;
        $total_pages = ceil($total_products / $products_per_page);
        $start = ($current_page - 1) * $products_per_page;

        if (empty($field)) {
            $sql .= " ORDER BY product_id LIMIT $products_per_page OFFSET $start";
        } else {
            $sql .= " ORDER BY $field $sort LIMIT $products_per_page OFFSET $start";
        }
        echo <<< FILTER_RESULT
        <script>
        let phrase = document.querySelector('.filter-phrase');
        let keywordSpan = document.querySelector('.keyword');
        let subkeywordSpan = document.querySelector('.subkeyword');
        let quantity = document.querySelector('.quantity');

        if ('$filter' === 'prod_name') {
            phrase.innerHTML = "Kết quả tìm kiếm";
            keywordsSpan.innerHTML = "'$keywords'";
            } else {
                keywordsSpan.innerHTML = "$keywords > $subkeywords";
            }
            quantity.innerHTML = ": " + $num_rows + " sản phẩm";
        </script>
        FILTER_RESULT;
        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_array()) {
                $img_path = 'img/product/' . $row['product_id'];
                $images = getImages($img_path);
                echo <<< PROD_AVATAR_NAME
                    <div class="product">
                    <div class="product__avatar" id="$row[0]">
                    <img src="$img_path/$images[0]" class="product__avatar--front">
                    <img src="$img_path/$images[1]" class="product__avatar--back">
                </div>
                <div class="product__name" title="$row[3]">$row[3]</div>
                PROD_AVATAR_NAME;

                $price = formatPrice($row['Price']);
                if ($row['Discount'] > 0) {
                    $discounted_price = formatPrice($row['PriceWithDiscount']);
                    $sale_percennt = getSalePercent($row['Price'], $row['PriceWithDiscount']);
                    echo <<< PROD_PRICE
                        <div class="product__price">
                        <span class="product__price--discounted">$discounted_price đ</span>
                        <span class="product__price--original">$price đ</span>
                        <span class="product__price--sale">-$sale_percennt%</span>
                    </div>
                    PROD_PRICE;
                } else {
                    echo <<< PROD_PRICE
                    <div class="product__price">
                    <span class="product__price--discounted">$price đ</span>
                    </div>
                PROD_PRICE;
                }
            }
        }

        ?>
    </div>
    <div class="products-bottom">
        <?php
        $range = 2;
        $min = $current_page - $range;
        $max = $current_page + $range;
        $i = $min > 1 ? $min : 1;
        if ($max > $num_pages) {
            $max = $num_pages;
        }

        echo "<span data-value='1'><i class='fa-solid fa-angles-left'></i></span>";
        while ($i < $current_page) {
            echo "<span data-value='$i'>$i</span>";
            $i++;
        }
        echo "<span class='current-page'>$i</span>";
        $i++;
        while ($i <= $max) {
            echo "<span data-value='$i'>$i</span>";
            $i++;
        }
        echo "<span data-value='$num_pages'><i class='fa-solid fa-angles-right'></i></span>";
        ?>
    </div>
</section>

<?php
loadFooter();
?>