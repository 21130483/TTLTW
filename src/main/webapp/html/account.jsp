<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Nhà Thuốc</title>

    <link rel="stylesheet" href="../css/account.css">
    <link rel="stylesheet" href="../css/contact.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" /> -->
    <%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"--%>
    <%--          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">--%>
    <%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"--%>
    <%--            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"--%>
    <%--            crossorigin="anonymous"></script>--%>
</head>

<body>


<div class="page">
    <%
        User user = (User) session.getAttribute("user");
    %>
    <%@ page import="model.Account" %>
    <%@ page import="model.Order" %>
    <%@ page import="java.util.List" %>
    <%@ page import="model.Product" %>
    <%
        Account acInfo = (Account) request.getSession().getAttribute("accountInfo");
        String status = request.getParameter("status");
        String field = request.getParameter("field");
        Object ordersObject = request.getSession().getAttribute("orders");
        List<Order> orders = null;
        if (ordersObject != null) {
            orders = (List<Order>) ordersObject;
        }
        if (field == null)
            field = "";
        String note = "";
        if (status != null) {
            switch (status) {
                case "success":
                    note = "Cập nhật thông tin thành công";
                    break;
                case "failed":
                    note = "Cập nhật thông tin không thành công";
                    break;
                case "failed-0":
                    note = "Lỗi thông tin nhập vào";
                    break;
                case "failed-1":
                    note = "Thông tin không khớp";
                    break;
                default:
                    note = "Có lỗi";
                    break;
            }
        } else {
            note = "";
        }
    %>


    <jsp:include page="header.jsp"></jsp:include>


    <div class="noi-dung">
        <div id="main-content">
            <!-- <div>
                <div class="container">
                    <nav>
                        <ol class="Breadcrumbs">
                            <li class="Breadcrumbs-item">
                                <a href="#">
                                    <span>Pharmacity</span>
                                </a>
                                <meta itemprop="position" content="1">
                            </li>
                            <li class="Breadcrumbs-item">
                                <a href="#">
                                    <span>Trang cá nhân</span>
                                </a>
                                <meta itemprop="position" content="1">
                            </li>
                            <li class="Breadcrumbs-item common-bre">
                                <a href="#">
                                    <span>Chỉnh sửa thông tin cá nhân</span>
                                </a>
                                <meta itemprop="position" content="1">
                            </li>
                        </ol>
                    </nav>
                </div>
            </div> -->

            <div class="Desktop-account">
                <div class="container">
                    <div class="Desktop-box">
                        <div class="Desktop-anpha">
                            <div class="AccountMenu">
                                <div class="Account-head" style="background: rgb(170, 124, 13);">
                                    <div class="AvtAndName">
                                        <i class="imgAvtName fa-regular fa-user"></i>
                                        <%
                                            if (user.getRole() == false) {
                                        %>
                                        <div class="fullName">Khach Hang</div>
                                        <%
                                            }
                                        %>
                                        <%
                                            if (user.getRole() == true) {
                                        %>
                                        <div class="fullName">Admin</div>
                                        <%
                                            }
                                        %>

                                    </div>

                                </div>
                                <div class="Account-box">
                                    <ul>
                                        <div class="history">
                                            <li class="list">
                                                <i class="icon-common fa-solid fa-clock-rotate-left"></i>
                                                <h3 class="AccountMenu-menu-label">Lịch sử đơn hàng</h3>
                                            </li>
                                        </div>

                                        <div class="voucher">
                                            <li class="list">
                                                <i class=" icon-common fa-solid fa-ticket-simple"></i>
                                                <h3 class="AccountMenu-menu-label">Mã giảm giá</h3>

                                            </li>
                                        </div>

                                        <div class="desgin">
                                            <li class="list">
                                                <i class=" icon-common fa-solid fa-user-pen"></i>
                                                <h3 class="AccountMenu-menu-label">Chỉnh sửa thông tin cá nhân</h3>

                                            </li>
                                        </div>

                                        <div class="addresser">
                                            <li class="list">
                                                <i class="icon-common fa-solid fa-location-dot"></i>
                                                <h3 class="AccountMenu-menu-label">Sổ địa chỉ nhận hàng</h3>

                                            </li>
                                        </div>

                                        <div class="favourite">
                                            <li class="list">
                                                <i class="icon-common fa-solid fa-heart"></i>
                                                <h3 class="AccountMenu-menu-label">Sản phẩm yêu thích</h3>
                                            </li>
                                        </div>
                                        <%
                                            if (user.getRole() == true) {
                                        %>
                                        <a href="admin?page=product" style="text-decoration: none;color: #112950">
                                            <div class="favourites">
                                                <li class="list">
                                                    <i class="icon-common fa-solid fa-wrench"></i>
                                                    <h3 class="AccountMenu-menu-label">Quản lý trang web</h3>
                                                </li>
                                            </div>
                                        </a>
                                        <%
                                            }
                                        %>
                                    </ul>
                                    <div class="AccountMenu_support">
                                        <div class="list">
                                            <div class="AccountMenu_liveChat cursor-point">
                                                <i class="icon-common fa-solid fa-user-doctor"></i>
                                                <b>1800 6821</b>
                                                <p>Tư vấn đặt hàng</p>
                                            </div>
                                        </div>
                                        <a href="login">
                                            <button style="border: 4px #ccc solid;
                                            padding: 12px;
                                            border-radius: 38px;">Đăng xuất
                                            </button>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="one" class="Desktop_omega" style="padding: 24px; width: 100%;">
                            <div class="CommonHeaderMobile_fixed-header common-header-profile">
                                <div class="CommonHeaderMobile_common-header">
                                    <div class="container d-flex justify-content-between align-items-center">
                                        <div class="CommonHeaderMobile_left-content">
                                            <h1>Lịch sử đơn hàng</h1>
                                        </div>
                                        <div class="CommonHeaderMobile_group-cart"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="ListOrder_list-order">
                                <div class="ListOrder_order-body">
                                    <div class="ListOrderTab_list-order-tab">
                                        <div class="ListOrderTab_tab">
                                            <div class="ListOrderTab_tab-item luuidol-item1">
                                                <button
                                                        class="ListOrderTab_tab-name ">Đang xử lý
                                                </button>
                                            </div>
                                            <div class="ListOrderTab_tab-item luuidol-item3">
                                                <button
                                                        class="ListOrderTab_tab-name">Đang giao
                                                    hàng
                                                </button>
                                            </div>
                                            <div class="ListOrderTab_tab-item luuidol-item4">
                                                <button
                                                        class="ListOrderTab_tab-name">Nhận
                                                    hàng thành công
                                                </button>
                                            </div>
                                            <div class="ListOrderTab_tab-item luuidol-item5">
                                                <button
                                                        class="ListOrderTab_tab-name">Đã
                                                    hủy
                                                </button>
                                            </div>
                                        </div>

                                        <div class="ListOrderTab_tab-content">
                                            <!-- Nếu chưa có đơn hàng nào -->
                                            <div class="EmptyResult_empty-result luuidol-empty1">
                                                <div><img src="../image/account/giphy2.gif" alt="empty-cart">
                                                    <p>Bạn có đơn hàng nào rồi!</p>
                                                </div>
                                            </div>

                                            <!-- Nếu đã có đơn hàng đang xử lý -->
                                            <div class="Confirmation-result" style="display: none;">
                                                <div class="cac-san-pham">
                                                    <ul>
                                                        <c:forEach var="item" items="${listOrderItem}">
                                                            <c:if test="${item.getStatus()==0}">
                                                                <li class="san-pham ">
                                                                    <div class="link-san-pham">
                                                                        <div class="noi-dung-san-pham">
                                                                            <c:forEach var="p" items="${getAllProduct}">
                                                                                <c:if test="${item.getProductID() == p.getProductID()}">
                                                                                    <div class="img-san-pham">
                                                                                        <!-- 248 x 248 -->
                                                                                        <img src="${p.getPathFirstImage1()}"
                                                                                             alt="">
                                                                                    </div>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                            <div class="khoang-trong" style="margin-top: 280px; margin-right: 20px;">

                                                                            <div class="ten-san-pham">
                                                                                <a href="product-detail?id=${item.getProductID()}">${item.getName()}</a>
                                                                            </div>

                                                                            <div class="khoang-trong"></div>

                                                                            <div class="gia-san-pham">
                                                                                <fmt:formatNumber
                                                                                        value="${item.getPrice()}"
                                                                                        type="currency"
                                                                                        pattern="###,### đ"/>
                                                                                    <%--                                                                            10.000 đ/Hộp--%>
                                                                            </div>
                                                                            <fmt:formatDate
                                                                                    value="${item.getOrderDate()}"
                                                                                    pattern=" 'Ngày' dd 'tháng' MM 'năm' yyyy"
                                                                            />
                                                                            <p class="waitXacNhan">Chờ xác nhận....</p>

                                                                            <form action="<c:url value="/html/cancel"/> "
                                                                                  method="post">
                                                                                <input type="hidden" name="purchaseID"
                                                                                       value="${item.getPurchaseID()}">
                                                                                <button class="buy-now-product them-san-pham ">
                                                                                    <div class="a-none-fff ">Hủy đơn
                                                                                        hàng
                                                                                    </div>
                                                                                </button>
                                                                            </form>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </li>
                                                            </c:if>
                                                        </c:forEach>

                                                    </ul>
                                                </div>

                                            </div>

                                            <!-- Nếu đơn hàng đang giao -->

                                            <div class="AreDelivering-result" style="display: none;">
                                                <div class="cac-san-pham">
                                                    <ul>
                                                        <c:forEach var="item" items="${listOrderItem}">
                                                            <c:if test="${item.getStatus()==1}">
                                                                <li class="san-pham ">
                                                                    <div class="link-san-pham">
                                                                        <div class="noi-dung-san-pham">
                                                                            <c:forEach var="p" items="${getAllProduct}">
                                                                                <c:if test="${item.getProductID() == p.getProductID()}">
                                                                                    <div class="img-san-pham">
                                                                                        <!-- 248 x 248 -->
                                                                                        <img src="${p.getPathFirstImage1()}"
                                                                                             alt="">
                                                                                    </div>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                            <div class="khoang-trong" style="margin-top: 280px; margin-right: 20px;">

                                                                            <div class="ten-san-pham">
                                                                                <a href="product-detail?id=${item.getProductID()}">${item.getName()}</a>
                                                                            </div>

                                                                            <div class="khoang-trong"></div>

                                                                            <div class="gia-san-pham">
                                                                                <fmt:formatNumber
                                                                                        value="${item.getPrice()}"
                                                                                        type="currency"
                                                                                        pattern="###,### đ"/>
                                                                            </div>
                                                                            <fmt:formatDate
                                                                                    value="${item.getOrderDate()}"
                                                                                    pattern=" 'Ngày' dd 'tháng' MM 'năm' yyyy"
                                                                            />
                                                                            <!-- Khi ấn vào di chuyển đến giỏ hàng -->
                                                                            <p class="waitXacNhan">Đang giao....</p>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </li>
                                                            </c:if>
                                                        </c:forEach>

                                                    </ul>
                                                </div>

                                            </div>

                                            <!-- Nếu đơn hàng nhận thành công -->
                                            <div class="ReceiveSuccess-result" style="display: none;">
                                                <div class="cac-san-pham">
                                                    <ul>
                                                        <c:forEach var="item" items="${listOrderItem}">
                                                            <c:if test="${item.getStatus()==2}">
                                                                <li class="san-pham ">
                                                                    <div class="link-san-pham">
                                                                        <div class="noi-dung-san-pham">
                                                                            <c:forEach var="p" items="${getAllProduct}">
                                                                                <c:if test="${item.getProductID() == p.getProductID()}">
                                                                                    <div class="img-san-pham">
                                                                                        <!-- 248 x 248 -->
                                                                                        <img src="${p.getPathFirstImage1()}"
                                                                                             alt="">
                                                                                    </div>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                            <div class="khoang-trong" style="margin-top: 280px; margin-right: 20px;">

                                                                            <div class="ten-san-pham">
                                                                                <a href="product-detail?id=${item.getProductID()}">${item.getName()}</a>
                                                                            </div>

                                                                            <div class="khoang-trong"></div>

                                                                            <div class="gia-san-pham">
                                                                                <fmt:formatNumber
                                                                                        value="${item.getPrice()}"
                                                                                        type="currency"
                                                                                        pattern="###,### đ"/>
                                                                            </div>
                                                                            <fmt:formatDate
                                                                                    value="${item.getOrderDate()}"
                                                                                    pattern=" 'Ngày' dd 'tháng' MM 'năm' yyyy"
                                                                            />
                                                                            <!-- Khi ấn vào di chuyển đến giỏ hàng -->
                                                                            <p class="waitXacNhan">Đã giao thành
                                                                                công</p>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </li>
                                                            </c:if>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                            </div>

                                            <!-- Nếu hủy đơn hàng -->
                                            <div class="Cancel-result" style="display: none;">
                                                <div class="cac-san-pham">
                                                    <ul>
                                                        <c:forEach var="item" items="${listOrderItem}">
                                                            <c:if test="${item.getStatus()==-1}">
                                                                <li class="san-pham ">
                                                                    <div class="link-san-pham">
                                                                        <div class="noi-dung-san-pham">
                                                                            <c:forEach var="p" items="${getAllProduct}">
                                                                                <c:if test="${item.getProductID() == p.getProductID()}">
                                                                                    <div class="img-san-pham">
                                                                                        <!-- 248 x 248 -->
                                                                                        <img src="${p.getPathFirstImage1()}"
                                                                                             alt="">
                                                                                    </div>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                            <div class="khoang-trong" style="margin-top: 280px; margin-right: 20px;">

                                                                            <div class="ten-san-pham">
                                                                                <a href="product-detail?id=${item.getProductID()}">${item.getName()}</a>
                                                                            </div>

                                                                            <div class="khoang-trong"></div>

                                                                            <div class="gia-san-pham">
                                                                                <fmt:formatNumber
                                                                                        value="${item.getPrice()}"
                                                                                        type="currency"
                                                                                        pattern="###,### đ"/>
                                                                            </div>
                                                                            <fmt:formatDate
                                                                                    value="${item.getOrderDate()}"
                                                                                    pattern=" 'Ngày' dd 'tháng' MM 'năm' yyyy"
                                                                            />
                                                                            <!-- Khi ấn vào di chuyển đến giỏ hàng -->
                                                                            <p class="waitXacNhan">Đã hủy</p>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </li>
                                                            </c:if>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="two" class="Desktop_omega" style="padding: 24px; width: 100%; display: none;">
                            <div class="CommonHeaderMobile_fixed-header common-header-profile">
                                <div class="CommonHeaderMobile_common-header">
                                    <div class="container d-flex justify-content-between align-items-center">
                                        <div class="CommonHeaderMobile_left-content">
                                            <h1>Mã giảm giá</h1>
                                        </div>
                                        <div class="CommonHeaderMobile_group-cart"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="ListOrder_list-order">
                                <div class="ListOrder_order-body">
                                    <div class="ListOrderTab_list-order-tab">
                                        <div class="ListOrderTab_tab">
                                            <div class="ListOrderTab_tab-item luuidol-voucher1">
                                                <button
                                                        class="ListOrderTab_tab-name ">Có thể dùng
                                                </button>
                                            </div>
                                            <div class="ListOrderTab_tab-item luuidol-voucher2">
                                                <button
                                                        class="ListOrderTab_tab-name">Đã sử
                                                    dụng
                                                </button>
                                            </div>
                                            <div class="ListOrderTab_tab-item luuidol-voucher3">
                                                <button
                                                        class="ListOrderTab_tab-name">Đã hết
                                                    hạn
                                                </button>
                                            </div>

                                        </div>

                                        <div class="ListOrderTab_tab-content">
                                            <!-- Nếu chưa có mã giảm giá -->
                                            <div class="EmptyResult_empty-result luuidol-empty2">
                                                <div><img src="../image/account/giphy2.gif" alt="empty-cart">
                                                    <p>Bạn chưa có mã giảm giá nào</p>
                                                </div>
                                            </div>

                                            <!-- Nếu có mã giảm giá -->

                                            <section class="Have-voucher" style="display: none;">
                                                <div class="container">
                                                    <div class="row-voucher">
                                                        <div class="Voucher-item pd-right-28">
                                                            <div class="list-voucher">
                                                                <div class="brand">
                                                                    <h2>VOUCHER</h2>
                                                                </div>
                                                                <div class="discount alizarin">30%
                                                                    <div class="type">off</div>
                                                                </div>
                                                                <div class="descr">
                                                                    <strong>Phiếu giảm giá 30%*.</strong>
                                                                    Cho tất cả các đơn hàng.
                                                                </div>
                                                                <div class="ends">
                                                                    <small>* Hạn sử dụng đến hết 01/01/2024.</small>
                                                                </div>
                                                                <div class="coupon midnight-blue">
                                                                    <a href="#code-1" class="open-code1">Hiện mã
                                                                        code</a>
                                                                    <div id="code-1" class="collapse code"
                                                                         style="display: none;">L2P30
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="Voucher-item pd-right-28">
                                                            <div class="list-voucher">
                                                                <div class="brand">
                                                                    <h2>VOUCHER</h2>
                                                                </div>
                                                                <div class="discount emerald">
                                                                    50%
                                                                    <div class="type">
                                                                        off
                                                                    </div>
                                                                </div>
                                                                <div class="descr">
                                                                    <strong>
                                                                        Phiếu giảm giá 50%*.
                                                                    </strong>
                                                                    Áp dụng cho đơn hàng 100K trở lên.
                                                                </div>
                                                                <div class="ends">
                                                                    <small>
                                                                        * Hạn sử dụng đến hết 31/12/2023.
                                                                    </small>
                                                                </div>
                                                                <div class="coupon midnight-blue">
                                                                    <a href="#code-2" class="open-code2">Hiện mã
                                                                        code</a>
                                                                    <div id="code-2" class="collapse in code"
                                                                         style="display: none;">
                                                                        L2P50
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%--                                                        <div class="Voucher-item pd-right-28">--%>
                                                        <%--                                                            <div class="list-voucher">--%>
                                                        <%--                                                                <div class="brand">--%>
                                                        <%--                                                                    <h2>--%>
                                                        <%--                                                                        VOUCHER--%>
                                                        <%--                                                                    </h2>--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                                <div class="discount peter-river">--%>
                                                        <%--                                                                    15%--%>
                                                        <%--                                                                    <div class="type">--%>
                                                        <%--                                                                        off--%>
                                                        <%--                                                                    </div>--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                                <div class="descr">--%>
                                                        <%--                                                                    <strong>--%>
                                                        <%--                                                                        Phiếu giảm giá 15% *.--%>
                                                        <%--                                                                    </strong>--%>
                                                        <%--                                                                    Cho tất cả các đơn hàng.--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                                <div class="ends">--%>
                                                        <%--                                                                    <small>--%>
                                                        <%--                                                                        * Hạn sử dụng đến hết 19/01/2024.--%>
                                                        <%--                                                                    </small>--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                                <div class="coupon midnight-blue">--%>
                                                        <%--                                                                    <a href="#code-3" class="open-code3">Hiện mã--%>
                                                        <%--                                                                        code</a>--%>
                                                        <%--                                                                    <div id="code-3" class="collapse code"--%>
                                                        <%--                                                                         style="display: none;">--%>
                                                        <%--                                                                        L2P15--%>
                                                        <%--                                                                    </div>--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                            </div>--%>
                                                        <%--                                                        </div>--%>
                                                        <%--                                                        <div class="Voucher-item pd-right-28">--%>
                                                        <%--                                                            <div class="list-voucher">--%>
                                                        <%--                                                                <div class="brand">--%>
                                                        <%--                                                                    <h2>--%>
                                                        <%--                                                                        VOUCHER--%>
                                                        <%--                                                                    </h2>--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                                <div class="discount amethyst">--%>
                                                        <%--                                                                    25%--%>
                                                        <%--                                                                    <div class="type">--%>
                                                        <%--                                                                        off--%>
                                                        <%--                                                                    </div>--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                                <div class="descr">--%>
                                                        <%--                                                                    <strong>--%>
                                                        <%--                                                                        Phiếu giảm giá 25%*.--%>
                                                        <%--                                                                    </strong>--%>
                                                        <%--                                                                    Áp dụng cho đơn hàng 200K trở lên.--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                                <div class="ends">--%>
                                                        <%--                                                                    <small>--%>
                                                        <%--                                                                        * Hạn sử dụng đến 11/11/2024.--%>
                                                        <%--                                                                    </small>--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                                <div class="coupon midnight-blue">--%>
                                                        <%--                                                                    <a href="#code-4" class="open-code4">Hiện mã--%>
                                                        <%--                                                                        code</a>--%>
                                                        <%--                                                                    <div id="code-4" class="collapse code"--%>
                                                        <%--                                                                         style="display: none;">--%>
                                                        <%--                                                                        L2P25--%>
                                                        <%--                                                                    </div>--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                            </div>--%>
                                                        <%--                                                        </div>--%>
                                                    </div>
                                                </div>
                                            </section>

                                            <!-- Nếu voucher đã dùng -->

                                            <section class="Use-voucher" style="display: none;">
                                                <div class="container">
                                                    <div class="row-voucher">
                                                        <div class="Voucher-item pd-right-28">
                                                            <div class="list-voucher">
                                                                <div class="brand">
                                                                    <h2>VOUCHER</h2>
                                                                </div>
                                                                <div class="discount alizarin">30%
                                                                    <div class="type">off</div>
                                                                </div>
                                                                <div class="descr">
                                                                    <strong>Phiếu giảm giá 30%*.</strong>
                                                                    Cho tất cả các đơn hàng.
                                                                </div>
                                                                <div class="ends">
                                                                    <small>* Đã dùng.</small>
                                                                </div>
                                                                <div class="coupon midnight-blue">
                                                                    <a href="#code-1" class="open-code">Bạn đã
                                                                        dùng</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="Voucher-item pd-right-28">
                                                            <div class="list-voucher">
                                                                <div class="brand">
                                                                    <h2>VOUCHER</h2>
                                                                </div>
                                                                <div class="discount alizarin">30%
                                                                    <div class="type">off</div>
                                                                </div>
                                                                <div class="descr">
                                                                    <strong>Phiếu giảm giá 30%*.</strong>
                                                                    Cho đơn hàng từ 100K trở lên.
                                                                </div>
                                                                <div class="ends">
                                                                    <small>* Đã dùng.</small>
                                                                </div>
                                                                <div class="coupon midnight-blue">
                                                                    <a href="#code-1" class="open-code">Bạn đã
                                                                        dùng</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </section>

                                            <!-- Nếu voucher hết hạn -->

                                            <section class="NoUse-voucher" style="display: none;">
                                                <div class="container">
                                                    <div class="row-voucher">
                                                        <div class="Voucher-item pd-right-28">
                                                            <div class="list-voucher">
                                                                <div class="brand">
                                                                    <h2>VOUCHER</h2>
                                                                </div>
                                                                <div class="discount emerald">
                                                                    50%
                                                                    <div class="type">
                                                                        off
                                                                    </div>
                                                                </div>
                                                                <div class="descr">
                                                                    <strong>
                                                                        Phiếu giảm giá 50%*.
                                                                    </strong>
                                                                    Áp dụng cho đơn hàng 100K trở lên.
                                                                </div>
                                                                <div class="ends">
                                                                    <small>
                                                                        * Đã hết hạn
                                                                    </small>
                                                                </div>
                                                                <div class="coupon midnight-blue">
                                                                    <a href="#code-2" class="open-code2">Đã hết hạn</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%--                                                        <div class="Voucher-item pd-right-28">--%>
                                                        <%--                                                            <div class="list-voucher">--%>
                                                        <%--                                                                <div class="brand">--%>
                                                        <%--                                                                    <h2>VOUCHER</h2>--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                                <div class="discount alizarin">50%--%>
                                                        <%--                                                                    <div class="type">off</div>--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                                <div class="descr">--%>
                                                        <%--                                                                    <strong>Phiếu giảm giá 50%*.</strong>--%>
                                                        <%--                                                                    Cho tất cả các đơn hàng.--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                                <div class="ends">--%>
                                                        <%--                                                                    <small>* Hết hạn.</small>--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                                <div class="coupon midnight-blue">--%>
                                                        <%--                                                                    <a href="#code-1" class="open-code">Đã hết--%>
                                                        <%--                                                                        hạn</a>--%>
                                                        <%--                                                                </div>--%>
                                                        <%--                                                            </div>--%>
                                                        <%--                                                        </div>--%>
                                                    </div>
                                                </div>
                                            </section>


                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="three" class="Desktop-omega" style="padding: 24px; display: none;">
                            <div class="CommonHeaderMobile_fixed-header common-header-profile">
                                <div class="CommonHeaderMobile_common-header">
                                    <div class="container d-flex justify-content-between align-items-center">
                                        <div class="CommonHeaderMobile_left-content">
                                            <h1>Chỉnh sửa thông tin cá nhân</h1>
                                        </div>
                                        <div class="CommonHeaderMobile_group-cart"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="Desktop_big-box">
                                <div class="AccountDetails_profile">
                                    <form action="user-edit?userId=<%=user.getUserID()%>" method="post">
                                        <div class="AccountDetails_info">
                                            <div class="AccountDetails_avatar">
                                                <div class="AccountDetails_photo-upload" style="display: grid;">
                                                    <input type="file" accept=".png, .jpeg, .jpg" id="photoInput"
                                                           style="display: none;">
                                                    <img id="onImg" src="../image/account/<%=user.getUserID()%>.jpg"
                                                         alt="Ảnh đã chọn">

                                                    <button onclick="choosePhoto()">Bấm để cập nhật ảnh mới</button>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="AccountDetails_detail">
                                            <div>
                                                <div class="InputTextField_input-text-field">
                                                    <label><i class="fa-solid fa-check-double"></i>Họ và
                                                        tên<span>*</span></label>
                                                    <div class="InputTextField_input-group">
                                                        <input name="full_name" maxlength="150" type="text"
                                                               placeholder="Vui lòng nhập họ và tên"
                                                               autocomplete="on"
                                                               class="" value="<%=user.getFullName()%>">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="AccountDetails_gender"><label style="font-size: 20px">Giới
                                                tính</label>
                                                <div class="d-flex" style="border-bottom: 1px solid #e5e5e5;">

                                                    <div>Nam</div>
                                                    <input type="radio" name="gender" value="nam"
                                                           style="margin-left: -48px;"
                                                        <%
                                                           if (user.getGender().equals("nam")){
                                                        %>
                                                           checked
                                                        <%
                                                           }
                                                        %>

                                                    >


                                                    <div style="margin-left: 48px;">Nữ</div>
                                                    <input type="radio"
                                                           name="gender" value="nữ" style="margin-left: -48px;"
                                                        <%
                                                           if (user.getGender().equals("nữ")){
                                                        %>
                                                           checked
                                                        <%
                                                           }
                                                        %>
                                                    >


                                                </div>
                                            </div>
                                            <div class="DateField_date-field AccountDetails_birthday"
                                                 style="padding-bottom: 10px; border-bottom: 1px solid #e5e5e5">
                                                <label><i class="fa-solid fa-check-double"></i>Ngày tháng năm sinh
                                                    <span>*</span></label>
                                                <input type="date" name="date" value="<%=user.getDobString()%>" style="    width: 136px;
                                                    height: 40px;
                                                    font-size: 16px;
                                                    border-radius: 16px;
                                                    margin-top: 16px;
                                                    margin-left: 132px;
                                                    padding-left: 8px;">

                                            </div>
                                            <div class="InputTextField_input-text-field"><label><i
                                                    class="fa-solid fa-check-double"></i>Số điện
                                                thoại</label>
                                                <div class="InputTextField_input-group">
                                                    <input name="phone_number" type="text" class=""
                                                           value="0<%=user.getPhoneNumbers()%>"
                                                           placeholder="Vui lòng nhập số điện thoại">
                                                </div>
                                            </div>
                                            <div class="AccountDetails_email">
                                                <div class="InputTextField_input-text-field">
                                                    <label style="padding-top: 20px"><i
                                                            class="fa-solid fa-check-double"></i>Email<span>*</span></label>
                                                    <div class="InputTextField_input-group"><input name="email"
                                                                                                   maxlength="255"
                                                                                                   type="email"
                                                                                                   autocomplete="on"
                                                                                                   class=""
                                                                                                   value="<%=user.getEmail()%>">
                                                    </div>
                                                </div>
                                            </div>
                                            <a>
                                                <span
                                                        class="btn-add-password AccountDetails_btn-change-pass">Thiết lập mật khẩu
                                                </span>
                                            </a>
                                            <button
                                                    class="Button_button Button_button__primary Button_button__disabled AccountDetails_submit"
                                                    type="submit">Lưu
                                            </button>

                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div id="four" class="Desktop_omega" style="padding: 24px; display: none; width: 100%;">
                            <div class="CommonHeaderMobile_fixed-header common-header-profile">
                                <div class="CommonHeaderMobile_common-header">
                                    <div class="container d-flex justify-content-between align-items-center">
                                        <div class="CommonHeaderMobile_left-content">
                                            <h1>Sổ địa chỉ nhận hàng</h1>
                                        </div>
                                        <div class="CommonHeaderMobile_group-cart"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="ListOrder_list-order">
                                <div class="ListOrder_order-body">
                                    <div class="ListOrderTab_list-order-tab">


                                        <div class="ListOrderTab_tab-content">
                                            <div class="EmptyResult_empty-result luuidol-empty3"
                                                 style="display: grid;">
                                                <div><img src="../image/account/giphy2.gif" alt="empty-cart">
                                                    <p>Bạn chưa thêm địa chỉ</p>
                                                </div>
                                                <button class="btn-add-address"
                                                        style="width: 400px; height: 50px; background-color: blue; color: #fff; border-radius: 32px; margin-top: 16px;">
                                                    Thêm địa chỉ nhận hàng
                                                </button>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="show-abc"></div>
                        </div>

                        <div id="five" class="Desktop_omega" style="padding: 24px; display: none; width: 100%;">
                            <div class="CommonHeaderMobile_fixed-header common-header-profile">
                                <div class="CommonHeaderMobile_common-header">
                                    <div class="container d-flex justify-content-between align-items-center">
                                        <div class="CommonHeaderMobile_left-content">
                                            <h1>Sản phẩm yêu thích</h1>
                                        </div>
                                        <div class="CommonHeaderMobile_group-cart"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="ListOrder_list-order">
                                <div class="ListOrder_order-body">
                                    <div class="ListOrderTab_list-order-tab">
                                        <div class="cac-san-pham">
                                            <ul>
                                                <%
                                                    List<Product> p = (List) request.getAttribute("getBestSelling");
                                                %>

                                                <%
                                                    for (int i = 0; i < 2; i++) {
                                                %>
                                                <li class="san-pham">
                                                    <a href="product-detail?id=<%=p.get(i).getProductID()%>"
                                                       class="link-san-pham">
                                                        <div class="img-san-pham">
                                                            <!-- 248 x 248 -->
                                                            <img src="../image/product/<%=p.get(i).getProductID()%>/0.webp"
                                                                 alt="" style="width: 248px">
                                                        </div>

                                                        <div class="noi-dung-san-pham">
                                                            <div class="khoang-trong"></div>

                                                            <div class="ten-san-pham"
                                                                 style="max-height: 50px; max-width: 224px;overflow: hidden; text-overflow: ellipsis">
                                                                <%=p.get(i).getName()%>
                                                            </div>

                                                            <div class="khoang-trong"></div>

                                                            <div class="gia-san-pham">
                                                                <%=p.get(i).getPriceHaveDots()%>

                                                            </div>

                                                            <form action="cart?id=<%=p.get(i).getProductID()%>&active=add&page=index"
                                                                  method="post"

                                                                  style="width: 100%; height: 100%">
                                                                <button type="submit" class="them-san-pham">
                                                                    Thêm vào giỏ hàng
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </a>
                                                    <i class="icon-love-product fa-solid fa-heart"
                                                       style="position: absolute; top:390px"></i>


                                                </li>
                                                <%
                                                    }
                                                %>
                                                <%--                                                <li class="san-pham">--%>
                                                <%--                                                    <div class="link-san-pham">--%>
                                                <%--                                                        <div class="img-san-pham">--%>
                                                <%--                                                            248 x 248--%>
                                                <%--                                                        </div>--%>

                                                <%--                                                        <div class="noi-dung-san-pham">--%>
                                                <%--                                                            <div class="khoang-trong"></div>--%>

                                                <%--                                                            <div class="ten-san-pham">--%>
                                                <%--                                                                Sản phẩm 2--%>
                                                <%--                                                            </div>--%>

                                                <%--                                                            <div class="khoang-trong"></div>--%>

                                                <%--                                                            <div class="gia-san-pham">--%>
                                                <%--                                                                10.000 đ/Hộp--%>
                                                <%--                                                                <i class="icon-love-product fa-solid fa-heart"></i>--%>
                                                <%--                                                            </div>--%>
                                                <%--                                                            <!-- Khi ấn vào di chuyển đến giỏ hàng -->--%>
                                                <%--                                                            <button class="them-san-pham">--%>
                                                <%--                                                                <a class="a-none-fff" href="#">Thêm vào giỏ hàng</a>--%>
                                                <%--                                                            </button>--%>

                                                <%--                                                            <!-- Khi ấn vào sẽ di chuyển đến phần thanh toán -->--%>
                                                <%--                                                            <!-- <button class="buy-now-product them-san-pham">--%>
                                                <%--                                                        <a class="a-none-fff" href="#">Mua ngay</a>--%>
                                                <%--                                                      </button> -->--%>

                                                <%--                                                        </div>--%>
                                                <%--                                                    </div>--%>
                                                <%--                                                </li>--%>

                                                <%--                                                <li class="san-pham">--%>
                                                <%--                                                    <div class="link-san-pham">--%>
                                                <%--                                                        <div class="img-san-pham">--%>
                                                <%--                                                            248 x 248--%>
                                                <%--                                                        </div>--%>

                                                <%--                                                        <div class="noi-dung-san-pham">--%>
                                                <%--                                                            <div class="khoang-trong"></div>--%>

                                                <%--                                                            <div class="ten-san-pham">--%>
                                                <%--                                                                Sản phẩm 3--%>
                                                <%--                                                            </div>--%>

                                                <%--                                                            <div class="khoang-trong"></div>--%>

                                                <%--                                                            <div class="gia-san-pham">--%>
                                                <%--                                                                70.000 đ/Chiếc--%>
                                                <%--                                                                <i class="icon-love-product fa-solid fa-heart"></i>--%>
                                                <%--                                                            </div>--%>
                                                <%--                                                            <!-- Khi ấn vào di chuyển đến giỏ hàng -->--%>
                                                <%--                                                            <button class="them-san-pham">--%>
                                                <%--                                                                <a class="a-none-fff" href="#">Thêm vào giỏ hàng</a>--%>
                                                <%--                                                            </button>--%>

                                                <%--                                                            <!-- Khi ấn vào sẽ di chuyển đến phần thanh toán -->--%>
                                                <%--                                                            <!-- <button class="buy-now-product them-san-pham">--%>
                                                <%--                                                        <a class="a-none-fff" href="#">Mua ngay</a>--%>
                                                <%--                                                      </button> -->--%>

                                                <%--                                                        </div>--%>
                                                <%--                                                    </div>--%>
                                                <%--                                                </li>--%>


                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Thêm địa chỉ  -->
        <div id="add-address" style="display: none;">
            <div class="main-address">
                <div class="address-box">
                    <h2>Thêm địa chỉ</h2>
                    <form action="address-controller?active=add" method="post">
                        <div class="user-box">
                            <input id="fullName-address" type="text" name="city" required="">
                            <label for="fullName-address">Tỉnh</label>
                        </div>
                        <div class="user-box">
                            <input id="phone-address" type="text" name="district" required="">
                            <label for="phone-address">Thành phố</label>
                        </div>
                        <div class="user-box">
                            <input id="address-address" type="text" name="ward" required="">
                            <label for="address-address">Phường</label>
                        </div>
                        <div class="user-box">
                            <input id="email-address" type="text" name="detail" required="">
                            <label for="email-address">Chi tiết</label>
                        </div>
                        <a href="" class="btn-save-address">
                            <button type="submit" style="background: inherit;border: none">
                                Lưu
                            </button>
                        </a>

                    </form>
                </div>
            </div>
        </div>

        <!-- Thêm mật khẩu -->

        <div id="add-password" style="display: none;">
            <div class="main-address">
                <div class="address-box">
                    <h2>Thiết lập mật khẩu</h2>
                    <form action="pass-edit?userId=<%=user.getUserID()%>" method="post">
                        <div class="user-box">
                            <input type="password" name="oldpass">
                            <label>Mật khẩu cũ</label>
                        </div>
                        <div class="user-box">
                            <input type="password" name="newpass1">
                            <label>Mật khẩu mới</label>
                        </div>
                        <div class="user-box">
                            <input type="password" name="newpass2">
                            <label>Nhập lại mật khẩu mới</label>
                        </div>

                        <a href="#">
                            <button type="submit" style="background: inherit; border: none">
                                Lưu
                            </button>
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <jsp:include page="footer.jsp"></jsp:include>


</div>

<!-- add contact -->
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
                <h2 style="color: #fff">Thông tin liên lạc</h2>
                <h2 style="color: #fff">Email:</h2>
                <p style="color: #000;">LuuLongPhuoc@gamil.com</p>
                <h2 style="color: #fff">Số điện thoại:</h2>
                <p style="color: #000;">0162 ngày mai nói tiếp</p>
                <h2 style="color: #fff">Địa chỉ:</h2>
                <p style="color: #000;">Số 123,Tổ 3, Khu phố 6, Linh Trung, Thủ Đức, TP HCM</p>
            </a>
        </div>

    </div>
</div>
</body>

</html>

<!-- Scritp -->

<script>
    function choosePhoto() {
        var photoInput = document.getElementById("photoInput");
        var avtImg = document.getElementById("onImg");

        photoInput.click();

        photoInput.addEventListener("change", function () {
            var selectedPhoto = photoInput.files[0];

            var reader = new FileReader();
            reader.onload = function (e) {
                avtImg.setAttribute("src", e.target.result);
            };
            reader.readAsDataURL(selectedPhoto);
        });
    }

    $(document).ready(function () {

        // order click
        $(".history").click(function () {
            $("#one").show();
            $("#two").hide();
            $("#three").hide();
            $("#four").hide();
            $("#five").hide();
        });


        $(".voucher").click(function () {
            $("#two").show();
            $("#one").hide();
            $("#three").hide();
            $("#four").hide();
            $("#five").hide();
        });

        $(".desgin").click(function () {
            $("#three").show();
            $("#one").hide();
            $("#two").hide();
            $("#four").hide();
            $("#five").hide();
        });


        $(".addresser").click(function () {
            $("#one").hide();
            $("#two").hide();
            $("#three").hide();
            $("#four").show();
            $("#five").hide();
        });


        $(".favourite").click(function () {
            $("#one").hide();
            $("#two").hide();
            $("#three").hide();
            $("#four").hide();
            $("#five").show();
        })

        // end order click

        // click item order ----------------------------------------------

        $(".luuidol-item1").click(function () {
            $(".luuidol-empty1").hide();
            $(".Confirmation-result").show();
            $(".Packing-result").hide();
            $(".AreDelivering-result").hide();
            $(".ReceiveSuccess-result").hide();
            $(".Cancel-result").hide();
        });

        $(".luuidol-item2").click(function () {
            $(".luuidol-empty1").hide();
            $(".Confirmation-result").hide();
            $(".Packing-result").show();
            $(".AreDelivering-result").hide();
            $(".ReceiveSuccess-result").hide();
            $(".Cancel-result").hide();
        });

        $(".luuidol-item3").click(function () {
            $(".luuidol-empty1").hide();
            $(".Confirmation-result").hide();
            $(".Packing-result").hide();
            $(".AreDelivering-result").show();
            $(".ReceiveSuccess-result").hide();
            $(".Cancel-result").hide();
        });

        $(".luuidol-item4").click(function () {
            $(".luuidol-empty1").hide();
            $(".Confirmation-result").hide();
            $(".Packing-result").hide();
            $(".AreDelivering-result").hide();
            $(".ReceiveSuccess-result").show();
            $(".Cancel-result").hide();
        });

        $(".luuidol-item5").click(function () {
            $(".luuidol-empty1").hide();
            $(".Confirmation-result").hide();
            $(".Packing-result").hide();
            $(".AreDelivering-result").hide();
            $(".ReceiveSuccess-result").hide();
            $(".Cancel-result").show();
        });

        // end click item order

        // address add

        $(".btn-add-address").click(function (e) {
            e.stopPropagation(); // khi click vào body - phần này thì nó sẽ ẩn đi
            $("#add-address").toggle();
        });

        $(document).click(function (e) {
            if (!$(e.target).closest('#add-address').length) {
                $("#add-address").hide();
            }
        });

        $("#add-address").click(function (e) {
            e.stopPropagation();
        });


        // $(".btn-save-address").click(function () {
        //     $(".luuidol-empty3").hide();
        //     $("#add-address").hide();
        //     // Lấy giá trị từ input
        //     var fullName = $("#fullName-address").val();
        //     var phoneAddress = $("#phone-address").val();
        //     var address = $("#address-address").val();
        //     var emailAddress = $("#email-address").val();
        //
        //     // Hiển thị dữ liệu đã lưu trong một thẻ div
        //     $(".show-abc").html("<p>Họ Tên: " + fullName + "</p><p>Số Điện Thoại: " + phoneAddress +
        //         "</p><p>Địa chỉ: " + address + "</p><p> Email: " + emailAddress +
        //         "</p><button class='edit-button-address'>Chỉnh Sửa</button>");
        // });

        $(".edit-button-address").click(function () {
            $("#add-address").show();
            // Đặt lại giá trị cho input
            $("#fullName-address").val(fullName);
            $("#phone-address").val(phoneAddress);
            $("#address-address").val(address);
            $("#email-address").val(emailAddress);
        });

        // end add address

        // password add

        $(".btn-add-password").click(function (e) {
            e.stopPropagation(); // khi click vào body - phần này thì nó sẽ ẩn đi
            $("#add-password").toggle();
        });

        $(document).click(function (e) {
            if (!$(e.target).closest('#add-password').length) {
                $("#add-password").hide();
            }
        });

        $("#add-password").click(function (e) {
            e.stopPropagation();
        });

        // and add password


        // btn-order-item

        $(".ListOrderTab_tab-item").click(function () {
            $(".ListOrderTab_tab-item").removeClass("btn-click-bottom-blue");
            $(this).addClass("btn-click-bottom-blue");
        });

        // end btn-order-item


        // love product

        $(".icon-love-product").click(function () {
            // $(".icon-love-product").removeClass("color-love-click");
            // $(this).addClass("color-love-click");
            $(this).closest('.san-pham').hide();
        });

        $(".icon-nolove-product").click(function () {
            $(this).addClass("red-color").toggleClass("ccc-color");
        })

        // end love product

        // hủy đơn hàng

        $(".buy-now-product").click(function () {
            // $(this).closest('.san-pham').hide();
            var closestSanpham = $(this).closest('.san-pham');
            closestSanpham.appendTo('.Cancel-result');
            $(this).hide();
        });

        // end hủy đơn hàng

        // Voucher ------------------------

        $(".open-code1").click(function () {
            $("#code-1").toggle();
        });

        $(".open-code2").click(function () {
            $("#code-2").toggle();
        });

        $(".open-code3").click(function () {
            $("#code-3").toggle();
        });

        $(".open-code4").click(function () {
            $("#code-4").toggle();
        });

        // ------------------
        $(".luuidol-voucher1").click(function () {
            $(".luuidol-empty2").hide();
            $(".Have-voucher").show();
            $(".Use-voucher").hide();
            $(".NoUse-voucher").hide();
        });

        $(".luuidol-voucher2").click(function () {
            $(".luuidol-empty2").hide();
            $(".Have-voucher").hide();
            $(".Use-voucher").show();
            $(".NoUse-voucher").hide();
        });

        $(".luuidol-voucher3").click(function () {
            $(".luuidol-empty2").hide();
            $(".Have-voucher").hide();
            $(".Use-voucher").hide();
            $(".NoUse-voucher").show();
        });

        // end voucher


        // contct


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
    })
</script>


<%--<script>--%>
<%--    $(document).ready(function () {--%>

<%--        // order click--%>
<%--        $(".history").click(function () {--%>
<%--            $("#one").show();--%>
<%--            $("#two").hide();--%>
<%--            $("#three").hide();--%>
<%--            $("#four").hide();--%>
<%--            $("#five").hide();--%>
<%--        });--%>


<%--        $(".voucher").click(function () {--%>
<%--            $("#two").show();--%>
<%--            $("#one").hide();--%>
<%--            $("#three").hide();--%>
<%--            $("#four").hide();--%>
<%--            $("#five").hide();--%>
<%--        });--%>

<%--        $(".desgin").click(function () {--%>
<%--            $("#three").show();--%>
<%--            $("#one").hide();--%>
<%--            $("#two").hide();--%>
<%--            $("#four").hide();--%>
<%--            $("#five").hide();--%>
<%--        });--%>


<%--        $(".addresser").click(function () {--%>
<%--            $("#one").hide();--%>
<%--            $("#two").hide();--%>
<%--            $("#three").hide();--%>
<%--            $("#four").show();--%>
<%--            $("#five").hide();--%>
<%--        });--%>


<%--        $(".favourite").click(function () {--%>
<%--            $("#one").hide();--%>
<%--            $("#two").hide();--%>
<%--            $("#three").hide();--%>
<%--            $("#four").hide();--%>
<%--            $("#five").show();--%>
<%--        })--%>

<%--        // end order click--%>

<%--        // click item order ------------------------------------------------%>

<%--        $(".luuidol-item1").click(function () {--%>
<%--            $(".luuidol-empty1").hide();--%>
<%--            $(".Confirmation-result").show();--%>
<%--            $(".Packing-result").hide();--%>
<%--            $(".AreDelivering-result").hide();--%>
<%--            $(".ReceiveSuccess-result").hide();--%>
<%--            $(".Cancel-result").hide();--%>
<%--        });--%>

<%--        $(".luuidol-item2").click(function () {--%>
<%--            $(".luuidol-empty1").hide();--%>
<%--            $(".Confirmation-result").hide();--%>
<%--            $(".Packing-result").show();--%>
<%--            $(".AreDelivering-result").hide();--%>
<%--            $(".ReceiveSuccess-result").hide();--%>
<%--            $(".Cancel-result").hide();--%>
<%--        });--%>

<%--        $(".luuidol-item3").click(function () {--%>
<%--            $(".luuidol-empty1").hide();--%>
<%--            $(".Confirmation-result").hide();--%>
<%--            $(".Packing-result").hide();--%>
<%--            $(".AreDelivering-result").show();--%>
<%--            $(".ReceiveSuccess-result").hide();--%>
<%--            $(".Cancel-result").hide();--%>
<%--        });--%>

<%--        $(".luuidol-item4").click(function () {--%>
<%--            $(".luuidol-empty1").hide();--%>
<%--            $(".Confirmation-result").hide();--%>
<%--            $(".Packing-result").hide();--%>
<%--            $(".AreDelivering-result").hide();--%>
<%--            $(".ReceiveSuccess-result").show();--%>
<%--            $(".Cancel-result").hide();--%>
<%--        });--%>

<%--        $(".luuidol-item5").click(function () {--%>
<%--            $(".luuidol-empty1").hide();--%>
<%--            $(".Confirmation-result").hide();--%>
<%--            $(".Packing-result").hide();--%>
<%--            $(".AreDelivering-result").hide();--%>
<%--            $(".ReceiveSuccess-result").hide();--%>
<%--            $(".Cancel-result").show();--%>
<%--        });--%>

<%--        // end click item order--%>

<%--        // address add--%>

<%--        $(".btn-add-address").click(function (e) {--%>
<%--            e.stopPropagation(); // khi click vào body - phần này thì nó sẽ ẩn đi--%>
<%--            $("#add-address").toggle();--%>
<%--        });--%>

<%--        $(document).click(function (e) {--%>
<%--            if (!$(e.target).closest('#add-address').length) {--%>
<%--                $("#add-address").hide();--%>
<%--            }--%>
<%--        });--%>

<%--        $("#add-address").click(function (e) {--%>
<%--            e.stopPropagation();--%>
<%--        });--%>


<%--        // $(".btn-save-address").click(function () {--%>
<%--        //     $(".luuidol-empty3").hide();--%>
<%--        //     $("#add-address").hide();--%>
<%--        //     // Lấy giá trị từ input--%>
<%--        //     var fullName = $("#fullName-address").val();--%>
<%--        //     var phoneAddress = $("#phone-address").val();--%>
<%--        //     var address = $("#address-address").val();--%>
<%--        //     var emailAddress = $("#email-address").val();--%>
<%--        //--%>
<%--        //     // Hiển thị dữ liệu đã lưu trong một thẻ div--%>
<%--        //     $(".show-abc").html("<p>Họ Tên: " + fullName + "</p><p>Số Điện Thoại: " + phoneAddress +--%>
<%--        //         "</p><p>Địa chỉ: " + address + "</p><p> Email: " + emailAddress +--%>
<%--        //         "</p><button class='edit-button-address'>Chỉnh Sửa</button>");--%>
<%--        // });--%>

<%--        $(".edit-button-address").click(function () {--%>
<%--            $("#add-address").show();--%>
<%--            // Đặt lại giá trị cho input--%>
<%--            $("#fullName-address").val(fullName);--%>
<%--            $("#phone-address").val(phoneAddress);--%>
<%--            $("#address-address").val(address);--%>
<%--            $("#email-address").val(emailAddress);--%>
<%--        });--%>

<%--        // end add address--%>

<%--        // password add--%>

<%--        $(".btn-add-password").click(function (e) {--%>
<%--            e.stopPropagation(); // khi click vào body - phần này thì nó sẽ ẩn đi--%>
<%--            $("#add-password").toggle();--%>
<%--        });--%>

<%--        $(document).click(function (e) {--%>
<%--            if (!$(e.target).closest('#add-password').length) {--%>
<%--                $("#add-password").hide();--%>
<%--            }--%>
<%--        });--%>

<%--        $("#add-password").click(function (e) {--%>
<%--            e.stopPropagation();--%>
<%--        });--%>

<%--        // and add password--%>


<%--        // btn-order-item--%>

<%--        $(".ListOrderTab_tab-item").click(function () {--%>
<%--            $(".ListOrderTab_tab-item").removeClass("btn-click-bottom-blue");--%>
<%--            $(this).addClass("btn-click-bottom-blue");--%>
<%--        });--%>

<%--        // end btn-order-item--%>


<%--        // love product--%>

<%--        $(".icon-love-product").click(function () {--%>
<%--            // $(".icon-love-product").removeClass("color-love-click");--%>
<%--            // $(this).addClass("color-love-click");--%>
<%--            $(this).closest('.san-pham').hide();--%>
<%--        });--%>

<%--        $(".icon-nolove-product").click(function () {--%>
<%--            $(this).addClass("red-color").toggleClass("ccc-color");--%>
<%--        })--%>

<%--        // end love product--%>

<%--        // hủy đơn hàng --%>

<%--        $(".buy-now-product").click(function () {--%>
<%--            // $(this).closest('.san-pham').hide();--%>
<%--            var closestSanpham = $(this).closest('.san-pham');--%>
<%--            closestSanpham.appendTo('.Cancel-result');--%>
<%--            $(this).hide();--%>
<%--        });--%>

<%--        // end hủy đơn hàng--%>

<%--        // Voucher --------------------------%>

<%--        $(".open-code1").click(function () {--%>
<%--            $("#code-1").toggle();--%>
<%--        });--%>

<%--        $(".open-code2").click(function () {--%>
<%--            $("#code-2").toggle();--%>
<%--        });--%>

<%--        $(".open-code3").click(function () {--%>
<%--            $("#code-3").toggle();--%>
<%--        });--%>

<%--        $(".open-code4").click(function () {--%>
<%--            $("#code-4").toggle();--%>
<%--        });--%>

<%--        // --------------------%>
<%--        $(".luuidol-voucher1").click(function () {--%>
<%--            $(".luuidol-empty2").hide();--%>
<%--            $(".Have-voucher").show();--%>
<%--            $(".Use-voucher").hide();--%>
<%--            $(".NoUse-voucher").hide();--%>
<%--        });--%>

<%--        $(".luuidol-voucher2").click(function () {--%>
<%--            $(".luuidol-empty2").hide();--%>
<%--            $(".Have-voucher").hide();--%>
<%--            $(".Use-voucher").show();--%>
<%--            $(".NoUse-voucher").hide();--%>
<%--        });--%>

<%--        $(".luuidol-voucher3").click(function () {--%>
<%--            $(".luuidol-empty2").hide();--%>
<%--            $(".Have-voucher").hide();--%>
<%--            $(".Use-voucher").hide();--%>
<%--            $(".NoUse-voucher").show();--%>
<%--        });--%>

<%--        // end voucher--%>


<%--        // contct--%>


<%--        $(".contact-button").click(function (e) {--%>
<%--            e.stopPropagation(); // khi click vào body - phần này thì nó sẽ ẩn đi--%>
<%--            $(".contact-info").toggle();--%>
<%--        });--%>

<%--        $(document).click(function (e) {--%>
<%--            if (!$(e.target).closest('.contact-info').length) {--%>
<%--                $(".contact-info").hide();--%>
<%--            }--%>
<%--        });--%>

<%--        $(".contact-info").click(function (e) {--%>
<%--            e.stopPropagation();--%>
<%--        });--%>
<%--    })--%>
<%--    --%>
<%--</script>--%>