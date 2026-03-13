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
                        </div>

                        <div class="total">
                            <div class="name_price">
                                Tổng tiền (<%=quantity%> sản phẩm)
                            </div>
                            <div class="price">
                                <%=purchases.getTotalPriceHaveDotsHaveDelivery()%>
                            </div>
                        </div>

                    </div>
                </div>


            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>

</html>