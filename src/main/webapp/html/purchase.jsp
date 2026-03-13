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

    <link rel="stylesheet" href="../css/purchase.css">
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
    List<Purchases> purchasesList = (List<Purchases>) request.getAttribute("getPurchaseList");
    String status = (String) request.getAttribute("getStatus");
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
                    Lịch sử mua
                </div>

                <div class="content">
                    <ul class="type_bills">
                        <li class="type_bill">
                            <a href="listbill?status=all">
                                <div class="box
                                <%
                                if (status.equals("all")){
                                %>
                                choose
                                <%
                                    }
                                %>">

                                    Tất cả
                                </div>
                            </a>

                        </li>

                        <li class="type_bill">
                            <a href="listbill?status=0">
                                <div class="box
                                <%
                                if (status.equals("0")){
                                %>
                                choose
                                <%
                                    }
                                %>">
                                    Chờ xác nhận
                                </div>
                            </a>
                        </li>



                        <li class="type_bill">
                            <a href="listbill?status=1">
                                <div class="box
                                <%
                                if (status.equals("1")){
                                %>
                                choose
                                <%
                                    }
                                %>">
                                    Đang giao
                                </div>
                            </a>
                        </li>

                        <li class="type_bill">
                            <a href="listbill?status=2">
                                <div class="box
                                <%
                                if (status.equals("2")){
                                %>
                                choose
                                <%
                                    }
                                %>">
                                    Thành công
                                </div>
                            </a>
                        </li>

                        <li class="type_bill">
                            <a href="listbill?status=-1">
                                <div class="box
                                <%
                                if (status.equals("-1")){
                                %>
                                choose
                                <%
                                    }
                                %>">
                                    Hủy đơn
                                </div>
                            </a>
                        </li>
                    </ul>

                    <div class="list_bill">
                        <%
                            PurchasesDAO purchasesDAO = new PurchasesDAO();

                            for(Purchases purchases : purchasesList){
                                ProductDAO productDAO = new ProductDAO();
                                Product product = productDAO.getProductById(purchases.getProductID());
                                int quantityProducts = purchasesDAO.countByPurchaseID(purchases.getPurchaseID());

                        %>
                        <a href="billdetail?purchaseId=<%=purchases.getPurchaseID()%>" style="text-decoration: none;">
                            <div class="box_bill">
                                <div class="status_date">
                                    <div class="status_bill">
                                        <%=purchases.getStatusString()%>
                                    </div>
                                    <div class="date_bill">
                                        <%=purchases.getDateOrderStringShort()%>
                                    </div>
                                </div>


                                <div class="product_bill">
                                    <div class="img_name">
                                        <img src="<%=product.getPathFirstImage(request.getServletContext().getRealPath(""))%>" alt="">
                                        <%=product.getName()%>
                                    </div>

                                    <div class="price">
                                        <%=product.getPriceHaveDots()%>
                                    </div>

                                </div>
                                <%
                                    if(quantityProducts !=1){
                                %>
                                <div class="other_product_bill">
                                    Cùng <%=quantityProducts-1%> sản phẩm khác
                                </div>
                                <%
                                    }
                                %>
                                <div class="price_bill">
                                    <%=purchases.getTotalPriceHaveDotsHaveDelivery()%>
                                </div>
                            </div>
                        </a>
                        <%
                            }
                        %>

                    </div>
                </div>


            </div>
        </div>
    </div>

</div>
<jsp:include page="footer.jsp"></jsp:include>


</body>

</html>