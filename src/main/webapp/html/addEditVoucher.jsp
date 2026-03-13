<%@ page import="dao.CategoryDAO" %>
<%@ page import="model.Category" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="../css/addEditVoucher.css">
</head>
<body>
<div class="noi-dung">
    <div class="them-sua-san-pham">
        <div class="thong-tin-san-pham">
            <p>Thông tin phiếu giảm giá</p>
        </div>


        <%
            CategoryDAO categoryDAO = new CategoryDAO();
            String active = request.getParameter("active");
            if (active.equals("add")) {


        %>
        <form action="category?active=add" method="post">

            <div class="dien-thong-tin">
                <div class="box">
                    Id loại sản phẩm
                    <input name="id" type="text" value="<%=categoryDAO.getIdNewCategory()%>" readonly>

                </div>


                <div class="box" required>
                    Tên loại sản phẩm
                    <input name="name" type="text">
                </div>


            </div>


            <div class="button-them-huy">
                <button type="submit" style="background-color: inherit;border: none; height: auto; width: auto" >
                    <div class="them">
                        Thêm
                    </div>
                </button>

                <a href="admin?page=voucher">
                    <div class="huy">
                        Hủy
                    </div>
                </a>
            </div>
        </form>
        <%
        } else {
            int id = Integer.parseInt(request.getParameter("id"));
            Category category = categoryDAO.getCategoryById(id);
        %>
        <form action="category?active=edit" method="post">

            <div class="dien-thong-tin">
                <div class="box">
                    Id loại sản phẩm
                    <input name="id" type="text" value="<%=category.getCategoryID()%>" readonly>

                </div>


                <div class="box"  required>
                    Tên loại sản phẩm
                    <input name="name" value="<%=category.getName()%>" type="text">
                </div>


            </div>


            <div class="button-them-huy">
                <button type="submit" style="background-color: inherit;border: none; height: auto; width: auto" >
                    <div class="them">
                        Cập nhật
                    </div>
                </button>

                <a href="admin?page=voucher">
                    <div class="huy">
                        Hủy
                    </div>
                </a>
            </div>
        </form>
        <%
            }
        %>
    </div>
</div>
</body>
</html>