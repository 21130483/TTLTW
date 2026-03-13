<%@ page import="dao.CategoryDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page import="dao.ProductDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="../css/managerVouchers.css">

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
                    <div class="a">
                        Quản lý hóa đơn
                    </div>
                </a>
            </li>

            <li class="button-muc-luc">
                <a href="admin?page=voucher" >
                    <div class="a" style="background-color: #007bff;">
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
        <div class="quan-ly-voucher">
            <div class="title">
                <p>Quản lý loại sản phẩm</p>
            </div>

            <div  class="them-voucher">
                <a href="category?active=add">
                    <div class="a">
                        Thêm loại sản phẩm
                    </div>
                </a>
            </div>

            <div class="danh-muc-voucher">
                <div class="ten-cot">
                    <input type="text" placeholder="Id loại sản phẩm">
                    <input type="text" placeholder="loại sản phẩm">
                    <input type="text" placeholder="Số lượng sản phẩm">
                    <!-- <input type="text" placeholder="Ngày cập nhật"> -->

                    <div class="button">
                        <button>Tìm kiếm</button>
                    </div>
                </div>

                <ul>
                    <%
                        CategoryDAO categoryDAO = new CategoryDAO();
                        ProductDAO productDAO = new ProductDAO();
                        List<Category> categories = categoryDAO.getAllCategory();
                        for (Category c : categories){
                    %>
                    <li class="box-san-pham">
                        <div class="san-pham">
                            <p><%=c.getCategoryID()%></p>
                            <p><%=c.getName()%></p>
                            <p><%=productDAO.countProductByCategory(c.getCategoryID())%></p>
                            <!-- <p>11/1/2023</p> -->
                            <div class="sua-xoa">
                                <a href="category?active=edit&id=<%=c.getCategoryID()%>">
                                    <button class="sua">Sửa</button>
                                </a>

                                <a href="category?active=delete&id=<%=c.getCategoryID()%>">
                                    <button class="xoa">Xóa</button>
                                </a>



                            </div>
                        </div>

                    </li>
                    <%
                        }
                    %>





                </ul>
            </div>
        </div>

    </div>


</div>
</body>
</html>