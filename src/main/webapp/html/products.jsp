<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.Category" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
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

    <link rel="stylesheet" href="../css/products.css">
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
        List<Product> getFindProducts = (List) request.getAttribute("getFindProducts");
        int categoryID = (int) request.getAttribute("getCategoryID");
        List<Category> categories = (List) request.getAttribute("getCategories");
        int currentPage = (int) request.getAttribute("getcurrentPage");
        int numberPages = (int) request.getAttribute("getnumberPages");
        int priceBy = (int) request.getAttribute("getpriceBy");
        int detail = (int) request.getAttribute("getDetail");
        int from = (int) request.getAttribute("getFrom");
        int to = (int) request.getAttribute("getTo");
    %>


    <div class="noi-dung">
        <div class="bang-sap-xep">
            <div class="container"
                 style="display: flex; margin-bottom: 0;padding-bottom: 0;justify-content: space-between">
                <p style="font-size: 18px;">Kết quả tiềm kiếm cho từ khóa
                    "<%=
                    request.getAttribute("textFindProducts")
                    %>"
                </p>

                <form action="findProduct" method="get">
                    <input value="category" name="active" style="display: none">
                    <select name="categoryID" style="font-size: 17px">
                        <option value="0" style="font-size: 17px"
                                <%
                                    if (categoryID == 0) {
                                %>
                                selected
                                <%
                                    }
                                %>
                        >Mặc định
                        </option>
                        <%
                            for (Category c : categories) {
                        %>
                        <option value="<%=c.getCategoryID()%>" style="font-size: 17px"
                                <%
                                    if (c.getCategoryID() == categoryID) {
                                %>
                                selected
                                <%
                                    }
                                %>
                        >
                            <%=c.getName()%>
                        </option>
                        <%
                            }
                        %>
                    </select>

                    <button type="submit"
                            style="width: 100px;height: 27px; font-size: 16px;border: none;background-color: #305BD4;color: white;border-radius: 10px;">
                        Áp dụng
                    </button>
                </form>
            </div>
            <div class="container">
                <div class="sap-xep-theo">
                    Sắp xếp theo
                </div>

                <div class="che-do">
                    <div class="lien-quan">
                        <a href="findProduct?active=detail&detail=0">
                            <button
                                    <%
                                        if (detail == 0) {

                                    %>
                                    style="background-color: #3F85EA"
                                    <%
                                        }
                                    %>
                            >Liên quan
                            </button>
                        </a>

                    </div>

                    <div class="moi-nhat">
                        <a href="findProduct?active=detail&detail=1">
                            <button
                                    <%
                                        if (detail == 1) {

                                    %>
                                    style="background-color: #3F85EA"
                                    <%
                                        }
                                    %>
                            >Mới nhất
                            </button>
                        </a>

                    </div>

                    <div class="ban-chay">
                        <a href="findProduct?active=detail&detail=2">
                            <button
                                    <%
                                        if (detail == 2) {

                                    %>
                                    style="background-color: #3F85EA"
                                    <%
                                        }
                                    %>
                            >Bán chạy
                            </button>
                        </a>

                    </div>
                </div>

                <div class="gia">

                    <a href="findProduct?active=price" style="text-decoration: none">
                        <button class="button-gia" style="justify-content: center">
                            <%
                                if (priceBy == 0) {
                            %>
                            <span>Giá mặc định</span>
                            <%
                            } else if (priceBy == 1) {
                            %>
                            <span>Giá từ thấp đến cao</span>
                            <%
                            } else {
                            %>
                            <span>Giá từ cao đến thấp</span>
                            <%
                                }
                            %>
                        </button>


                    </a>

                </div>

                <form action="findProduct" method="get">
                    <div class="khoang-gia">
                        <div class="title">
                            Khoảng giá
                        </div>


                        <div class="from">
                            <input name="from" type="number" value="<%=from%>"
                            <%--                                   oninput="validateInput(event)"--%>
                            >
                            <script>
                                function validateInput(event) {
                                    // Lấy giá trị nhập vào từ sự kiện
                                    var inputValue = event.target.value;

                                    // Loại bỏ các ký tự không phải số từ giá trị nhập vào
                                    var numericValue = inputValue.replace(/[^0-9]/g, '');

                                    // Cập nhật giá trị của trường input
                                    event.target.value = numericValue;
                                }
                            </script>
                        </div>

                        <div class="between">
                            <i class="fa-solid fa-minus"></i>
                        </div>

                        <div class="to">
                            <input name="to" type="number" value="<%=to%>"
                            <%--                                   oninput="validateInput(event)"--%>
                            >
                            <script>
                                function validateInput(event) {
                                    // Lấy giá trị nhập vào từ sự kiện
                                    var inputValue = event.target.value;

                                    // Loại bỏ các ký tự không phải số từ giá trị nhập vào
                                    var numericValue = inputValue.replace(/[^0-9]/g, '');

                                    // Cập nhật giá trị của trường input
                                    event.target.value = numericValue;
                                }
                            </script>
                        </div>

                        <div class="ap-dung">

                            <button type="submit">Áp dụng</button>
                            <input type="text" name="active" value="between" style="display: none">
                        </div>
                    </div>
                </form>


            </div>
        </div>

        <div class="danh-sach-san-pham">
            <div class="container">
                <div class="cac-san-pham">
                    <ul>


                        <%
                            if
                            (getFindProducts != null) {
                                for (int i = 0 + ((currentPage - 1) * 20); i < 20 * currentPage; i++) {

                                    if (getFindProducts.size() <= i) {
                                        break;
                                    } else {
                                        Product p = getFindProducts.get(i);

                        %>
                        <li class="san-pham">
                            <a href="product-detail?id=<%=p.getProductID()%>" class="link-san-pham">
                                <div class="img-san-pham">

                                    <img src="<%=p.getPathFirstImage(request.getServletContext().getRealPath(""))%>"
                                         alt="">
                                </div>

                                <div class="noi-dung-san-pham">
                                    <div class="khoang-trong"></div>

                                    <div class="ten-san-pham"
                                         style="max-height: 50px; max-width: 224px;overflow: hidden; text-overflow: ellipsis">
                                        <%=p.getName()%>
                                    </div>

                                        <div class="khoang-trong"></div>

                                    <div class="gia-san-pham">
                                        <%=p.getPriceHaveDots()%>
                                    </div>

                                    <form action="cart?id=<%=p.getProductID()%>&active=add&page=products" method="post"
                                          style="width: 100%; height: 100%">
                                        <button type="submit" class="them-san-pham">
                                            Thêm vào giỏ hàng
                                        </button>
                                    </form>


                                </div>
                            </a>
                        </li>
                        <%
                                    }
                                }
                            }
                        %>
                    </ul>

                </div>


                <div class="so-trang-san-pham">
                    <ul>
                        <%
                            if (currentPage != 1) {
                        %>
                        <li>
                            <a href="findProduct?active=page&page=<%=currentPage-1%>">
                                <button><i class="fa-solid fa-angle-left"></i></button>
                            </a>
                        </li>

                        <%
                            }
                        %>

                        <%
                            for (int i = 1; i <= numberPages; i++) {
                        %>
                        <li>
                            <a href="findProduct?active=page&page=<%=i%>"><%=i%>
                            </a>
                        </li>
                        <%
                            }
                        %>


                        <%
                            if (currentPage != numberPages) {
                        %>
                        <li>
                            <a href="findProduct?active=page&page=<%=currentPage+1%>">
                                <button><i class="fa-solid fa-angle-right"></i></button>
                            </a>
                        </li>

                        <%
                            }
                        %>

                    </ul>
                </div>


            </div>

        </div>

    </div>


    <jsp:include page="footer.jsp"></jsp:include>
</div>
</body>

</html>