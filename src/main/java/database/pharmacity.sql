
CREATE DATABASE IF NOT EXISTS `pharmacity` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `pharmacity`;


CREATE TABLE IF NOT EXISTS `users` (
                                       `userID` int(11) NOT NULL AUTO_INCREMENT,
    `email` varchar(50) NOT NULL,
    `phoneNumbers` varchar(20) NOT NULL,
    `fullName` varchar(50) NOT NULL,
    `password` varchar(50) NOT NULL,
    `dob` date NOT NULL,
    `gender` varchar(20) NOT NULL,
    `role` varchar(20) NOT NULL,
    `access` varchar(20) NOT NULL,

    PRIMARY KEY (`userID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



INSERT INTO `users` (`userID`, `email`, `phoneNumbers`, `fullName`, `password`, `dob`, `gender`, `role`, `access`) VALUES
                                                                                                                       (1, 'phuoc@gmail.com', '0986216717', 'Nguyễn Hữu Phước', '123', '2003-02-17', 'nam', 'true', 'true'),
                                                                                                                       (2, 'admin@gmail.com', '0986216717', 'admin', 'admin', '2003-02-17', 'nam', 'true', 'true');




CREATE TABLE IF NOT EXISTS `category` (
                                          `categoryID` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL,
    PRIMARY KEY (`categoryID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `category` (`categoryID`, `name`) VALUES
                                                  (1, 'Khẩu trang y tế'),
                                                  (2, 'Máy massage'),
                                                  (3, 'Máy đo huyết áp'),
                                                  (4, 'Băng - Gạc y tế'),
                                                  (5, 'Bông y tế'),
                                                  (6, 'Nhiệt kế'),
                                                  (7, 'Máy, que thử đường huyết'),
                                                  (8, 'Kim các loại'),
                                                  (9, 'Dụng cụ xét nghiệm'),
                                                  (10, 'Găng tay'),
                                                  (11, 'Máy xông mũi họng'),
                                                  (12, 'Máy xông khí'),
                                                  (13, 'Đèn Y Khoa'),
                                                  (14, 'Máy đo SpO2'),
                                                  (15,'Test covid');
--	(999, 'loại');




CREATE TABLE IF NOT EXISTS `origin` (
                                        `originID` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL,
    PRIMARY KEY (`originID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `origin` (`originID`, `name`) VALUES
                                              (1, 'Việt Nam'),
                                              (2, 'Trung Quốc'),
                                              (3, 'Thụy Sĩ'),
                                              (4, 'Hoa Kỳ'),
                                              (5, 'Hàn Quốc'),
                                              (6, 'Đài Loan'),
                                              (7, 'Đức'),
                                              (8, 'Nhật bản'),
                                              (9, 'Thái Lan'),
                                              (10, 'Ấn Độ'),
                                              (11, 'Pháp');
--	(999, 'quốc gia');



CREATE TABLE IF NOT EXISTS `products` (
                                          `productID` int(11) NOT NULL AUTO_INCREMENT,
    `categoryID` int(11) NOT NULl,
    `originID` int(11) NOT NULL,
    `quantity` int(11) NOT NULL,
    `dateAdded` date NOT NULL,
    `price` int(11) NOT NULL,
    `sale` int(11) NOT NULL,
    `orderedNumbers` int(11) NOT NULL,
    `name` varchar(100) NOT NULL,
    `trademark` varchar(50) NOT NULL,
    `content` varchar(200) NOT NULL,

    PRIMARY KEY (`productID`),
    KEY `userID` (`categoryID`),
    KEY `productID` (`originID`),
    CONSTRAINT `products_fk_categoryID` FOREIGN KEY (`categoryID`) REFERENCES `category` (`categoryID`),
    CONSTRAINT `products_fk_originID` FOREIGN KEY (`originID`) REFERENCES `origin` (`originID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `products` (`productID`, `categoryID`, `originID`, `quantity`, `dateAdded`, `price`, `sale`, `orderedNumbers`, `name`, `trademark`, `content`) VALUES
                                                                                                                                                               (1, 3, 3, 999, '2023-02-17', 20000, 1000, 10, 'Máy đo huyết áp tự động Microlife B3 Basic hỗ trợ đo huyết áp', 'MICROLIFE AG', 'Máy đo huyết áp bắp tay tự động Microlife B3 Basic là sản phẩm thế hệ mới của thương hiệu Microlife đến từ Thụy Sĩ, dùng để đo huyết áp và nhịp tim. Sản phẩm ứng dụng công nghệ MAM hiện đại, thông minh mang lại cho người dùng trải nghiệm an toàn, nhanh chóng và chính xác.'),
                                                                                                                                                               (2, 1, 1, 999, '2023-02-17', 24000, 1000, 20, 'Khẩu trang 3D trẻ em quai vải Swan Mask ngăn giọt bắn, vi khuẩn, khói bụi (10 cái)', 'CÔNG TY TNHH VẬT TƯ Y TẾ GIA BẢO', 'Khẩu trang 3D trẻ em quai vải Swan Mask với công nghệ lọc 4.0 mang lại hiệu quả trên 95%, giúp ngăn giọt bắn, vi khuẩn, khói bụi, bảo vệ đường hô hấp của bé tối ưu.'),
                                                                                                                                                               (3, 1, 1, 999, '2023-02-17', 49000, 1000, 30, 'Khẩu trang Niva N95 hỗ trợ ngăn bụi và vi khuẩn (10 cái)', 'DILIGO HOLDINGS', 'Khẩu trang NIVA N95 được tạo bởi 2 lớp vải không dệt cao cấp không thấm nước, bụi, dầu, giọt bắn, một lớp vải bông không dệt và 1 lớp màng lọc có tác dụng ngăn vi khuẩn, khói, bụi, dầu, giọt bắn xâm nhập, phòng chống các dịch bệnh nguy hiểm lây qua đường hô hấp. Sản phẩm khẩu trang N95 sử dụng hiệu quả cho các y bác sĩ, trong môi trường tiếp xúc với các bệnh nhân và phòng mổ, môi trường công nghiệp độc hại, nơi công cộng để ngăn ngừa dịch bệnh và giọt bắn có nguy cơ lây nhiễm mầm bệnh.'),
                                                                                                                                                               (4, 1, 1, 999, '2023-02-17', 39000, 1000, 40, 'Khẩu trang y tế Famapro Extra màu trắng 4 lớp hỗ trợ ngăn khói, bụi, kháng khuẩn (50 cái)', 'Famapro', 'Khẩu trang y tế 4 lớp Famapro Extra siêu mềm mượt, nguyên liệu cao cấp, kháng khuẩn, lọc bụi mịn và chống tia UV hiệu quả.'),
                                                                                                                                                               (5, 1, 1, 999, '2023-02-17', 69000, 1000, 50, 'Khẩu trang y tế cao cấp 3Hmask 4D Vĩnh Tiến màu trắng hỗ trợ ngăn khói, bụi, kháng khuẩn (20 cái)', 'Vĩnh Tiến', 'Khẩu trang 4D 3Hmask Vĩnh Tiến với thiết kế form 4D ôm sát khuôn mặt, đảm bảo ngăn cản được các giọt bắn và siêu bụi mịn, ngăn vi khuẩn, phòng chống các dịch bệnh nguy hiểm lây qua đường hô hấp.'),
                                                                                                                                                               (6, 1, 1, 999, '2023-02-17', 65000, 1000, 60, 'Khẩu trang y tế Hamita N95 ngăn bụi, kháng khuẩn (10 cái)', 'HẠNH MINH', 'Khẩu trang Hamita N95 Hộp 10 Cái với lớp lọc khuẩn công nghệ tĩnh điện để giữ lại các hạt mịn ô nhiễm không khí hiệu quả: Trên 95% bụi mịn 0.3 micron và trên 98% bụi mịn < 2.5 micron. Đây là khẩu trang N95 được khuyến nghị sử dụng khi chỉ số chất lượng không khí trên 100 (AQI).'),
                                                                                                                                                               (7, 2, 2, 999, '2023-02-17', 1950000, 1000, 70, 'Máy massage Pangao PG-2601B51 xoa dịu đốt sống cổ, giúp thư giãn giảm căng thẳng', 'Pangao', 'Máy massage cổ Pangao sử dụng công nghệ xoa bóp mô phỏng Shiatsu ba chiều 3D và mô phỏng thao tác xoa bóp tại Spa. Đầu massage 3D áp dụng công nghệ ánh sáng hồng ngoại, có thể xoa dịu đốt sống cổ, giúp bạn thư giãn giảm căng thẳng ngay tại nhà.'),
                                                                                                                                                               (8, 2, 1, 999, '2023-02-17', 70000, 1000, 80, 'Dụng cụ massage ngón tay Duy Thành giảm thiểu lo lắng, căng thẳng trong cuộc sống (1 cái x 120gr)', 'DUY THÀNH', 'Dụng cụ massage ngón tay Duy Thành với thiết kế đặc biệt giúp việc massage các ngón tay hiệu quả, tăng cường sự kết nối xúc cảm và tiếp xúc với các cơ quan trong cơ thể. Mỗi lần bạn chỉ cần xoa nắn các ngón tay 3-5 phút, ngày làm 3-5 lần cũng giúp cải thiện sức khỏe rõ rệt.'),
                                                                                                                                                               (9, 4, 1, 999, '2023-02-17', 27000, 1000, 90, 'Băng keo cá nhân in hình Pororo Kids Band Young Chemical Vina (72mm x 18mm - 20 miếng)', 'CÔNG TY TNHH YOUNG CHEMICAL VINA', 'Băng Keo Cá Nhân Kids Band (Pororo) là dòng sản phẩm dành cho trẻ nhỏ và đối tượng người dùng có da nhạy cảm phân phối dành cho thị trường Việt Nam. Bề mặt sản phẩm được in hình nhận vật hoạt hình Pororo dễ thương, đi kèm với vải băng gạc có chứa Benzalkonium giúp mau làm lành vết thương. Đây là sản phẩm mà các bậc phụ huynh nên cân nhắc bổ sung cho tủ thuốc – dụng cụ y tế gia đình mình.'),
                                                                                                                                                               (10, 5, 1, 999, '2023-02-17', 32000, 1000, 100, 'Bông viên Niva YB2 dùng trong phòng khám, vệ sinh cá nhân, vệ sinh vết thương, tẩy trang (100 viên)', 'DILIGO HOLDINGS', 'Bông viên Niva được làm từ 100% bông thiên nhiên​, có sợi sơ dài và chắc chắn nên khi sử dụng sẽ không bị đổ bụi. Sản phẩm được dùng để làm sạch vết thương, thấm máu và dịch tiết hoặc để thấm thuốc bôi lên vết thương.'),
                                                                                                                                                               (11, 6, 3, 999, '2023-02-17', 27000, 1000, 90, 'Nhiệt kế hồng ngoại đo trán Microlife NC200 không cần tiếp xúc, cho kết quả sau 1 giây', 'ONBO ELECTRONIC (SHENZEN) CO.LTD', 'Nhiệt kế hồng ngoại đo trán NC200 nhỏ gọn, dễ sử dụng, phù hợp với việc đo thân nhiệt cho người lớn và trẻ em. Đo nhanh, không chạm, an toàn, chính xác, thích hợp sử dụng tại bệnh viện, phòng khám, cơ quan, trường học, gia đình…'),
                                                                                                                                                               (12, 7, 4, 999, '2023-02-17', 27000, 1000, 90, 'Máy đo đường huyết tự động MediUSA GM3300 thiết kế gọn nhẹ, thao tác sử dụng đơn giản', 'MEDIUSA', 'Máy đo đường huyết MediUSA GM3300 được thiết kế dựa trên nhu cầu kiểm tra đường huyết thường xuyên của tất cả mọi người. Sản phẩm kiểm soát đường huyết tự động mã hóa, kích cỡ mẫu máu 0.7ul, đo nhanh trong 6 giây, kết quả đo trung bình của 7 ngày, bộ nhớ 250 kết quả và thiết kế gọn nhẹ. '),
                                                                                                                                                               (13, 7, 5, 999, '2023-02-17', 27000, 1000, 90, 'Máy đo đường huyết Nipro Premier Alpha giúp đo đường huyết một cách an toàn, nhanh chóng, chính xác', 'I-SENS WONJU FACTORY', 'Máy đo đường huyết Nipro Premier Alpha là sản phẩm của thương hiệu Nipro, được sản xuất tại Hàn Quốc. Nipro được sáng lập từ năm 1954, có trụ sở đặt tại Osaka – Nhật Bản. Nipro Corporation là một công ty sản xuất thiết bị y tế của Nhật Bản, tập đoàn có cơ sở sản xuất và kinh doanh trên quy mô toàn cầu. Nipro Premier Alpha có cổng dữ liệu kết nối Bluetooth, cho phép chia sẻ và lưu trữ kết quả qua ứng dụng FPT Medicare trên các thiết bị điện tử thông minh, giúp người dùng quản lý và theo dõi kết quả đường huyết một cách khoa học, hiệu quả.'),
                                                                                                                                                               (14, 7, 4, 999, '2023-02-17', 27000, 1000, 90, 'Máy đo đường huyết On Call Ez II ACON thiết kế gọn nhẹ, thao tác sử dụng đơn giản', 'ACON', 'Máy đo đường huyết On Call EZ II với công nghệ đo ứng dụng cảm ứng sinh học tiên tiến, cho kết quả chính xác đến 99%. Máy được thiết kế gọn nhẹ, thao tác sử dụng đơn giản, thuận lợi cho bệnh nhân tự đo đường huyết của mình ở mọi lúc, mọi nơi.'),
                                                                                                                                                               (15, 7, 6, 999, '2023-02-17', 27000, 1000, 90, 'Que thử đường huyết FaCare FC-M168 (TD-4216) kiểm tra nồng độ đường huyết trong máu (25 cái)', 'TAIDOC', 'm phân phối dành cho thị trườ'),

                                                                                                                                                               (16, 6, 2, 999, '2023-02-17', 300000 , 1000, 100, 'Nhiệt kế hồng ngoại CK-T1502 (EXC)', 'EXC', 'Sản phẩm này được thiết kế để đo nhiệt độ cơ thể người bằng cách thu bức xạ nhiệt hồng ngoại từ trán người, có ưu điểm là vận hành đơn giản và vệ sinh, đo nhanh và chính xác.'),
                                                                                                                                                               (17, 3, 1, 999, '2023-02-17', 350000 , 1000, 100, 'Máy đo huyết áp tự động Omron HEM-7124 (Hộp 1 cái)', 'Omron', 'Sản phẩm này được thiết kế để đo huyết áp cơ thể người bằng cách thu bức xạ nhiệt hồng ngoại từ trán người, có ưu điểm là vận hành đơn giản và vệ sinh, đo nhanh và chính xác.'),
                                                                                                                                                               (18, 8, 8, 999, '2023-02-17', 275000 , 1000, 100, 'Đầu kim tiêm tiểu đường Novofine 31G (100cái/hộp - 0.25x6mm)', 'Novofine', 'Khi sử dụng, gỡ miếng bảo vệ kim và vặn kim chặt vào đầu bút tiêm.'),
                                                                                                                                                               (19, 9, 2, 999, '2023-02-17', 2200000 , 1000, 100, 'Dụng cụ xét nghiệm nhanh COVID-19 Flowflex Test Kit (Hộp 25 bộ kit)', 'Flowflex', 'Flowflex SARS-CoV-2 Antigen Rapid Test giúp phát hiện nhanh kháng nguyên SARS-CoV-2 trong mẫu ngoáy dịch tỵ hầu của người nghi ngờ mắc COVID-19 trong vòng 7 ngày đầu tiên kể từ khi xuất hiện triệu chứng, sản phẩm cũng có thể xét nghiệm các mẫu bệnh phẩm của người không có triệu chứng. Sản phẩm dễ sử dụng, độ chính xác cao, có kết quả chỉ sau 15 - 30 phút và đã được Bộ Y tế cấp phép nhập khẩu theo giấy phép số 5895/BYT-TB-CT.'),
                                                                                                                                                               (20, 10, 9, 999, '2023-02-17', 30000 , 1000, 90, 'Găng tay y tế có bột SH Gloves size M (Hộp 100 chiếc)', 'SRI TRANG GLOVE PUBLIC COMPANY LTD', 'Găng tay y tế có bột SH Gloves được làm từ cao su tự nhiên, chưa được tiệt trùng, có chứa tạp chất và sử dụng 1 lần. Sản phẩm có độ đàn hồi vượt trội so với găng cao su tổng hợp, đặc biệt bột trong găng giúp thao tác đeo và tháo găng dễ dàng hơn đồng thời mang lại cảm giác cầm nắm chính xác. Găng tay SH Gloves được sử dụng rộng rãi trong các hoạt động y tế.'),


                                                                                                                                                               (21, 7, 4, 999, '2023-02-17', 1900000, 1000, 90, 'Máy đo đường huyết Accu Chek Guide', 'ROCHE','Máy đo đường huyết Accu Chek Guide là một chiếc máy đo đường huyết tốt với bộ máy hoạt động thông minh, cho kết quả cực nhanh, cực chính xác. Máy đo đường huyết của hãng luôn tuyệt đối an toàn và đáng tin cậy đối với người bệnh, thiết bị nhằm theo dõi và kiểm soát đường huyết tại nhà.'),
                                                                                                                                                               (22, 7, 7, 999, '2023-02-17', 1500000, 1000, 90, 'Máy đo đường huyết Accu Chek Instant Germany', 'ROCHE', 'Máy đo đương huyết Instant Germany mang đến một giải pháp thông minh vượt trội giúp việc kiểm tra đường huyết trở nên dễ dàng hơn. Tất cả sản phẩm của hãng Roche đều phải trải qua các kiểm nghiệm nghiêm ngặt, qua thử nghiệm lâm sàn trên quy mô lớn. Máy đo đường huyết của hãng luôn tuyệt đối an toàn và đáng tin cậy đối với người bệnh, thiết bị nhằm theo dõi và kiểm soát đường huyết tại nhà.'),
                                                                                                                                                               (23, 11, 8, 999, '2023-02-17', 1600000, 1000, 90, 'Máy xông mũi họng Omron NE-C28', 'OMRON', 'Máy khí dung Omron NE-C28 là sản phẩm máy xông điều trị hiệu quả cao các chứng bệnh liên qua mũi họng và phế quản. May xong mui hong Omron NE-C28 dễ sử dụng và đảm bảo vệ sinh. Phụ kiện kèm theo phù hợp với mọi đối tượng sử dụng từ trẻ sơ sinh, trẻ nhỏ và người lớn tuổi. Tốc độ xông có 2 mức riêng biệt cho người lớn và trẻ nhỏ; hạt thuốc phun có độ mịn cao, thẩm thấu nhanh vào cơ thể và độ bền luôn ở mức cao nhất. Đây là sản phẩm rất phù hợp cho quy mô gia đình.'),
                                                                                                                                                               (24, 11, 8, 999, '2023-02-17', 3100000, 1000, 90, 'Máy xông mũi họng Omron NE-C30', 'OMRON', 'Máy xông mũi họng Omron NE-C30 thuộc dòng máy nén khí không nóng, dễ sử dụng và đảm bảo vệ sinh. Đây là sản phẩm lý tưởng cho việc chăm sóc sức khỏe gia đình bạn.'),
                                                                                                                                                               (25, 11, 1, 999, '2023-02-17', 1500000, 1000, 90, 'Máy xông mũi họng và hút dịch mũi Zava Z350', 'ZAVA', 'Máy xông mũi họng và hút dịch mũi Zava Z350 có 2 tính năng: Xông khí dung mũi họng và hút dịch mũi. Có điều chỉnh tốc độ xông và áp lực hút mũi. Đặc biệt có điều chỉnh áp lực xông và hút mũi sao cho phù hợp với từng độ tuổi của trẻ nhỏ.'),


                                                                                                                                                               (26, 8, 2, 999, '2023-02-17', 27000, 1000, 90, 'Kim Lancet lấy máu BL-28 (100 cái)', 'PROMISEMED HANGZHOU MEDITECH CO.,LTD', 'Kim lấy máu Lancet Carefine BL-28G được dùng cho máy đo đường huyết thương hiệu Easy Max, Nipro Premier Alpha. Kim được lắp vào bút lấy máu để chích lấy máu, giúp kiểm tra nhanh các chỉ số cụ thể.'),
                                                                                                                                                               (27, 8, 4, 999, '2023-02-17', 27000, 1000, 90, 'Kim lấy máu MediUSA MM3300 dùng cho máy đo đường huyết (25 cái)', 'MEDIUSA', 'Kim lấy máu MediUSA MM3300 cho máy đo đường huyết là sản phẩm lấy mẫu máu thử hỗ trợ dùng cho máy đo đường huyết. Sản phẩm đã qua tiệt trùng và chỉ sử dụng 1 kim 1 lần nên rất an toàn.'),
                                                                                                                                                               (28, 8, 7, 999, '2023-02-17', 27000, 1000, 90, 'Kim tiêm tiểu đường B.Braun Omnican 1ml/100 I.U màu cam dùng cho người tiểu đường (100 cái x 1ml)', 'BRAUN', 'Kim tiêm tiểu đường B.Braun Omnican dùng cho người tiểu đường với chất liệu dùng trong y tế đảm bảo an toàn cho bệnh. Đặc biệt, các ống tiêm được đóng gói trong bao riêng biệt đảm bảo vô trùng khi sử dụng.'),
                                                                                                                                                               (29, 8, 1, 999, '2023-02-17', 27000, 1000, 90, 'Bơm tiêm sử dụng một lần Vinahankook 3ml/cc được khử trùng bằng khí E.O (25g - 100 cái)', 'VINAHANKOOK', 'Bơm tiêm 3ml Vinahankook được khử trùng bằng khí E.O. Vinahankook sản xuất theo công nghệ Hàn Quốc đảm bảo vô trùng, không gây độc, không gây sốt.'),
                                                                                                                                                               (30, 8, 1, 999, '2023-02-17', 27000, 1000, 90, 'Đầu kim Vinahankook sử dụng một lần dùng để tiêm chích, lấy máu, pha thuốc (100 cái x 18g)', 'VINAHANKOOK', 'Đầu kim 18 Vinahankook sử dụng một lần, thích hợp dùng để tiêm chích, lấy máu, pha thuốc. Sản phẩm an toàn, vô trùng tuyệt đối.'),


                                                                                                                                                               (31, 2, 8, 999, '2023-02-17', 800000, 1000, 80, 'Máy massage cầm tay 11 đầu Luxurious', 'LUXURIOUS', 'Máy massage cầm tay 11 đầu Luxurious với 11 đầu massage đa dạng, từ massage vùng đầu cho đến vùng lưng vai gáy, chân tay...người dùng sẽ có nhiều cảm giác dễ chịu đa dạng. Thân máy chỉ dài 45cm, rất thuận tiện sử dụng ngay cả với người lớn tuổi.'),
                                                                                                                                                               (32, 12, 3, 999, '2023-02-17', 1100000, 1000, 80, 'Máy xông khí dung Microlife NEB200 hỗ trợ các bệnh viêm mũi, viêm xoang', 'MICROLIFE', 'Máy xông khí dung Microlife NEB200 có các cải tiến về mặt công nghệ giúp người sử dụng dễ dàng hơn trong quá trình phòng và điều trị bệnh liên quan đến đường hô hấp. Sản phẩm được thiết kế nhỏ gọn, chất liệu cao cấp, dễ dàng vận hành và sử dụng, NEB200 đang dần trở thành giải pháp tối ưu trong quá trình phòng và điều trị bệnh.'),
                                                                                                                                                               (33, 12, 2, 999, '2023-02-17', 1000000, 1000, 80, 'Máy xông khí dung BioHealth Neb Pro hỗ trợ điều trị các bệnh về đường hô hấp', 'BIOHEALTH', 'Máy xông khí dung BioHealth NEB Pro với kích thước nhỏ gọn, thiết kế đơn giản dễ sử dụng, giúp khuếch tán thuốc theo dạng sương mù, tác động vào hệ thống niêm mạc đường hô hấp trên hoặc dưới, hữu ích trong hỗ trợ điều trị các bệnh về đường hô hấp.'),
                                                                                                                                                               (34, 3, 8, 999, '2023-02-17', 1000000, 1000, 90, 'Máy đo huyết áp bắp tay tự động AND UA-1020 hỗ trợ đo huyết áp, cảnh báo đột quỵ', 'AND', 'Máy đo huyết áp bắp tay tự động AND UA-1020 được trang bị công nghệ AFIB mới nhất giúp tầm soát rung nhĩ, cảnh báo đột quỵ. Sản phẩm được cá nhân hóa tạo sự thoải mái hơn khi sử dụng với 2 chế độ thiết kế độc đáo: Chế độ MyPressure và chế độ TricheckTM.'),
                                                                                                                                                               (35, 3, 4, 999, '2023-02-17', 1200000, 1000, 90, 'Máy đo huyết áp bắp tay tự động MediUSA TP-33 hỗ trợ đo huyết áp và nhịp tim', 'MEDIUSA', 'Máy đo huyết áp bắp tay tự động MediUSA TP-33 được dùng để đo huyết áp và nhịp tim.'),



                                                                                                                                                               (36, 3, 2, 999, '2023-02-17', 57000, 1000, 90, 'Máy đo huyết áp bắp tay Beurer BM45', 'Beurer', 'Máy đo huyết áp bắp tay điện tử Beurer BM45 rất được tin dùng vì độ chính xác rất cao, dễ dàng sử dụng và có nhiều ưu điểm nổi trội. Sản phẩm ứng dụng công nghệ cảm biến thông minh, giúp đo huyết áp và nhịp tim nhanh chóng, thích hợp sử dụng để bảo vệ sức khỏe cho mọi gia đình và dành cho mọi lứa tuổi.'),
                                                                                                                                                               (37, 3, 2, 999, '2023-02-17', 68000, 1000, 90, 'Máy đo huyết áp bắp tay tự động Microlife B4 Basic, hỗ trợ tầm soát nhịp tim', 'Microlife', 'Máy đo huyết áp bắp tay Microlife BP B3 Basic là sản phẩm thế hệ mới của thương hiệu Microlife đến từ Thụy Sĩ, dùng để đo huyết áp và nhịp tim. Sản phẩm ứng dụng công nghệ MAM hiện đại thông minh mang lại cho người dùng trải nghiệm an toàn như được bác sĩ đo đạc với kết quả nhanh chóng và chính xác.'),
                                                                                                                                                               (38, 3, 2, 999, '2023-02-17', 3000, 1000, 90, 'Máy đo huyết áp cổ tay Beurer BC40', 'Beurer', 'Máy đo huyết áp cổ tay Beurer BC40 giúp bạn đo huyết áp của mình nhanh chóng và dễ dàng, máy có thể lưu các kết quả đo để xem lại. Ngoài ra, máy đo huyết áp cổ tay Beurer BC40 còn có chức năng phát hiện bệnh rối loạn nhịp tim khi có triệu chứng nhịp tim bất thường. Sản phẩm là người bạn đồng hành không thể thiếu chăm sóc sức khỏe cho mỗi gia đình, đặc biệt là những gia đình có người già hoặc người mắc các bệnh liên quan đến huyết áp.'),
                                                                                                                                                               (39, 3, 2, 999, '2023-02-17', 120000, 1000, 90, 'Máy đo huyết áp Kachi MK167', 'Kachi', 'Máy đo huyết áp Kachi MK167 với công nghệ hiện đại tự động hoàn toàn và độ chính xác cao, đặc biệt có giọng nói hướng dẫn, giúp đo huyết áp tại nhà đơn giản và nhanh chóng, phù hợp để kiểm soát và theo dõi hiệu quả điều trị cao huyết áp.'),
                                                                                                                                                               (40, 3, 2, 999, '2023-02-17', 199000, 1000, 90, 'Máy đo huyết áp cổ tay điện tử CK-W132', 'Kachi', 'Máy đo huyết áp cổ tay điện tử CK-W132 sử dụng để đo huyết áp, nhịp tim ở người lớn. Máy hoạt động dựa trên phương pháp dao động của đo huyết áp. Máy được thiết kế nhỏ gọn, dây đeo tay gắn liền với thân máy và kèm màn hình LCD rất tiện lợi.'),

                                                                                                                                                               (41, 11, 2, 999, '2023-02-17', 490000, 1000, 90, 'Máy đo nồng độ oxy trong máu Jumper JPD 500E Led thiết kế nhỏ gọn và sử dụng dễ dàng', 'SHENZHEN JUMPER MEDICAL EQUIPTMENT CO.,LTD', 'Máy đo nồng độ oxy trong máu SpO2 Jumper JPD 500E Led là thiết bị dùng để đo sự bão hòa oxy trong mạch máu và nhịp tim. Thiết bị giúp phát hiện hiện tượng thiếu oxy trong máu và nhịp tim bất thường để có cách xử lý nhanh chóng, kịp thời bằng phương pháp cảm biến quang học thông qua đầu ngón tay với độ chính xác cao, dễ thao tác. Sản phẩm có thiết kế nhỏ gọn và sử dụng dễ dàng, phù hợp với mọi đối tượng.'),
                                                                                                                                                               (42, 11, 3, 999, '2023-02-17', 690000, 1000, 90, 'Máy đo nồng độ oxy trong máu Microlife Oxy 200 hỗ trợ đo nhanh chóng và chính xác', 'MICROLIFE', 'Microlife Oxy 200 - Máy Đo Nồng Độ Oxy Trong Máu là một thiết bị y tế cải tiến với các tính năng không xâm lấn và liên tục để phát hiện nồng độ oxy trong máu (SPO2), nhịp tim (PR) của cả người lớn và bệnh nhi. Mang tính di động nên sản phẩm có thể đo các giá trị SPO2 và PR một cách nhanh chóng, chính xác.'),
                                                                                                                                                               (43, 11, 2, 999, '2023-02-17', 399000, 1000, 90, 'Máy đo nồng độ oxy trong máu SpO2 Metech - PC - 60A hỗ trợ đo nhanh chóng và chính xác', 'SHENZHEN CREATIVE INDUSTRY CO.,LTD', 'Máy đo nồng độ Oxy trong máu SpO2 Metech - PC - 60A được dùng để đo nồng độ bảo hòa oxy trong máu và nhịp tim, dạng kẹp ngón tay, có thể theo dõi nồng độ bảo hòa oxy trong máu (SPO2), nhịp tim (PR) thông qua ngón tay của bệnh nhân.'),
                                                                                                                                                               (44, 11, 10, 999, '2023-02-17', 690000, 1000, 90, 'Máy đo nồng độ oxy trong máu (SPO2) Pulse Fingertip Oximeter A4 Oromi hỗ trợ đo nhanh chóng và chính xác', 'FT DIGITAL TECHNOLOGY CO.,LTD', 'Máy Đo Nhịp Tim Và Nồng Độ Oxy Trong Máu (SpO2) Fingertip Pulse Oximeter Oromi A4 là một thiết bị y tế cải tiến với các tính năng không xâm lấn và liên tục để phát hiện nồng độ oxy trong máu (SPO2) và nhịp đập của tim (PR). Mang tính di động nên sản phẩm có thể đo các giá trị SPO2 và PR một cách nhanh chóng và chính xác.'),

                                                                                                                                                               (45, 3, 8, 999, '2023-02-17', 1030000, 1000, 90, 'Máy đo huyết áp bắp tay tự động AND UA-651 hỗ trợ đo huyết áp và nhịp tim', 'A&D ELECTRONICS(SHENZEN) CO.,LTD', 'Máy Đo Huyết Áp Bắp Tay Tự Động And Ua-651 được sản xuất theo tiêu chuẩn Nhật Bản với các tính năng nổi bật như: Cảnh báo Nhịp tim không đều, cảnh báo huyết áp cao theo WHO, bộ nhớ lưu trữ đến 30 kết quả đo và hiển thị kết quả trung bình giữa các lần đo.'),

                                                                                                                                                               (46, 3, 1, 999, '2023-02-17', 199000, 1000, 90, 'Omron HEM - 7120 May Do Huyet Ap Bap Tay', 'Omron', 'Máy đo huyết áp cổ tay điện tử Omron HEM - 7120 sử dụng để đo huyết áp, nhịp tim ở người lớn. Máy hoạt động dựa trên phương pháp dao động của đo huyết áp. Máy được thiết kế nhỏ gọn, dây đeo tay gắn liền với thân máy và kèm màn hình LCD rất tiện lợi.'),
                                                                                                                                                               (47, 3, 1, 999, '2023-02-17', 299000, 1000, 90, 'Máy đo huyết áp tự động Omron HEM-7124 (Hộp 1 cái)', 'Omron', 'Máy đo huyết áp cổ tay điện tử Omron HEM-7124 sử dụng để đo huyết áp, nhịp tim ở người lớn. Máy hoạt động dựa trên phương pháp dao động của đo huyết áp. Máy được thiết kế nhỏ gọn, dây đeo tay gắn liền với thân máy và kèm màn hình LCD rất tiện lợi.'),
                                                                                                                                                               (48, 3, 1, 999, '2023-02-17', 234000, 1000, 90, 'Máy đo huyết áp bắp tay bluetooth Omron HEM-7143T1 (Hộp 1 cái)', 'Omron', 'Máy đo huyết áp cổ tay điện tử Omron HEM-7143T1 sử dụng để đo huyết áp, nhịp tim ở người lớn. Máy hoạt động dựa trên phương pháp dao động của đo huyết áp. Máy được thiết kế nhỏ gọn, dây đeo tay gắn liền với thân máy và kèm màn hình LCD rất tiện lợi.'),
                                                                                                                                                               (49, 3, 3, 999, '2023-02-17', 765000, 1000, 90, 'Máy đo huyết áp bắp tay tự động Microlife BP 3NZ1-1P, hỗ trợ tầm soát nhịp tim', 'Microlife', 'Máy đo huyết áp bắp tay tự động Microlife BP 3NZ1-1P là thiết bị đo huyết áp thế hệ mới của Microlife được tích hợp công nghệ đo PAD, AFIB và MAM giúp đưa ra kết quả chính xác và tin cậy, cảnh báo sớm về chứng tăng huyết áp và rung nhĩ, hai nguyên nhân chính dẫn đến đột quỵ não.'),
                                                                                                                                                               (50, 3, 3, 999, '2023-02-17', 100000, 1000, 90, 'Máy đo huyết áp điện tử cổ tay tự động Microlife W3 Comfort, hỗ trợ tầm soát nhịp tim', 'Microlife', 'Máy đo huyết áp bắp tay MICROLIFE W3 Comfort là sản phẩm thế hệ mới của thương hiệu Microlife đến từ Thụy Sĩ. Máy đo huyết áp hoàn toàn tự động với thiết kế siêu mỏng nhẹ, được trang bị công nghệ IMT độc đáo, cải tiến cách đo huyết áp truyền thống, mang lại trải nghiệm đo huyết áp thoải mái, dễ chịu, cùng kết quả nhanh chóng và chính xác.'),


                                                                                                                                                               (71, 12, 5, 999, '2023-02-17', 100000, 1000, 90, 'Dụng cụ xét nghiệm nhanh COVID-19 COVICHEK COVID-19 Ag Test Kit (Hộp 5 bộ kit)', 'WIZCHEM', 'COVICHEK COVID-19 Ag Kit là dụng cụ y tế chẩn đoán in vitro dùng để chẩn đoán COVID-19 bằng cách kiểm tra định tính kháng nguyên SARS-CoV-2 ở những bệnh nhân có các triệu chứng nhiễm trùng đường hô hấp thông qua phân tích sắc ký miễn dịch.'),
                                                                                                                                                               (72, 12, 2, 999, '2023-02-17', 45000, 1000, 90, 'Bộ xét nghiệm nhanh kháng nguyên SARS-CoV-2 SureScreen Diagnostics Covid-19 Test Kit', 'SureScreen Diagnostics', 'SARS-CoV-2 Antigen Rapid Test Cassette là xét nghiệm miễn dịch sắc ký nhanh để phát hiện định tính sự hiện diện kháng nguyên SARS-CoV-2 trong mẫu tăm bông ngoáy mũi của các cá nhân nghi ngờ nhiễm COVID-19 trong 7 ngày đầu tiên kể từ khi có triệu chứng.  '),
                                                                                                                                                               (73, 12, 5, 999, '2023-02-17', 30000, 1000, 90, 'Dụng cụ xét nghiệm nhanh COVID-19 Flowflex Test Kit (Hộp 25 bộ kit)', 'Flowflex', 'Flowflex SARS-CoV-2 Antigen Rapid Test giúp phát hiện nhanh kháng nguyên SARS-CoV-2 trong mẫu ngoáy dịch tỵ hầu của người nghi ngờ mắc COVID-19 trong vòng 7 ngày đầu tiên kể từ khi xuất hiện triệu chứng, sản phẩm cũng có thể xét nghiệm các mẫu bệnh phẩm của người không có triệu chứng. Sản phẩm dễ sử dụng, độ chính xác cao, có kết quả chỉ sau 15 - 30 phút và đã được Bộ Y tế cấp phép nhập khẩu theo giấy phép số 5895/BYT-TB-CT.'),
                                                                                                                                                               (74, 12, 5, 999, '2023-02-17', 99000, 1000, 90, 'Bộ xét nghiệm nhanh RAPIDFOR Sars-CoV-2 Rapid Antigen Test (Hộp 1 Test)', 'Rapid Antigen', 'Bộ xét nghiệm nhanh RAPIDFOR Sars-CoV-2 Rapid Antigen Test (Hộp 1 Test) là bộ test nhanh kháng nguyên Sars Cov-2 chỉ trong vòng 15 phút. Dụng cụ có độ nhạy và độ đặc hiệu cao vào giai đoạn đầu nhiễm, gọn nhẹ, giảm tối đa gây cảm giác đau cho người sử dụng.'),
                                                                                                                                                               (75, 12, 1, 999, '2023-02-17', 77000, 1000, 90, 'Thuốc Molnupiravir Stella 400mg hỗ trợ điều trị covid-19', 'STELLA', 'Thuốc Molnupiravir 400mg là sản phẩm của Công ty TNHH Liên doanh Stellapharm có thành phần hoạt chất chính là Molnupiravir. Thuốc dùng chỉ định điều trị Covid-19 mức độ nhẹ đến trung bình ở người trưởng thành dương tính với xét nghiệm chẩn đoán SARS-CoV-2 và có ít nhất một yếu tố nguy cơ làm tiến triển bệnh nặng.'),
                                                                                                                                                               (76, 12, 2, 999, '2023-02-17', 64000, 1000, 90, 'Bộ kit test nước bọt Covid-19 Antigen Rapid độ nhạy lên đến 96%, độ đặc hiệu 99% (20 kit)', 'WUHAN EASYDIAGNOSIS BIOMEDICINE CO.,LTD', 'Kit test nước bọt Covid-19 Antigen Rapid Ediagnosis được sử dụng để phát hiện định tính kháng nguyên của Coronavirus (SARS-CoV-2) trong mẫu nước bọt từ những người nghi nhiễm Covid-19 nhanh chóng chỉ trong vòng 15 phút. Thiết bị kit test covid bằng nước bọt có độ hiệu quả cao cho giai đoạn đầu nhiễm Covid-19 với độ nhạy lên đến 96%, độ đặc hiệu 99%.'),
                                                                                                                                                               (77, 12, 3, 999, '2023-02-17', 45000, 1000, 90, 'Bộ kit test nhanh Covid Toda Coronadiag Ag độ nhạy lên tới 98,6%, độ đặc hiệu 100% (20 kit)', 'TODA PHARMA', 'Kit Test Covid Toda - Pháp - Khay Thử Xét Nghiệm Kháng Nguyên Sars Cov-2 được sản xuất tại Pháp theo tiêu chuẩn Châu Âu CE, ISO 1348, là bộ phát hiện kháng nguyên COVID-19 nhanh chóng chỉ trong 15 phút. Dụng cụ có độ nhạy lên tới 98,6%, độ đặc hiệu 100% và được Bộ Y Tế cấp phép, kiểm định chất lượng tại Viện kiểm định quốc gia vắc xin và sinh phẩm y tế.'),
                                                                                                                                                               (78, 12, 2, 999, '2023-02-17', 45000, 1000, 90, 'Bộ kit test nhanh Humasis Covid-19 Ag Test độ nhạy và độ đặc hiệu cao (25 bộ)', 'HUMASIS CO., LTD', 'Humasis Covid-19 Ag Test - Thiết Bị Chẩn Đoán In Vitro Xét Nghiệm Vi Rút Sars-Cov-2 là bộ phát hiện kháng nguyên COVID-19 nhanh chóng chỉ trong vòng 15 phút. Thiết bị kit test nhanh Humasis có độ nhạy và độ đặc hiệu cao vào giai đoạn đầu nhiễm, thiết kế gọn nhẹ, giảm tối đa cảm giác đau cho người sử dụng.'),
                                                                                                                                                               (79, 12, 6, 999, '2023-02-17', 87000, 1000, 90, 'Kit test nhanh Covid-19 Rapid Test Ag 2019-nCoV túi 20 bộ', 'ProGnosis Biotech S.A.', 'Kit test nhanh Covid-19 Rapid Test Ag 2019-nCoV là một sản phẩm kiểm tra nhanh chẩn đoán bệnh Covid-19 bằng phương pháp xét nghiệm kháng nguyên. Sản phẩm này được sản xuất bởi công ty ProGnosis Biotech, Hy Lạp và sử dụng cho các mẫu bệnh phẩm từ mũi, có độ nhạy và độ đặc hiệu cao.'),
                                                                                                                                                               (80, 12, 1, 999, '2023-02-17', 78000, 1000, 90, 'Kit test nhanh Covid-19 TrueLine AG Rapid Test hộp 25 bộ', 'Trueline', 'Kit test nhanh Covid-19 TrueLine AG Rapid Test là một trong những thiết bị, dụng cụ y tế giúp kiểm tra nhanh chẩn đoán bệnh Covid-19 bằng phương pháp xét nghiệm kháng nguyên. Sản phẩm này có thể giúp phát hiện sớm vi-rút SARS-CoV-2 đối với các mẫu bệnh phẩm từ mũi.'),


                                                                                                                                                               (91, 4, 1, 999, '2023-02-17', 30000, 1000, 90, 'Băng thun y tế 2 móc Bảo Thạch (0.075m x 3m) ', 'Bảo Thạch ', 'Băng thun y tế 2 móc Bảo Thạch được làm từ sợi polyester và cao su thiên nhiên cùng độ co dãn cao, từ 180% đến 200% so với kích thước ban đầu, dùng để nén ép, cầm máu, cố định khớp, giữ vật liệu cầm máu tại chỗ không bị xê dịch.'),
                                                                                                                                                               (92, 4, 9, 999, '2023-02-17', 45000, 1000, 90, 'Gạc Urgo Optiskin (10cm x 7cm) hộp 50 miếng', 'Urgo Healthcare Products', 'Gạc Urgo Optiskin (10cm x 7cm) sử dụng để bao phủ lên tất cả các vết thương ngoài da (vết khâu, vết trầy xước), hoặc các loại dụng cụ (que dò, ống dẫn...). Do Optiskin cho phép bệnh nhân có thể tắm rửa, vệ sinh nên băng đặc biệt phù hợp cho các liệu pháp tắm ngâm hay nói chung nhanh chóng bắt đầu lại các hoạt động sau phẫu thuật.'),
                                                                                                                                                               (93, 4, 9, 999, '2023-02-17', 15000, 1000, 90, 'Gạc lưới UrgoTul AG/Sliver hộp 16 miếng (10cm x 12cm)', 'Urgo Healthcare Products', 'Bạc có hoạt tính kháng khuẩn phổ rộng bao gồm các vi khuẩn gram âm và gram dương và một số loại nấm. Đặc biệt nó có tác dụng đối với tụ cầu (Staphylococcus aureus), tụ cầu kháng Methicilline (MRSA), liên cầu (Streptococcus pyogens) và trực khuẩn mủ xanh là những vi khuẩn gây ra hầu hết các nhiễm khuẩn vết thương. Trên in vitro cho thấy băng này có hoạt tính kháng khuẩn trong 7 ngày. Hoạt tính kháng khuẩn của băng cũng góp phần làm giảm mùi khó chịu của vết thương.'),
                                                                                                                                                               (94, 4, 9, 999, '2023-02-17', 20000, 1000, 90, 'Gạc Urgo Optiskin hộp 50 miếng (5.3 x 8cm)', 'Urgo Healthcare Products', 'Gạc Urgo Optiskin (5.3 x 8cm) sử dụng để bao phủ lên tất cả các vết thương ngoài da (vết khâu: vết trầy xước), hoặc các loại dụng cụ (que dò, ống dẫn...). Do Optiskin cho phép bệnh nhân có thể tắm rửa vệ sinh nên băng đặc biệt phù hợp cho các liệu pháp tắm ngâm hay nói chung nhanh chóng bắt đầu lại các hoạt động sau phẫu thuật.'),
                                                                                                                                                               (95, 4, 1, 999, '2023-02-17', 20000, 1000, 90, 'Băng rốn Đông FA 3 con nai cho bé hộp 3 miếng', 'Công ty TNHH Trang Thiết Bị Y Tế Đông Pha', 'Bảo vệ vùng rốn và giữ ấm cho bé và đắp các vết thương.'),
                                                                                                                                                               (96, 4, 1, 999, '2023-02-17', 49000, 1000, 90, 'Gạc rơ lưỡi thảo dược Ích Nhi hộp 30 gói', 'Dược mỹ phẩm Quang Xanh', 'Vệ sinh hàng ngày làm sạch nướu, lưỡi, răng miệng cho trẻ từ sơ sinh trở lên.Giúp phòng ngừa những vấn đề về răng miệng (nấm miệng, tưa lưỡi, viêm nướu,...), giúp nướu khỏe trong thời kỳ trẻ mọc răng, giúp ngừa sâu răng.'),
                                                                                                                                                               (97, 4, 11, 999, '2023-02-17', 40000, 1000, 90, 'Gạc Urgo Compresses Stériles Non Tissées hộp 10 miếng (10cm x 10cm)', 'Urgo Healthcare Products', 'Gạc Urgo Compresses Stériles Non Tissées (10cm x 10cm) được chỉ định để băng bó, làm sạch vết thương.'),
                                                                                                                                                               (98, 4, 11, 999, '2023-02-17', 30000, 1000, 90, 'Gạc lưới UrgoTul Ag/Silver hộp 10 miếng (5cm x 5cm)', 'Urgo Healthcare Products', 'UrgoTul Ag/Silver được dùng tại chỗ cho các vết thương có nguy cơ hoặc dấu hiệu nhiễm khuẩn tại chỗ: các vết thương mãn tính (các vết loét ở chân, các vết loét do tỳ đè) và các vết thương cấp tính (các vết bỏng có độ sâu vừa phải, các vết mài mòn da, các vết thương do chấn thương, các vết thương do phẫu thuật...).'),
                                                                                                                                                               (99, 4, 1, 999, '2023-02-17', 18000, 1000, 90, 'Băng cuộn y tế Bảo Thạch túi 5 cuộn (0.09m x 2m)', 'Bảo Thạch', 'Băng cuộn y tế Bảo Thạch được làm từ 100% sợi cotton, gạc trắng và sạch. Khả năng thấm hút của bông gòn y tế Bảo Thạch cao và nhanh. Mịn màng, mềm mại, không gây kích ứng da.'),
                                                                                                                                                               (100, 4, 1, 999, '2023-02-17', 12000, 1000, 90, 'Gạc y tế Bảo Thạch túi 10 miếng (5cm x 6.5cm x 12 lớp)', 'Bảo Thạch', 'Gạc phẫu thuật được sử dụng rộng rãi trong phòng mổ của bệnh viện. Thích hợp cho các vết thương lớn, khả năng thấm hút nhanh máu và dịch tiết từ vết thương. Được sử dụng cho các vết rạch, vết cắt dài trong quá trình phẫu thuật.');


--	(998, 4, 1, 999, '2023-02-17', 27000, 1000, 90, 'Băng  ', 'CÔNG TY ', 'm phân phối dành cho thị trườ'),
--	(999, 4, 1, 999, '2023-02-17', 27000, 1000, 90, 'Băng  ', 'CÔNG TY ', 'm phân phối dành cho thị trườ');	





--	(999, `categoryID`, `originID`, `quantity`, `dateAdded`, `price`, `sale`, `orderedNumbers`, `name, `trademark`, `content`);




CREATE TABLE IF NOT EXISTS `voucher` (
                                         `voucherID` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL,
    `type` varchar(50) NOT NULL,
    `sale` int(11) NOT NULL,
    `expiredDat` date NOT NULL,
    `condition` int(11) NOT NULL,

    PRIMARY KEY (`voucherID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE IF NOT EXISTS `wishes` (
                                        `userID` int(11) NOT NULL,
    `productID` int(11) NOT NULL,
    PRIMARY KEY (`userID`,`productID`),
    KEY `userID` (`userID`),
    KEY `productID` (`productID`),
    CONSTRAINT `wishes_fk_userID` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`),
    CONSTRAINT `wishes_fk_productID` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=UTF8MB4_UNICODE_CI;






CREATE TABLE IF NOT EXISTS `purchases` (
                                           `purchaseID` int(11) NOT NULL AUTO_INCREMENT,
    `userID` int(11) NOT NULL,
    `productID` int(11) NOT NULL,
    `quantity` int(11) NOT NULL,
    `price` int(11) NOT NULL,
    `orderDate` date NOT NULL,
    `status` int NOT NULL,
    `receivedDate` date,
    `starNumber` int(11),
    `comment` varchar(100),
    `address` varchar(100),
    `dateRated` date,
    PRIMARY KEY (`purchaseID`,`userID`,`productID`),
    KEY `userID` (`userID`),
    KEY `productID` (`productID`),
    CONSTRAINT `purchases_fk_userID` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`),
    CONSTRAINT `purchases_fk_productID` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`)
    ) ENGINE=INNODB AUTO_INCREMENT=1  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE IF NOT EXISTS `address` (
                                         `addressID` int(11) NOT NULL AUTO_INCREMENT,
    `userID` int(11) NOT NULL,
    `city` varchar(50) NOT NULL,
    `district` varchar(50) NOT NULL,
    `ward` varchar(50) NOT NULL,
    `detail` varchar(100) NOT NULL,
    PRIMARY KEY (`addressID`,`userID`),
    KEY `userID` (`userID`),
    CONSTRAINT `address_fk_userID` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`)
    ) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;







CREATE TABLE IF NOT EXISTS `vouchers` (
                                          `userID` int(11) NOT NULL,
    `voucherID` int(11) NOT NULL,
    `quantity` int(11) NOT NULL,
    PRIMARY KEY (`userID`,`voucherID`),
    KEY `userID` (`userID`),
    KEY `voucherID` (`voucherID`),
    CONSTRAINT `vouchers_fk_userID` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`),
    CONSTRAINT `vouchers_fk_voucherID` FOREIGN KEY (`voucherID`) REFERENCES `voucher` (`voucherID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE IF NOT EXISTS `verify` (
                                        `userID` int(11) NOT NULL,
    `code` int(11) NOT NULL,
    `exipiredTime` time NOT NULL,
    PRIMARY KEY (`userID`),
    KEY `userID` (`userID`),
    CONSTRAINT `verify_fk_userID` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=UTF8MB4_UNICODE_CI;
