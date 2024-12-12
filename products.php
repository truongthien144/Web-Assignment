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
$size = !empty($_GET['size']) ? $_GET['size'] : '';
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
        <form class="products-sort-by" method="GET" onsubmit="sortProducts();">
            <input type="hidden" name="filter" value="<?php echo $filter; ?>">
            <input type="hidden" name="value" value="<?php echo $value; ?>">
            <select name="size" id="size">
                <option value="">Size</option>
                <option value="s" <?php if ($size === 's') echo 'selected'; ?>>S</option>
                <option value="m" <?php if ($size === 'm') echo 'selected'; ?>>M</option>
                <option value="l" <?php if ($size === 'l') echo 'selected'; ?>>L</option>
                <option value="xl" <?php if ($size === 'xl') echo 'selected'; ?>>XL</option>
            </select>
            <input type="hidden" name="field" value="<?php echo $field; ?>">
            <input type="hidden" name="sort" value=<?php echo $sort; ?>>
            <select id="order">
                <option value="">Sắp xếp</option>
                <option value="product_name asc" <?php if ($field === 'product_name' && $sort === 'asc') echo 'selected'; ?>>Tên sản phẩm</option>
                <option value="price asc" <?php if ($field === 'price' && $sort === 'asc') echo 'selected'; ?>>Giá tăng dần</option>
                <option value="price desc" <?php if ($field === 'price' && $sort === 'desc') echo 'selected'; ?>>Giá giảm dần</option>
            </select>
            <button type="submit" class="btn btn-primary">Lọc</button>
            <input type="hidden" name="page" value=<?php echo $current_page; ?>>
        </form>
    </div>
    <div class="products-content">
        <?php
        require 'connect_db.php';
        switch ($filter) {
            case 'product_name':
                $keyword = $value;
                $subkeyword = '';

                $where = "WHERE UPPER($filter) LIKE UPPER('%$value%')";
                break;
            case 'category_id':
                $sql = "SELECT category_name FROM category WHERE $filter = '$value' LIMIT 1";
                $result = $conn->query($sql);
                $keyword = $result->fetch_array()[0];
                $subkeyword = '';

                $where = "WHERE subcategory_id IN (SELECT subcategory_id FROM subcategory WHERE $filter = '$value')";
                break;
            case 'subcategory_id':
                $sql = "SELECT subcategory_name FROM subcategory WHERE $filter = '$value' LIMIT 1";
                $result = $conn->query($sql);
                $subkeyword = $result->fetch_array()[0];

                $sql = "SELECT category_name FROM category WHERE category_id = (SELECT category_id FROM subcategory WHERE $filter = '$value')";
                $result = $conn->query($sql);
                $keyword = $result->fetch_array()[0];

                $where = "WHERE $filter = '$value'";
                break;
            case 'discount':
                $keyword = 'Khuyến mãi';
                $subkeyword = '';

                $where = "WHERE $filter > 0";
                break;
            default:
                $where = "WHERE 1=1";
                break;
        }
        $sql = "SELECT * FROM product as A JOIN size as C ON A.product_id = C.prod_id ";
        $sql .= $where;
        if (!empty($size)) {
            $sql .= " AND C.$size > 0";
        }
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

        if ('$filter' === 'product_name') {
            phrase.innerHTML = "Kết quả tìm kiếm";
            keywordSpan.innerHTML = "'$keyword'";
            } else {
                if ('$subkeyword' !== '') {
                    keywordSpan.innerHTML = "$keyword > $subkeyword";
                } else {
                    keywordSpan.innerHTML = "$keyword";
                }
            }
            quantity.innerHTML = ": " + $total_products + " sản phẩm";
        </script>
        FILTER_RESULT;
        $result = $conn->query($sql);
        if (!$result) {
            echo $conn->error;
        }
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_array()) {
                $img_path = 'img/product/' . $row['product_id'];
                if (!file_exists($img_path)) {
                    $img_path = 'img/product/DEFAULT';
                }
                $images = getImages($img_path);
                if (empty($images)) {
                    $images = getImages('img/product/DEFAULT');
                }
                echo <<< PROD_AVATAR_NAME
                    <div class="product">
                    <div class="product__avatar" id="$row[0]">
                        <img src="$img_path/$images[0]" class="product__avatar">
                    </div>
                    <div class="product__name" title="$row[1]">$row[1]</div>
                    </div>
                PROD_AVATAR_NAME;
                $price = formatPrice($row['price']);
                if ($row['discount'] > 0) {
                    $discounted_price = formatPrice(getDiscountedPrice($row['price'], $row['discount']));
                    $sale_percennt = getSalePercent($row['price'], $row['discount']);
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
        if ($max > $total_pages) {
            $max = $total_pages;
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
        echo "<span data-value='$total_pages'><i class='fa-solid fa-angles-right'></i></span>";
        ?>
    </div>
</section>

<?php
loadFooter();
?>