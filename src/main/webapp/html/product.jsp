<%@ page import="model.Product" %>
<%@ page import="model.Review" %>
<%@ page import="model.User" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="../css/product.css">

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="../js/addToCart.js"></script>
    <link rel="stylesheet" href="../css/dialog.css">
    <title>Chi Tiết Sản Phẩm</title>
</head>
<body>
<div class="page">
    <jsp:include page="header.jsp"></jsp:include>

    <%
        Product product = (Product) request.getAttribute("productDetail");
        List<Product> ListProdcutRelated = (List) request.getAttribute("getProductRelated");
        List<Review> reviews = (List<Review>) request.getAttribute("reviews");
        Double avgRatingObj = (Double) request.getAttribute("avgRating");
        double avgRating = avgRatingObj != null ? avgRatingObj : 0.0;
        Integer reviewCountObj = (Integer) request.getAttribute("reviewCount");
        int reviewCount = reviewCountObj != null ? reviewCountObj : 0;
        Boolean hasPurchasedObj = (Boolean) request.getAttribute("hasPurchased");
        boolean hasPurchased = hasPurchasedObj != null ? hasPurchasedObj : false;
        User loggedInUser = (User) session.getAttribute("user");
    %>

    <div class="product-container">
        <div class="product-info">
            <div class="col-9">
                <div class="left-slide">
                    <div class="product-left">
                        <div class="product-left-big-images">

                            <img src="<%=product.getPathFirstImage(request.getServletContext().getRealPath(""))%>"
                                 alt="">
                        </div>
                        <div class="product-left-small-images" onclick="changeBigImage(event)">
                            <%--                            <img src="../image/product/may-tao-oxi1.jpg" alt="">--%>
                            <%--                            <img src="../image/product/may-tao-oxi2.jpg" alt="">--%>
                            <%--                            <img src="../image/product/may-tao-oxi3.jpg" alt="">--%>
                            <%--                            <img src="../image/product/may-oxi.jpg" alt="">--%>
                            <%--                            <img src="../image/product/may-tao-oxi3.jpg" alt="">--%>

                            <%

                                int numberImg = (int) request.getAttribute("numberImg");
                                for (String path : product.getPathImage(request.getServletContext().getRealPath(""))) {

                            %>


                            <img src="<%=path%>" alt="" style="max-width: 100%; max-height: 100%;  height: auto; width: auto">

                            <%
                                }
                            %>

                        </div>
                    </div>
                    <div class="product-details">
                        <%--                        <h1 class="product-title">Máy tạo oxy xách tay 5 lít Dynmed POC5</h1>--%>
                        <h1 class="product-title"><%=product.getName()%>
                        </h1>
                        <%--                        <div class="product-description">--%>
                        <%--                            <span class="title">Mã sản phẩm:</span>--%>
                        <%--                            <span class="info">--%>
                        <%--                                        <span title="Mã sản phẩm">A2324</span>--%>
                        <%--                                    </span>--%>
                        <%--                        </div>--%>
                        <div class="product-description">
                            <span class="title">Thương hiệu:</span>
                            <span class="info">
                                        <span title="Thương hiệu"><%=product.getTrademark()%></span>
                                    </span>
                        </div>
                        <div class="product-description">
                            <span class="title">Sản xuất:</span>
                            <span class="info">
                                        <span title="Sản xuất"><%=product.getOriginID()%></span>
                                    </span>
                        </div>
                        <%--                        <div class="product-description">--%>
                        <%--                            <span class="title">Bảo hành:</span>--%>
                        <%--                            <span class="info">--%>
                        <%--                                        <span title="Đơn vị tính">24 tháng</span>--%>
                        <%--                                    </span>--%>
                        <%--                        </div>--%>
                        <div class="product-description">
                            <span class="title">Mô tả ngắn: </span>
                            <span class="info-des">
                                        <span title="Mô tả ngắn"><%=product.getContent()%></span>
                                    </span>
                        </div>

                        <div class="product-price-box">
                            <div class="row gx-0">
                                <div class="col-4">
                                    <h2 class="text-primary-green"
                                        style="white-space: nowrap"><%=product.getPriceHaveDots()%>
                                    </h2>
                                    <span class="saving">Tiết kiệm: <span class="text-red"
                                                                          style="white-space: nowrap"><%=product.getSaleHaveDots()%></span></span>
                                </div>
                                <div class="col-4">
                                    <span class="origin-price"
                                          style="white-space: nowrap"><%=product.getRealPriceHaveDots()%></span>
                                </div>
                            </div>
                        </div>
                            <button type="button" class="add-to-cart-btn  mt-3" onclick="addToCart(event, <%=product.getProductID()%>)">
                                <div class="col-2">
                                    <i class="fas fa-shopping-cart cart-icon"></i>
                                </div>
                                <div class="col-10">
                                    <span class="fw-bold">Thêm vào giỏ hàng</span><br>
                                </div>
                            </button>
                        <div class="sale-box">
                            <div class="sale-title bg-primary-green">
                                <i class="fa-solid fa-gift" style="font-size: 25px;"></i> Khuyến mãi đặc biệt !!!
                            </div>
                        </div>
                        <div class="sale-detail border-s-r-5">
                            <div class="d-flex align-items-center">
                                <i class="fa-solid fa-check text-primary-green p-2 fs-2"></i>
                                <span>Áp dụng Phiếu quà tặng/ Mã giảm giá theo ngành hàng.</span>
                            </div>
                            <div class="d-flex align-items-center">
                                <i class="fa-solid fa-check text-primary-green p-2 fs-2"></i>
                                <span>Giảm giá 25% khi mua từ 2 sản phẩm trở lên có giá trị hóa đơn 7.000.000₫.</span>
                            </div>
                            <div class="d-flex align-items-center">
                                <i class="fa-solid fa-gifts text-primary-green p-1 fs-2"></i>
                                <span>Tặng ngay 1 voucher có trị giá từ 150.000₫ trên Shopee, Lazada, Tiki khi thanh toán hóa đơn từ 1.300.000₫ qua VNPay, ZaloPay.</span>
                            </div>
                        </div>
                    </div>

                    <div class="product-contents mt4">
                        <%--                        <button id="show-info-btn" class="btn-info">THÔNG TIN SẢN PHẨM</button>--%>
                        <%--                        <button id="show-spec-btn" class="btn-spec">THÔNG SỐ KỸ THUẬT</button>--%>
                        <%--                        <button id="show-manual-btn" class="btn-manual">HƯỚNG DẪN SỬ DỤNG</button>--%>
                        <%--                        <button id="show-warranty-policy-btn" class="btn-warranty">CHÍNH SÁCH BẢO HÀNH</button>--%>
                        <%--                        <div class="description-info">--%>
                        <%--                            <h2>Giới thiệu máy tạo oxy xách tay 5 lít Dynmed POC5</h2>--%>
                        <%--                            <p>--%>
                        <%--                                <strong>Máy tạo oxy xách tay 5L Dynmed POC5</strong>--%>
                        <%--                                cung cấp oxy ổn định mỗi phút theo sự thay đổi liên tục của nhịp thở,--%>
                        <%--                                mang đến hiệu quả trị liệu tối ưu đối với bệnh nhân mắc các bệnh về đường hô hấp, người--%>
                        <%--                                lớn tuổi và--%>
                        <%--                                những người được chỉ định cần tiếp nhận oxy bổ sung.--%>
                        <%--                            </p>--%>
                        <%--                            <p class="images-info">--%>
                        <%--                                <img src="../image/product/may-oxi.jpg" alt="">--%>
                        <%--                            </p>--%>
                        <%--                            <p class="name-images-info">Máy tạo oxy xách tay 5 lít Dynmed POC5</p>--%>
                        <%--                            <p>Người dùng có thể tùy chỉnh <strong>3 chế độ</strong> sử dụng gồm chế độ xung, chế độ tần--%>
                        <%--                                số không đổi--%>
                        <%--                                và chế độ cao nguyên dùng được ở cả độ cao đến 6000m.--%>
                        <%--                                Với nồng độ oxy tinh khiết luôn đạt 93% ± 3% và lưu lượng dòng chảy lên đến 5L/phút,--%>
                        <%--                                người dùng có thể an tâm trị liệu hiệu quả khi sử dụng--%>
                        <%--                                <strong> máy tạo oxy xách tay Dynmed POC5.</strong>--%>
                        <%--                            </p>--%>
                        <%--                            <p class="images-info">--%>
                        <%--                                <img src="../image/product/thong-tin-may-oxi.jpg" alt="">--%>
                        <%--                            </p>--%>
                        <%--                            <p>--%>
                        <%--                                <strong>Máy tạo oxy 5 lít Dynmed POC5 </strong>--%>
                        <%--                                còn được thiết kế với các tính năng an toàn nâng cao,--%>
                        <%--                                phát báo động khi phát hiện lỗi trong quá trình sử dụng, đảm bảo an toàn cho người dùng.--%>
                        <%--                                Màn hình cảm ứng 3,5 inch hiển thị thông số rõ nét, dễ dàng tùy chỉnh và theo dõi.--%>
                        <%--                            </p>--%>
                        <%--                        </div>--%>
                    <!-- Bắt đầu phần đánh giá sản phẩm -->
                    <div class="product-reviews-section" style="margin-top: 30px; padding: 20px; background: #fff; border-radius: 8px; border: 1px solid #e0e0e0;">
                        <h3 style="font-size: 20px; font-weight: bold; border-bottom: 2px solid #00a046; padding-bottom: 10px; margin-bottom: 20px; color: #333;">Đánh giá & Bình luận sản phẩm</h3>
                        
                        <!-- Thống kê tổng quan -->
                        <div class="reviews-summary" style="display: flex; align-items: center; gap: 20px; margin-bottom: 25px; background: #f9f9f9; padding: 15px; border-radius: 6px;">
                            <div style="text-align: center; border-right: 1px solid #e0e0e0; padding-right: 20px;">
                                <span style="font-size: 36px; font-weight: bold; color: #00a046;"><%= String.format("%.1f", avgRating) %></span>
                                <span style="font-size: 16px; color: #666;">/ 5</span>
                            </div>
                            <div>
                                <div style="color: #ff9800; font-size: 18px; margin-bottom: 5px;">
                                    <% 
                                        int fullStars = (int) Math.round(avgRating);
                                        for (int i = 1; i <= 5; i++) {
                                            if (i <= fullStars) {
                                    %>
                                                <i class="fa-solid fa-star"></i>
                                    <% 
                                            } else {
                                    %>
                                                <i class="fa-regular fa-star"></i>
                                    <% 
                                            }
                                        }
                                    %>
                                </div>
                                <span style="color: #666; font-size: 14px;"><%= reviewCount %> lượt đánh giá</span>
                            </div>
                        </div>

                        <!-- Danh sách đánh giá -->
                        <div class="reviews-list" style="margin-bottom: 30px;">
                            <% 
                                if (reviews == null || reviews.isEmpty()) {
                            %>
                                <p style="color: #777; font-style: italic;">Chưa có đánh giá nào cho sản phẩm này.</p>
                            <% 
                                } else {
                                    for (Review r : reviews) {
                            %>
                                        <div class="review-item" style="border-bottom: 1px solid #f0f0f0; padding: 15px 0;">
                                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 5px;">
                                                <span style="font-weight: bold; color: #333;"><%= r.getFullName() %></span>
                                                <span style="font-size: 12px; color: #999;"><%= r.getDateAdded() %></span>
                                            </div>
                                            <div style="color: #ff9800; font-size: 14px; margin-bottom: 8px;">
                                                <% 
                                                    for (int i = 1; i <= 5; i++) {
                                                        if (i <= r.getRating()) {
                                                %>
                                                            <i class="fa-solid fa-star"></i>
                                                <% 
                                                        } else {
                                                %>
                                                            <i class="fa-regular fa-star"></i>
                                                <% 
                                                        }
                                                    }
                                                %>
                                            </div>
                                            <p style="color: #555; margin: 0; line-height: 1.5;"><%= r.getContent() %></p>
                                        </div>
                            <% 
                                    }
                                }
                            %>
                        </div>

                        <!-- Form gửi đánh giá -->
                        <div class="add-review-form" style="border-top: 1px solid #e0e0e0; padding-top: 20px;">
                            <h4 style="font-size: 16px; font-weight: bold; margin-bottom: 15px; color: #333;">Gửi đánh giá của bạn</h4>
                            <% 
                                if (loggedInUser == null) {
                            %>
                                <div style="background: #fff8e1; border: 1px solid #ffe082; padding: 12px; border-radius: 4px; color: #b78103;">
                                    Bạn cần <a href="login.jsp" style="font-weight: bold; color: #00a046; text-decoration: underline;">Đăng nhập</a> để gửi đánh giá cho sản phẩm này.
                                </div>
                            <% 
                                } else if (!hasPurchased) {
                            %>
                                <div style="background: #ffebee; border: 1px solid #ffcdd2; padding: 12px; border-radius: 4px; color: #c62828;">
                                    Bạn chỉ có thể đánh giá sản phẩm này sau khi đã mua hàng thành công.
                                </div>
                            <% 
                                } else {
                            %>
                                <form action="add-review" method="POST">
                                    <input type="hidden" name="productID" value="<%= product.getProductID() %>">
                                    
                                    <div style="margin-bottom: 15px;">
                                        <label for="rating" style="display: block; font-weight: bold; margin-bottom: 5px; color: #555;">Chọn mức độ đánh giá:</label>
                                        <select name="rating" id="rating" style="padding: 8px 12px; border-radius: 4px; border: 1px solid #ccc; background: #fff; width: 200px;">
                                            <option value="5">5 Sao (Rất tốt)</option>
                                            <option value="4">4 Sao (Tốt)</option>
                                            <option value="3">3 Sao (Bình thường)</option>
                                            <option value="2">2 Sao (Tệ)</option>
                                            <option value="1">1 Sao (Rất tệ)</option>
                                        </select>
                                    </div>
                                    
                                    <div style="margin-bottom: 15px;">
                                        <label for="content" style="display: block; font-weight: bold; margin-bottom: 5px; color: #555;">Nội dung bình luận:</label>
                                        <textarea name="content" id="content" rows="4" style="width: 100%; padding: 10px; border-radius: 4px; border: 1px solid #ccc; resize: vertical;" placeholder="Chia sẻ nhận xét của bạn về sản phẩm này..." required></textarea>
                                    </div>
                                    
                                    <button type="submit" style="background: #00a046; color: #fff; border: none; padding: 10px 20px; border-radius: 4px; font-weight: bold; cursor: pointer; transition: background 0.2s;">
                                        Gửi đánh giá
                                    </button>
                                </form>
                            <% 
                                }
                            %>
                        </div>
                    </div>
                    <!-- Kết thúc phần đánh giá sản phẩm -->

                        <div class="relative-product">
                            <div class="group_title mt-5">
                                <div class="title-relative">
                                    <a class="title-name" href=" ">Sản phẩm liên quan</a>
                                </div>
                                <%--                                <div class="button-control">--%>
                                <%--                                    <div class="btn-green btn-small disabled">--%>
                                <%--                                        <i class="fa-solid fa-chevron-left fa-chevron"></i>--%>
                                <%--                                    </div>--%>
                                <%--                                    <div class="btn-green btn-small">--%>
                                <%--                                        <i class="fa-solid fa-chevron-right fa-chevron"></i>--%>
                                <%--                                    </div>--%>
                                <%--                                </div>--%>
                            </div>

                            <div class="card-deck d-flex mr-child-20">
                                <%
                                    for (Product related : ListProdcutRelated) {
                                %>
                                <div class="card radius-green">
                                    <div style="width: 250px;height: 250px">

                                        <img src="<%=related.getPathFirstImage(request.getServletContext().getRealPath(""))%>"
                                             alt=""
                                             style="max-width: 100%;max-height: 100%;width: auto;">
                                    </div>

                                    <div class="card-body">
                                        <h3 class="card-title"
                                            style="width: 226px; /* Đặt chiều rộng tùy ý */ white-space: nowrap; /* Ngăn văn bản xuống dòng */ overflow: hidden; /* Ẩn phần vượt quá độ rộng */text-overflow: ellipsis; ">
                                            <a href="product-detail?id=<%=related.getProductID()%>"
                                               style="width: 200px">
                                                <%=related.getName()%>
                                            </a>
                                        </h3>
                                        <div class="card-text">
                                            <div class="price-box">
                                                <%=related.getPriceHaveDots()%>
                                                <span class="price-compare">
                                                        <%=related.getRealPriceHaveDots()%>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>


                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div class="col-3">
                <div class="right-slide">
                    <div class="box-t">
                        <h4 class="title-text">Chính sách cửa hàng</h4>
                        <div class="d-flex align-items-center mt-3">
                            <img src="../image/product/freeship.png" width="40" height="40" alt="Hình ảnh"
                                 class="blue-filter">
                            <div class="text-group">
                                <h6>Miễn phí vận chuyển</h6>
                                <span>Trong nội thành Hồ Chí Minh.</span>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mt-3">
                            <img src="../image/product/freeship.png" width="40" height="40" alt="Hình ảnh"
                                 class="blue-filter">
                            <div class="text-group">
                                <h6>Miễn phí vận chuyển</h6>
                                <span>Trên toàn quốc cho đơn hàng từ 1.500.000₫.</span>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mt-3">
                            <i class="fa-solid fa-repeat"></i>
                            <div class="text-group">
                                <h6>Miễn phí đổi trả</h6>
                                <span>Cho sản phẩm có lỗi khi vận chuyển.</span>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mt-3">
                            <i class="fa-solid fa-repeat"></i>
                            <div class="text-group">
                                <h6>Miễn phí đổi trả</h6>
                                <span>Sản phẩm có lỗi từ nhà sản xuất theo quy định trong chính sách bảo hành.</span>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mt-3">
                            <i class="fa-solid fa-phone"></i>
                            <div class="text-group">
                                <h6>Liên hệ hỗ trợ, tư vấn</h6>
                                <span>0238.312.523 - 0248.636.917</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp"></jsp:include>

</div>


<div id="cartDialog" class="modal-cart" style="display: none;">
    <div class="modal-cart-content">
        <span class="close-dialog" onclick="closeCartDialog()">&times;</span>
        <div class="modal-cart-body">
            <div class="icon-success">✓</div>
            <p>Đã thêm sản phẩm vào giỏ hàng thành công!</p>
        </div>
        <div class="modal-cart-footer">
            <button class="btn-continue" onclick="closeCartDialog()">Tiếp tục mua sắm</button>
            <a href="carts" class="btn-go-to-cart">Xem giỏ hàng</a>
        </div>
    </div>
</div>


<script>
    function changeBigImage(event) {
        if (event.target.tagName === 'IMG') {
            var bigImage = document.getElementById('bigImage');
            bigImage.src = event.target.src;
        }
    }

    // Lấy danh sách các small images
    var smallImages = document.querySelectorAll('.product-left-small-images img');
    var bigImage = document.querySelector('.product-left-big-images img');
    var currentImageIndex = 0;

    // Hàm chuyển hình ảnh
    function changeImage() {
        bigImage.src = smallImages[currentImageIndex].src;
        currentImageIndex = (currentImageIndex + 1) % smallImages.length;
    }

    // Tự động chuyển hình ảnh sau một khoảng thời gian
    var imageInterval = setInterval(changeImage, 3000); // Thay đổi hình sau mỗi 3 giây

    // Hàm giảm số lượng
    var allowFunctions = true;

    function decreaseQuantity() {
        // Kiểm tra xem có nên thực hiện chức năng hay không
        if (allowFunctions) {
            var quantityInput = document.getElementById("quantity");
            var currentQuantity = parseInt(quantityInput.value);
            if (currentQuantity > 1) {
                quantityInput.value = currentQuantity - 1;
            }
        }
    }

    function increaseQuantity() {
        // Kiểm tra xem có nên thực hiện chức năng hay không
        if (allowFunctions) {
            var quantityInput = document.getElementById("quantity");
            var currentQuantity = parseInt(quantityInput.value);
            quantityInput.value = currentQuantity + 1;
        }
    }
</script>

</body>
</html>