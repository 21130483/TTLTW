<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="../css/sick.css">
    <link rel="stylesheet" href="../css/header-footer.css">
    <link rel="stylesheet" href="../css/contact.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <title>Bệnh</title>
</head>

<body>

<div class="page">
    <jsp:include page="header.jsp"></jsp:include>


    <div id="sick-main">
        <div class="sub1-sick-main">
            <div class="sub2-sick-main">
                <div class="sick-header">
                    <h2 class="text-sick-header">Tìm hiểu các bệnh thường gặp</h2>
                </div>


                <div class="sick-sub-header">
                    <i class="fa-solid fa-book-open"></i>
                    <p>Cơ thể người</p>
                </div>


                <div class="sick-content">
                    <div class="sick-sub-content">
                        <div class="sick-content-main">
                            <div class="sick-body-people">
                                <img src="../image/sick/body.png" alt="body people">
                                <p>Hình ảnh chỉ mang tính chất minh họa</p>
                            </div>

                            <div class="sick-body-item">
                                <div class="click-sick-head sick-item ">
                                    <img src="../image/sick/head-body.svg" alt="đầu">
                                    <p>Đầu</p>
                                </div>

                                <div class="click-sick-neck sick-item ">
                                    <img src="../image/sick/neck-body.svg" alt="cổ">
                                    <p>Cổ</p>
                                </div>

                                <div class="click-sick-chest sick-item">
                                    <img src="../image/sick/chest-body.svg" alt="ngực">
                                    <p>Ngực</p>
                                </div>

                                <div class="click-sick-belly sick-item">
                                    <img src="../image/sick/belly-body.svg" alt="bụng">
                                    <p>Bụng</p>
                                </div>

                                <div class="click-sick-genital sick-item">
                                    <img src="../image/sick/genital-body.svg" alt="sinh dục">
                                    <p>Sinh dục</p>
                                </div>

                                <div class="click-sick-limbs sick-item">
                                    <img src="../image/sick/limbs-body.svg" alt="tứ chi">
                                    <p>Tứ chi</p>
                                </div>

                                <div class="click-sick-skin sick-item">
                                    <img src="../image/sick/skin-body.svg" alt="da">
                                    <p>Da</p>
                                </div>
                            </div>

                            <!-- các bệnh của đầu -->

                            <div class="out-sick-head1 Sick-text-sick">
                                <div class="sick-text-main">
                                    <div class="sick-text-content1">
                                        <p class="contentSick">Ung thư vòm họng giai đoạn đầu</p>
                                        <p class="contentSick">Ung thư khoang miệng</p>
                                        <p class="contentSick">Bệnh teo đa hệ thống</p>
                                        <p class="contentSick">Hội chứng Cotard</p>
                                        <p class="contentSick">Viêm xoang trán</p>
                                        <p class="contentSick">Viêm xoang sàng</p>
                                        <p class="contentSick">Viêm tai xương chũm</p>
                                        <p class="contentSick">Viêm tai giữa thủng màng nhĩ</p>
                                        <p class="contentSick">Viêm đa xoang</p>
                                        <p class="contentSick">U nhầy xoang trán</p>
                                    </div>
                                    <div class="sick-text-content2">
                                        <p class="contentSick"> Bướu huyết thanh</p>
                                        <p class="contentSick">Bạch sản</p>
                                        <p class="contentSick">Rối loạn chức năng não sau hóa trị</p>
                                        <p class="contentSick">Xốp xơ tai</p>
                                        <p class="contentSick">Viêm xoang sàng sau</p>
                                        <p class="contentSick">Viêm tuyến nước bọt</p>
                                        <p class="contentSick">Viêm tai giữa ứ dịch</p>
                                        <p class="contentSick">Viêm màng não mủ</p>
                                        <p class="contentSick">U tuyến nước bọt mang tai</p>
                                        <p class="contentSick">Viêm kết mạc mắt</p>
                                    </div>
                                </div>
                                <div class="sick-text-button">
                                    <i class="click-sick-head fa-solid fa-angle-left"></i>
                                    <button class="click-sick-head btn-sick">1</button>
                                    <button class="click-sick-head2 btn-sick">2</button>
                                    <i class="click-sick-head2 fa-solid fa-angle-right"></i>
                                </div>
                            </div>

                            <div class="out-sick-head2 Sick-text-sick" style="display: none;">
                                <div class="sick-text-main">
                                    <div class="sick-text-content1">
                                        <p class="contentSick">Áp lực nội sọ</p>
                                        <p class="contentSick">Viêm mũi mãn tính</p>
                                        <p class="contentSick">Đột quỵ não</p>
                                        <p class="contentSick">Thoái hóa tiểu não</p>
                                        <p class="contentSick">U tế bào thần kinh đệm ít nhánh</p>
                                        <p class="contentSick">Não úng thủy</p>
                                        <p class="contentSick">Liệt mặt</p>
                                        <p class="contentSick">Khàn tiếng</p>
                                        <p class="contentSick">Đột quỵ thiếu máu cục bộ</p>
                                        <p class="contentSick">Viêm dây thần kinh tiền đình</p>
                                    </div>
                                    <div class="sick-text-content2">
                                        <p class="contentSick">Viêm não cấp ở trẻ em</p>
                                        <p class="contentSick">Giác mạc hình chóp</p>
                                        <p class="contentSick">Đau đầu vận mạch</p>
                                        <p class="contentSick">Xốp xơ mũi</p>

                                    </div>
                                </div>
                                <div class="sick-text-button">
                                    <i class="click-sick-head fa-solid fa-angle-left"></i>
                                    <button class="click-sick-head btn-sick">1</button>
                                    <button class="click-sick-head2 btn-sick">2</button>
                                    <i class="click-sick-head2 fa-solid fa-angle-right"></i>
                                </div>
                            </div>

                            <!-- Các bệnh của cổ -->
                            <div class="out-sick-neck1 Sick-text-sick" style="display: none;">
                                <div class="sick-text-main">
                                    <div class="sick-text-content1">
                                        <p class="contentSick">Bướu giáp lan tỏa</p>
                                        <p class="contentSick">Đau cổ vai gáy</p>
                                        <p class="contentSick">Đau cổ</p>
                                        <p class="contentSick">Ung thư thanh quản</p>
                                        <p class="contentSick">Suy cận giáp</p>
                                        <p class="contentSick">Đau nhức toàn thân</p>
                                        <p class="contentSick">Thoái hóa đốt sống cổ</p>
                                        <p class="contentSick">Chấn thương thanh quản</p>
                                        <p class="contentSick">Bướu giáp keo</p>
                                        <p class="contentSick">Viêm tuyến giáp Hashimoto</p>
                                    </div>
                                    <div class="sick-text-content2">
                                        <p class="contentSick">Chứng khó nuốt</p>
                                        <p class="contentSick">Viêm họng mạn tính</p>

                                    </div>
                                </div>
                                <div class="sick-text-button">
                                    <i class="fa-solid fa-angle-left"></i>
                                    <button class="btn-sick">1</button>

                                    <i class="fa-solid fa-angle-right"></i>
                                </div>
                            </div>

                            <!-- Các bệnh về Ngực -->
                            <div class="out-sick-chest1 Sick-text-sick" style="display: none;">
                                <div class="sick-text-main">
                                    <div class="sick-text-content1">
                                        <p class="contentSick">Đau ngực</p>
                                        <p class="contentSick">Cơn đau thắt ngực</p>
                                        <p class="contentSick">Bệnh phổi kẽ</p>
                                        <p class="contentSick">Bệnh mạch vành</p>
                                        <p class="contentSick">Ghép tim</p>
                                        <p class="contentSick">Đau nhức toàn thân</p>
                                        <p class="contentSick">Bụi phổi bông</p>
                                        <p class="contentSick">Trào ngược dạ dày</p>
                                        <p class="contentSick">
                                            Bụi phổi silic</p>
                                        <p class="contentSick">
                                            Giãn tĩnh mạch thực quản</p>
                                    </div>
                                    <div class="sick-text-content2">
                                        <p class="contentSick">
                                            Bệnh van tim</p>
                                        <p class="contentSick">U trung thất</p>
                                        <p class="contentSick">Viêm sụn sườn</p>
                                        <p class="contentSick">Viêm phổi kẽ tróc vảy</p>
                                        <p class="contentSick">Viêm phổi tăng bạch cầu ái toan</p>
                                        <p class="contentSick">Bệnh tích protein phế nang</p>
                                        <p class="contentSick">Xuất huyết phế nang lan tỏa</p>
                                        <p class="contentSick">Bệnh cơ tim</p>
                                        <p class="contentSick">U trung biểu mô</p>
                                        <p class="contentSick">Cơ tim hạn chế</p>
                                    </div>
                                </div>
                                <div class="sick-text-button">
                                    <i class="fa-solid fa-angle-left"></i>
                                    <button class="btn-sick">1</button>

                                    <i class="fa-solid fa-angle-right"></i>
                                </div>
                            </div>

                            <!-- Các bệnh về Bụng -->
                            <div class="out-sick-belly1 Sick-text-sick" style="display: none;">
                                <div class="sick-text-main">
                                    <div class="sick-text-content1">
                                        <p class="contentSick">Xơ gan do rượu</p>
                                        <p class="contentSick">Xơ gan còn bù</p>
                                        <p class="contentSick">Viêm dạ dày cấp</p>
                                        <p class="contentSick">Suy gan mạn</p>
                                        <p class="contentSick">Nhiễm vi khuẩn Salmonella</p>
                                        <p class="contentSick">Đạm niệu</p>
                                        <p class="contentSick">Ung thư gan di căn</p>
                                        <p class="contentSick">Bệnh nang gan</p>
                                        <p class="contentSick">Tăng áp tĩnh mạch cửa</p>
                                        <p class="contentSick">Viêm đường mật nguyên phát (PBC)</p>
                                    </div>
                                    <div class="sick-text-content2">
                                        <p class="contentSick">
                                            Xơ gan mất bù</p>
                                        <p class="contentSick">
                                            Viêm ruột mạn tính</p>
                                        <p class="contentSick">U tụy nội tiết Insulinoma</p>
                                        <p class="contentSick">
                                            Sỏi bùn túi mật</p>
                                        <p class="contentSick">
                                            Lỵ amip</p>
                                        <p class="contentSick">
                                            U mô đệm đường tiêu hóa (GISTs)</p>
                                        <p class="contentSick">
                                            Ung thư gan nguyên phát</p>
                                        <p class="contentSick">Viêm phúc mạc nhiễm khuẩn tiên phát</p>
                                        <p class="contentSick">
                                            Cổ trướng</p>
                                        <p class="contentSick">
                                            U tuỷ thượng thận</p>
                                    </div>
                                </div>
                                <div class="sick-text-button">
                                    <i class="click-sick-belly fa-solid fa-angle-left"></i>
                                    <button class="click-sick-belly btn-sick">1</button>
                                    <button class="click-sick-belly2 btn-sick">2</button>
                                    <i class="click-sick-belly2 fa-solid fa-angle-right"></i>
                                </div>
                            </div>

                            <div class="out-sick-belly2 Sick-text-sick" style="display: none;">
                                <div class="sick-text-main">
                                    <div class="sick-text-content1">
                                        <p class="contentSick">Bệnh thận tắc nghẽn</p>
                                    </div>
                                </div>
                                <div class="sick-text-button">
                                    <i class="click-sick-belly fa-solid fa-angle-left"></i>
                                    <button class="click-sick-belly btn-sick">1</button>
                                    <button class="click-sick-belly2 btn-sick">2</button>
                                    <i class="click-sick-belly2 fa-solid fa-angle-right"></i>
                                </div>
                            </div>

                            <!-- Các bệnh về Sinh Học -->
                            <div class="out-sick-genital1 Sick-text-sick" style="display: none;">
                                <div class="sick-text-main">
                                    <div class="sick-text-content1">
                                        <p class="contentSick">Vô sinh nguyên phát</p>
                                        <p class="contentSick">Viêm tuyến tiền liệt cấp tính</p>
                                        <p class="contentSick">Tinh hoàn lạc chỗ</p>
                                        <p class="contentSick">Herpes hậu môn</p>
                                        <p class="contentSick">Hội chứng Swyer</p>
                                        <p class="contentSick">Dương vật cong</p>
                                        <p class="contentSick">Chuyển dạ đình trệ</p>
                                        <p class="contentSick">Viêm túi tinh</p>
                                        <p class="contentSick">sa tinh hoàn</p>
                                        <p class="contentSick">U tinh hoàn</p>
                                    </div>
                                    <div class="sick-text-content2">
                                        <p class="contentSick">Viêm tuyến tiền liệt mạn tính</p>
                                        <p class="contentSick">
                                            Viêm nội mạc tử cung</p>
                                        <p class="contentSick">
                                            Tắc ống dẫn tinh</p>
                                        <p class="contentSick">
                                            Không có tinh trùng</p>

                                    </div>
                                </div>
                                <div class="sick-text-button">
                                    <i class="fa-solid fa-angle-left"></i>
                                    <button class="btn-sick">1</button>

                                    <i class="fa-solid fa-angle-right"></i>
                                </div>
                            </div>

                            <!-- Các bệnh về tứ chi -->

                            <div class="out-sick-limbs1 Sick-text-sick" style="display: none;">
                                <div class="sick-text-main">
                                    <div class="sick-text-content1">
                                        <p class="contentSick">Viêm gân gấp ngón cái</p>
                                        <p class="contentSick">Trật khớp cùng đòn</p>
                                        <p class="contentSick">Ngón chân hình búa</p>
                                        <p class="contentSick">Liệt dây thần kinh hông khoeo ngoài</p>
                                        <p class="contentSick">Gout cấp tính</p>
                                        <p class="contentSick">Đau khớp khuỷu tay</p>
                                        <p class="contentSick">Viêm gân bánh chè</p>

                                    </div>

                                </div>
                                <div class="sick-text-button">
                                    <i class="fa-solid fa-angle-left"></i>
                                    <button class="btn-sick">1</button>

                                    <i class="fa-solid fa-angle-right"></i>
                                </div>
                            </div>

                            <!-- Các bệnh về Da -->
                            <div class="out-sick-skin1 Sick-text-sick" style="display: none;">
                                <div class="sick-text-main">
                                    <div class="sick-text-content1">
                                        <p class="contentSick">Xơ cứng bì</p>
                                        <p class="contentSick">Nám nội tiết</p>
                                        <p class="contentSick">Lupus ban đỏ hệ thống</p>
                                        <p class="contentSick">Chàm đồng tiền</p>
                                        <p class="contentSick">Xơ cứng bì toàn thể</p>
                                        <p class="contentSick">Giời leo</p>
                                        <p class="contentSick">Vàng da</p>
                                        <p class="contentSick">Lang ben</p>
                                        <p class="contentSick">Da khô</p>
                                        <p class="contentSick">Mụn</p>
                                    </div>
                                    <div class="sick-text-content2">
                                        <p class="contentSick">
                                            U mềm treo</p>
                                        <p class="contentSick">
                                            Mụn cóc phẳng</p>
                                        <p class="contentSick">Lupus ban đỏ dạng đĩa</p>
                                        <p class="contentSick">Bệnh ấu trùng da di chuyển</p>
                                        <p class="contentSick">
                                            Viêm nang lông</p>
                                        <p class="contentSick">
                                            Ung thư tế bào hắc tố</p>
                                        <p class="contentSick">
                                            Mụn nhọt</p>
                                        <p class="contentSick">
                                            Rôm sảy</p>
                                        <p class="contentSick">
                                            Tàn nhang</p>
                                        <p class="contentSick">Hôi nách</p>
                                    </div>
                                </div>
                                <div class="sick-text-button">
                                    <i class="click-sick-skin fa-solid fa-angle-left"></i>
                                    <button class="click-sick-skin btn-sick">1</button>
                                    <button class="click-sick-skin2 btn-sick">2</button>
                                    <i class="click-sick-skin2 fa-solid fa-angle-right"></i>
                                </div>
                            </div>

                            <div class="out-sick-skin2 Sick-text-sick" style="display: none;">
                                <div class="sick-text-main">
                                    <div class="sick-text-content1">
                                        <p class="contentSick">Da bọng nước tự miễn Pemphigus</p>
                                        <p class="contentSick">Chân tay lạnh</p>

                                    </div>
                                    <div class="sick-text-content2">
                                        <p class="contentSick">
                                            Chốc lở</p>
                                        <p class="contentSick">Bỏng da</p>

                                    </div>
                                </div>
                                <div class="sick-text-button">
                                    <i class="click-sick-skin fa-solid fa-angle-left"></i>
                                    <button class="click-sick-skin btn-sick">1</button>
                                    <button class="click-sick-skin2 btn-sick">2</button>
                                    <i class="click-sick-skin2 fa-solid fa-angle-right"></i>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>


            </div>

        </div>
    </div>

    <jsp:include page="footer.jsp"></jsp:include>


</div>


<div class="contact-main">
    <div class="contact-button">
        <i class="fa-solid fa-phone fa-bounce" style="color: #0f63f5; font-size: 32px;"></i>
    </div>

    <div class="contact-box">
        <div class="contact-info">
            <a href="#" style="text-decoration: none;">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
                <h2>Thông tin liên lạc</h2>
                <h2>Email:</h2>
                <p style="color: #000;">LuuLongPhuoc@gamil.com</p>
                <h2>Số điện thoại:</h2>
                <p style="color: #000;">0162 ngày mai nói tiếp</p>
                <h2>Địa chỉ:</h2>
                <p style="color: #000;">Số 123,Tổ 3, Khu phố 6, Linh Trung, Thủ Đức, TP HCM</p>
            </a>
        </div>

    </div>
</div>
</body>

<script>
    $(document).ready(function () {

        // sick img click 

        $(".sick-item").click(function () {
            $(".sick-item").removeClass("color-sick-item");
            $(this).addClass("color-sick-item");
        });

        // head

        $(".click-sick-head").click(function () {
            $(".out-sick-head1").show();
            $(".out-sick-head2").hide();
            $(".out-sick-neck1").hide();
            $(".out-sick-chest1").hide();
            $(".out-sick-belly1").hide();
            $(".out-sick-belly2").hide();
            $(".out-sick-genital1").hide();
            $(".out-sick-limbs1").hide();
            $(".out-sick-skin1").hide();
            $(".out-sick-skin2").hide();
        });

        $(".click-sick-head2").click(function () {
            $(".out-sick-head2").show();
            $(".out-sick-head1").hide();
            $(".out-sick-neck1").hide();
            $(".out-sick-chest1").hide();
            $(".out-sick-belly1").hide();
            $(".out-sick-belly2").hide();
            $(".out-sick-genital1").hide();
            $(".out-sick-limbs1").hide();
            $(".out-sick-skin1").hide();
            $(".out-sick-skin2").hide();
        });

        // neck

        $(".click-sick-neck").click(function () {
            $(".out-sick-neck1").show();
            $(".out-sick-head1").hide();
            $(".out-sick-head2").hide();
            $(".out-sick-chest1").hide();
            $(".out-sick-belly1").hide();
            $(".out-sick-belly2").hide();
            $(".out-sick-genital1").hide();
            $(".out-sick-limbs1").hide();
            $(".out-sick-skin1").hide();
            $(".out-sick-skin2").hide();
        });

        // chest 

        $(".click-sick-chest").click(function () {
            $(".out-sick-head1").hide();
            $(".out-sick-head2").hide();
            $(".out-sick-neck1").hide();
            $(".out-sick-chest1").show();
            $(".out-sick-belly1").hide();
            $(".out-sick-belly2").hide();
            $(".out-sick-genital1").hide();
            $(".out-sick-limbs1").hide();
            $(".out-sick-skin1").hide();
            $(".out-sick-skin2").hide();
        });

        // belly

        $(".click-sick-belly").click(function () {
            $(".out-sick-head1").hide();
            $(".out-sick-head2").hide();
            $(".out-sick-neck1").hide();
            $(".out-sick-chest1").hide();
            $(".out-sick-belly1").show();
            $(".out-sick-belly2").hide();
            $(".out-sick-genital1").hide();
            $(".out-sick-limbs1").hide();
            $(".out-sick-skin1").hide();
            $(".out-sick-skin2").hide();
        });

        $(".click-sick-belly2").click(function () {
            $(".out-sick-head1").hide();
            $(".out-sick-head2").hide();
            $(".out-sick-neck1").hide();
            $(".out-sick-chest1").hide();
            $(".out-sick-belly1").hide();
            $(".out-sick-belly2").show();
            $(".out-sick-genital1").hide();
            $(".out-sick-limbs1").hide();
            $(".out-sick-skin1").hide();
            $(".out-sick-skin2").hide();
        });

        // genital

        $(".click-sick-genital").click(function () {
            $(".out-sick-head1").hide();
            $(".out-sick-head2").hide();
            $(".out-sick-neck1").hide();
            $(".out-sick-chest1").hide();
            $(".out-sick-belly1").hide();
            $(".out-sick-belly2").hide();
            $(".out-sick-genital1").show();
            $(".out-sick-limbs1").hide();
            $(".out-sick-skin1").hide();
            $(".out-sick-skin2").hide();
        });

        // limbs

        $(".click-sick-limbs").click(function () {
            $(".out-sick-head1").hide();
            $(".out-sick-head2").hide();
            $(".out-sick-neck1").hide();
            $(".out-sick-chest1").hide();
            $(".out-sick-belly1").hide();
            $(".out-sick-belly2").hide();
            $(".out-sick-genital1").hide();
            $(".out-sick-limbs1").show();
            $(".out-sick-skin1").hide();
            $(".out-sick-skin2").hide();
        });

        // skin

        $(".click-sick-skin").click(function () {
            $(".out-sick-head1").hide();
            $(".out-sick-head2").hide();
            $(".out-sick-neck1").hide();
            $(".out-sick-chest1").hide();
            $(".out-sick-belly1").hide();
            $(".out-sick-belly2").hide();
            $(".out-sick-genital1").hide();
            $(".out-sick-limbs1").hide();
            $(".out-sick-skin1").show();
            $(".out-sick-skin2").hide();
        });

        $(".click-sick-skin2").click(function () {
            $(".out-sick-head1").hide();
            $(".out-sick-head2").hide();
            $(".out-sick-neck1").hide();
            $(".out-sick-chest1").hide();
            $(".out-sick-belly1").hide();
            $(".out-sick-belly2").hide();
            $(".out-sick-genital1").hide();
            $(".out-sick-limbs1").hide();
            $(".out-sick-skin1").hide();
            $(".out-sick-skin2").show();
        });


        // end sick img click


        $(".contact-button").click(function (e) {
            e.stopPropagation(); // khi click vào body - phần này thì nó sẽ ẩn đi
            $(".contact-info").toggle();
        });

        $(document).click(function (e) {
            if (!$(e.target).closest('.contact-info').length) {
                $(".contact-info").hide();
            }
        });

        $(".contact-info").click(function (e) {
            e.stopPropagation();
        });

    });

</script>


</html>
