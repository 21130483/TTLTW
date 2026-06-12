<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Nhà Thuốc</title>

    <link rel="stylesheet" href="../css/home.css">
    <link rel="stylesheet" href="../css/billdetail.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"></script>
    <style>
        .btn-cancel-order {
            background-color: transparent;
            color: #dc3545;
            border: 1.5px solid #dc3545;
            padding: 8px 20px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.25s ease;
            outline: none;
        }
        .btn-cancel-order:hover {
            background-color: #dc3545;
            color: #fff;
            box-shadow: 0 4px 10px rgba(220, 53, 69, 0.25);
            transform: translateY(-1px);
        }
        .btn-cancel-order:active {
            transform: translateY(0);
        }

        /* Modal Overlay */
        .cancel-modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(4px);
            z-index: 1050;
            justify-content: center;
            align-items: center;
            animation: fadeIn 0.2s ease-out;
        }
        .cancel-modal-overlay.active {
            display: flex;
        }

        /* Modal Box */
        .cancel-modal-content {
            background-color: #fff;
            width: 90%;
            max-width: 500px;
            border-radius: 16px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            animation: slideUp 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            overflow: hidden;
            border: 1px solid #e2e8f0;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        /* Header */
        .cancel-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 24px;
            border-bottom: 1px solid #edf2f7;
            background-color: #f8fafc;
        }
        .cancel-modal-header h3 {
            margin: 0;
            font-size: 18px;
            color: #0f172a;
            font-weight: 700;
        }
        .btn-cancel-close {
            background: none;
            border: none;
            font-size: 28px;
            color: #94a3b8;
            cursor: pointer;
            transition: color 0.2s;
            line-height: 1;
            padding: 0;
        }
        .btn-cancel-close:hover {
            color: #475569;
        }

        /* Body */
        .cancel-modal-body {
            padding: 24px;
        }

        /* Options */
        .cancel-reason-options {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 12px;
        }
        .reason-option {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 14px;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.2s ease;
            user-select: none;
            text-align: left;
            margin-bottom: 0;
        }
        .reason-option:hover {
            background-color: #f8fafc;
            border-color: #cbd5e1;
        }
        .reason-option input[type="radio"] {
            margin: 0;
            width: 16px;
            height: 16px;
            cursor: pointer;
        }
        .reason-option span {
            font-size: 14px;
            color: #334155;
            font-weight: 500;
        }

        /* Footer */
        .cancel-modal-footer {
            display: flex;
            gap: 12px;
            padding: 16px 24px;
            border-top: 1px solid #edf2f7;
            justify-content: flex-end;
            background-color: #f8fafc;
        }
        .btn-modal {
            padding: 10px 22px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
        }
        .btn-modal-back {
            background-color: #e2e8f0;
            color: #475569;
        }
        .btn-modal-back:hover {
            background-color: #cbd5e1;
        }
        .btn-modal-confirm {
            background-color: #dc3545;
            color: #fff;
        }
        .btn-modal-confirm:hover {
            background-color: #bb2d3b;
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.25);
        }
    </style>
</head>

<body>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="dao.PurchasesDAO" %>
<%
    User user = (User) session.getAttribute("user");
    List<Integer> productList = (List<Integer>) request.getAttribute("getProductId");
    Purchases purchases = (Purchases) request.getAttribute("getPurchase");
    int quantity = 0;
%>


<jsp:include page="header.jsp"></jsp:include>
<div class="page">

    <div class="noi-dung">
        <div class="container">
            <div class="account-info">
                <div class="avatar_box">
                    <div class="avatar">
                        <i class="fa-solid fa-user"></i>
                    </div>
                    <%=user.getFullName()%>
                </div>
                <ul>
                    <a href="account">
                        <li class="menu_account ">
                            <i class="fa-solid fa-user"></i>
                            Thông tin cá nhân
                        </li>
                    </a>

                    <a href="listbill?status=all">
                        <li class="menu_account choose">
                            <i class="fa-solid fa-clipboard-list"></i>
                            Lịch sử mua
                        </li>
                    </a>

                    <a href="">
                        <li class="menu_account">
                            <i class="fa-solid fa-heart"></i>
                            Sản phẩm yêu thích
                        </li>
                    </a>

                    <%
                        if (user.getRole() == true) {
                    %>
                    <a href="admin?page=product">
                        <li class="menu_account">
                            <i class="fa-solid fa-wrench"></i>
                            Quản lý trang web
                        </li>
                    </a>
                    <%
                        }
                    %>

                    <a href="login">
                        <li class="menu_account">
                            <i class="fa-solid fa-arrow-right-from-bracket"></i>
                            Đăng xuất
                        </li>
                    </a>



                </ul>
            </div>

            <div class="account-noidung">
                <div class="title">
                    Chi tiết hóa đơn
                </div>

                <div class="content">
                    <div class="infor_bill">
                        <div class="address">
                            <div class="title">
                                Địa chỉ nhận hàng
                            </div>
                            105B Nguyễn Ái Quốc, Khu phố 8, Phường Tân Phong, TP Biên Hòa, Tỉnh Đồng Nai
                        </div>

                        <div class="date">
                            <div class="title">
                                Thời gian đặt hàng
                            </div>
                            <%=purchases.getDateOrderString()%>
                        </div>

                    </div>

                    <div class="list_product">
                        <div class="name">
                            Sản phẩm đã mua
                        </div>

                        <%
                            for (Integer i : productList) {
                                ProductDAO productDAO = new ProductDAO();
                                Product product = productDAO.getProductById(i);
                                int productQuantity = PurchasesDAO.getQuantityByPurchaseIdAndProductID(purchases.getPurchaseID(),product.getProductID());
                                quantity +=productQuantity;

                        %>

                        <a href="product-detail?id=<%=product.getProductID()%>">
                            <div class="product">
                                <div class="img_name">
                                    <img src="<%=product.getPathFirstImage(request.getServletContext().getRealPath(""))%>" alt="">
                                    <%=product.getName()%>
                                </div>
                                <div class="quantity">
                                    Số lượng : <%=productQuantity%>
                                </div>

                                <div class="price">
                                    6.000 ₫
                                </div>
                            </div>
                        </a>

                        <%
                            }
                        %>


                    </div>

                    <div class="price_bill">
                        <div class="name">
                            Chi tiết thanh toán
                        </div>

                        <div class="detail">
                            <div class="name_price">
                                Tiền hàng
                            </div>
                            <div class="price">
                                <%=purchases.getTotalPriceHaveDots()%>
                            </div>

                            <div class="name_price">
                                Phí vận chuyển
                            </div>
                            <div class="price">
                                25.000 ₫
                            </div>

                            <div class="name_price" style="font-weight: 500; color: #475569;">
                                Phương thức thanh toán
                            </div>
                            <div class="price" style="font-weight: 500; color: #1e293b;">
                                <%=purchases.getPaymentMethodString()%>
                            </div>

                            <div class="name_price" style="font-weight: 500; color: #475569;">
                                Trạng thái thanh toán
                            </div>
                            <div class="price" style="font-weight: 500; color: #1e293b;">
                                <%=purchases.getPaymentStatusString()%>
                            </div>

                            <% if (purchases.getStatus() == -1 && purchases.getCancelReason() != null) { %>
                                <div class="name_price" style="color: #dc3545; font-weight: bold;">
                                    Lý do hủy đơn hàng
                                </div>
                                <div class="price" style="color: #dc3545; font-weight: bold;">
                                    <%=purchases.getCancelReason()%>
                                </div>
                            <% } %>
                        </div>

                        <div class="total">
                            <div class="name_price">
                                Tổng tiền (<%=quantity%> sản phẩm)
                            </div>
                            <div class="price">
                                <%=purchases.getTotalPriceHaveDotsHaveDelivery()%>
                            </div>
                        </div>

                        <% if (purchases.getStatus() == 0 && purchases.getPaymentStatus() == 0) { %>
                            <div class="cancel_order_section" style="margin-top: 20px; display: flex; justify-content: flex-end;">
                                <button class="btn-cancel-order" onclick="openCancelModal(event, '<%=purchases.getPurchaseID()%>')">Hủy đơn hàng</button>
                            </div>
                        <% } %>
                    </div>
                </div>


            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
<!-- Cancel Order Modal -->
<div id="cancelOrderModal" class="cancel-modal-overlay">
    <div class="cancel-modal-content">
        <div class="cancel-modal-header">
            <h3>Hủy Đơn Hàng</h3>
            <button class="btn-cancel-close" onclick="closeCancelModal()">&times;</button>
        </div>
        <div class="cancel-modal-body">
            <p style="font-size: 14px; color: #4a5568; margin-bottom: 15px; text-align: left;">
                Vui lòng chọn lý do bạn muốn hủy đơn hàng này:
            </p>
            <input type="hidden" id="cancelPurchaseID" value="">
            <div class="cancel-reason-options">
                <label class="reason-option">
                    <input type="radio" name="cancelReasonOpt" value="Thay đổi địa chỉ / số điện thoại nhận hàng" checked onclick="selectReasonOption(this)">
                    <span>Thay đổi địa chỉ / số điện thoại nhận hàng</span>
                </label>
                <label class="reason-option">
                    <input type="radio" name="cancelReasonOpt" value="Muốn thay đổi sản phẩm trong đơn hàng" onclick="selectReasonOption(this)">
                    <span>Muốn thay đổi sản phẩm trong đơn hàng</span>
                </label>
                <label class="reason-option">
                    <input type="radio" name="cancelReasonOpt" value="Tìm thấy giá rẻ hơn ở nơi khác" onclick="selectReasonOption(this)">
                    <span>Tìm thấy giá rẻ hơn ở nơi khác</span>
                </label>
                <label class="reason-option">
                    <input type="radio" name="cancelReasonOpt" value="Thời gian giao hàng quá lâu" onclick="selectReasonOption(this)">
                    <span>Thời gian giao hàng quá lâu</span>
                </label>
                <label class="reason-option">
                    <input type="radio" name="cancelReasonOpt" value="other" onclick="selectReasonOption(this)">
                    <span>Khác (nhập chi tiết bên dưới)</span>
                </label>
            </div>
            <textarea id="cancelReasonText" placeholder="Nhập lý do hủy chi tiết của bạn..." style="display: none; width: 100%; margin-top: 10px; padding: 10px; border: 1.5px solid #cbd5e1; border-radius: 8px; font-size: 14px; min-height: 80px; box-sizing: border-box; resize: vertical; outline: none; transition: border-color 0.2s;"></textarea>
        </div>
        <div class="cancel-modal-footer">
            <button class="btn-modal btn-modal-back" onclick="closeCancelModal()">Quay lại</button>
            <button class="btn-modal btn-modal-confirm" onclick="submitCancelOrder()">Xác nhận hủy</button>
        </div>
    </div>
</div>

<script>
    function openCancelModal(event, purchaseID) {
        if (event) {
            event.preventDefault();
            event.stopPropagation();
        }
        document.getElementById('cancelPurchaseID').value = purchaseID;
        document.getElementById('cancelOrderModal').classList.add('active');
        
        // Reset inputs
        const radios = document.getElementsByName('cancelReasonOpt');
        if (radios.length > 0) {
            radios[0].checked = true;
        }
        document.getElementById('cancelReasonText').style.display = 'none';
        document.getElementById('cancelReasonText').value = '';
    }

    function closeCancelModal() {
        document.getElementById('cancelOrderModal').classList.remove('active');
    }

    function selectReasonOption(radio) {
        const textSection = document.getElementById('cancelReasonText');
        if (radio.value === 'other') {
            textSection.style.display = 'block';
            textSection.focus();
        } else {
            textSection.style.display = 'none';
        }
    }

    function submitCancelOrder() {
        const purchaseID = document.getElementById('cancelPurchaseID').value;
        let reason = '';
        
        const selectedRadio = document.querySelector('input[name="cancelReasonOpt"]:checked');
        if (!selectedRadio) {
            alert("Vui lòng chọn lý do hủy đơn!");
            return;
        }
        
        if (selectedRadio.value === 'other') {
            reason = document.getElementById('cancelReasonText').value.trim();
            if (reason === '') {
                alert("Vui lòng nhập lý do hủy chi tiết!");
                return;
            }
        } else {
            reason = selectedRadio.value;
        }
        
        const params = new URLSearchParams();
        params.append('purchaseID', purchaseID);
        params.append('reason', reason);
        
        fetch('listbill?action=cancel', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: params
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                closeCancelModal();
                // Since we canceled it, let's redirect to listbill page
                location.href = 'listbill?status=all';
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert("Có lỗi xảy ra khi thực hiện hủy đơn hàng.");
        });
    }
</script>
</body>
</html>