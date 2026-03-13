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

    <link rel="stylesheet" href="../css/payment.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous">
    </script>

</head>

<body>

<div class="page">
    <jsp:include page="header.jsp"></jsp:include>

    <%
        Cart cart = (Cart) session.getAttribute("cart");

    %>


    <form method="post" action="purchase">
        <div class="noi-dung">
            <div class="container">
                <div class="thong-tin-don-hang-va-bang-gia">
                    <div class="thong-tin-don-hang">
                        <div class="title">
                            Danh sách sản phẩm
                        </div>

                        <div class="box" style="padding: 0 15px;">
                            <ul style="padding: 0 ;">
                                <%
                                    for (Product p : cart.listProductBuy()) {
                                %>
                                <li class="san-pham-muon-mua">
                                    <div class="input-img-ten-san-pham">
                                        <div class="img-san-pham">

                                            <img src="<%=p.getPathFirstImage(request.getServletContext().getRealPath(""))%>" alt=""
                                                 style="max-width: 100%;max-height: 100%;height: auto;width: auto;">
                                        </div>

                                        <div class="ten-san-pham">
                                            <a href="product-detail?id=<%=p.getProductID()%>">
                                                <%=p.getName()%>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="cost">
                                        <p class="origin"><%=p.getRealPriceHaveDots()%>
                                        </p>
                                        <p class="sale"><%=p.getPriceHaveDots()%>
                                        </p>
                                    </div>

                                    <div class="unit">
                                        số lượng : <%=cart.getCart().get(p)%>
                                    </div>
                                </li>
                                <%
                                    }
                                %>


                            </ul>


                        </div>

                        <div class="title">
                            Địa chỉ nhận hàng
                        </div>

                        <div class="box address">

                            <div class="title" style="justify-content: space-between;">
                                <div style="all: inherit;">
                                    <i class="fa-solid fa-location-dot"></i>Địa chỉ
                                </div>


                                <!-- <button class="textChoosen">Thay đổi</button> -->


                            </div>
                            <div class="addressDetail">
                                <div class="choose_add">
                                    <select id="city" required name="city">
                                        <option value=""  selected >Chọn tỉnh thành</option>
                                    </select>

                                    <select id="district" required name="district">
                                        <option value=""  selected>Chọn quận huyện</option>
                                    </select>

                                    <select id="ward" required name="ward">
                                        <option value=""  selected>Chọn phường xã</option>
                                    </select>
                                </div>
                                <textarea required name="addressdetail" id="1" cols="30" rows="10" placeholder="Địa chỉ cụ thể"></textarea>
                            </div>

                            <div class="title">
                                <i class="fa-solid fa-user-large"></i>Nguyễn Hữu Phước
                                <div class="between">|</div>
                                <div class="sdt">0986216717</div>
                            </div>

                            <div class="ghi-chu">
                                <textarea name="comment" id="2" cols="30" rows="10" placeholder="Thêm ghi chú"></textarea>
                            </div>

                        </div>

                        <div class="box" style="margin-top: 15px;">
                            <div class="title" style="justify-content: space-between;">
                                <div style="all: inherit;">
                                    <i class="fa-solid fa-ticket"></i>Phiếu giảm giá
                                </div>

                                <button class="textChoosen">Chọn phiếu giảm giá</button>
                            </div>
                        </div>

                        <div class="title">
                            Chọn hình thức thanh toán
                        </div>

                        <div class="box thanh-toan">
                            <ul>
                                <li>
                                    <div class="type">
                                        <input type="radio" name="payment" checked>
                                        <i class="fa-solid fa-money-bill-wave"></i>Thanh toán tiền mặt khi nhận hàng
                                    </div>
                                </li>

                                <li>
                                    <div class="type">
                                        <input type="radio" name="payment">
                                        <i class="fa-solid fa-credit-card"></i>Thanh toán bằng thẻ tín dụng
                                    </div>
                                </li>


                            </ul>

                        </div>


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
                            <p>0đ</p>
                        </div>

                        <div class="title">
                            <p>Tiết kiệm được</p>
                            <p><%=cart.getTotalSalesHaveDots()%>
                            </p>
                        </div>

                        <div class="phi-van-chuyen">
                            <p class="title">Phí vận chuyển</p>
                            <p class="cost">25.000đ</p>
                        </div>

                        <div class="thanh-tien">
                            <p class="title">Thành tiền</p>
                            <p class="cost"><%=cart.getTotalPricesWithDeliveryHaveDots()%>
                            </p>
                        </div>

                        <a>
                            <button type="submit" class="mua-hang">Hoàn tất</button>
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
    </form>



    <jsp:include page="footer.jsp"></jsp:include>


    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
    <script>
        var citis = document.getElementById("city");
        var districts = document.getElementById("district");
        var wards = document.getElementById("ward");
        var Parameter = {
            url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
            method: "GET",
            responseType: "application/json",
        };
        var promise = axios(Parameter);
        promise.then(function (result) {
            renderCity(result.data);
        });

        function renderCity(data) {
            for (const x of data) {
                var opt = document.createElement('option');
                opt.value = x.Name;
                opt.text = x.Name;
                opt.setAttribute('data-id', x.Id);
                citis.options.add(opt);
            }
            citis.onchange = function () {
                district.length = 1;
                ward.length = 1;
                if (this.options[this.selectedIndex].dataset.id != "") {
                    const result = data.filter(n => n.Id === this.options[this.selectedIndex].dataset.id);

                    for (const k of result[0].Districts) {
                        var opt = document.createElement('option');
                        opt.value = k.Name;
                        opt.text = k.Name;
                        opt.setAttribute('data-id', k.Id);
                        district.options.add(opt);
                    }
                }
            };
            district.onchange = function () {
                ward.length = 1;
                const dataCity = data.filter((n) => n.Id === citis.options[citis.selectedIndex].dataset.id);
                if (this.options[this.selectedIndex].dataset.id != "") {
                    const dataWards = dataCity[0].Districts.filter(n => n.Id === this.options[this.selectedIndex].dataset.id)[0].Wards;

                    for (const w of dataWards) {
                        var opt = document.createElement('option');
                        opt.value = w.Name;
                        opt.text = w.Name;
                        opt.setAttribute('data-id', w.Id);
                        wards.options.add(opt);
                    }
                }
            };
        }
    </script>



</div>
</body>

</html>