function addToCart(event, productId) {

    // CHẶN NGAY LẬP TỨC hành vi lan truyền sự kiện lên thẻ <a> cha
    event.stopPropagation();
    // Nếu nút nằm trong form cũ hoặc có hành vi mặc định nào khác, chặn luôn cho chắc chắn
    event.preventDefault();

    var currentPath = window.location.pathname;
    var contextPath = currentPath.substring(0, currentPath.indexOf('/html'));

    // Tạo URL chính xác tuyệt đối gửi về Controller
    var finalUrl = window.location.origin + contextPath + "/html/carts";
    $.ajax({
        type: "POST",
        url: finalUrl,
        data: { productId: productId },
        success: function(sizeCart) {
            $("#sizeCart").text(sizeCart);
            alert("Đã thêm sản phẩm vào giỏ hàng thành công!");
        },
        error: function(xhr) {
            // Trường hợp xảy ra lỗi từ phía Server trả về
            if (xhr.status === 401) {
                // Nhận diện lỗi 401 (Chưa đăng nhập) -> Thông báo và lập tức chuyển hướng
                alert("Bạn cần phải đăng nhập để thêm sản phẩm vào giỏ hàng!");
                window.location.href = "login.jsp";
            } else {
                // Các lỗi hệ thống khác nếu có (ví dụ 500, 404, 400)
                alert("Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau!");
            }
        }
    });
}