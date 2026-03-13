<%@ page import="model.Cart" %>
<%@ page import="model.Product" %>
<%@ page import="java.io.File" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Nhà Thuốc</title>

    <link rel="stylesheet" href="../css/cart.css">
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

<div class="page">
    <jsp:include page="header.jsp"></jsp:include>
    <%
        Cart cart = (Cart) session.getAttribute("cart");
    %>


    <div class="noi-dung">
        <div class="container">

            <div class="san-pham-mua-va-bang-gia">
                <div class="san-pham-mua">
                    <div class="chon-all-cost-quantity-unit">
                        <div class="chon-all">
                            <div class="input-text">
                                <div class="box-input">

                                    <input type="checkbox" class="input" id="checkedAll" data-hrf="index.jsp"
                                        <%
                                            if (cart!=null && cart.cartEqualChecked()){
                                        %>
                                           checked
                                        <%
                                            }
                                        %>
                                    >
                                </div>

                                <div style="display: flex; align-items: center; font-size: 20px;">Chọn tất cả</div>
                            </div>
                        </div>

                        <div class="cost">
                            Giá thành
                        </div>

                        <div class="quantity">
                            Số lượng
                        </div>


                        <div class="khoang-trong">

                        </div>

                    </div>

                    <ul class="cac-san-pham-muon-mua">


                        <%
                            if (cart != null && cart.sizeCart() != 0) {
                                for (Product p : cart.getCart().keySet()) {
                        %>

                        <li class="san-pham-muon-mua">
                            <div class="input-img-ten-san-pham">
                                <div class="box-input">
                                    <input type="checkbox" class="input checked"
                                           data-href="buy-product?active=normal&id=<%=p.getProductID()%>"
                                           value="<%=p.getProductID()%>"
                                        <%
                                            if (cart.getProductChecked().contains(p.getProductID())){
                                            %>
                                           checked
                                        <%
                                            }
                                            %>
                                    >
                                </div>

                                <div class="img-san-pham">

                                    <img src="<%=p.getPathFirstImage(request.getServletContext().getRealPath(""))%>" alt=""
                                         style="    max-width: 100%; max-height: 100%; height: auto; width: auto;">
                                </div>

                                <div class="ten-san-pham">
                                    <a href=""><%=p.getName()%>
                                    </a>
                                </div>
                            </div>

                            <div class="cost">
                                <p class="sale"><%=p.getPriceHaveDots()%>
                                </p>
                                <p class="origin"><%=p.getRealPriceHaveDots()%>
                                </p>
                            </div>

                            <div class="quantity">
                                <div class="down-up-quantity">

                                    <form action="cart?id=<%=p.getProductID()%>&active=remove&page=cart&clearAll=false"
                                          method="post">
                                        <button class="down"><i class="fa-solid fa-minus"></i></button>
                                    </form>

                                    <input type="text" class="quantity" value="<%=cart.getCart().get(p)%>">


                                    <form action="cart?id=<%=p.getProductID()%>&active=add&page=cart" method="post">
                                        <button class="up"><i class="fa-solid fa-plus"></i></button>
                                    </form>

                                </div>
                            </div>


                            <div class="delete">
                                <form action="cart?id=<%=p.getProductID()%>&active=remove&page=cart&clearAll=true"
                                      method="post">
                                    <button><i class="fa-solid fa-trash-can"></i></button>
                                </form>
                            </div>

                        </li>
                        <%

                                }
                            }
                        %>

                        <%--                        <li class="san-pham-muon-mua">--%>
                        <%--                            <div class="input-img-ten-san-pham">--%>
                        <%--                                <div class="box-input">--%>
                        <%--                                    <input type="checkbox" class="input">--%>
                        <%--                                </div>--%>

                        <%--                                <div class="img-san-pham">--%>

                        <%--                                </div>--%>

                        <%--                                <div class="ten-san-pham">--%>
                        <%--                                    <a href="">Bột Diếp Cá nguyên chất Datino bổ sung chất dinh dưỡng có lợi cho sức--%>
                        <%--                                        khỏe từ diếp cá (15--%>
                        <%--                                        gói x 3g)</a>--%>
                        <%--                                </div>--%>
                        <%--                            </div>--%>

                        <%--                            <div class="cost">--%>
                        <%--                                <p class="sale">925.000đ</p>--%>
                        <%--                                <p class="origin">1.200.000đ</p>--%>
                        <%--                            </div>--%>

                        <%--                            <div class="quantity">--%>
                        <%--                                <div class="down-up-quantity">--%>
                        <%--                                    <button class="down"><i class="fa-solid fa-minus"></i></button>--%>

                        <%--                                    <input type="text" class="quantity" value="1">--%>

                        <%--                                    <button class="up"><i class="fa-solid fa-plus"></i></button>--%>
                        <%--                                </div>--%>
                        <%--                            </div>--%>

                        <%--                            <div class="unit">--%>
                        <%--                                Hộp--%>
                        <%--                            </div>--%>

                        <%--                            <div class="delete">--%>
                        <%--                                <button><i class="fa-solid fa-trash-can"></i></button>--%>
                        <%--                            </div>--%>

                        <%--                        </li>--%>


                    </ul>
                </div>

                <div class="bang-gia">
                    <div class="title">
                        <p>Tổng tiền</p>
                        <p><%=cart.getTotalRealPricesHaveDots()%>
                        </p>
                    </div>

                    <div class="title">
                        <p>Giảm giá trực tiếp</p>
                        <p><%=cart.getTotalSalesHaveDots()%>
                        </p>
                    </div>

                    <div class="title">
                        <p>Giảm giá voucher</p>
                        <p>0 Đồng</p>
                    </div>

                    <div class="title">
                        <p>Tiết kiệm được</p>
                        <p><%=cart.getTotalSalesHaveDots()%>
                        </p>
                    </div>

                    <div class="tam-tinh">
                        <p class="title">Tạm tính</p>
                        <p class="cost"><%=cart.getTotalPricesHaveDots()%>
                        </p>
                    </div>
                    <%
                        String content = (String) request.getAttribute("content");
                        if (content!=null){
                    %>
                    <div>
                        <p style="color: red"><%=content%></p>
                    </div>
                    <%
                        }
                    %>
                    <a href="payment">
                        <button class="mua-hang">Mua hàng</button>
                    </a>


                    <div class="dieu-khoan">
                        Bằng việc tiến hành đặt mua hàng, bạn đồng ý với
                        <a href="">Điều khoản dịch vụ</a>
                        ,
                        <a href=""> Chính sách thu thập và xử lý dữ liệu cá nhân</a>
                        của Nhà thuốc FPT Long Châu
                    </div>
                </div>
            </div>

        </div>

    </div>

    <a class="checkedlink" href="index.jsp"></a>


    <jsp:include page="footer.jsp"></jsp:include>
    <script src="../js/cart.js"></script>
    <script>
        var checkboxes = document.querySelectorAll('.checked');

        // Thêm sự kiện change cho tất cả các ô kiểm
        checkboxes.forEach(function (checkbox) {
            checkbox.addEventListener('change', function () {
                // Kiểm tra trạng thái checked của checkbox
                var redirectHref = checkbox.getAttribute('data-href');
                if (checkbox.checked) {
                    // alert('Checkbox is checked!');
                    window.location.href = redirectHref;
                } else {
                    // alert('Checkbox is unchecked!');
                    window.location.href = redirectHref;
                }
            });
        });


        var myCheckbox = document.getElementById('checkedAll');
        myCheckbox.addEventListener('change', function () {
            // Kiểm tra trạng thái checked của checkbox
            if (myCheckbox.checked) {
                // alert('Checkbox is checked!');
                window.location.href = "buy-product?active=all";
            } else {
                // alert('Checkbox is unchecked!');
                window.location.href = "buy-product?active=all";
            }
        });

    </script>

</div>
</body>

</html>