function addToCart(productId) {
    // Gửi yêu cầu không đồng bộ để thêm sản phẩm vào giỏ hàng
    $.ajax({
        type: "POST",
        url: "/cart",
        data: { productId: productId },
        success: function(sizeCart) {
            // Cập nhật số lượng sản phẩm trong giỏ hàng mà không làm mới trang
            $("#sizeCart").text(0);
        }
    });
}