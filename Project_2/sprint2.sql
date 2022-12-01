create database sprint2test;
use sprint2test;

create table if not exists `account` (
	account_id bigint primary key auto_increment,
    username varchar(255) unique not null,
    `password` varchar(255)
);

create table if not exists `role` (
	role_id bigint primary key auto_increment,
    role_name varchar(255)
);

create table if not exists account_role (
	account_role_id bigint primary key auto_increment,				
	account_id bigint not null,				
	role_id bigint not null,				
	foreign key (account_id) references `account`(account_id) on update cascade,				
	foreign key (role_id) references `role`(role_id) on update cascade	  			
);

create table customer(
  customer_id bigint primary key auto_increment,
  customer_name varchar(255),
  customer_phone varchar(255) unique, 
  customer_email varchar(255) unique,
  customer_image varchar(255),
  customer_address varchar(255),
  customer_account_id bigint unique,
  foreign key (customer_account_id) references `account` (account_id) on update cascade
);

create table if not exists category(
  category_id bigint primary key auto_increment,
  category_name varchar(255)
);

create table if not exists author(
  author_id bigint primary key auto_increment,
  author_name varchar(255),
  author_avatar varchar(255)
);

create table if not exists promotion(
	promotion_id bigint primary key auto_increment,		
    promotion_percent double
);

create table if not exists book(
  book_id bigint primary key auto_increment,
  book_code varchar(255),
  book_name varchar(255),
  book_image varchar(255),
  book_content text,
  book_price double,
  book_translator varchar(255),
  book_total_page int,
  book_size varchar(255),
  book_publish_date date,
  book_quantity int not null,					
  book_flag bit(1) default 0,
  book_publisher varchar(255),
  book_category_id bigint,
  book_author_id bigint,
  book_promotion_id bigint default 1,
  
  foreign key(book_promotion_id) references promotion(promotion_id) on update cascade,
  foreign key(book_category_id) references category(category_id) on update cascade,
  foreign key(book_author_id) references author(author_id) on update cascade
);

create table if not exists cart (					
	cart_id bigint primary key auto_increment,	
    cart_code varchar(255),
	cart_quantity int not null,					
	cart_total_money double not null,	
	cart_purchase_date date,
    cart_status bit(1) default 0,
	cart_account_id bigint,												
	foreign key (cart_account_id) references `account`(account_id)
);

create table if not exists cart_book (					
	cart_book_id bigint primary key auto_increment,		
    book_id bigint not null,
	cart_id bigint not null,					
	foreign key(cart_id) references cart(cart_id) on delete cascade,					
	foreign key(book_id) references book(book_id) on update cascade					
);

INSERT INTO `sprint2test`.`account` (`username`, `password`) VALUES ('admin', '$2a$10$lqnvHKHPyKkZWMMtBB.jy.hMuPaSNH/Nlfuj6XaHCRLB7PK.EU60K'),
																	('customer', '$2a$10$PkK1zRmB8v/Ei4cD.nuTB.8FzdTLAXVTPcgYkLACrEy5jZsvehXn6');

INSERT INTO `sprint2test`.`role` (`role_name`) VALUES ('ROLE_ADMIN'),
													  ('ROLE_CUSTOMER');

INSERT INTO `sprint2test`.`account_role` (`account_id`, `role_id`) VALUES ('1', '1'),
																		  ('2', '2');
    
INSERT INTO `sprint2test`.`customer` (`customer_name`, `customer_phone`, `customer_email`, `customer_image`, `customer_address`, `customer_account_id`) 
VALUES ('Nguyễn Trung Chính', '0935147852', 'nguyentrungchinh@gmail.com', 'avatar1.jpg', 'Đà Nẵng', '1'),
	   ('Trần Ánh Linh', '0359876543', 'trananhlinh@gmail.com', 'avatar2.jpg', 'Quảng Nam', '2');

INSERT INTO `sprint2test`.`category` (`category_name`) VALUES ('Văn học Việt Nam'),
															  ('Văn học nước ngoài'),
															  ('Thiếu nhi'),
															  ('Thời sự - Chính trị');

INSERT INTO `sprint2test`.`author` (`author_name`, `author_avatar`) VALUES ('Kim Lân', 'KimLan.jpg'),
																		   ('Nguyễn Đình Lạp', 'NguyenDinhLap.jpg'),
																		   ('Vũ Trọng Phụng', 'VuTrongPhung.jpg'),
																		   ('Virginia Woolf', 'VirginiaWoolf.jpg'),
																		   ('Haruki Murakami', 'HarukiMurakami.jpg'),
																		   ('Hector Malot', 'HectorMalot.jpg'),
																		   ('Lewis Carroll', 'LewisCarroll.jpg'),
																		   ('Roald', 'Roald.jpg'),
																		   ('Tô Hoài', 'ToHoai.jpg'),
																		   ('Vũ Dương Huân', 'VuDuongHuan.png'),
																		   ('Arrian', 'Arrian.jpg'),
																		   ('J. J. Rousseau', 'JJRousseau.jpg'),
																		   ('Georgia Amson-Bradshaw', 'GeorgiaAmsonBradshaw.jpg'),
																		   ('Edgar Allan Poe', 'EdgarAllanPoe.jpg'),
																		   ('Anne Rooney', 'AnneRooney.jpg'),
																		   ('Nhiều tác giả', 'KhongXacDinh.jpg'),
																		   ('Nguyễn Tuân', 'NguyenTuan.webp'),
																		   ('Nguyễn Nhật Ánh', 'NguyenNhatAnh.jpg'),
																		   ('Anh Khang', 'AnhKhang.jpg'),
																		   ('Ernest Miller Hemingway', 'ErnestMillerHemingway.jpg'),
																		   ('Franz Kafka', 'FranzKafka.jpg'),
																		   ('Gabriel Garcia Marquez', 'GabrielGarciaMarquez.jpg'),
																		   ('Harper Lee', 'HarperLee.jpg'),
																		   ('J. K. Rowling', 'JKRowling.jpg'),
																		   ('Nguyễn Quang Sáng', 'NguyenQuangSang.jpg');
    
    
INSERT INTO `sprint2test`.`promotion` (`promotion_percent`) VALUES ('0'),
																   ('5'),
																   ('10'),
																   ('15'),
																   ('20'),
																   ('25'),
																   ('50'),
																   ('75'),
																   ('90');
    
INSERT INTO `sprint2test`.`book` (`book_code`, `book_name`, `book_image`, `book_content`, `book_price`, `book_translator`, `book_total_page`, `book_size`, `book_publish_date`, `book_quantity`, `book_publisher`, `book_category_id`, `book_author_id`, `book_promotion_id`)
VALUES ('BK-001', 'Vợ nhặt', 'sach-vo-nhat-190x300.png', 'Năm 1945, nạn đói khủng khiếp xảy ra tràn lan khắp nơi, người chết như rạ, người sống cũng dật dờ như những bóng ma. Tràng là một người xấu xí thô kệch, ế vợ, sống ở xóm ngụ cư. Tràng làm nghề kéo xe bò thuê và sống với một mẹ già. Một lần kéo xe thóc Liên đoàn lên tỉnh, Tràng đã quen với một cô gái. Vài ngày sau gặp lại, Tràng không còn nhận ra cô gái ấy, bởi vẻ tiều tụy, đói rách làm cô đã khác đi rất nhiều. Tràng đã mời cô gái một bữa ăn, cô gái liền ăn một lúc bốn bát bánh đúc. Sau một câu nói nửa thật, nửa đùa, cô gái đã theo anh về nhà làm vợ. Việc Tràng nhặt được vợ đã làm cả xóm ngụ cư ngạc nhiên, nhất là bà cụ Tứ (mẹ Tràng) đón nhận người con dâu trong tâm trạng vừa buồn vừa mừng, vừa lo âu, vừa hi vọng nhưng không hề tỏ ra rẻ rúng người phụ nữ đã theo không con mình. Đêm tân hôn của họ diễn ra trong không khí chết chóc, tủi sầu từ xóm ngụ cư vọng tới. Sáng hôm sau, một buổi sáng mùa hạ, nắng chói lóa. Bà cụ Tứ và cô dâu mới xăm xắn dọn dẹp, quét tước trong ngoài. Trước cảnh ấy, Tràng cảm thấy mình gắn bó và có trách nhiệm với cái nhà của mình và thấy mình nên người, trông người vợ đúng là một người phụ nữ hiền hậu đúng mực, không còn vẻ gì chao chát chỏng lỏn như lần đầu gặp nhau. Bà cụ Tứ hồ hởi đãi hai con vài bát cháo loãng và một nồi chè cám. Qua lời kể của người vợ, Tràng dần dần hiểu được Việt Minh và trong óc Tràng hiện lên hình ảnh đám người đói kéo nhau đi phá kho thóc Nhật, phía trước là một lá cờ đỏ bay phấp phới...', '44000', '', '100', '30x40cm', '2020-01-01', '5', 'Le Van A', '1', '1', '1'),
	   ('BK-002', 'Người Kép Già', 'NguoiKepGia.jpg', 'Người kép già bao gồm những truyện ngắn và vừa của nhà văn Kim Lân mà tôi đã đọc những truyện này và có truyện đọc rất nhiều lần. Nhưng ấn bản lần này vẫn làm tôi ngập tràn cảm hứng và chìm sâu trong suy tưởng khi đọc lại. […] Những tác phẩm trong cuốn sách này của ông là những câu chuyện đời sống của gần một thế kỷ trước. Nhưng tất cả vẫn như vừa diễn ra. Ngôn ngữ và những thông điệp chứa đựng bên trong những câu chuyện của ông vẫn rực ấm như một dòng máu chảy trong cơ thể thời gian mà những người đương thời đang sống trong đó. Mọi hình thức xã hội luôn thay đổi nhưng bản chất của kiếp người không thay đổi, mọi ngôn ngữ có thể thay đổi nhưng bản chất của tình yêu thương con người và cái Thiện không hề thay đổi. Văn chương của nhà văn Kim Lân thuộc về những điều không thể thay đổi ấy. Ông đã chạm vào cái lõi của kiếp nhân sinh và ông cũng sống trong cái lõi của mọi kiếp nhân sinh vì vậy ông còn mãi đến bây giờ.', '270000', 'Nguyen Van B', '150', '30x40cm', '2020-02-02', '5', 'Le Van B', '1', '1', '1'),
	   ('BK-003', 'Ngoại ô', 'ngoai_o.jpg', 'Ngoại ô ra mắt người đọc vào những năm cuối của trào lưu văn học hiện thực phê phán – giai đoạn 1940 – 1945, “khi mà không khí văn đàn không còn được sôi nổi, nhộn nhịp như thời kì trước (1936 – 1939) nên ít được phê bình, giới thiệu… làm cho tác phẩm bị giảm tiếng vang”.', '65000', 'Nguyen Van C', '200', '30x40cm', '2020-03-03', '5', 'Le Van C', '1', '2', '2'),
	   ('BK-004', 'Đình Lạp', 'NguyenDinhLap.webp', 'Có độ dày gần 700 trang, là tập hợp những sáng tác tiêu biểu của nhà văn đã in rải rác ở nhiều cuốn khác nhau bao gồm: 2 tiểu thuyết "Ngõ hẻm" và "Ngoại ô", truyện vừa "Chiếc va ly"; các phóng sự "Thanh niên trụy lạc", "Từ ái tình đến hôn nhân", "Hà Nộ giao thừa"; các bài giảng môn phóng sự lớp Văn hóa cứu quốc khóa 1, 2.: "Những nỗi băn khoăn của tư tưởng và nghệ thuật", "Muốn làm phóng sự".', '230000', 'Nguyen Van D', '250', '30x40cm', '2020-04-04', '5', 'Le Van D', '1', '3', '2'),
	   ('BK-005', 'Bà Dalloway', 'img043.u335.d20160426.t105052.jpg.webp', 'Virginia Woolf viết Bà Dalloway trong lúc đang cố chống chọi với chứng bệnh thần kinh của chính mình. Và đây cũng là tác phẩm đầu tiên bà khai thác thủ pháp Dòng ý thức. Phần vì bút pháp mới thử nghiệm ở đây chưa tinh luyện và nhuần nhuyễn như ở “Tới ngọn hải đăng”, phần vì lượng nhân vật cũng quá nhiều (Ngoài khoảng mười mấy nhân vật chủ yếu có tới mấy chục nhân vật phụ; có nhân vật chỉ thoáng hiện ra rồi biến mất hoàn toàn); mặt khác, ý nghĩ và hành động của các nhân vật đan xen như những sợi tơ nhện từ quá khứ sang hiện tại, rồi lại từ hiện tại sang quá khứ, với rất nhiều hình ảnh ẩn dụ, nên đòi hỏi người đọc phải thật sự tập trung.', '75500', 'Nguyen Van E', '300', '30x40cm', '2020-05-05', '5', 'Le Van E', '2', '4', '3'),
	   ('BK-006', 'Kafka', 'Kafka-Ben-Bo-Bien-633x1024.jpg', 'Kafka Tamura, mười lăm tuổi, bỏ trốn khỏi nhà ở Tokyo để thoát khỏi lời nguyền khủng khiếp mà người cha đã giáng xuống đầu mình.Ở phía bên kia quần đảo, Nakata, một ông già lẩm cẩm cùng quyết định dấn thân. Hai số phận đan xen vào nhau để trở thành một tấm gương phản chiếu lẫn nhau. Trong khi đó, trên đường đi, thực tại xào xạc lời thì thầm quyến rũ. Khu rừng đầy những người linh vừa thoát khỏi cuộc chiến tranh vừa qua, cá mưa từ trên trời xuống và gái điếm trích dẫn Hegel. Kafka bên bờ biển, câu chuyện hoang đường mở đầu thế kỷ XXI, cho chúng ta đắm chìm trong một chuyến du hành đầy sóng gió đầy chất hiện đại và mơ mộng trong lòng Nhật Bản đương đại.', '105000', 'Nguyen Van F', '350', '30x40cm', '2020-06-06', '5', 'Le Van F', '2', '5', '3'),
	   ('BK-007', 'Không gia đình', 'sach-khong-gia-dinh-212x300.png', 'Không Gia Đình kể về chuyện đời Rémi, một cậu bé không cha mẹ, họ hàng thân thích. Sau khi phải rời khỏi vòng tay của người má nuôi, em đã đi theo đoàn xiếc thú của cụ già Vitalis tốt bụng. Kể từ đó, em lưu lạc khắp nơi, ban đầu dưới sự che chở của cụ Vitalis, sau đó thì tự lập và còn lo cả công việc biểu diễn và sinh sống cho cả một gánh hát rong. Đã có lúc em và cả đoàn lang thang cả mấy ngày đói khát rồi còn suýt chết rét. Có bận em bị lụt ngầm chôn trong giếng mỏ hàng tuần. Rồi có lần em còn mắc oan bị giải ra tòa và phải ở tù. Nhưng cũng có khi em được nuôi nấng đàng hoàng, no ấm. Song dù trong hoàn cảnh nào, Rémi vẫn giữ được sự gan dạ, ngay thẳng, lòng tự trọng, tính thương người, ham lao động chứ không hạ mình hay gian dối. Cuối cùng, sau bao gian nan khổ cực, em đã đoàn tụ được với gia đình của mình.', '119000', 'Nguyen Van G', '400', '30x40cm', '2020-07-07', '5', 'Le Van G', '2', '6', '4'),
	   ('BK-008', 'Alice diệu kỳ', 'Alice-o-xu-so-dieu-ky_600x855.jpg', 'Câu chuyện kể về chuyến phiêu lưu cảu cô bé Alice dũng cảm, can đảm. Bỗng một ngày cô chui qua một hang thỏ rồi lạc vào thế giới thần tiên có những sinh vật kì lạ với những cái tách trà có thể nói chuyện, chú thỏ ngộ nghĩnh hay cuộc đối đầu với bà hoàng hậu và những lá bài...', '56600', 'Nguyen Van H', '450', '30x40cm', '2020-08-08', '5', 'Le Van H', '3', '7', '4'),
	   ('BK-009', 'Charlie, nhà máy Socola', 'Charlie-va-nha-may-so-co-la_600x857.jpg', 'Nội dung của cuốn sách kể Cậu bé Charlie sống trong một gia đình nghèo khó, tình cờ một ngày cậu có được một tấm vé vàng tham quan nhà máy chocolate bí hiểm của ông chủ Willy Wonka. Đây là nhà máy sản xuất  những thanh kẹo chocolate ngon nhất thế giới, tuy nhiên điều đặc biệt là không một ai biết được bên trong nhà máy hoạt động như thế nào, vì ông chủ của nhà máy đã từng bị phản bội nên ông muốn giữ bí mật tuyệt đối công thức làm kẹo của mình sau khi bị phản bội. Charlie đã trải qua một chuyến phiêu lưu dị thường trong nhà máy kỳ quái này, và kết thúc  của câu chuyện như thế nào, mời bạn đón đọc cuốn sách này nhé.', '60000', 'Nguyen Van I', '500', '30x40cm', '2020-09-09', '5', 'Le Van I', '3', '8', '5'),
	   ('BK-010', 'Dế mèn phiêu lưu ký', 'de_men_phieu_luu_ky.jpg', '“Một con dế đã từ tay ông thả ra chu du thế giới tìm những điều tốt đẹp cho loài người. Và con dế ấy đã mang tên tuổi ông đi cùng trên những chặng đường phiêu lưu đến với cộng đồng những con vật trong văn học thế giới, đến với những xứ sở thiên nhiên và văn hóa của các quốc gia khác. Dế Mèn Tô Hoài đã lại sinh ra Tô Hoài Dế Mèn, một nhà văn trẻ mãi không già trong văn chươ” – Nhà phê bình Phạm Xuân Nguyên', '120000', 'Nguyen Van J', '450', '30x40cm', '2020-10-10', '5', 'Le Van J', '3', '9', '5'),
	   ('BK-011', 'Ngoại giao', 'ngoai-giao-va-cong-tac-ngoai-giao.jpg', 'Cuốn sách gồm 15 chương, giới thiệu một cách hệ thống các nội dung của ngoại giao như: các khái niệm ngoại giao, cơ quan đại diện ngoại giao, thư tín ngoại giao, tiếp xúc ngoại giao, ngoại giao kinh tế, ngoại giao văn hóa, đàm phán ngoại giao, văn kiện ngoại giao, lễ tân ngoại giao,... Cuốn sách có thể xem như một giáo trình phục vụ việc giảng dạy và học tập chuyên ngành quan hệ quốc tế, là một tài liệu tham khảo bổ ích phục vụ công tác bồi dưỡng cán bộ về hội nhập quốc tế, đồng thời góp phần đáp ứng nhu cầu tìm hiểu, nghiên cứu của đông đảo bạn đọc.', '291480', 'Nguyen Van K', '400', '30x40cm', '2020-11-11', '5', 'Le Van K', '4', '10', '6'),
	   ('BK-012', 'Phong cách đàm phán ngoại giao', 'PhongCachDamPhanNgoaiGiao.jpg', 'Nội dung cuốn sách Phong cách đàm phán ngoại giao gồm 03 chương, cung cấp những kiến thức từ cơ bản đến nâng cao việc công việc đàm phán ngoại giao như: bản chất của đàm phán ngoại giao, chiến lược của đàm phán, kỹ thuật tổ chức đàm phán và chiến thuật đàm phán. Tác giả giải thích những khái niệm ban đầu để hiểu hơn về đàm phán ngoại giao, đồng thời diễn tả đầy đủ thế giới của những cuộc đàm phán từ khâu tổ chức cho đến những gì diễn ra trong và ngoài sự kiện. Đặc biệt, người đọc sẽ hiểu hơn những cách thức, kinh nghiệm về mặt chiến lược, chiến thuật trên bàn đàm phán thông qua những phong cách làm phản tiêu biểu của một số cường quốc như Mỹ, Trung Quốc, Nga.', '250000', 'Nguyen Van L', '350', '30x40cm', '2020-12-12', '5', 'Le Van L', '4', '10', '6'),
	   ('BK-013', 'Phương pháp nghiên cứu quan hệ quốc tế ', 'GiaoTrinhPhuongPhapNghienCuuQHQT.jpg', 'Giáo trình gồm ba chương: Chương I: Đại cương về khoa học và nghiên cứu khoa học, Chương II: Phương pháp nghiên cứu khoa học quan hệ quốc tế, Chương III: Hướng dẫn làm đề tài nghiên cứu khoa học', '96000', 'Nguyen Van M', '300', '30x40cm', '2019-01-01', '5', 'Le Van M', '4', '10', '7'),
	   ('BK-014', 'Căn Phòng Riêng', 'CanPhongRieng.png', 'Căn Phòng Riêng - cuốn tiểu luận của Virginia Woolf, xuất bản lần đầu tiên vào năm 1929 - đã được khai triển từ luận điểm trên. Một luận điểm mang màu sắc duy vật và đầy khiêu khích. Thẳng thắn, sắc sảo, với một chất hài hước kín đáo, đó là giọng điệu chủ đạo của Căn Phòng Riêng.', '53900', 'Nguyen Van N', '250', '30x40cm', '2019-02-02', '5', 'Le Van N', '4', '4', '7'),
	   ('BK-015', 'Những cuộc chính phạt của Alexander đại đế', 'nhung-cuoc-chinh-phat-cua-Alexander-dai-de.jpg', 'Arrian đã nắm bắt được một đề tài hấp dẫn và một cơ hội huy hoàng. Không một ai từng viết về Alexander Đại đế nhiều hơn ông. Không một ai, một nhà thơ hoặc nhà văn nào, có được sự công minh như ông. Chừng nào những tác phẩm của những tác giả trước đó (viết về Alexander) còn chứa những sai lầm hiển nhiên, chừng đó một Alexander thực sự còn bị che giấu dưới vô vàn những tuyên bố mâu thuẫn. Cuốn sách của Arrian quả thực đã chấm dứt tình trạng này. Nó quan trọng đến mức Arrian đã không ngần ngại thách thức cả những sử gia Hy Lạp vĩ đại.', '129350', 'Nguyen Van O', '100', '30x40cm', '2019-03-03', '5', 'Le Van O', '5', '11', '1'),
	   ('BK-016', 'Số đỏ', 'so-do-vu-trong-phung-pdf.jpg', 'Truyện dài 20 chương và được bắt đầu khi bà Phó Đoan đến chơi ở sân quần vợt nơi Xuân tóc đỏ làm việc. Vô tình Xuân tóc đỏ vì xem trộm 1 cô đầm thay đồ nên bị cảnh sát bắt giam và được bà Phó Đoan bảo lãnh. Sau đó, bà Phó Đoan giới thiệu Xuân đến làm việc ở tiệm may Âu Hóa, từ đó Xuân bắt đầu tham gia vào việc cải cách xã hội. Nhờ thuộc lòng những bài quảng cáo thuốc lậu, hắn được vợ chồng Văn Minh gọi là “sinh viên trường thuốc”, “đốc tờ Xuân”. Hắn gia nhập xã hội thượng lưu, quen với những người giàu và có thế lực, quyến rũ được cô Tuyết và phát hiện cô Hoàng Hôn ngoại tình. Xuân còn được bà Phó đoan nhờ dạy dỗ cậu Phước, được nhà sư Tăng Phú mời làm cố vấn cho báo Gõ Mõ. Vì vô tình, hắn gây ra cái chết cho cụ cố tổ nên được mọi người mang ơn. Văn Minh vì nghĩ ơn của Xuân nên dẫn Xuân đi xóa bỏ lí lịch trước kia rồi đăng kí đi tranh giải quần vợt nhân dịp vua Xiêm đến Bắc Kì. Bằng thủ đoạn xảo trá, hắn làm 2 vận động viên quán quân bị bắt ngay trước hôm thi đấu nên Xuân được dịp thi tài với quán quân Xiêm. Vì để giữ tỉnh giao hảo, hắn được lệnh phải thua. Kết thúc trận đấu, khi bị đám đông phản đối, Xuân hùng hồn diễn thuyết cho đám đông dân chúng hiểu hành động “hi sinh vì tổ quốc của mình”, được mời vào hội Khai trí tiến đức, được nhận huân chương Bắc Đẩu bội tinh và cuối cùng trở thành con rể cụ cố Hồng.', '54400', 'Nguyen Van P', '150', '30x40cm', '2019-04-04', '5', 'Le Van P', '5', '11', '1'),
	   ('BK-017', 'Bàn Về Khế Ước Xã Hội', 'ban-ve-khe-uoc-xa-hoi.jpg', 'Khế ước xã hội là tên gọi vắn tắt của bản luận văn lớn mà J. J. Rousseau đặt dưới một nhan đề khá dài: Bàn về khế ước xã hội hay là các nguyên tắc của quyền chính trị (Du Contrat social – ou principes du droit politique).', '148000', 'Nguyen Van Q', '200', '30x40cm', '2019-05-05', '5', 'Le Van Q', '5', '12', '1'),
	   ('BK-018', 'Combo Tớ là công dân toàn cầu', 'cb_tlcdtc.webp', 'Công dân toàn cầu là những người quan tâm tới một thế giới rộng lớn hơn, tới toàn bộ địa', '168000', 'Nguyen Van R', '250', '30x40cm', '2019-06-06', '5', 'Le Van R', '6', '13', '1'),
	   ('BK-019', 'Chung tay bảo vệ môi trường ', 'ChungTayBaoVeMT.jpg', 'Trái Đất là ngôi nhà chung của các loài sinh vật khác nhau, và tất cả chúng ta đều phụ thuộc vào môi trường để có thức ăn, không khí, nước và các nhu cầu khác. Tớ Là Công Dân Toàn Cầu – Chung Tay Bảo Vệ Môi Trường đưa em khám phá những vấn đề môi trường từ biến đổi khí hậu đến sự suy giảm đa dạng sinh học và ô nhiễm; qua đó đưa ra những ý tưởng hành động để biến hành tinh xanh trở thành một nơi tốt đẹp hơn.', '31500', 'Nguyen Van S', '300', '30x40cm', '2019-07-07', '5', 'Le Van S', '6', '13', '1'),
	   ('BK-020', 'Combo Con mèo đen + Vụ án mạng', 'cb_cmd.webp', 'Bất chấp các vấn đề cá nhân, Poe vẫn không ngừng sáng tác và để lại một gia tài đồ sộ các tác phẩm giúp ông chiếm một vị trí danh dự trong lịch sử văn học thế giới. Ông thể hiện mình là một người đi trước thời đại, ngọn hải đăng của “chủ nghĩa lãng mạn đen tối”, bậc thầy về kể chuyện kinh dị, cha đẻ của thể loại truyện trinh thám và hình sự, nhà tiên phong trong lĩnh vực truyện khoa học viễn tưởng... và không còn nghi ngờ gì nữa, là một trong những người sáng tạo có ảnh hưởng sâu sắc và lâu dài nhất trong văn chương hiện đại nói riêng, và nền văn hoá nói chung.', '96000', 'Nguyen Van T', '350', '30x40cm', '2019-08-08', '5', 'Le Van T', '6', '14', '1'),
	   ('BK-021', 'Combo Lược sử bằng hình', 'luoc_su_bang_hinh.webp', 'Ngay từ khi bắt đầu xuất hiện, con người đã nhìn khắp hành tinh phong phú nhưng khó đoán định này và đặt ra những câu hỏi sâu sắc. Vạn vật bắt nguồn từ đâu? Sự sống từ đâu mà có? Tương lai sẽ ra sao? Tất cả những câu hỏi trên đây và nhiều câu hỏi lí thú khác sẽ được lí giải trong bộ sách Lược Sử Vạn Vật Bằng Hình (3 Cuốn). Thông qua những tư duy khoa học mới mẻ nhất được trình bày rõ ràng và đơn giản, cùng những hình minh họa tuyệt đẹp và sống động, bộ sách dẫn dắt bạn đọc bước vào chuyến phiêu lưu diệu kì trải dài từ quá khứ đến hiện tại của sự sống, Trái Đất và vũ trụ.', '372000', 'Nguyen Van U', '400', '30x40cm', '2019-09-09', '5', 'Le Van U', '6', '15', '2'),
	   ('BK-022', 'Combo Làm quen với danh tác ', 'cb_lqvdt.webp', 'Với sự tư vấn ngôn ngữ của chuyên gia hàng đầu về giáo dục tiểu học nước Anh, bộ sách xinh xắn này được nghiên cứu và biên soạn hết sức phù hợp với lứa tuổi mới biết đọc. Tuyển tập tác phẩm kinh điển đậm tính nghệ thuật này sẽ góp phần thúc đẩy trí tưởng tượng cũng như hoàn thiện khả năng đọc hiểu của các em.', '378000', 'Ngọc Linh', '272', '14x20.5 cm', '2022-06-29', '5', 'Hội nhà văn', '7', '16', '1'),
	   ('BK-023', 'Chùa Đàn', 'ChuaDan.jpg', 'Sau một cái tử biệt, giờ ta phải tính đến một nỗi sinh li khác. Đối với đàn, hát, từ bây giờ ta nguyện làm một người điếc một người cô đơn một người phản bội. Và trên vong linh Bá Nhỡ, ta thề độc là không bao giờ cầm đến một cái chén nào của cuộc đời này.', '48100', 'Ngọc Linh A', '300', '14x20.5 cm', '2022-07-29', '5', 'Hội nhà văn', '7', '17', '1'),
	   ('BK-024', 'Ra Bờ Suối', 'RaBoSuoiNgamHoaKenHong.jpg', 'Ra bờ suối ngắm hoa kèn hồng là tác phẩm trong trẻo, tràn đầy tình yêu thương mát lành, trải ra trước mắt người đọc khu vườn trại rực rỡ cỏ hoa của vùng quê thanh bình, kèm theo đó là những “nhân vật” đáng yêu, làm nên một “thế giới giàu có, rộng lớn và vô cùng hấp dẫn” mà dường như người lớn đã bỏ quên đâu đó từ lâu.', '116000', 'Ngọc Linh B', '350', '14x20.5 cm', '2022-08-29', '5', 'Hội nhà văn', '7', '18', '1'),
	   ('BK-025', 'Thả Thính', 'ThaThinhChanKinh.jpg', 'Thả thính chân kinh, với mạch cảm xúc của một trái tim từng trải quá nhiều cảm xúc buồn vui trong tình yêu và cuộc sống, văn của Khang đẹp và buồn và trong sáng và đầy hy vọng, như chính con người và tính cách của Khang. Tập sách trẻ trung và thú vị cùng nhiều cung bậc cảm xúc về tình yêu, mách nước cho các cậu trai cô gái cách “thả thính” làm sao cho đối tượng mình thầm thương trộm nhớ phải “gục ngã”. Nhưng sâu hơn, xa hơn những lời ngọt ngào có cánh là thái độ vui sống sau bão giông tình trường, là cách hành xử văn minh sau khi tình yêu bỏ ra đi.', '67400', 'Ngọc Linh C', '400', '14x20.5 cm', '2022-09-29', '5', 'Hội nhà văn', '7', '19', '2'),
	   ('BK-026', 'Chuông Nguyện Hồn Ai', 'ChuongNguyenHonAi.jpg', '“Chuông nguyện hồn ai” được xuất bản vào năm 1940, đoạt “Giải Pulitzer cho tác phẩm hư cấu” năm 1941. Tác phẩm này lọt vào danh sách 100 cuốn sách hay nhất thế kỷ 20 của Le Monde thông qua cuộc bầu chọn do nhà sách Fnac của Pháp và báo Le Monde tiến hành năm 1999.', '97400', 'Ngọc Linh D', '450', '14x20.5 cm', '2022-10-29', '5', 'Hội nhà văn', '7', '20', '2'),
	   ('BK-027', 'Nước Mỹ (Kẻ Mất Tích)', 'NuocMy.jpg', 'Nước Mỹ (Kẻ mất tích) - tiểu thuyết đầu tiên, và hài hước nhất của Franz Kafka như tia sáng lẻ loi bên ngoài chùm tác phẩm đã trở thành huyền thoại vẫn thường được nhắc đến là Hóa thân, Vụ án và Lâu đài. E. L. Doctorow – nhà văn đương đại lớn hàng đầu nước Mỹ đánh giá đây là câu chuyện hiện đại, mang tầm tư tưởng lớn về nước Mỹ như một nơi chốn chưa ai từng thấy, trong một thời kỳ lịch sử không thể nhận dạng, vì nó được Kafka, dù chưa từng đặt chân đến Mỹ, viết nên từ những yếu tố thần thoại trong chính tâm trí thiên tài của ông', '78700', 'Ngọc Linh E', '400', '14x20.5 cm', '2022-11-29', '5', 'Hội nhà văn', '7', '21', '1'),
	   ('BK-028', 'Trăm Năm Cô Đơn', 'TramNamCoDon.jpg', '“Chỉ với một bước nhảy, Gabriel García Márquez đã vụt lên ngang hàng với Günter Grass và Vladimir Nabokov.”', '123000', 'Ngọc Linh G', '350', '14x20.5 cm', '2022-12-29', '5', 'Hội nhà văn', '7', '22', '1'),
	   ('BK-029', 'Giết Con Chim Nhại', 'GietConChimNhai.jpg', 'Nào, hãy mở cuốn sách này ra. Bạn phải làm quen ngay với bố Atticus của hai anh em - Jem và Scout, ông bố luật sư có một cách riêng, để những đứa trẻ của mình cứng cáp và vững vàng hơn khi đón nhận những bức xúc không sao hiểu nổi trong cuộc sống. Bạn sẽ nhớ rất lâu người đàn ông thích trốn trong nhà Boo Radley, kẻ bị đám đông coi là lập dị đã chọn một cách rất riêng để gửi những món quà nhỏ cho Jem và Scout, và khi chúng lâm nguy, đã đột nhiên xuất hiện để che chở. Và tất nhiên, bạn không thể bỏ qua anh chàng Tom Robinson, kẻ bị kết án tử hình vì tội hãm hiếp một cô gái da trắng, sự thật thà và suy nghĩ quá đỗi đơn giản của anh lại dẫn đến một cái kết hết sức đau lòng, chỉ vì lý do anh là một người da đen.', '88300', 'Ngọc Linh H', '300', '14x20.5 cm', '2021-06-29', '5', 'Hội nhà văn', '7', '23', '1'),
	   ('BK-030', 'Combo Harry Potter', 'cb_HarryPotter.jpg', 'Nội dung câu chuyện giả tưởng từng gây sốt trên nhiều thị trường sách này kể về cuộc chiến của cậu bé Harry Potter một mình chống lại một phù thủy hắc ám Chúa tể Voldemort, người đã giết cha mẹ cậu để thực hiện tham vọng làm chủ thế giới phù thủy. Harry Potter đã chắp cánh cho trí tưởng tượng của trẻ em trên toàn thế giới bay cao bay xa trong thế giới pháp thuật huyền hoặc. Truyện bắt đầu với một nhân vật bình thường, thậm chí là có phần tầm thường và nó diễn ra ngay bên cạnh chúng ta, bắt đầu từ sân ga 9¾ ở nhà ga Ngã tư Vua. Lần lượt bảy tập truyện sẽ đưa độc giả đi khám phá con đường trở thành pháp sư đầy chông gai, thử thách của Harry cùng với các bạn của mình tại ngôi trường phù thủy Hogwarts.', '1200000', 'Ngọc Linh F', '250', '14x20.5 cm', '2021-07-29', '5', 'Hội nhà văn', '7', '24', '1'),
	   ('BK-031', 'Văn Và Đời', 'VanVaDoi.jpg', 'Nguyễn Quang Sáng bắt đầu sáng tác khi còn khá trẻ. Giọng văn của ông giản dị, mộc mạc nhưng phản ánh chân thật giá trị cuộc sống. Từng lời văn, câu chuyện đưa tâm hồn độc giả đến với giá trị nhân văn sâu sắc. Độc giả sẽ chẳng bao giờ quên bé Thu trong Chiếc lược ngà và những lát cắt cảm xúc khó phai trong Mùa gió chướng, Cánh đồng - những tác phẩm đi cùng giai đoạn lịch sử hào hùng của dân tộc.', '120000', 'Ngọc Linh I', '200', '14x20.5 cm', '2021-08-29', '5', 'Hội nhà văn', '7', '25', '2');

INSERT INTO `sprint2test`.`cart` (`cart_code`, `cart_quantity`, `cart_status`, `cart_total_money`, `cart_purchase_date`, `cart_account_id`) 
VALUES ('MHD-001', '1', 1, '1000', '2022-01-01', '1'),
	   ('MHD-001', '2', 1,'4000', '2022-01-01', '1'),
	   ('MHD-001', '3', 1,'9000', '2022-01-01', '1'),
	   ('MHD-001', '3', 1,'75500', '2022-01-01', '1'),
	   ('MHD-002', '1', 1,'4000', '2022-01-01', '2'),
	   ('MHD-002', '2', 1,'10000', '2022-01-01', '2'),
	   ('MHD-002', '3', 1,'18000', '2022-01-01', '2'),
	   ('MHD-002', '4', 1,'18000', '2022-01-01', '2');

INSERT INTO `sprint2test`.`cart_book` (`book_id`, `cart_id`) VALUES ('1', '1'),
																	('2', '2'),
																	('3', '3'),
																	('4', '4'),
																	('5', '5'),
																	('6', '6'),
																	('1', '7'),
																	('5', '8');
    
INSERT INTO `sprint2test`.`cart` (`cart_quantity`, `cart_total_money`, `cart_status`, `cart_account_id`) VALUES ('5', '22500', b'0', '1'),
																												('4', '21600', b'0', '1'),
																												('3', '17850', b'0', '1'),
																												('2', '13600', b'0', '2'),
																												('3', '21600', b'0', '2'),
																												('4', '32000', b'0', '2');
    
INSERT INTO `sprint2test`.`cart_book` (`book_id`, `cart_id`) VALUES ('5', '8'),
																	('6', '9'),
																	('7', '10'),
																	('8', '11'),
																	('9', '12'),
																	('10', '13');