-- Set SQL Mode and Transaction settings
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
START TRANSACTION;

-- Drop and Create Database
DROP DATABASE IF EXISTS `ananas`;
CREATE DATABASE IF NOT EXISTS `ananas`
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
USE `ananas`;

-- Account Table
DROP TABLE IF EXISTS `account`;
CREATE TABLE IF NOT EXISTS `account` (
  `username` varchar(20) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'username',
  `password` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'password',
  `account_type` bit(1) NOT NULL DEFAULT b'0' COMMENT 'account type (0-user, 1-admin)',
  `fullname` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'full name',
  `current_address` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'current address',
  `email` varchar(50) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'email',
  `phone_number` varchar(10) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'phone number',
  `shipping_address` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'shipping address',
  PRIMARY KEY (`username`),
  UNIQUE KEY `un_email` (`email`),
  UNIQUE KEY `un_phone_number` (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='accounts';

INSERT INTO `account` (`username`, `password`, `account_type`, `fullname`, `current_address`, `email`, `phone_number`, `shipping_address`) VALUES
('AliceMr', 'e7fa1ddf432061c6a5f76929a2864304', b'0', 'AliceHan', '46-Phan Đình Phùng-Phạm Kim Đồng-Đà Lạt', 'Alice1111@gmail.com', '0563238915', '46-Phan Đình Phùng-Phạm Kim Đồng-Đà Lạt'),
('Henlee', 'ada3d9c6301016a630c44fa731a65022', b'0', 'Helenka', '02-Định Văn Của-Xuân Vinh-Rạch Giá', 'Henlee123@gmail.com', '0834554432', 'KBang-Chư Pưng-Gia Lai'),
('JamesJon', 'd0b68aad25845831798a12d58599f002', b'0', 'Jon Văn James', '61-Lý Thái Tổ-Xuân Diệu-Quy Nhơn', 'James222@gmail.com', '0905232261', '61-Lý Thái Tổ-Xuân Diệu-Quy Nhơn'),
('ThompsonRobert', 'd6f38295491c9c9e60d5b6914d76f04c', b'0', ' Robert Thompson', ' Phụng Hoài Hảo-Hoài Nhơn-Bình Định', ' RobertThompson000@gmail.com', '0394778001', '53-Nguyễn Đình Thụ-Nguyễn Văn Cừ-Hồ Chí Minh'),
('admin', 'd829b843a6550a947e82f2f38ed6b7a7', b'1', 'Nguyễn Văn Admin', '77-Nguyễn Huệ-Quang Trung-Bình Định-\r\nFashion-shop', 'admin123@gmail.com', '0920392389', ''),
('johnweak', 'e323066cbbc32189ca6da109cab50e39', b'0', 'John Wick', '123 Wall Sred, New York', 'johnweak@gg.com', '0398166111', '123 Chợ đầu mối');

-- Cart Table
DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `username` varchar(20) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'username',
  `prod_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'product id',
  `size` varchar(3) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'size',
  `quantity` int NOT NULL COMMENT 'quantity',
  KEY `fk_cart-prod_id` (`prod_id`),
  KEY `fk_cart-username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii COLLATE=ascii_bin COMMENT='shopping cart';

INSERT INTO `cart` (`username`, `prod_id`, `size`, `quantity`) VALUES
('johnweak', 'AV00202', 'M', 2),
('johnweak', 'AV00001', 'M', 1),
('AliceMr', 'AV00189', 'L', 1),
('AliceMr', 'A6T016', 'S', 1),
('AliceMr', 'AV00125', 'M', 1),
('AliceMr', 'AV00098', 'L', 2),
('AliceMr', 'AV00071', 'S', 2),
('JamesJon', 'AV00207', 'L', 1),
('JamesJon', 'AV00130', 'XL', 1),
('JamesJon', 'AV00171', 'L', 1),
('Henlee', 'ALP2401', 'L', 1),
('Henlee', 'AV00208', 'XL', 1),
('johnweak', 'AV00126', 'L', 1),
('johnweak', 'AV00098', 'XL', 2);

-- Order Table
DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` int NOT NULL AUTO_INCREMENT COMMENT 'order id',
  `username` varchar(20) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'username',
  `fullname` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'full name',
  `phone_number` char(10) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'phone number',
  `shipping_address` varchar(250) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'shipping address',
  `pay_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'payment date',
  PRIMARY KEY (`order_id`),
  KEY `fk_order-username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=ascii COLLATE=ascii_bin COMMENT='orders';

INSERT INTO `order` (`order_id`, `username`, `fullname`, `phone_number`, `shipping_address`, `pay_date`) VALUES
(1, 'johnweak', 'John Wick', '0398166111', '123 Chợ đầu mối', '2022-05-30 22:20:06'),
(2, 'AliceMr', 'Alice Han', '0563238915', '46-Phan Đình Phùng-Phạm Kim Đồng-Đà Lạt', '2022-05-30 22:24:01'),
(3, 'ThompsonRobert', ' Robert Thompson ', '0394778001', '53-Nguyễn Đình Thụ-Nguyễn Văn Cừ-Hồ Chí Minh', '2022-05-30 22:24:01'),
(4, 'Henlee', 'Helenka', '0834554432', 'KBang-Chư Pưng-Gia Lai', '2022-05-30 22:24:01');


-- Order Detail Table
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE IF NOT EXISTS `order_detail` (
  `order_id` int NOT NULL COMMENT 'order id',
  `prod_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'product id',
  `size` varchar(3) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'size',
  `price` int NOT NULL COMMENT 'price',
  `quantity` int NOT NULL COMMENT 'quantity',
  KEY `fk_order_id` (`order_id`),
  KEY `fk_order_detail_prod_id` (`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii COLLATE=ascii_bin COMMENT='order details';

INSERT INTO `order_detail` (`order_id`, `prod_id`, `size`, `price`, `quantity`) VALUES
(1, 'AV00115', 'l' , 390000, 1),
(1, 'AV00117', 'xl', 290000, 1),
(2, 'A6T006', 'm', 792000, 1),
(2, 'AV00202', 's', 290000, 1),
(2, 'AV00158', 's', 290000, 1),
(3, 'AV00121', 'm', 345000, 1),
(3, 'AV00189', 'l', 290000, 1),
(3, 'AV00115', 'l', 390000, 1),
(4, 'AV00172', 'l', 290000, 1);

-- Product Table
DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `product_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'product id',
  `product_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'product name',
  `subcategory_id` varchar(3) NOT NULL COMMENT 'subcategory id',
  `discount` int NOT NULL COMMENT 'discount price',
  `price` int NOT NULL COMMENT 'original price',
  `color` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'color',
  `description` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'description',
  `overview` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'overview',
  PRIMARY KEY (`product_id`),
  KEY `fk_subcategory_id` (`subcategory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='products';

INSERT INTO `product` (`product_id`, `product_name`, `subcategory_id`, `discount`, `price`, `color`, `description`, `overview`)
VALUES
('AV00121','Vintas Aunter - Low Top','VIN',345000,690000,'Botanical Garden','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas<br>Outsole: Rubber','Kết hợp cùng diện mạo quai dán hookn loop mới mẻ, Aunter chính là một bản phối lạ lẫm nhưng đầy thú vị lần đầu tiên xuất hiện của dòng Vintas. Vẫn là chất vải Canvas thường gặp, đi cặp cùng các lựa chọn màu sắc phong phú nhưng vẫn ẩn sâu bên trong nét điềm đạm. Tất cả làm nên điểm nhấn chững chạc tổng thể, dễ dàng tôn lên nét thu hút cần thiết mọi lần lên chân.'),
('A6T006','Track 6 Suede Moonphase - Low Top','TRA',198000,990000,'Fossil','Gender: Unisex<br>Size run: 35 – 46<br>Upper: All Suede<br>Outsole: Rubber<br><br>Sản phẩm được Double Box khi giao hàng.Khuyến nghị chọn truesize hoặc +1 size (tùy form chân) so với giày Ananas Vulcanized.','Dựa trên cảm hứng từ việc tái hiện những sắc xám (Grey) khác nhau hoà cùng những trạng thái ánh sáng trên bề mặt mặt trăng, Ananas Track 6 Suede Moonphase Pack sử dụng chất liệu da lộn (suede) đặc trưng, được phủ toàn bộ thân giày với tông màu sáng tối sắp xếp hài hoà hợp lý. Đây chắc chắn là một sản phẩm must have với những ai yêu thích chất suede và những gam màu Grey trung tính.'),
('AV00202','Urbas SC - Mule','URB',330000,620000,'Dusty Blue','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber',NULL),
('AV00131','Urbas Retrospective - Mid Top','URB',430000,720000,'Yellow Submarine','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas<br>Outsole: Transparent Rubber','Với việc đưa những chiếc đế cao su "xuyên thấu" rực rỡ trở lại, kết hợp cùng phần upper bằng vải canvas với những màu sắc tươi rói, Urbas Retrospective đã khắc họa nên bức tranh đầy sinh động về một thời kỳ phát triển rực rỡ của thời trang và nghệ thuật của những thập kỉ trước. Đây chắc chắn sẽ là lựa chọn không thể thiếu trong tủ đồ đối với những bạn trẻ đang tìm kiếm nguồn cảm hứng cổ điển trong phong cách thời trang hiện đại và độc đáo của bản thân. Sự độc đáo này còn mạnh mẽ hơn trên một form dáng Mid Top hoàn toàn mới.'),
('AV00158','Pattas Polka Dots - High Top','PAT',460000,750000,'Offwhite','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber',NULL),
('AV00117','Vintas Flannel - Low Top','VIN',400000,690000,'Cement','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas/Suede/Flannel<br>Outsole: Rubber<br>Tặng kèm 2 nút áo tròn/đôi','Khoác lên thân giày một lớp áo mới theo đúng nghĩa đen với thiết kế đánh dấu sự xuất hiện lần đầu tiên của chất vải Flannel trên các dáng sản phẩm quen thuộc từ Ananas. Phát huy những ưu điểm thoải mái và bền bỉ từ chất vải Flannel “vạn người mê”, song hành cùng phối màu trầm ấm đặc trưng, Vintas Flannel Pack là lựa chọn thú vị dành cho những bạn trẻ ái mộ phong cách điềm đạm chững chạc nhưng vẫn đầy sức hút.'),
('AV00172','Pattas Polka Dots - High Top','PAT',460000,750000,'Jelly Bean','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber',NULL),
('AV00001','Basas Mono Black NE - Low Top','BAS',98000,490000,'All Black','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber<br>Có thêm 01 bộ dây đi kèm','Nâng cấp chất liệu vải mới bền màu ổn định, kết hợp cùng vẻ ngoài ton sur ton từ trên xuống dưới cùng sắc đen cá tính, giúp phiên bản Basas Mono Black NE trở nên quyến rũ và tiện dụng hơn bao giờ hết. Đây hứa hẹn sẽ là sản phẩm lọt vào danh sách cho những tín đồ thường coi màu đen là sự ưu tiên.'),
('AV00183','Urbas SC - Low Top','URB',290000,580000,'Dark Purple','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber',NULL),
('AV00115','Basas Bumper Gum EXT NE - High Top','BAS',260000,650000,'Offwhite/Gum','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber<br>Có thêm 01 bộ dây đi kèm','Bumper Gum EXT (Extension) NE là bản nâng cấp được xếp vào dòng sản phẩm Basas, nhưng lại gây ấn tượng với diện mạo phá đi sự an toàn thường thấy. Với cách sắp xếp logo hoán đổi đầy ý tứ và mảng miếng da lộn (Suede) xuất hiện hợp lí trên chất vải canvas NE bền bỉ dày dặn nhấn nhá thêm bằng những sắc Gum dẻo dai. Tất cả làm nên 01 bộ sản phẩm với thiết kế đầy thoải mái trong trải nghiệm, đủ thanh lịch trong dáng vẻ.'),
('AV00206','Vintas Vivu - Low Top','VIN',186000,620000,'Plantation','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber',NULL),
('AV00116','Vintas Flannel - Low Top','VIN',400000,690000,'Cement','Gender: Unisex<br>Size run: 35-46<br>Upper: Canvas/Suede/Flannel<br>Outsole: Rubber<br>Tặng kèm 2 nút áo tròn/đôi','Khoác lên thân giày một lớp áo mới theo đúng nghĩa đen với thiết kế đánh dấu sự xuất hiện lần đầu tiên của chất vải Flannel trên các dáng sản phẩm quen thuộc từ Ananas. Phát huy những ưu điểm thoải mái và bền bỉ từ chất vải Flannel “vạn người mê”, song hành cùng phối màu trầm ấm đặc trưng, Vintas Flannel Pack là lựa chọn thú vị dành cho những bạn trẻ ái mộ phong cách điềm đạm chững chạc nhưng vẫn đầy sức hút.'),
('AV00189','Urbas SC - Low Top','URB',330000,620000,'Aloe Wash','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber',NULL),
('AV00149','Basas Workaday - Low Top','BAS',116000,580000,'Black','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber<br>Có thêm 01 bộ dây đi kèm',NULL),
('AV00135','Basas RAW - Low Top','BAS',244000,610000,'Rustic','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber','Phiên bản tối giản mới sử dụng chất liệu Canvas RAW với phần bề mặt được tiết chế tối đa các bước xử lý sau dệt, đem đến một cảm nhận thô ráp, dễ dàng cảm nhận nét bền bỉ, dày dặn đặc trưng nguyên bản chỉ từ ánh nhìn diện mạo. Với những điểm nhấn thay đổi trong thiết kế cùng với vài chọn lựa chi tiết khác hơn từ trong ra ngoài, Basas RAW mang trên mình sứ mệnh chào sân phiên bản /rập mới/ và cũng là nơi bắt đầu cho những nâng cấp này xuất hiện rộng rãi hơn trong tương lai. Như một tấm ảnh RAW với đầy đủ cảm xúc tự nhiên, hãy tự do ngẫu hứng nó theo cách của bạn.'),
('AV00005','Basas Simple Life NE - Mule','BAS',196000,490000,'White','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber<br>Có thêm 01 bộ dây đi kèm','Phù hợp hoàn hảo với nhịp sống mới của giới trẻ, Basas Simple Life NE - Mule tinh giản vấn đề thắt dây với chi tiết hở gót độc đáo, mang đến khả năng lên chân nhanh gọn nhưng vẫn đảm bảo trọn vẹn nét thanh lịch trong diện mạo, qua đó nhấn mạnh chất “Simple Life” đặc trưng của thiết kế. Với khả năng ứng dụng cao từ công năng đến phối màu, sản phẩm dễ dàng đáp ứng mọi tiêu chí của giới mộ điệu cho một item thiết yếu trong tủ giày/dép.'),
('AV00180','Pattas Tomo - Low Top','PAT',216000,720000,'Blarney','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber',NULL),
('AV00181','Pattas Tomo - Mule','PAT',360000,720000,'Primrose Yellow','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber',NULL),
('AV00199','Urbas SC - Mule','URB',290000,580000,'Fair Orchid','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber',NULL),
('AV00012','Basas Bumper Gum NE - Mule','BAS',156000,520000,'Offwhite/Gum','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber','Kết hợp thiết kế hở gót cùng quai dán, Basas Bumper Gum NE - Mule mang lại trải nghiệm tiện lợi tăng cấp so với phiên bản thắt dây truyền thống. Lên chân nhanh chóng trong tích tắc không cần chạm tay nhưng vẫn sở hữu diện mạo đầy tính thanh lịch, Basas Bumper Gum NE - Mule chính là lựa chọn toàn diện cho mọi dịp dạo chơi từ nhà ra phố của các tín đồ thời trang trẻ.'),
('A6T016','Track 6 Jazico - Low Top','TRA',119000,1190000,'Royal White','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber',NULL),
('AV00125','Urbas Ruler - Low Top','URB',300000,590000,'Icelandic Blue','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber','Vẻ ngoài với màu sắc tươi tắn, hiện đại. Urbas Ruler mang trên mình một chức năng khiến không ít người bất ngờ, sẽ rất hữu ích dành cho những ai có thói quen dùng thước kẻ nhưng hay quên, mặc dù độ chính xác "chưa chắc cao".'),
('AV00004','Basas Bumper Gum NE - Mule','BAS',104000,520000,'Black/Gum','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber<br>Có thêm 01 bộ dây đi kèm','Thiết kế hở gót "lạ lẫm" mang lại trải nghiệm lên chân nhanh chóng chỉ trong chớp mắt (như dép) nhưng lại có thần thái "gần sát" với một đôi Sneakers. Basas Bumper Gum NE - Mule được ra đời với các chi tiết màu sắc đặc trưng của bộ sản phẩm Basas Bumper Gum quen thuộc, phù hợp nhiều kiểu phong cách nhẹ nhàng từ nhà ra phố, xứng đáng là một lựa chọn must have để làm đa dạng thêm tủ giày/dép của bạn.'),
('AV00119','Vintas Monoguso - Low Top','VIN',288000,720000,'Moonbeam/Green','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Heavy Canvas/Suede/Leather<br>Outsole: Rubber','Thiết kế mới Vintas Monoguso mang đến âm hưởng của những nét đẹp cổ điển không tuổi. Sử dụng chất liệu Heavy Canvas sợi lớn dày dặn-nhân đôi, đặc biệt bền bỉ theo thời gian; viền giày được bọc lớp da “bề mặt” (Full Grain Leather) cho cảm giác cổ điển hơn. Điểm nhấn màu sắc từ chất liệu Suede (da lộn) tại lưỡi gà-gót giày tăng vẻ ấn tượng trên nền màu nhã nhặn tổng thể. Vintas Monoguso chính là lựa chọn sở hữu diện mạo đủ chất “cũ” nhưng đầy mới lạ khi lên chân.'),
('AV00165','Urbas Corluray Mix - Low Top','URB',244000,610000,'Corluray Mix','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Corduroy<br>Outsole: Rubber',NULL),
('AV00101','Vintas Mister NE - High Top','VIN',260000,650000,'Chocolate Brown','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE/Suede<br>Outsole: Rubber','Sử dụng vải canvas NE phối hợp cùng da lộn, Vintas Mister phiên bản mới gia tăng thêm độ thoải mái khi lên chân, đồng thời vẫn nguyên vẹn diện mạo cổ điển đầy cuốn hút. Lựa chọn không thể bỏ qua đối với mọi tín đồ theo đuổi nét đẹp mang dấu ấn thời gian.'),
('AV00201','Urbas SC - Mule','URB',290000,580000,'Foliage','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber',NULL),
('AV00098','Basas Bumper Gum EXT NE - Low Top','BAS',58000,580000,'Black/Gum','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas/Suede<br>Outsole: Rubber<br>Có thêm 01 bộ dây đi kèm','Bumper Gum EXT (Extension) NE là bản nâng cấp được xếp vào dòng sản phẩm Basas, nhưng lại gây ấn tượng với diện mạo phá đi sự an toàn thường thấy. Với cách sắp xếp logo hoán đổi đầy ý tứ và mảng miếng da lộn (Suede) xuất hiện hợp lí trên chất vải canvas NE bền bỉ dày dặn nhấn nhá thêm bằng những sắc Gum dẻo dai. Tất cả làm nên 01 bộ sản phẩm với thiết kế đầy thoải mái trong trải nghiệm, đủ thanh lịch trong dáng vẻ.'),
('AV00071','Basas Bumper Gum NE - Low Top','BAS',104000,520000,'Offwhite/Gum','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber','Đánh dấu một bước trưởng thành nữa, Basas Bumper Gum NE (New Episode) ra đời với những cải tiến nhẹ nhàng nhưng đủ tạo được sự thay đổi trong cảm nhận khi trải nghiệm. Vẫn giữ ngoại hình gần như không thay để phát huy đặc tính ứng dụng cao của dòng Basas vốn đã được chứng minh, phần đế màu Gum thú vị và /Foxing thân/ mới làm nền cho phần chất liệu Upper được nâng cấp. Đây được xem là một trong những phiên bản được chúng tôi kì vọng có thể bền vững vượt qua thời gian và không gian, chắc chắn đáng để thử.'),
('AV00144','Basas Evergreen - Mule','BAS',232000,580000,'Evergreen','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber<br>Có thêm 01 bộ dây đi kèm',NULL),
('AV00207','Vintas Public 2000s - Low Top','VIN',186000,620000,'Insignia Blue','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber',NULL),
('AV00173','Vintas Jazico - Low Top','VIN',144000,720000,'Royal White','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas/Leather<br>Outsole: Rubber',NULL),
('AV00130','Urbas Retrospective - Mid Top','URB',430000,720000,'Popular Blue','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas<br>Outsole: Transparent Rubber','Với việc đưa những chiếc đế cao su "xuyên thấu" rực rỡ trở lại, kết hợp cùng phần upper bằng vải canvas với những màu sắc tươi rói, Urbas Retrospective đã khắc họa nên bức tranh đầy sinh động về một thời kỳ phát triển rực rỡ của thời trang và nghệ thuật của những thập kỉ trước. Đây chắc chắn sẽ là lựa chọn không thể thiếu trong tủ đồ đối với những bạn trẻ đang tìm kiếm nguồn cảm hứng cổ điển trong phong cách thời trang hiện đại và độc đáo của bản thân. Sự độc đáo này còn mạnh mẽ hơn trên một form dáng Mid Top hoàn toàn mới.'),
('AV00174','Vintas Jazico - High Top','VIN',156000,780000,'Royal White','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas/Leather<br>Outsole: Rubber',NULL),
('AV00171','Pattas Polka Dots - Low Top','PAT',430000,720000,'True Blue','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber',NULL),
('AV00122','Vintas Aunter - Low Top','VIN',345000,690000,'Soybean','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber','Kết hợp cùng diện mạo quai dán hookn loop mới mẻ, Aunter chính là một bản phối lạ lẫm nhưng đầy thú vị lần đầu tiên xuất hiện của dòng Vintas. Vẫn là chất vải Canvas thường gặp, đi cặp cùng các lựa chọn màu sắc phong phú nhưng vẫn ẩn sâu bên trong nét điềm đạm. Tất cả làm nên điểm nhấn chững chạc tổng thể, dễ dàng tôn lên nét thu hút cần thiết mọi lần lên chân.'),
('ALP2401','Urbas Love+ 24','URB',0,650000,'Oyster White','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Suede / Canvas<br>Outsole: Rubber',NULL),
('AV00208','Vintas Public 2000s - Low Top','VIN',124000,620000,'Brindle','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber',NULL),
('AV00126','Urbas Ruler - Low Top','URB',300000,590000,'Silver Pink','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas NE<br>Outsole: Rubber','Vẻ ngoài với màu sắc tươi tắn, hiện đại. Urbas Ruler mang trên mình một chức năng khiến không ít người bất ngờ, sẽ rất hữu ích dành cho những ai có thói quen dùng thước kẻ nhưng hay quên, mặc dù độ chính xác "chưa chắc cao".'),
('ANS006','Invisible Socks Pack - Ananas Typo','SOC',0,95000,'Estate Blue','Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/<br><br> ','Vớ ẩn hình có hoạ tiết đơn giản, gót nhựa trong cố định khó trượt. Tạo cảm giác thoải mái, đi như chân không và chắc chắn tàng hình khi mang trong giày.'),
('ANS020','Invisible Socks Pack - Ananas Typo','SOC',0,95000,'3 Colors','Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/','Bộ 3 vớ tàng hình, nhiều màu nhiều lựa chọn. Một đi học, một đi làm, một đi chơi, thay phiên nhau tàng hình trong đôi giày của bạn.'),
('AHP002','Hip Pack - Ananas Global Goal','HIP',55000,275000,'Purple Sage','Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/','Vớ ẩn hình có hoạ tiết đơn giản, gót nhựa trong cố định khó trượt. Tạo cảm giác thoải mái, đi như chân không và chắc chắn tàng hình khi mang trong giày.'),
('ANS024','Invisible Socks Pack - DiscoverYou','SOC',0,95000,'Black','Gender – /Unisex/<br>Họa tiết – /Discover You/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/','Bộ 3 vớ màu cơ bản, tàng hình, ít thấy khi mang thay phiên trong đôi giày của bạn.'),
('AHCS007','High Crew Socks - Ananas Daily Things','SOC',0,95000,'Sunny Lime','Giới tính – /Unisex/<br>Họa tiết – /Ananas Daily Things/<br>Thành phần – /53% Cotton, 40% Polyester, 3% Spandex, 2% Nylon, 2% Elastan/',NULL),
('AHCS012','High Crew Socks - Ananas Daily Things','SOC',0,95000,'Laurel Oak','Giới tính – /Unisex/<br>Họa tiết – /Ananas Daily Things/<br>Thành phần – /53% Cotton, 40% Polyester, 3% Spandex, 2% Nylon, 2% Elastan/',NULL),
('ALB006','Blank Shoelaces','SHO',0,35000,'Viridian Green','Chất liệu – /100% Cotton/<br>Chiều dài dây – /100cm – 115cm – 140cm/<br>Màu trơn đơn giản<br>Bản dẹp 8mm<br>Dệt đan xen','Dây giày bản dẹp, nổi bật bởi màu chính và điểm nhấn đầu tip có typo Ananas. Phù hợp để tạo nét mới mẻ, vừa phá cách trên chính đôi giày của bạn.'),
('ANS010','Invisible Socks Pack - Ananas Typo','SOC',0,95000,'Ocean Depths','Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/','Vớ ẩn hình có hoạ tiết đơn giản, gót nhựa trong cố định khó trượt. Tạo cảm giác thoải mái, đi như chân không và chắc chắn tàng hình khi mang trong giày.'),
('ASTB001','Ananas \Copy\ Store Bag 001','TOT',50000,250000,'Black','Giới tính: Unisex<br>Chất liệu: Canvas, định lượng 365GSM (trượt nước)<br>Thành phần chất liệu: 100% Cotton<br>Kích thước: 440 x 390 x 120 mm (W x H x D)<br>Dung tích: 20.5 lit<br>Hoạ tiết: Ananas – DiscoverYOU<br>Sử dụng phương pháp in lụa.','Hướng đến sức chịu đựng và độ lì lợm cao làm cốt lõi. Ananas "Copy" Store Bag 001 được thiết kế cực kì căn bản, tiết chế hoàn toàn các chi tiết cộng thêm khác để sự đặc biệt tập trung hoàn toàn vào chất liệu chính. Túi sử dụng Canvas cao cấp với định lượng lên đến 365 gsm, có tính năng trượt nước, chấp hết các thể loại xuyên thủng từ kim loại đến chất lỏng nếu đặt dưới một cường độ tác động không quá lớn.'),
('AHCS011','High Crew Socks - Ananas Daily Things','SOC',0,95000,'Candy Pink','Giới tính – /Unisex/<br>Họa tiết – /Ananas Daily Things/<br>Thành phần – /53% Cotton, 40% Polyester, 3% Spandex, 2% Nylon, 2% Elastan/',NULL),
('AHCS010','High Crew Socks - Ananas Daily Things','SOC',0,95000,'Cinnamon Stick','Giới tính – /Unisex/<br>Họa tiết – /Ananas Daily Things/<br>Thành phần – /53% Cotton, 40% Polyester, 3% Spandex, 2% Nylon, 2% Elastan/',NULL),
('ALB017','Blank Shoelaces','SHO',0,35000,'Sunlit Allium','Chất liệu – /100% Cotton/<br>Chiều dài dây – /100cm – 115cm – 140cm/<br>Màu trơn đơn giản.<br>Dạng ống – 10mm.','Dây giày trơn màu Sunlit Allium, dạng ống rỗng, thích hợp để thay mới hoặc mix màu cho đôi Low Top, High Top của bạn thêm khác biệt.'),
('ASTB002','Ananas \Copy\ Store Bag 002','TOT',56000,280000,'Caviar Black','Giới tính: Unisex<br>Chất liệu: Ripstop, định lượng 225GSM (trượt nước)<br>Thành phần chất liệu: 100% Polyester<br>Kích thước: 440 x 390 x 120 mm (W x H x D)<br>Dung tích: 20.5 lit<br>Hoạ tiết: Ananas – DiscoverYOU<br>Sử dụng phương pháp in lụa.','Hướng đến sự linh hoạt, phù hợp với nhiều hoàn cảnh sử dụng hay thời tiết khác nhau: dù nắng hay mưa do túi sử dụng chất liệu Ripstop có trọng lượng vừa phải và tính năng trượt nước trên bề mặt. Khoá kéo phao cũng hỗ trợ thêm cho tính năng này bên cạnh việc thuận tiện hơn trong việc cất giữ đồ đạc.'),
('ALB004','Blank Shoelaces','SHO',0,35000,'Carrot','Chất liệu – /100% Cotton/<br>Chiều dài dây – /100cm – 115cm – 140cm/<br>Màu trơn đơn giản<br>Bản dẹp 8mm<br>Dệt đan xen','Dây giày bản dẹp, đặc biệt nổi bật ở phần màu sắc. Phù hợp để tạo điểm nhấn mới mẻ, vừa phá cách trên chính đôi giày của bạn.'),
('ATH005','Trucker Hat - Be Positive','TRU',55000,275000,'Black/White','Gender – /Unisex/<br><br>Size: Free Hoạ tiết – /Be Positive/<br><br>Chất liệu – /100% Polyester/<br><br>Thêu 2D đơn giản','Trucker Hat - Be Positive màu Black/White đơn giản cùng artwork “Be Positive” mang nét tích cực của nhịp sống hiện đại. Với chất vải thun lạnh từ sợi Polyester có đệm mút và phần hậu dùng lưới mesh thông thoáng đặc trưng của Trucker Hat, đây chắc chắn là yếu tố ghi điểm cho những ngày quay cuồng, đầu bù tóc rối mà vẫn tự tin bứt phá chất tôi riêng biệt.'),
('AHP003','Hip Pack - Ananas Global Goal','HIP',55000,275000,'Blue Berry','Giới tính: Unisex<br>Chất liệu: Taslan, định lượng 230gsm (trượt nước)<br>Thành phần chất liệu: 100% Polyester<br>Kích thước: 280 x 120 x 100 mm (W x H x D)<br>Dung tích: 2.0 lit<br>Hoạ tiết: Ananas Global Goal',NULL),
('ANS004','Invisible Socks Pack - Ananas Typo','SOC',0,95000,'White','Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/','Vớ ẩn hình có hoạ tiết đơn giản, gót nhựa trong cố định khó trượt. Tạo cảm giác thoải mái, đi như chân không và chắc chắn tàng hình khi mang trong giày.'),
('AHP001','Hip Pack - Ananas Global Goal','HIP',55000,275000,'Climbing Ivy','Giới tính: Unisex<br>Chất liệu: Taslan, định lượng 230gsm (trượt nước)<br>Thành phần chất liệu: 100% Polyester<br>Kích thước: 280 x 120 x 100 mm (W x H x D)<br>Dung tích: 2.0 lit<br>Hoạ tiết: Ananas Global Goal',NULL),
('ANS003','Invisible Socks Pack - Ananas Typo','SOC',0,95000,'Grey','Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/','Vớ ẩn hình có hoạ tiết đơn giản, gót nhựa trong cố định khó trượt. Tạo cảm giác thoải mái, đi như chân không và chắc chắn tàng hình khi mang trong giày.'),
('ANS008','Invisible Socks Pack - Ananas Typo','SOC',0,95000,'Mimosa','Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/<br><br> ','Vớ ẩn hình có hoạ tiết đơn giản, gót nhựa trong cố định khó trượt. Tạo cảm giác thoải mái, đi như chân không và chắc chắn tàng hình khi mang trong giày.'),
('ANS011','Invisible Socks Pack - Ananas Typo','SOC',0,95000,'3 Colors','Gender – /Unisex/<br>Họa tiết – /Ananas Typo/<br>Thành phần – /80% Cotton – 18% Spandex – 2% Rubber/','Bộ 3 vớ tàng hình, nhiều màu nhiều lựa chọn. Một đi học, một đi làm, một đi chơi, thay phiên nhau tàng hình trong đôi giày của bạn'),
('AHCS004','High Crew Socks - Ananas Puppet Club','SOC',0,119000,'Tie Dye','Gender – /Unisex/<br><br>Họa tiết – /Ananas Puppet Club/<br><br>Kỹ thuật – /Nhuộm Tie Dye/<br><br>Thành phần – /78% Cotton, 15% Spandex, 5% Rubber, 2% Nylon/',NULL),
('AGT0023','Graphic Tee - Dance Till Sunrise','GRA',0,350000,'Jet Black','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 220GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: Dance Till Sunrise<br>Sử dụng phương pháp in PET.',NULL),
('AGT0006','Hiphop Graphic Tee - Outline Typo','GRA',200000,350000,'Black','Giới tính: Unisex<br>Form nên mặc: Oversized<br>Chất liệu: 100% Cotton<br>Định lượng: 220 GSM<br>Độ co dãn: +/- 3%','Streetwear nói chung và thời trang Hiphop nói riêng không bao giờ thiếu đi những chiếc Graphic Tee nổi bật với cổ tròn ôm gọn, tay lỡ và phom áo rộng linh hoạt. Kết hợp cùng họa tiết Ananas Typo biến tấu lạ mắt cùng dòng chữ Discover Ananas sau cổ, Hiphop Graphic Tee sẽ là một mảnh ghép không tồi giúp bạn có bộ outfit thú vị và khẳng định cá tính riêng của bản thân.'),
('AGLT0028','Long Sleeve Graphic Tee - Love, Peace & Music','GRA',0,390000,24,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 220GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: Love, Peace & Music<br>Sử dụng phương pháp in lụa.',NULL),
('ABT00025','Basic Tee - Ananas Oval Symbol','BAT',0,290000,'Frost Gray','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Hoạ tiết Ananas trong khung viền oval được thêu tinh tế, đồng màu khiến chiếc áo nhìn "vẫn trơn" nhưng ánh nhẹ điểm nhấn tinh tế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('ABT00032','Basic Pocket Tee - Ananas Mini Label','BAT',0,290000,'Caviar Black','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay, có túi với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt Ananas xanh, nho nhỏ kẹp nhẹ nhàng bên cạnh trái túi tạo điểm nhấn vừa phải, không làm mất đi định hướng của áo cơ bản. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('AET00002','Pigment Tee - Nice Nature Club','EFF',0,390000,'Greener Pastures','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 210GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: Nice Nature Club<br>Kỹ thuật nhuộm Pigment Dye.',NULL),
('AHO0010','Doraemon 50 Years Hoodie','HOO',0,590000,'Black','Gender: Unisex<br>Form: Regular<br>Size run: S – M – L – XL<br>Chất liệu: 100% Cotton<br>Hình in trên nên áo ép nổi.','Chiếc Hoodie màu Black căn bản sở hữu nhiều graphic truyện tranh Doraemon ẩn giấu. Điểm nhấn đặc biệt từ logo Doraemon phiên bản tiếng Nhật đặc trưng với hiệu ứng ép nổi 3D độc đáo và chiếc túi trước bụng, tuy không phải túi thần kì nhưng sẽ mang đến cho bạn những ứng dụng bất ngờ.'),
('AGT0002','Hiphop Graphic Tee - Discover Ananas','GRA',215000,365000,'Ketchup','Giới tính: Unisex<br>Form nên mặc: Oversized<br>Chất liệu: 100% Cotton<br>Định lượng: 220 GSM<br>Độ co dãn: +/- 3%','Streetwear nói chung và thời trang Hiphop nói riêng không bao giờ thiếu đi những chiếc Graphic Tee nổi bật với cổ tròn ôm gọn, tay lỡ và phom áo rộng linh hoạt. Kết hợp cùng họa tiết Discover Ananas ở trước và sau, Hiphop Graphic Tee sẽ là một mảnh ghép không tồi giúp bạn có bộ outfit thú vị và khẳng định cá tính riêng của bản thân.'),
('ABT00022','Basic Tee - Ananas Oval Symbol','BAT',0,290000,'Caviar Black','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Hoạ tiết Ananas trong khung viền oval được thêu tinh tế, đồng màu khiến chiếc áo nhìn "vẫn trơn" nhưng ánh nhẹ điểm nhấn tinh tế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('ABT00021','Basic Tee - Ananas Oval Symbol','BAT',0,290000,'Cloud Dancer','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Hoạ tiết Ananas trong khung viền oval được thêu tinh tế, đồng màu khiến chiếc áo nhìn "vẫn trơn" nhưng ánh nhẹ điểm nhấn tinh tế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('AGT0014','Graphic Tee - Most Wanted Dalton','GRA',200000,350000,'Caviar Black','Gender – /Unisex/<br>Hình in – /Most Wanted Daltons/<br>Chất liệu – /100% Cotton/<br>Size – /S – M – L – XL/<br>Màu sắc: Caviar Black<br>In 2D','Những chiếc áo Ananas Graphic Tee có phom dáng thoải mái, rộng linh hoạt được kết hợp cùng hoạ tiết lấy cảm hứng từ bộ truyện tuổi thơ Lucky Luke. Đây sẽ là một mảnh ghép cho những outfit thú vị, dù đủ bộ hay mặc riêng lẻ vẫn khẳng định cá tính riêng biệt, ghi dấu ấn cho lần hợp tác quốc tế đầu tiên của Ananas.'),
('AET00001','Pigment Tee - AAA New Standard','EFF',0,390000,'Kangaroo','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: AAA – New Standard<br>Kỹ thuật nhuộm Pigment Dye.',NULL),
('ABT00033','Basic Pocket Tee - Ananas Mini Label','BAT',0,290000,'Molten Lava','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay, có túi với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt Ananas xanh, nho nhỏ kẹp nhẹ nhàng bên cạnh trái túi tạo điểm nhấn vừa phải, không làm mất đi định hướng của áo cơ bản. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('ABT00024','Basic Tee - Ananas Oval Symbol','BAT',0,290000,'Medium Green','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Hoạ tiết Ananas trong khung viền oval được thêu tinh tế, đồng màu khiến chiếc áo nhìn "vẫn trơn" nhưng ánh nhẹ điểm nhấn tinh tế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('ABT00026','Basic Tee - Branding Label','BAT',0,290000,'Cloud Dancer','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt xanh mang vài thông điệp nho nhỏ đính gọn gàng cạnh gấu áo, tạo chút điểm nhấn vui tươi nhưng không làm mất đi định hướng cơ bản trong thiết kế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('AGT0010','Hiphop Graphic Tee - Ananas Symbol','GRA',215000,365000,'Black','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Streetwear nói chung và thời trang Hiphop nói riêng không bao giờ thiếu đi những chiếc Graphic Tee nổi bật với cổ tròn ôm gọn, tay lỡ và phom áo rộng linh hoạt. Kết hợp cùng họa tiết Discover Ananas ở trước và sau, Hiphop Graphic Tee sẽ là một mảnh ghép không tồi giúp bạn có bộ outfit thú vị và khẳng định cá tính riêng của bản thân.'),
('AGT0009','Hiphop Graphic Tee - Ananas Symbol','GRA',215000,365000,'Ketchup','Giới tính: Unisex<br>Form nên mặc: Oversized<br>Chất liệu: 100% Cotton<br>Định lượng: 220 GSM<br>Độ co dãn: +/- 3%','Streetwear nói chung và thời trang Hiphop nói riêng không bao giờ thiếu đi những chiếc Graphic Tee nổi bật với cổ tròn ôm gọn, tay lỡ và phom áo rộng linh hoạt. Kết hợp cùng họa tiết Discover Ananas ở trước và sau, Hiphop Graphic Tee sẽ là một mảnh ghép không tồi giúp bạn có bộ outfit thú vị và khẳng định cá tính riêng của bản thân.'),
('ABT00035','Basic Pocket Tee - Ananas Mini Label','BAT',0,290000,'Antique White','Giới tính: Unisex<br>Form: Regular<br>Chất liệu: Single Jersey<br>Định lượng: 250 GSM','Áo thun ngắn tay, có túi với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt Ananas xanh, nho nhỏ kẹp nhẹ nhàng bên cạnh trái túi tạo điểm nhấn vừa phải, không làm mất đi định hướng của áo cơ bản. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('AGT0024','Graphic Tee - The Guitar Sings','GRA',0,350000,'Jet Black','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 220GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: The Guitar Sings<br>Sử dụng phương pháp in lụa.',NULL),
('ABT00030','Basic Tee - Branding Label','BAT',0,290000,'Frost Gray','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt xanh mang vài thông điệp nho nhỏ đính gọn gàng cạnh gấu áo, tạo chút điểm nhấn vui tươi nhưng không làm mất đi định hướng cơ bản trong thiết kế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('ABT00031','Basic Pocket Tee - Ananas Mini Label','BAT',0,290000,'Cloud Dancer','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay, có túi với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt Ananas xanh, nho nhỏ kẹp nhẹ nhàng bên cạnh trái túi tạo điểm nhấn vừa phải, không làm mất đi định hướng của áo cơ bản. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('AGT0003','Hiphop Graphic Tee - Discover Ananas','GRA',215000,365000,'Ermine','Gender: Unisex<br>Form nên mặc: Oversized<br>Chất liệu: 100% Cotton<br>Định lượng: 220 GSM<br>Độ co dãn: +/- 3%','Streetwear nói chung và thời trang Hiphop nói riêng không bao giờ thiếu đi những chiếc Graphic Tee nổi bật với cổ tròn ôm gọn, tay lỡ và phom áo rộng linh hoạt. Kết hợp cùng họa tiết Discover Ananas ở trước và sau, Hiphop Graphic Tee sẽ là một mảnh ghép không tồi giúp bạn có bộ outfit thú vị và khẳng định cá tính riêng của bản thân.'),
('ABT00027','Basic Tee - Branding Label','BAT',0,290000,'Caviar Black','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt xanh mang vài thông điệp nho nhỏ đính gọn gàng cạnh gấu áo, tạo chút điểm nhấn vui tươi nhưng không làm mất đi định hướng cơ bản trong thiết kế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('ABT00029','Basic Tee - Branding Label','BAT',0,290000,'Medium Green','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt xanh mang vài thông điệp nho nhỏ đính gọn gàng cạnh gấu áo, tạo chút điểm nhấn vui tươi nhưng không làm mất đi định hướng cơ bản trong thiết kế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('AGT0022','Graphic Tee - Logos Packed','GRA',0,350000,'Snow White','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 220GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: Logos Packed<br>Sử dụng phương pháp in PET.',NULL),
('ABT00028','Basic Tee - Branding Label','BAT',0,290000,'Grape Compote','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt xanh mang vài thông điệp nho nhỏ đính gọn gàng cạnh gấu áo, tạo chút điểm nhấn vui tươi nhưng không làm mất đi định hướng cơ bản trong thiết kế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('ABT00023','Basic Tee - Ananas Oval Symbol','BAT',0,290000,'Grape Compote','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Hoạ tiết Ananas trong khung viền oval được thêu tinh tế, đồng màu khiến chiếc áo nhìn "vẫn trơn" nhưng ánh nhẹ điểm nhấn tinh tế. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('ABT00034','Basic Pocket Tee - Ananas Mini Label','BAT',0,290000,'Dune','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 250GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL','Áo thun ngắn tay, có túi với màu trơn đơn giản, form áo căn bản; vải được dệt từ 100% sợi cotton to, thô mộc, đứng dáng. Tem dệt Ananas xanh, nho nhỏ kẹp nhẹ nhàng bên cạnh trái túi tạo điểm nhấn vừa phải, không làm mất đi định hướng của áo cơ bản. Phối và ứng dụng bất chấp trong mọi ngày, mọi thể loại trang phục (nếu hợp màu).'),
('AGT0021','Graphic Tee - Skate 4P','GRA',0,350000,'Snow White','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 220GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: Skate 4P<br>Sử dụng phương pháp in PET.',NULL),
('AGT0020','Graphic Pocket Tee - Doraemon 50 Years','GRA',0,390000,'Cloud Dancer','Gender: Unisex<br>Form: Regular<br>Size run: S – M – L – XL<br>Chất liệu: 100% Cotton<br>Hình in, thêu 2D sắc nét.','Ananas Graphic Tee sở hữu phom dáng rộng thoải mái với chất vải 100% cotton dày vừa phải. Kết hợp chi tiết từ bộ truyện Doraemon cùng Typo đặc trưng kỉ niệm 50 năm tạo nên chiếc Pocket cá tính bên ngực trái. Chiếc áo là mảnh ghép phù hợp cho những bạn yêu thích Doraemon và muốn lưu dấu cột mốc đặc biệt này.'),
('AGLT0027','Long Sleeve Graphic Tee - Love, Peace & Music','GRA',0,390000,20,'Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 220GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: Love, Peace & Music<br>Sử dụng phương pháp in lụa.',NULL),
('AGT0026','Graphic Tee - Logos Packed','GRA',0,350000,'Vibrant Orange','Giới tính: Unisex<br>Form dáng: Regular<br>Chất liệu: Single Jersey, định lượng 220GSM<br>Thành phần chất liệu: 100% Cotton<br>Size: S – M – L – XL<br>Hoạ tiết: Logos Packed<br>Sử dụng phương pháp in lụa.',NULL),
('AV00210','Basas Day Slide - Slip On','BAS',0,550000,'Offwhite','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas<br>Outsole: Rubber',NULL),
('AV00211','Basas Day Slide - Slip On','BAS',0,550000,'Caviar Black','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas<br>Outsole: Rubber',NULL),
('AV00167','Urbas Corluray Mix - High Top','URB',260000,650000,'Corluray Mix','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Corduroy<br>Outsole: Rubber',NULL),
('A6T014','Track 6 2.Blues - Low Top','TRA',238000,1190000,'Navy Blue','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Eco Nylon Fabric<br>Outsole: Rubber',NULL),
('ALP2023','Urbas Love+ 23 - Slip On','URB',0,550000,'Offwhite','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Canvas<br>Outsole: Rubber',NULL),
('AV00154','Vintas Soda Pop - Low Top','VIN',390000,680000,'Amparo Blue','Gender: Unisex<br>Size run: 35 – 46<br>Upper: Corduroy<br>Outsole: Rubber',NULL);

-- Category Table
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` varchar(2) NOT NULL COMMENT 'category id',
  `category_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'category name',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='categories';

INSERT INTO `category` (`category_id`, `category_name`)
VALUES
('TO', 'Top'),
('AC', 'Accessories'),
('FO', 'Footwear');

-- Subcategory Table
DROP TABLE IF EXISTS `subcategory`;
CREATE TABLE IF NOT EXISTS `subcategory` (
  `subcategory_id` varchar(3) NOT NULL COMMENT 'subcategory id',
  `subcategory_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'subcategory name',
  `category_id` varchar(2) NOT NULL COMMENT 'category id',
  PRIMARY KEY (`subcategory_id`),
  KEY `fk_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='subcategories';

INSERT INTO `subcategory` (`subcategory_id`, `subcategory_name`,`category_id`)
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
('SOC', 'Socks', 'AC'),
('SHO', 'Shoelaces', 'AC'),
('TOT', 'Tote Bag', 'AC'),
('TRU', 'Trucker Hat', 'AC');

-- Size Table
DROP TABLE IF EXISTS `size`;
CREATE TABLE IF NOT EXISTS `size` (
  `prod_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'product id',
  `s` int NOT NULL DEFAULT '0' COMMENT 'size s',
  `m` int NOT NULL DEFAULT '0' COMMENT 'size m',
  `l` int NOT NULL DEFAULT '0' COMMENT 'size l',
  `xl` int NOT NULL DEFAULT '0' COMMENT 'size xl',
  KEY `fk_size_prod_id` (`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii COLLATE=ascii_bin COMMENT='sizes';

INSERT INTO `size` (`prod_id`, `s`, `m`, `l`, `xl`) VALUES
('AV00121',50,70,70,10),
('A6T006',25,15,20,10),
('AV00202',80,50,10,19),
('AV00131',30,10,10,10),
('AV00158',6,9,5,5),
('AV00117',20,30,0,20),
('AV00172',4,6,6,2),
('AV00001',10,5,20,10),
('AV00183',40,20,5,5),
('AV00115',48,2,80,0),
('AV00206',20,20,20,20),
('AV00116',20,20,20,20),
('AV00189',20,20,20,20),
('AV00149',20,20,20,20),
('AV00135',18,22,20,20),
('AV00005',20,20,20,20),
('AV00180',20,20,20,20),
('AV00181',20,20,20,20),
('AV00199',20,20,20,20),
('AV00012',0,40,40,0),
('A6T016',20,20,20,20),
('AV00125',20,20,20,20),
('AV00004',20,20,20,20),
('AV00119',20,0,20,20),
('AV00165',18,22,20,20),
('AV00101',20,20,20,20),
('AV00201',20,20,20,20),
('AV00098',20,20,20,20),
('AV00071',20,20,20,20),
('AV00144',38,2,40,0),
('AV00207',10,10,10,10),
('AV00173',10,10,10,10),
('AV00130',10,10,10,10),
('AV00174',10,10,10,10),
('AV00171',8,12,10,10),
('AV00122',10,10,10,10),
('ALP2401',50,10,0,2),
('AV00208',10,10,10,10),
('AV00126',10,10,10,10),
('ANS006',0,20,20,0),
('ANS020',10,10,10,10),
('AHP002',10,0,10,20),
('ANS024',10,10,10,10),
('AHCS007',10,10,10,20),
('AHCS012',8,12,10,10),
('ALB006',10,10,10,10),
('ANS010',10,10,10,10),
('ASTB001',5,10,15,10),
('AHCS011',10,10,10,10),
('AHCS010',18,2,20,0),
('ALB017',20,0,0,10),
('ASTB002',20,50,30,20),
('ALB004',20,50,30,20),
('ATH005',70,50,50,0),
('AHP003',20,50,60,20),
('ANS004',0,50,90,70),
('AHP001',20,50,30,20),
('ANS003',20,50,30,20),
('ANS008',0,10,0,20),
('ANS011',20,0,0,0),
('AHCS004',10,10,10,10),
('AGT0023',40,50,70,40),
('AGT0006',20,30,0,20),
('AGLT0028',10,10,20,10),
('ABT00025',58,92,80,20),
('ABT00032',20,50,50,20),
('AET00002',20,30,10,20),
('AHO0010',20,30,50,20),
('AGT0002',50,50,50,60),
('ABT00022',28,2,10,0),
('ABT00021',10,10,15,15),
('AGT0014',2,2,2,2),
('AET00001',48,22,30,40),
('ABT00033',40,40,40,40),
('ABT00024',60,50,60,60),
('ABT00026',30,25,35,30),
('AGT0010',80,60,90,100),
('AGT0009',0,45,45,0),
('ABT00035',100,150,100,100),
('AGT0024',40,40,60,20),
('ABT00030',100,170,130,0),
('ABT00031',60,60,60,60),
('AGT0003',88,27,25,25),
('ABT00027',60,60,60,60),
('ABT00029',40,60,40,20),
('AGT0022',30,50,50,50),
('ABT00028',50,100,50,150),
('ABT00023',118,2,120,0),
('ABT00034',20,25,25,25),
('AGT0021',90,25,25,25),
('AGT0020',30,25,25,25),
('AGLT0027',10,20,20,10),
('AGT0026',18,22,20,20),
('AV00210',20,30,40,10),
('AV00211',20,30,30,20),
('AV00167',30,40,40,10),
('A6T014',10,20,20,20),
('ALP2023',0,80,40,0),
('AV00154',10,20,10,10);

-- Foreign Key Constraints
ALTER TABLE `cart`
  ADD CONSTRAINT `fk_cart-prod_id` FOREIGN KEY (`prod_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `fk_cart-username` FOREIGN KEY (`username`) REFERENCES `account` (`username`) ON DELETE CASCADE;

ALTER TABLE `order`
  ADD CONSTRAINT `fk_order_username` FOREIGN KEY (`username`) REFERENCES `account` (`username`) ON DELETE CASCADE;

ALTER TABLE `order_detail`
  ADD CONSTRAINT `fk_order-id` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order_detail-prod_id` FOREIGN KEY (`prod_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE;

ALTER TABLE `size`
  ADD CONSTRAINT `fk_size_prod_id` FOREIGN KEY (`prod_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE;

ALTER TABLE `subcategory`
  ADD CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE;

ALTER TABLE `product`
  ADD CONSTRAINT `fk_sub_id` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategory` (`subcategory_id`) ON DELETE CASCADE;

COMMIT;
