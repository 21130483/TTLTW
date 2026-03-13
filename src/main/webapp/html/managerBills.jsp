<%@ page import="java.util.List" %>
<%@ page import="model.Purchases" %>
<%@ page import="model.User" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="model.Product" %>
<%@ page import="dao.ProductDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="../css/managerBills.css">


</head>

<body>
<div class="noi-dung">
    <div class="muc-luc">
        <div class="title">
            <p>Quản lý</p>
        </div>
        <ul>
            <li class="button-muc-luc">
                <a href="admin?page=product">
                    <div class="a">
                        Quản lý sản phẩm
                    </div>
                </a>
            </li>

            <li class="button-muc-luc">
                <a href="admin?page=user">
                    <div class="a">
                        Quản lý thành viên
                    </div>
                </a>
            </li>

            <li class="button-muc-luc">
                <a href="admin?page=bill">
                    <div class="a" style="background-color: #007bff;">
                        Quản lý hóa đơn
                    </div>
                </a>
            </li>

            <li class="button-muc-luc">
                <a href="admin?page=voucher">
                    <div class="a">
                        Quản lý loại sản phẩm
                    </div>
                </a>
            </li>

            <li class="button-muc-luc" style="margin-top: 50px;">
                <a href="index.jsp">
                    <div class="a">
                        Quay về trang chủ
                    </div>
                </a>
            </li>
        </ul>
    </div>

    <div class="quan-ly">
        <div class="quan-ly-san-pham">
            <div class="title">
                <p>Quản lý hóa đơn</p>
            </div>

            <div class="danh-muc-san-pham">
                <div class="ten-cot">
                    <input type="text" placeholder="Id hóa đơn">
                    <input type="text" placeholder="Id khách hàng">
                    <input type="text" placeholder="Tên khách hàng">
                    <input type="text" placeholder="Tổng giá">
                    <input type="text" placeholder="Trạng thái">
                    <!-- <input type="text" placeholder=""> -->
                    <div class="button">
                        <button>Tìm kiếm</button>
                    </div>
                </div>

                <ul>
                    <%
                        List<Purchases> purchases = (List) request.getAttribute("getAllPurchases");
                        UserDAO userDAO = new UserDAO();
                        ProductDAO productDAO = new ProductDAO();
                        if (purchases != null) {
                            for (Purchases p : purchases) {
                                User user = userDAO.getUserById(p.getUserID());
                                Product product = productDAO.getProductById(p.getProductID());

                    %>

                    <li class="box-san-pham">
                        <div class="san-pham">
                            <p><%=p.getPurchaseID()%>
                            </p>
                            <p style="overflow: hidden; text-overflow: ellipsis;  white-space: nowrap;"><%=product.getName()%>
                            </p>
                            <p><%=user.getFullName()%>
                            </p>
                            <p><%=p.getPrice()%>
                            </p>
                            <div class="center">
                                <span class="cho-xac-nhan" style="
                                    <%
                                            if (p.getStatus() == 0) {
                                        %>
                                        background-color: yellow;
                                    <%} else if (p.getStatus() == 1) {%>
                                        background-color: #3498db;
                                    <%
                                        } else if (p.getStatus() == 2) {
                                        %>
                                        background-color: #00FF00;
                                    <%
                                        } else {
                                        %>
                                        background-color: red;
                                    <%}%>
                                        ">
                                    <%=p.getStatusString()%>
                                </span>
                            </div>

                            <!-- <p>11/1/2023</p> -->
                            <div class="box-button">
                                <%
                                    if (p.getStatus() == 0) {
                                %>
                                <a href="bill?active=confirm&purchaseid=<%=p.getPurchaseID()%>&userid=<%=p.getUserID()%>&productid=<%=p.getProductID()%>">
                                    <button style="background-color: #007bff">Xác nhận</button>
                                </a>
                                <a href="bill?active=cancel&purchaseid=<%=p.getPurchaseID()%>&userid=<%=p.getUserID()%>&productid=<%=p.getProductID()%>">
                                    <button style="margin: 0 20px 0;background-color: red">Hủy</button>
                                </a>


                                <%
                                } else if (p.getStatus() == 1) {
                                %>
                                <a href="bill?active=confirm&purchaseid=<%=p.getPurchaseID()%>&userid=<%=p.getUserID()%>&productid=<%=p.getProductID()%>">
                                    <button style="background-color: #007bff">Hoàn thành</button>
                                </a>
                                <a href="bill?active=cancel&purchaseid=<%=p.getPurchaseID()%>&userid=<%=p.getUserID()%>&productid=<%=p.getProductID()%>">
                                    <button style="margin: 0 20px 0;background-color: red">Hủy</button>
                                </a>


                                <%
                                    }
                                %>
                                <%--                                <button>Chi tiết</button>--%>
                            </div>
                        </div>

                    </li>
                    <%
                            }
                        }
                    %>
                    <%--                    <li class="box-san-pham">--%>
                    <%--                        <div class="san-pham">--%>
                    <%--                            <p>123</p>--%>
                    <%--                            <p>123</p>--%>
                    <%--                            <p>Nguyễn Thanh Lưu</p>--%>
                    <%--                            <p>10.000.000</p>--%>
                    <%--                            <div class="center">--%>
                    <%--                                <span class="dang-giao">Đang giao</span>--%>
                    <%--                            </div>--%>
                    <%--                            <!-- <p>11/1/2023</p> -->--%>
                    <%--                            <div class="box-button">--%>
                    <%--                                <button>Chi tiết</button>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                    <%--                    </li>--%>

                    <%--                    <li class="box-san-pham">--%>
                    <%--                        <div class="san-pham">--%>
                    <%--                            <p>123</p>--%>
                    <%--                            <p>123</p>--%>
                    <%--                            <p>Hồng Phúc Long</p>--%>
                    <%--                            <p>10.000.000</p>--%>
                    <%--                            <div class="center">--%>
                    <%--                                <span class="hoan-thanh">Hoàn thành</span>--%>
                    <%--                            </div>--%>
                    <%--                            <!-- <p>11/1/2023</p> -->--%>
                    <%--                            <div class="box-button">--%>
                    <%--                                <button>Chi tiết</button>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                    <%--                    </li>--%>


                </ul>
            </div>
        </div>
    </div>
</div>
</body>

</html>