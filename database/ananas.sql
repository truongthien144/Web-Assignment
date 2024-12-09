SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
DROP DATABASE IF EXISTS `ananas`;
CREATE DATABASE IF NOT EXISTS `ananas` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `ananas`;
CREATE DATABASE IF NOT EXISTS `ananas`
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;


-- --------------------------------------------------------
USE `ananas`;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
CREATE TABLE IF NOT EXISTS `account` (
  `username` VARCHAR(20) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'tên tài khoản',
  `password` VARCHAR(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'mật khẩu',
  `account_type` BIT(1) NOT NULL DEFAULT b'0' COMMENT 'loại tài khoản(0-người dùng, 1-admin)',
  `fullname` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'họ tên',
  `current_address` TEXT CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'chỗ ở hiện tại',
  `email` VARCHAR(50) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'email',
  `phone_number` VARCHAR(10) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'số điện thoại',
  `shipping_address` TEXT CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'địa chỉ nhận hàng',
  PRIMARY KEY (`username`),
  UNIQUE KEY `UN_email` (`email`),
  UNIQUE KEY `UN_phone_number` (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='tài khoản';

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`username`, `password`, `account_type`, `fullname`, `current_address`, `email`, `phone_number`, `shipping_address`) VALUES
('AliceMr', 'e7fa1ddf432061c6a5f76929a2864304', b'0', 'AliceHan', '46-Phan Đình Phùng-Phạm Kim Đồng-Đà Lạt', 'Alice1111@gmail.com', '0563238915', '46-Phan Đình Phùng-Phạm Kim Đồng-Đà Lạt'),
('Henlee', 'ada3d9c6301016a630c44fa731a65022', b'0', 'Helenka', '02-Định Văn Của-Xuân Vinh-Rạch Giá', 'Henlee123@gmail.com', '0834554432', 'KBang-Chư Pưng-Gia Lai'),
('JamesJon', 'd0b68aad25845831798a12d58599f002', b'0', 'Jon Văn James', '61-Lý Thái Tổ-Xuân Diệu-Quy Nhơn', 'James222@gmail.com', '0905232261', '61-Lý Thái Tổ-Xuân Diệu-Quy Nhơn'),
('ThompsonRobert', 'd6f38295491c9c9e60d5b6914d76f04c', b'0', ' Robert Thompson', ' Phụng Hoài Hảo-Hoài Nhơn-Bình Định', ' RobertThompson000@gmail.com', '0394778001', '53-Nguyễn Đình Thụ-Nguyễn Văn Cừ-Hồ Chí Minh'),
('admin', 'd829b843a6550a947e82f2f38ed6b7a7', b'1', 'Nguyễn Văn Admin', '77-Nguyễn Huệ-Quang Trung-Bình Định-\r\nFashion-shop', 'admin123@gmail.com', '0920392389', ''),
('johnweak', 'e323066cbbc32189ca6da109cab50e39', b'0', 'John Wick', '123 Wall Sred, New York', 'johnweak@gg.com', '0398166111', '123 Chợ đầu mối');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `username` VARCHAR(20) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'tên tài khoản',
  `prod_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'mã sản phẩm',
  `size` VARCHAR(5) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'size',
  `quantity` INT NOT NULL COMMENT 'số lượng',
  KEY `FK_cart-prodID` (`prod_id`),
  KEY `FK_cart-username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii COLLATE=ascii_bin COMMENT='giỏ hàng';

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`username`, `prod_id`, `size`, `quantity`) VALUES
('johnweak', 'AV00202', 36, 2),
('johnweak', 'AV00001', 40, 1),
('AliceMr', 'AV00189', 37, 1),
('AliceMr', 'A6T016', 37, 1),
('AliceMr', 'AV00125', 39, 1),
('AliceMr', 'AV00098', 42, 2),
('AliceMr', 'AV00071', 38, 2),
('JamesJon', 'AV00207', 41, 1),
('JamesJon', 'AV00130', 43, 1),
('JamesJon', 'AV00171', 42, 1),
('Henlee', 'ALP2401', 42, 1),
('Henlee', 'AV00208', 38, 1),
('johnweak', 'AV00126', 41, 1),
('johnweak', 'AV00098', 42, 2);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT COMMENT 'mã hoá đơn',
  `username` varchar(20) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'tên tài khoản',
  `fullname` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'họ tên',
  `phone_number` char(10) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'số điện thoại',
  `shipping_address` varchar(250) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'địa chỉ nhận hàng',
  `pay_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ngày thanh toán',
  PRIMARY KEY (`order_id`),
  KEY `FK_order-username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=ascii COLLATE=ascii_bin COMMENT='hoá đơn';

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `username`, `fullname`, `phone_number`, `shipping_address`, `pay_date`) VALUES
(1, 'johnweak', 'John Wick', '0398166111', '123 Chợ đầu mối', '2022-05-30 22:20:06'),
(2, 'AliceMr', 'Alice Han', '0563238915', '46-Phan Đình Phùng-Phạm Kim Đồng-Đà Lạt', '2022-05-30 22:24:01'),
(3, 'ThompsonRobert', ' Robert Thompson ', '0394778001', '53-Nguyễn Đình Thụ-Nguyễn Văn Cừ-Hồ Chí Minh', '2022-05-30 22:24:01'),
(4, 'Henlee', 'Helenka', '0834554432', 'KBang-Chư Pưng-Gia Lai', '2022-05-30 22:24:01');

-- --------------------------------------------------------

--
-- Table structure for table `order-detail`
--

DROP TABLE IF EXISTS `order-detail`;
CREATE TABLE IF NOT EXISTS `order-detail` (
  `order_id` INT NOT NULL COMMENT 'mã hoá đơn',
  `prod_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'mã sản phẩm',
  `size` VARCHAR(5) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'size',
  `price` INT NOT NULL COMMENT 'giá',
  `quantity` INT NOT NULL COMMENT 'số lượng',
  KEY `FK_order-id` (`order_id`),
  KEY `FK_orderDetail-prodID` (`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii COLLATE=ascii_bin COMMENT='chi tiết hoá đơn';

--
-- Dumping data for table `order-detail`
--

INSERT INTO `order-detail` (`order_id`, `prod_id`, `size`, `price`, `quantity`) VALUES
(1, 'AV00115', 41 , 390000, 1),
(1, 'AV00117', 41, 290000, 1),
(2, 'A6T006', 42, 792000, 1),
(2, 'AV00202', 43, 290000, 1),
(2, 'AV00158', 43, 290000, 1),
(3, 'AV00121', 39, 345000, 1),
(3, 'AV00189', 40, 290000, 1),
(3, 'AV00115', 40, 390000, 1),
(4, 'AV00172', 39, 290000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `product_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'ID of the product',
  `productName` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Name of the product',
  `Category_id` VARCHAR(2) NOT NULL COMMENT 'Category ID',
  `Subcategory_id` VARCHAR(3) NOT NULL COMMENT 'Subcategory ID',
  `Discount` INT NOT NULL COMMENT 'Discount price of the product',
  `Price` INT NOT NULL COMMENT 'Original price of the product',
  `PriceWithDiscount` INT NOT NULL COMMENT 'Price of the product after discount',
  `Color` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'Color of the product',
  `Stock` INT NOT NULL COMMENT 'Available stock quantity',
  `Description` TEXT CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'Detailed description of the product',
  `Overview` TEXT CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'Brief overview or summary of the product',
  PRIMARY KEY (`product_id`),
  KEY `FK_Category_id` (`Category_id`),
  KEY `FK_Subcategory_id` (`Subcategory_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Product details table';

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `productName`, `Category_id`,`Subcategory_id`,`Discount`,`Price`,`PriceWithDiscount`,`Color`,`Stock`,`Description`,`Overview`)
VALUES
    ('AV00121','Vintas Aunter - Low Top','FO','VIN',345000,690000,345000,'Botanical Garden',11,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas<br>Outsole: Rubber','Kết hợp cùng diện mạo quai dán hookn loop mới mẻ, Aunter chính là một bản phối lạ lẫm nhưng đầy thú vị lần đầu tiên xuất hiện của dòng Vintas. Vẫn là chất vải Canvas thường gặp, đi cặp cùng các lựa chọn màu sắc phong phú nhưng vẫn ẩn sâu bên trong nét điềm đạm. Tất cả làm nên điểm nhấn chững chạc tổng thể, dễ dàng tôn lên nét thu hút cần thiết mọi lần lên chân.'),
    ('A6T006','Track 6 Suede Moonphase - Low Top','FO','TRA',198000,990000,792000,'Fossil',235,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: All Suede<br>Outsole: Rubber<br><br>Sản phẩm được Double Box khi giao hàng.Khuyến nghị chọn truesize hoặc +1 size (tùy form chân) so với giày Ananas Vulcanized.','Dựa trên cảm hứng từ việc tái hiện những sắc xám (Grey) khác nhau hoà cùng những trạng thái ánh sáng trên bề mặt mặt trăng, Ananas Track 6 Suede Moonphase Pack sử dụng chất liệu da lộn (suede) đặc trưng, được phủ toàn bộ thân giày với tông màu sáng tối sắp xếp hài hoà hợp lý. Đây chắc chắn là một sản phẩm must have với những ai yêu thích chất suede và những gam màu Grey trung tính.'),
    ('AV00202','Urbas SC - Mule','FO','URB',330000,620000,290000,'Dusty Blue',137,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber', NULL),
    ('AV00131','Urbas Retrospective - Mid Top','FO','URB',430000,720000,290000,'Yellow Submarine',420,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas<br>Outsole: Transparent Rubber','Với việc đưa những chiếc đế cao su "xuyên thấu" rực rỡ trở lại, kết hợp cùng phần upper bằng vải canvas với những màu sắc tươi rói, Urbas Retrospective đã khắc họa nên bức tranh đầy sinh động về một thời kỳ phát triển rực rỡ của thời trang và nghệ thuật của những thập kỉ trước. Đây chắc chắn sẽ là lựa chọn không thể thiếu trong tủ đồ đối với những bạn trẻ đang tìm kiếm nguồn cảm hứng cổ điển trong phong cách thời trang hiện đại và độc đáo của bản thân. Sự độc đáo này còn mạnh mẽ hơn trên một form dáng Mid Top hoàn toàn mới.'),
    ('AV00158','Pattas Polka Dots - High Top','FO','PAT',460000,750000,290000,'Offwhite',330,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber', NULL),
    ('AV00117','Vintas Flannel - Low Top','FO','VIN',400000,690000,290000,'Cement',65,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas/Suede/Flannel<br>Outsole: Rubber<br>Tặng kèm 2 nút áo tròn/đôi','Khoác lên thân giày một lớp áo mới theo đúng nghĩa đen với thiết kế đánh dấu sự xuất hiện lần đầu tiên của chất vải Flannel trên các dáng sản phẩm quen thuộc từ Ananas. Phát huy những ưu điểm thoải mái và bền bỉ từ chất vải Flannel “vạn người mê”, song hành cùng phối màu trầm ấm đặc trưng, Vintas Flannel Pack là lựa chọn thú vị dành cho những bạn trẻ ái mộ phong cách điềm đạm chững chạc nhưng vẫn đầy sức hút.'),
    ('AV00172','Pattas Polka Dots - High Top','FO','PAT',460000,750000,290000,'Jelly Bean',509,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber', NULL),
    ('AV00001','Basas Mono Black NE - Low Top','FO','BAS',98000,490000,392000,'All Black',215,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber<br>Có thêm 01 bộ dây đi kèm','Nâng cấp chất liệu vải mới bền màu ổn định, kết hợp cùng vẻ ngoài ton sur ton từ trên xuống dưới cùng sắc đen cá tính, giúp phiên bản Basas Mono Black NE trở nên quyến rũ và tiện dụng hơn bao giờ hết. Đây hứa hẹn sẽ là sản phẩm lọt vào danh sách cho những tín đồ thường coi màu đen là sự ưu tiên.'),
    ('AV00183','Urbas SC - Low Top','FO','URB',290000,580000,290000,'Dark Purple',214,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber', NULL),
    ('AV00115','Basas Bumper Gum EXT NE - High Top','FO','BAS',260000,650000,390000,'Offwhite/Gum',12,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber<br>Có thêm 01 bộ dây đi kèm','Bumper Gum EXT (Extension) NE là bản nâng cấp được xếp vào dòng sản phẩm Basas, nhưng lại gây ấn tượng với diện mạo phá đi sự an toàn thường thấy. Với cách sắp xếp logo hoán đổi đầy ý tứ và mảng miếng da lộn (Suede) xuất hiện hợp lí trên chất vải canvas NE bền bỉ dày dặn nhấn nhá thêm bằng những sắc Gum dẻo dai. Tất cả làm nên 01 bộ sản phẩm với thiết kế đầy thoải mái trong trải nghiệm, đủ thanh lịch trong dáng vẻ.'),
    ('AV00206','Vintas Vivu - Low Top','FO','VIN',186000,620000,434000,'Plantation',321,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber', NULL),
    ('AV00116','Vintas Flannel - Low Top','FO','VIN',400000,690000,290000,'Cement',82,'Gender: Unisex<br>Size run: 35-46<br>Upper: Canvas/Suede/Flannel<br>Outsole: Rubber<br>Tặng kèm 2 nút áo tròn/đôi','Khoác lên thân giày một lớp áo mới theo đúng nghĩa đen với thiết kế đánh dấu sự xuất hiện lần đầu tiên của chất vải Flannel trên các dáng sản phẩm quen thuộc từ Ananas. Phát huy những ưu điểm thoải mái và bền bỉ từ chất vải Flannel “vạn người mê”, song hành cùng phối màu trầm ấm đặc trưng, Vintas Flannel Pack là lựa chọn thú vị dành cho những bạn trẻ ái mộ phong cách điềm đạm chững chạc nhưng vẫn đầy sức hút.'),
    ('AV00189','Urbas SC - Low Top','FO','URB',330000,620000,290000,'Aloe Wash',72,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber', NULL),
    ('AV00149','Basas Workaday - Low Top','FO','BAS',116000,580000,464000,'Black',239,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber<br>Có thêm 01 bộ dây đi kèm', NULL),
    ('AV00135','Basas RAW - Low Top','FO','BAS',244000,610000,366000,'Rustic',256,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber','Phiên bản tối giản mới sử dụng chất liệu Canvas RAW với phần bề mặt được tiết chế tối đa các bước xử lý sau dệt, đem đến một cảm nhận thô ráp, dễ dàng cảm nhận nét bền bỉ, dày dặn đặc trưng nguyên bản chỉ từ ánh nhìn diện mạo. Với những điểm nhấn thay đổi trong thiết kế cùng với vài chọn lựa chi tiết khác hơn từ trong ra ngoài, Basas RAW mang trên mình sứ mệnh chào sân phiên bản /rập mới/ và cũng là nơi bắt đầu cho những nâng cấp này xuất hiện rộng rãi hơn trong tương lai. Như một tấm ảnh RAW với đầy đủ cảm xúc tự nhiên, hãy tự do ngẫu hứng nó theo cách của bạn.'),
    ('AV00005','Basas Simple Life NE - Mule','FO','BAS',196000,490000,294000,'White',195,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber<br>Có thêm 01 bộ dây đi kèm','Phù hợp hoàn hảo với nhịp sống mới của giới trẻ, Basas Simple Life NE - Mule tinh giản vấn đề thắt dây với chi tiết hở gót độc đáo, mang đến khả năng lên chân nhanh gọn nhưng vẫn đảm bảo trọn vẹn nét thanh lịch trong diện mạo, qua đó nhấn mạnh chất “Simple Life” đặc trưng của thiết kế. Với khả năng ứng dụng cao từ công năng đến phối màu, sản phẩm dễ dàng đáp ứng mọi tiêu chí của giới mộ điệu cho một item thiết yếu trong tủ giày/dép.'),
    ('AV00180','Pattas Tomo - Low Top','FO','PAT',216000,720000,504000,'Blarney',273,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber', NULL),
    ('AV00181','Pattas Tomo - Mule','FO','PAT',360000,720000,360000,'Primrose Yellow',138,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber', NULL),
    ('AV00199','Urbas SC - Mule','FO','URB',290000,580000,290000,'Fair Orchid',148,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber', NULL),
    ('AV00012','Basas Bumper Gum NE - Mule','FO','BAS',156000,520000,364000,'Offwhite/Gum',104,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber','Kết hợp thiết kế hở gót cùng quai dán, Basas Bumper Gum NE - Mule mang lại trải nghiệm tiện lợi tăng cấp so với phiên bản thắt dây truyền thống. Lên chân nhanh chóng trong tích tắc không cần chạm tay nhưng vẫn sở hữu diện mạo đầy tính thanh lịch, Basas Bumper Gum NE - Mule chính là lựa chọn toàn diện cho mọi dịp dạo chơi từ nhà ra phố của các tín đồ thời trang trẻ.'),
    ('A6T016','Track 6 Jazico - Low Top','FO','TRA',119000,1190000,1071000,'Royal White',237,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber', NULL),
    ('AV00125','Urbas Ruler - Low Top','FO','URB',300000,590000,290000,'Icelandic Blue',240,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber','Vẻ ngoài với màu sắc tươi tắn, hiện đại. Urbas Ruler mang trên mình một chức năng khiến không ít người bất ngờ, sẽ rất hữu ích dành cho những ai có thói quen dùng thước kẻ nhưng hay quên, mặc dù độ chính xác "chưa chắc cao".'),
    ('AV00004','Basas Bumper Gum NE - Mule','FO','BAS',104000,520000,416000,'Black/Gum',288,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber<br>Có thêm 01 bộ dây đi kèm','Thiết kế hở gót "lạ lẫm" mang lại trải nghiệm lên chân nhanh chóng chỉ trong chớp mắt (như dép) nhưng lại có thần thái "gần sát" với một đôi Sneakers. Basas Bumper Gum NE - Mule được ra đời với các chi tiết màu sắc đặc trưng của bộ sản phẩm Basas Bumper Gum quen thuộc, phù hợp nhiều kiểu phong cách nhẹ nhàng từ nhà ra phố, xứng đáng là một lựa chọn must have để làm đa dạng thêm tủ giày/dép của bạn.'),
    ('AV00119','Vintas Monoguso - Low Top','FO','VIN',288000,720000,432000,'Moonbeam/Green',18,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Heavy Canvas/Suede/Leather<br>Outsole: Rubber','Thiết kế mới Vintas Monoguso mang đến âm hưởng của những nét đẹp cổ điển không tuổi. Sử dụng chất liệu Heavy Canvas sợi lớn dày dặn-nhân đôi, đặc biệt bền bỉ theo thời gian; viền giày được bọc lớp da “bề mặt” (Full Grain Leather) cho cảm giác cổ điển hơn. Điểm nhấn màu sắc từ chất liệu Suede (da lộn) tại lưỡi gà-gót giày tăng vẻ ấn tượng trên nền màu nhã nhặn tổng thể. Vintas Monoguso chính là lựa chọn sở hữu diện mạo đủ chất “cũ” nhưng đầy mới lạ khi lên chân.'),
    ('AV00165','Urbas Corluray Mix - Low Top','FO','URB',244000,610000,366000,'Corluray Mix',0,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Corduroy<br>Outsole: Rubber', NULL),
    ('AV00101','Vintas Mister NE - High Top','FO','VIN',260000,650000,390000,'Chocolate Brown',45,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE/Suede<br>Outsole: Rubber','Sử dụng vải canvas NE phối hợp cùng da lộn, Vintas Mister phiên bản mới gia tăng thêm độ thoải mái khi lên chân, đồng thời vẫn nguyên vẹn diện mạo cổ điển đầy cuốn hút. Lựa chọn không thể bỏ qua đối với mọi tín đồ theo đuổi nét đẹp mang dấu ấn thời gian.'),
    ('AV00201','Urbas SC - Mule','FO','URB',290000,580000,290000,'Foliage',285,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber', NULL),
    ('AV00098','Basas Bumper Gum EXT NE - Low Top','FO','BAS',58000,580000,522000,'Black/Gum',261,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas/Suede<br>Outsole: Rubber<br>Có thêm 01 bộ dây đi kèm','Bumper Gum EXT (Extension) NE là bản nâng cấp được xếp vào dòng sản phẩm Basas, nhưng lại gây ấn tượng với diện mạo phá đi sự an toàn thường thấy. Với cách sắp xếp logo hoán đổi đầy ý tứ và mảng miếng da lộn (Suede) xuất hiện hợp lí trên chất vải canvas NE bền bỉ dày dặn nhấn nhá thêm bằng những sắc Gum dẻo dai. Tất cả làm nên 01 bộ sản phẩm với thiết kế đầy thoải mái trong trải nghiệm, đủ thanh lịch trong dáng vẻ.'),
    ('AV00071','Basas Bumper Gum NE - Low Top','FO','BAS',104000,520000,416000,'Offwhite/Gum',150,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber','Đánh dấu một bước trưởng thành nữa, Basas Bumper Gum NE (New Episode) ra đời với những cải tiến nhẹ nhàng nhưng đủ tạo được sự thay đổi trong cảm nhận khi trải nghiệm. Vẫn giữ ngoại hình gần như không thay để phát huy đặc tính ứng dụng cao của dòng Basas vốn đã được chứng minh, phần đế màu Gum thú vị và /Foxing thân/ mới làm nền cho phần chất liệu Upper được nâng cấp. Đây được xem là một trong những phiên bản được chúng tôi kì vọng có thể bền vững vượt qua thời gian và không gian, chắc chắn đáng để thử.'),
    ('AV00144','Basas Evergreen - Mule','FO','BAS',232000,580000,348000,'Evergreen',341,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber<br>Có thêm 01 bộ dây đi kèm', NULL),
    ('AV00207','Vintas Public 2000s - Low Top','FO','VIN',186000,620000,434000,'Insignia Blue',323,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber', NULL),
    ('AV00173','Vintas Jazico - Low Top','FO','VIN',144000,720000,576000,'Royal White',216,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas/Leather<br>Outsole: Rubber', NULL),
    ('AV00130','Urbas Retrospective - Mid Top','FO','URB',430000,720000,290000,'Popular Blue',352,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas<br>Outsole: Transparent Rubber','Với việc đưa những chiếc đế cao su "xuyên thấu" rực rỡ trở lại, kết hợp cùng phần upper bằng vải canvas với những màu sắc tươi rói, Urbas Retrospective đã khắc họa nên bức tranh đầy sinh động về một thời kỳ phát triển rực rỡ của thời trang và nghệ thuật của những thập kỉ trước. Đây chắc chắn sẽ là lựa chọn không thể thiếu trong tủ đồ đối với những bạn trẻ đang tìm kiếm nguồn cảm hứng cổ điển trong phong cách thời trang hiện đại và độc đáo của bản thân. Sự độc đáo này còn mạnh mẽ hơn trên một form dáng Mid Top hoàn toàn mới.'),
    ('AV00174','Vintas Jazico - High Top','FO','VIN',156000,780000,624000,'Royal White',213,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas/Leather<br>Outsole: Rubber', NULL),
    ('AV00171','Pattas Polka Dots - Low Top','FO','PAT',430000,720000,290000,'True Blue',501,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber', NULL),
    ('AV00122','Vintas Aunter - Low Top','FO','VIN',345000,690000,345000,'Soybean',70,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber','Kết hợp cùng diện mạo quai dán hookn loop mới mẻ, Aunter chính là một bản phối lạ lẫm nhưng đầy thú vị lần đầu tiên xuất hiện của dòng Vintas. Vẫn là chất vải Canvas thường gặp, đi cặp cùng các lựa chọn màu sắc phong phú nhưng vẫn ẩn sâu bên trong nét điềm đạm. Tất cả làm nên điểm nhấn chững chạc tổng thể, dễ dàng tôn lên nét thu hút cần thiết mọi lần lên chân.'),
    ('ALP2401','Urbas Love+ 24','FO','URB',0,650000,650000,'Oyster White',46,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Suede / Canvas<br>Outsole: Rubber', NULL),
    ('AV00208','Vintas Public 2000s - Low Top','FO','VIN',124000,620000,496000,'Brindle',271,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber', NULL),
    ('AV00126','Urbas Ruler - Low Top','FO','URB',300000,590000,290000,'Silver Pink',320,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber','Vẻ ngoài với màu sắc tươi tắn, hiện đại. Urbas Ruler mang trên mình một chức năng khiến không ít người bất ngờ, sẽ rất hữu ích dành cho những ai có thói quen dùng thước kẻ nhưng hay quên, mặc dù độ chính xác "chưa chắc cao".'),
    ('ANS006','Invisible Socks Pack - Ananas Typo','AC','SOC',0,95000,95000,'Estate Blue',52,'Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/<br><br> ','Vớ ẩn hình có hoạ tiết đơn giản, gót nhựa trong cố định khó trượt. Tạo cảm giác thoải mái, đi như chân không và chắc chắn tàng hình khi mang trong giày.'),
    ('ANS020','Invisible Socks Pack - Ananas Typo','AC','SOC',0,95000,95000,'3 Colors',29,'Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/','Bộ 3 vớ tàng hình, nhiều màu nhiều lựa chọn. Một đi học, một đi làm, một đi chơi, thay phiên nhau tàng hình trong đôi giày của bạn.'),
    ('AHP002','Hip Pack - Ananas Global Goal','AC','HIP',55000,275000,220000,'Purple Sage',20,'Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/','Vớ ẩn hình có hoạ tiết đơn giản, gót nhựa trong cố định khó trượt. Tạo cảm giác thoải mái, đi như chân không và chắc chắn tàng hình khi mang trong giày.'),
    ('ANS024','Invisible Socks Pack - DiscoverYou','AC','SOC',0,95000,95000,'Black',12,'Gender – /Unisex/<br>Họa tiết – /Discover You/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/','Bộ 3 vớ màu cơ bản, tàng hình, ít thấy khi mang thay phiên trong đôi giày của bạn.'),
    ('AHCS007','High Crew Socks - Ananas Daily Things','AC','SOC',0,95000,95000,'Sunny Lime',28,'Giới tính – /Unisex/<br>Họa tiết – /Ananas Daily Things/<br>Thành phần – /53% Cotton, 40% Polyester, 3% Spandex, 2% Nylon, 2% Elastan/', NULL),
    ('AHCS012','High Crew Socks - Ananas Daily Things','AC','SOC',0,95000,95000,'Laurel Oak',0,'Giới tính – /Unisex/<br>Họa tiết – /Ananas Daily Things/<br>Thành phần – /53% Cotton, 40% Polyester, 3% Spandex, 2% Nylon, 2% Elastan/', NULL),
    ('ALB006','Blank Shoelaces','AC','SHO',0,35000,35000,'Viridian Green',84,'Chất liệu – /100% Cotton/<br>Chiều dài dây – /100cm – 115cm – 140cm/<br>Màu trơn đơn giản<br>Bản dẹp 8mm<br>Dệt đan xen','Dây giày bản dẹp, nổi bật bởi màu chính và điểm nhấn đầu tip có typo Ananas. Phù hợp để tạo nét mới mẻ, vừa phá cách trên chính đôi giày của bạn.'),
    ('ANS010','Invisible Socks Pack - Ananas Typo','AC','SOC',0,95000,95000,'Ocean Depths',6,'Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/','Vớ ẩn hình có hoạ tiết đơn giản, gót nhựa trong cố định khó trượt. Tạo cảm giác thoải mái, đi như chân không và chắc chắn tàng hình khi mang trong giày.'),
    ('ASTB001','Ananas \Copy\ Store Bag 001','AC','TOT',50000,250000,200000,'Black',7,'Giới tính: Unisex<br>Chất liệu: Canvas, định lượng 365GSM (trượt nước)<br>Thành phần chất liệu: 100% Cotton<br>Kích thước: 440 x 390 x 120 mm (W x H x D)<br>Dung tích: 20.5 lit<br>Hoạ tiết: Ananas – DiscoverYOU<br>Sử dụng phương pháp in lụa.','Hướng đến sức chịu đựng và độ lì lợm cao làm cốt lõi. Ananas "Copy" Store Bag 001 được thiết kế cực kì căn bản, tiết chế hoàn toàn các chi tiết cộng thêm khác để sự đặc biệt tập trung hoàn toàn vào chất liệu chính. Túi sử dụng Canvas cao cấp với định lượng lên đến 365 gsm, có tính năng trượt nước, chấp hết các thể loại xuyên thủng từ kim loại đến chất lỏng nếu đặt dưới một cường độ tác động không quá lớn.'),
    ('AHCS011','High Crew Socks - Ananas Daily Things','AC','SOC',0,95000,95000,'Candy Pink',17,'Giới tính – /Unisex/<br>Họa tiết – /Ananas Daily Things/<br>Thành phần – /53% Cotton, 40% Polyester, 3% Spandex, 2% Nylon, 2% Elastan/', NULL),
    ('AHCS010','High Crew Socks - Ananas Daily Things','AC','SOC',0,95000,95000,'Cinnamon Stick',0,'Giới tính – /Unisex/<br>Họa tiết – /Ananas Daily Things/<br>Thành phần – /53% Cotton, 40% Polyester, 3% Spandex, 2% Nylon, 2% Elastan/', NULL),
    ('ALB017','Blank Shoelaces','AC','SHO',0,35000,35000,'Sunlit Allium',33,'Chất liệu – /100% Cotton/<br>Chiều dài dây – /100cm – 115cm – 140cm/<br>Màu trơn đơn giản.<br>Dạng ống – 10mm.','Dây giày trơn màu Sunlit Allium, dạng ống rỗng, thích hợp để thay mới hoặc mix màu cho đôi Low Top, High Top của bạn thêm khác biệt.'),
    ('ASTB002','Ananas \Copy\ Store Bag 002','AC','TOT',56000,280000,224000,'Caviar Black',11,'Giới tính: Unisex<br>Chất liệu: Ripstop, định lượng 225GSM (trượt nước)<br>Thành phần chất liệu: 100% Polyester<br>Kích thước: 440 x 390 x 120 mm (W x H x D)<br>Dung tích: 20.5 lit<br>Hoạ tiết: Ananas – DiscoverYOU<br>Sử dụng phương pháp in lụa.','Hướng đến sự linh hoạt, phù hợp với nhiều hoàn cảnh sử dụng hay thời tiết khác nhau: dù nắng hay mưa do túi sử dụng chất liệu Ripstop có trọng lượng vừa phải và tính năng trượt nước trên bề mặt. Khoá kéo phao cũng hỗ trợ thêm cho tính năng này bên cạnh việc thuận tiện hơn trong việc cất giữ đồ đạc.'),
    ('ALB004','Blank Shoelaces','AC','SHO',0,35000,35000,'Carrot',57,'Chất liệu – /100% Cotton/<br>Chiều dài dây – /100cm – 115cm – 140cm/<br>Màu trơn đơn giản<br>Bản dẹp 8mm<br>Dệt đan xen','Dây giày bản dẹp, đặc biệt nổi bật ở phần màu sắc. Phù hợp để tạo điểm nhấn mới mẻ, vừa phá cách trên chính đôi giày của bạn.'),
    ('ATH005','Trucker Hat - Be Positive','AC','TRU',55000,275000,220000,'Black/White',1,'Gender – /Unisex/<br><br>Size: Free Hoạ tiết – /Be Positive/<br><br>Chất liệu – /100% Polyester/<br><br>Thêu 2D đơn giản','Trucker Hat - Be Positive màu Black/White đơn giản cùng artwork “Be Positive” mang nét tích cực của nhịp sống hiện đại. Với chất vải thun lạnh từ sợi Polyester có đệm mút và phần hậu dùng lưới mesh thông thoáng đặc trưng của Trucker Hat, đây chắc chắn là yếu tố ghi điểm cho những ngày quay cuồng, đầu bù tóc rối mà vẫn tự tin bứt phá chất tôi riêng biệt.'),
    ('AHP003','Hip Pack - Ananas Global Goal','AC','HIP',55000,275000,220000,'Blue Berry',13,'Giới tính: Unisex<br>Chất liệu: Taslan, định lượng 230gsm (trượt nước)<br>Thành phần chất liệu: 100% Polyester<br>Kích thước: 280 x 120 x 100 mm (W x H x D)<br>Dung tích: 2.0 lit<br>Hoạ tiết: Ananas Global Goal', NULL),
    ('ANS004','Invisible Socks Pack - Ananas Typo','AC','SOC',0,95000,95000,'White',9,'Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/','Vớ ẩn hình có hoạ tiết đơn giản, gót nhựa trong cố định khó trượt. Tạo cảm giác thoải mái, đi như chân không và chắc chắn tàng hình khi mang trong giày.'),
    ('AHP001','Hip Pack - Ananas Global Goal','AC','HIP',55000,275000,220000,'Climbing Ivy',21,'Giới tính: Unisex<br>Chất liệu: Taslan, định lượng 230gsm (trượt nước)<br>Thành phần chất liệu: 100% Polyester<br>Kích thước: 280 x 120 x 100 mm (W x H x D)<br>Dung tích: 2.0 lit<br>Hoạ tiết: Ananas Global Goal', NULL),
    ('ANS003','Invisible Socks Pack - Ananas Typo','AC','SOC',0,95000,95000,'Grey',58,'Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/','Vớ ẩn hình có hoạ tiết đơn giản, gót nhựa trong cố định khó trượt. Tạo cảm giác thoải mái, đi như chân không và chắc chắn tàng hình khi mang trong giày.'),
    ('ANS008','Invisible Socks Pack - Ananas Typo','AC','SOC',0,95000,95000,'Mimosa',32,'Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/<br><br> ','Vớ ẩn hình có hoạ tiết đơn giản, gót nhựa trong cố định khó trượt. Tạo cảm giác thoải mái, đi như chân không và chắc chắn tàng hình khi mang trong giày.'),
    ('ANS011','Invisible Socks Pack - Ananas Typo','AC','SOC',0,95000,95000,'3 Colors',23,'Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/','Bộ 3 vớ tàng hình, nhiều màu nhiều lựa chọn. Một đi học, một đi làm, một đi chơi, thay phiên nhau tàng hình trong đôi giày của bạn'),
    ('AHCS004','High Crew Socks - Ananas Puppet Club','AC','SOC',0,119000,119000,'Tie Dye',25,'Gender – /Unisex/<br><br>Họa tiết – /Ananas Puppet Club/<br><br>Kỹ thuật – /Nhuộm Tie Dye/<br><br>Thành phần – /78% Cotton, 15% Spandex, 5% Rubber, 2% Nylon/', NULL),
    ('AGT0023','Graphic Tee - Dance Till Sunrise','TO','GRA',0,350000,350000,'Jet Black',13,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 220GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: Dance Till Sunrise<br>Sử dụng phương pháp in PET.', NULL),
    ('AGT0006','Hiphop Graphic Tee - Outline Typo','TO','GRA',200000,350000,150000,'Black',15,'Giới tính: Unisex<br>Form nên mặc: Oversized<br>Chất liệu: 100% Cotton<br>Định lượng: 220 GSM<br>Độ co dãn: +/- 3%','Streetwear nói chung và thời trang Hiphop nói riêng không bao giờ thiếu đi những chiếc Graphic Tee nổi bật với cổ tròn ôm gọn, tay lỡ và phom áo rộng linh hoạt. Kết hợp cùng họa tiết Ananas Typo biến tấu lạ mắt cùng dòng chữ Discover Ananas sau cổ, Hiphop Graphic Tee sẽ là một mảnh ghép không tồi giúp bạn có bộ outfit thú vị và khẳng định cá tính riêng của bản thân.'),
    ('AGLT0028','Long Sleeve Graphic Tee - Love, Peace & Music','TO','GRA',0,390000,390000,'Jet Black',24,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 220GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: Love, Peace & Music<br>Sử dụng phương pháp in lụa.', NULL),
    ('ABT00025','Basic Tee - Ananas Oval Symbol','TO','BAT',0,290000,290000,'Frost Gray',51,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Hoạ tiết Ananas trong khung viền oval được thêu tinh tế, đồng màu khiến chiếc áo nhìn "vẫn trơn" nhưng ánh nhẹ điểm nhấn tinh tế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('ABT00032','Basic Pocket Tee - Ananas Mini Label','TO','BAT',0,290000,290000,'Caviar Black',56,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay, có túi với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt Ananas xanh, nho nhỏ kẹp nhẹ nhàng bên cạnh trái túi tạo điểm nhấn vừa phải, không làm mất đi định hướng của áo cơ bản. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('AET00002','Pigment Tee - Nice Nature Club','TO','EFF',0,390000,390000,'Greener Pastures',46,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 210GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: Nice Nature Club<br>Kỹ thuật nhuộm Pigment Dye.', NULL),
    ('AHO0010','Doraemon 50 Years Hoodie','TO','HOO',0,590000,590000,'Black',0,'Gender: Unisex<br>Form: Regular<br>Size run: S – M – L – XL<br>Chất liệu: 100% Cotton<br>Hình in trên nên áo ép nổi.','Chiếc Hoodie màu Black căn bản sở hữu nhiều graphic truyện tranh Doraemon ẩn giấu. Điểm nhấn đặc biệt từ logo Doraemon phiên bản tiếng Nhật đặc trưng với hiệu ứng ép nổi 3D độc đáo và chiếc túi trước bụng, tuy không phải túi thần kì nhưng sẽ mang đến cho bạn những ứng dụng bất ngờ.'),
    ('AGT0002','Hiphop Graphic Tee - Discover Ananas','TO','GRA',215000,365000,150000,'Ketchup',0,'Giới tính: Unisex<br>Form nên mặc: Oversized<br>Chất liệu: 100% Cotton<br>Định lượng: 220 GSM<br>Độ co dãn: +/- 3%','Streetwear nói chung và thời trang Hiphop nói riêng không bao giờ thiếu đi những chiếc Graphic Tee nổi bật với cổ tròn ôm gọn, tay lỡ và phom áo rộng linh hoạt. Kết hợp cùng họa tiết Discover Ananas ở trước và sau, Hiphop Graphic Tee sẽ là một mảnh ghép không tồi giúp bạn có bộ outfit thú vị và khẳng định cá tính riêng của bản thân.'),
    ('ABT00022','Basic Tee - Ananas Oval Symbol','TO','BAT',0,290000,290000,'Caviar Black',57,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Hoạ tiết Ananas trong khung viền oval được thêu tinh tế, đồng màu khiến chiếc áo nhìn "vẫn trơn" nhưng ánh nhẹ điểm nhấn tinh tế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('ABT00021','Basic Tee - Ananas Oval Symbol','TO','BAT',0,290000,290000,'Cloud Dancer',42,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Hoạ tiết Ananas trong khung viền oval được thêu tinh tế, đồng màu khiến chiếc áo nhìn "vẫn trơn" nhưng ánh nhẹ điểm nhấn tinh tế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('AGT0014','Graphic Tee - Most Wanted Dalton','TO','GRA',200000,350000,150000,'Caviar Black',0,'Gender – /Unisex/<br>Hình in – /Most Wanted Daltons/<br>Chất liệu – /100% Cotton/<br>Size – /S – M – L – XL/<br>Màu sắc: Caviar Black<br>In 2D','Những chiếc áo Ananas Graphic Tee có phom dáng thoải mái, rộng linh hoạt được kết hợp cùng hoạ tiết lấy cảm hứng từ bộ truyện tuổi thơ Lucky Luke. Đây sẽ là một mảnh ghép cho những outfit thú vị, dù đủ bộ hay mặc riêng lẻ vẫn khẳng định cá tính riêng biệt, ghi dấu ấn cho lần hợp tác quốc tế đầu tiên của Ananas.'),
    ('AET00001','Pigment Tee - AAA New Standard','TO','EFF',0,390000,390000,'Kangaroo',52,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: AAA – New Standard<br>Kỹ thuật nhuộm Pigment Dye.', NULL),
    ('ABT00033','Basic Pocket Tee - Ananas Mini Label','TO','BAT',0,290000,290000,'Molten Lava',48,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay, có túi với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt Ananas xanh, nho nhỏ kẹp nhẹ nhàng bên cạnh trái túi tạo điểm nhấn vừa phải, không làm mất đi định hướng của áo cơ bản. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('ABT00024','Basic Tee - Ananas Oval Symbol','TO','BAT',0,290000,290000,'Medium Green',38,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Hoạ tiết Ananas trong khung viền oval được thêu tinh tế, đồng màu khiến chiếc áo nhìn "vẫn trơn" nhưng ánh nhẹ điểm nhấn tinh tế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('ABT00026','Basic Tee - Branding Label','TO','BAT',0,290000,290000,'Cloud Dancer',45,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt xanh mang vài thông điệp nho nhỏ đính gọn gàng cạnh gấu áo, tạo chút điểm nhấn vui tươi nhưng không làm mất đi định hướng cơ bản trong thiết kế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('AGT0010','Hiphop Graphic Tee - Ananas Symbol','TO','GRA',215000,365000,150000,'Black',0,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Streetwear nói chung và thời trang Hiphop nói riêng không bao giờ thiếu đi những chiếc Graphic Tee nổi bật với cổ tròn ôm gọn, tay lỡ và phom áo rộng linh hoạt. Kết hợp cùng họa tiết Discover Ananas ở trước và sau, Hiphop Graphic Tee sẽ là một mảnh ghép không tồi giúp bạn có bộ outfit thú vị và khẳng định cá tính riêng của bản thân.'),
    ('AGT0009','Hiphop Graphic Tee - Ananas Symbol','TO','GRA',215000,365000,150000,'Ketchup',7,'Giới tính: Unisex<br>Form nên mặc: Oversized<br>Chất liệu: 100% Cotton<br>Định lượng: 220 GSM<br>Độ co dãn: +/- 3%','Streetwear nói chung và thời trang Hiphop nói riêng không bao giờ thiếu đi những chiếc Graphic Tee nổi bật với cổ tròn ôm gọn, tay lỡ và phom áo rộng linh hoạt. Kết hợp cùng họa tiết Discover Ananas ở trước và sau, Hiphop Graphic Tee sẽ là một mảnh ghép không tồi giúp bạn có bộ outfit thú vị và khẳng định cá tính riêng của bản thân.'),
    ('ABT00035','Basic Pocket Tee - Ananas Mini Label','TO','BAT',0,290000,290000,'Antique White',46,'Giới tính: Unisex<br>Form: Regular<br>Chất liệu: Single Jersey<br>Định lượng: 250 GSM','Áo thun ngắn tay, có túi với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt Ananas xanh, nho nhỏ kẹp nhẹ nhàng bên cạnh trái túi tạo điểm nhấn vừa phải, không làm mất đi định hướng của áo cơ bản. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('AGT0024','Graphic Tee - The Guitar Sings','TO','GRA',0,350000,350000,'Jet Black',10,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 220GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: The Guitar Sings<br>Sử dụng phương pháp in lụa.', NULL),
    ('ABT00030','Basic Tee - Branding Label','TO','BAT',0,290000,290000,'Frost Gray',54,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt xanh mang vài thông điệp nho nhỏ đính gọn gàng cạnh gấu áo, tạo chút điểm nhấn vui tươi nhưng không làm mất đi định hướng cơ bản trong thiết kế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('ABT00031','Basic Pocket Tee - Ananas Mini Label','TO','BAT',0,290000,290000,'Cloud Dancer',49,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay, có túi với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt Ananas xanh, nho nhỏ kẹp nhẹ nhàng bên cạnh trái túi tạo điểm nhấn vừa phải, không làm mất đi định hướng của áo cơ bản. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('AGT0003','Hiphop Graphic Tee - Discover Ananas','TO','GRA',215000,365000,150000,'Ermine',4,'Gender: Unisex<br>Form nên mặc: Oversized<br>Chất liệu: 100% Cotton<br>Định lượng: 220 GSM<br>Độ co dãn: +/- 3%','Streetwear nói chung và thời trang Hiphop nói riêng không bao giờ thiếu đi những chiếc Graphic Tee nổi bật với cổ tròn ôm gọn, tay lỡ và phom áo rộng linh hoạt. Kết hợp cùng họa tiết Discover Ananas ở trước và sau, Hiphop Graphic Tee sẽ là một mảnh ghép không tồi giúp bạn có bộ outfit thú vị và khẳng định cá tính riêng của bản thân.'),
    ('ABT00027','Basic Tee - Branding Label','TO','BAT',0,290000,290000,'Caviar Black',55,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt xanh mang vài thông điệp nho nhỏ đính gọn gàng cạnh gấu áo, tạo chút điểm nhấn vui tươi nhưng không làm mất đi định hướng cơ bản trong thiết kế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('ABT00029','Basic Tee - Branding Label','TO','BAT',0,290000,290000,'Medium Green',35,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt xanh mang vài thông điệp nho nhỏ đính gọn gàng cạnh gấu áo, tạo chút điểm nhấn vui tươi nhưng không làm mất đi định hướng cơ bản trong thiết kế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('AGT0022','Graphic Tee - Logos Packed','TO','GRA',0,350000,350000,'Snow White',3,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 220GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: Logos Packed<br>Sử dụng phương pháp in PET.', NULL),
    ('ABT00028','Basic Tee - Branding Label','TO','BAT',0,290000,290000,'Grape Compote',25,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt xanh mang vài thông điệp nho nhỏ đính gọn gàng cạnh gấu áo, tạo chút điểm nhấn vui tươi nhưng không làm mất đi định hướng cơ bản trong thiết kế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('ABT00023','Basic Tee - Ananas Oval Symbol','TO','BAT',0,290000,290000,'Grape Compote',28,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Hoạ tiết Ananas trong khung viền oval được thêu tinh tế, đồng màu khiến chiếc áo nhìn "vẫn trơn" nhưng ánh nhẹ điểm nhấn tinh tế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('ABT00034','Basic Pocket Tee - Ananas Mini Label','TO','BAT',0,290000,290000,'Dune',47,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay, có túi với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt Ananas xanh, nho nhỏ kẹp nhẹ nhàng bên cạnh trái túi tạo điểm nhấn vừa phải, không làm mất đi định hướng của áo cơ bản. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
    ('AGT0021','Graphic Tee - Skate 4P','TO','GRA',0,350000,350000,'Snow White',4,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 220GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: Skate 4P<br>Sử dụng phương pháp in PET.', NULL),
    ('AGT0020','Graphic Pocket Tee - Doraemon 50 Years','TO','GRA',0,390000,390000,'Cloud Dancer',0,'Gender: Unisex<br>Form: Regular<br>Size run: S – M – L – XL<br>Chất liệu: 100% Cotton<br>Hình in, thêu 2D sắc nét.','Ananas Graphic Tee sở hữu phom dáng rộng thoải mái với chất vải 100% cotton dày vừa phải. Kết hợp chi tiết từ bộ truyện Doraemon cùng Typo đặc trưng kỉ niệm 50 năm tạo nên chiếc Pocket cá tính bên ngực trái. Chiếc áo là mảnh ghép phù hợp cho những bạn yêu thích Doraemon và muốn lưu dấu cột mốc đặc biệt này.'),
    ('AGLT0027','Long Sleeve Graphic Tee - Love, Peace & Music','TO','GRA',0,390000,390000,'White',20,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 220GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: Love, Peace & Music<br>Sử dụng phương pháp in lụa.', NULL),
    ('AGT0026','Graphic Tee - Logos Packed','TO','GRA',0,350000,350000,'Vibrant Orange',16,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 220GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: Logos Packed<br>Sử dụng phương pháp in lụa.', NULL),
    ('AV00210','Basas Day Slide - Slip On','FO','BAS',0,550000,550000,'Offwhite',317,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas<br>Outsole: Rubber', NULL),
    ('AV00211','Basas Day Slide - Slip On','FO','BAS',0,550000,550000,'Caviar Black',324,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas<br>Outsole: Rubber', NULL),
    ('AV00167','Urbas Corluray Mix - High Top','FO','URB',260000,650000,390000,'Corluray Mix',99,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Corduroy<br>Outsole: Rubber', NULL),
    ('A6T014','Track 6 2.Blues - Low Top','FO','TRA',238000,1190000,952000,'Navy Blue',105,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Eco Nylon Fabric<br>Outsole: Rubber', NULL),
    ('ALP2023','Urbas Love+ 23 - Slip On','FO','URB',0,550000,550000,'Offwhite',0,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas<br>Outsole: Rubber', NULL),
    ('AV00154','Vintas Soda Pop - Low Top','FO','VIN',390000,680000,290000,'Amparo Blue',208,'Gender: Unisex<br>Size run: 35 – 46<br>Upper: Corduroy<br>Outsole: Rubber', NULL);


-- Category Table

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` VARCHAR(2) NOT NULL COMMENT 'Category ID (e.g., TO, AC, FO)',
  `category_name` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Category Name (e.g., Top, Accessories, Footwear)',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Product categories table';

INSERT INTO `category` (`category_id`, `category_name`)
VALUES
  ('TO', 'Top'),
  ('AC', 'Accessories'),
  ('FO', 'Footwear');


-- Subcategory table

DROP TABLE IF EXISTS `subcategory`;
CREATE TABLE IF NOT EXISTS `subcategory` (
  `subcategory_id` VARCHAR(3) NOT NULL COMMENT 'Subcategory ID (e.g., GRA, BAT, HOO)',
  `subcategory_name` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Subcategory Name (e.g., Graphic Tee, Basic Tee, Hoodie)',
  `category_id` VARCHAR(2) NOT NULL COMMENT 'Category ID (e.g., TO, AC, FO) referencing category table',
  PRIMARY KEY (`subcategory_id`),
  FOREIGN KEY (`category_id`) REFERENCES `category`(`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Product subcategories table';

INSERT INTO `subcategory` (`subcategory_id`, `subcategory_name`, `category_id`)
VALUES
  ('GRA', 'Graphic Tee', 'TO'),
  ('BAT', 'Basic Tee', 'TO'),
  ('EFF', 'Effect Tee', 'TO'),
  ('HOO', 'Hoodie', 'TO'),
  ('HIP', 'Hip Pack', 'AC'),
  ('BAS', 'Basas', 'FO'),
  ('VIN', 'Vintas', 'FO'),
  ('TRA', 'Track 6', 'FO'),
  ('URB', 'Urbas', 'FO'),
  ('PAT', 'Pattas', 'FO'),
  ('SOC', 'Socks | Vớ', 'AC'),
  ('SHO', 'Shoelaces', 'AC'),
  ('TOT', 'Tote Bag', 'AC'),
  ('TRU', 'Trucker Hat', 'AC');


-- Data for product size
-- Create the product_sizes table

DROP TABLE IF EXISTS `product_sizes`;
CREATE TABLE IF NOT EXISTS `product_sizes` (
  `product_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `sizes` TEXT NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- Insert product data with sizes
INSERT INTO `product_sizes` (`product_id`, `sizes`) VALUES
('AV00121', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('A6T006', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00202', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00131', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00158', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00117', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00172', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00001', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00183', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00115', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00206', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00116', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00189', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00149', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00135', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00005', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00180', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00181', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00199', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00012', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 45]'),
('A6T016', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00125', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00004', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00119', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00165', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00101', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00201', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00098', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00071', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00144', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00207', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00173', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00130', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00174', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00171', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('AV00122', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('ALP2401', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00208', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00126', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('ANS006', '[M, S]'),
('ANS020', '[M, S]'),
('AHP002', '[M]'),
('ANS024', '[M, S]'),
('AHCS007', '[free]'),
('AHCS012', '[free]'),
('ALB006', '[100, 115, 140]'),
('ANS010', '[M, S]'),
('ASTB001', '[Free]'),
('AHCS011', '[free]'),
('AHCS010', '[free]'),
('ALB017', '[100, 115, 140]'),
('ASTB002', '[L]'),
('ALB004', '[100, 115, 140]'),
('ATH005', '[free]'),
('AHP003', '[M]'),
('ANS004', '[M, S]'),
('AHP001', '[M]'),
('ANS003', '[M, S]'),
('ANS008', '[S]'),
('ANS011', '[M, S]'),
('AHCS004', '[Free]'),
('AGT0023', '[L, M, S, XL]'),
('AGT0006', '[L, M, S, XL]'),
('AGLT0028', '[L, M, S, XL]'),
('ABT00025', '[L, M, S, XL]'),
('ABT00032', '[L, M, S, XL]'),
('AET00002', '[L, M, S, XL]'),
('AHO0010', '[L, M, S, XL]'),
('AGT0002', '[L, M, S, XL]'),
('ABT00022', '[L, M, S, XL]'),
('ABT00021', '[L, M, S, XL]'),
('AGT0014', '[L, M, S, XL]'),
('AET00001', '[L, M, S, XL]'),
('ABT00033', '[L, M, S, XL]'),
('ABT00024', '[L, M, S, XL]'),
('ABT00026', '[L, M, S, XL]'),
('AGT0010', '[L, M, S, XL]'),
('AGT0009', '[L, M, S, XL]'),
('ABT00035', '[L, M, S, XL]'),
('AGT0024', '[L, M, S, XL]'),
('ABT00030', '[L, M, S, XL]'),
('ABT00031', '[L, M, S, XL]'),
('AGT0003', '[L, M, S, XL]'),
('ABT00027', '[L, M, S, XL]'),
('ABT00029', '[L, M, S, XL]'),
('AGT0022', '[L, M, S, XL]'),
('ABT00028', '[L, M, S, XL]'),
('ABT00023', '[L, M, S, XL]'),
('ABT00034', '[L, M, S, XL]'),
('AGT0021', '[L, M, S, XL]'),
('AGT0020', '[L, M, S, XL]'),
('AGLT0027', '[L, M, S, XL]'),
('AGT0026', '[L, M, S, XL]'),
('AV00210', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00211', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 44, 44.5]'),
('AV00167', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('A6T014', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]'),
('ALP2023', '[35, 36, 36.5, 37, 38, 38.5, 39, 40, 40.5, 41, 42, 42.5, 43, 45, 46]'),
('AV00154', '[35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]');


--
-- Constraints for dumped tables
--
ALTER TABLE `cart`
  ADD CONSTRAINT `FK_cart-prodID` FOREIGN KEY (`prod_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `FK_cart-username` FOREIGN KEY (`username`) REFERENCES `account` (`username`);

ALTER TABLE `orders`
  ADD CONSTRAINT `FK_order-username` FOREIGN KEY (`username`) REFERENCES `account` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `order-detail`
  ADD CONSTRAINT `FK_order-id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK_orderDetail-prodID` FOREIGN KEY (`prod_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `product_sizes`
  ADD CONSTRAINT `FK_size_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `subcategory`
  ADD CONSTRAINT `FK_subcategory_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

ALTER TABLE `product`
  ADD CONSTRAINT `FK_Category_id` FOREIGN KEY (`Category_id`) REFERENCES `category` (`category_id`),
  ADD CONSTRAINT `FK_Subcatergory_id` FOREIGN KEY (`Subcategory_id`) REFERENCES `subcategory` (`subcategory_id`);

COMMIT;

