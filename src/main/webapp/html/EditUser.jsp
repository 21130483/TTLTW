<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page import="model.Origin" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="../css/addEditProduct.css">
</head>
<body>
<div class="noi-dung">
    <%
        String active = request.getParameter("active");
        List<Category> categories = (List) request.getAttribute("getCategories");
        List<Origin> origins = (List) request.getAttribute("getOrigins");
        ;

    %>
    <div class="them-sua-san-pham">
        <div class="thong-tin-san-pham">
            <p>Thông tin thành viên</p>
        </div>
        <%
            int id = Integer.parseInt(request.getParameter("id"));
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserById(id);

        %>


        <form action="edituser" method="post">
            <div class="dien-thong-tin">
                <div class="box">
                    Id thành viên
                    <input name="id" type="text" value="<%=user.getUserID()%>" readonly>
                    Tên thành viên
                    <input type="text" value="<%=user.getFullName()%>" readonly>
                    Email
                    <input type="text" value="<%=user.getEmail()%>" readonly>
                    Số điện thoại
                    <input type="text" value="<%=user.getPhoneNumbers()%>" readonly>
                </div>

                <div class="box">
                    Ngày sinh
                    <input type="text" value="<%=user.getDob()%>" readonly>
                    Giới tính
                    <input type="number" value="<%=user.getUserID()%>" readonly>
                    Hoạt động
                    <select name="access">

                        <option value="true"
                                <%
                                    if (user.getAccess()){

                                %>
                                selected
                                <%
                                    }
                                %>
                        >Hoạt động</option>
                        <option value="false"
                                <%
                                    if (!user.getAccess()){

                                %>
                                selected
                                <%
                                    }
                                %>
                        >Chặn</option>


                    </select>
                    Chức vụ
                    <select name="role">
                        <option value="true"
                                <%
                                    if (user.getRole()){

                                %>
                                selected
                                <%
                                    }
                                %>>Admin</option>
                        <option value="false"
                                <%
                                    if (!user.getRole()){

                                %>
                                selected
                                <%
                                    }
                                %>>khách hàng</option>

                    </select>
                </div>


            </div>

            <div class="button-them-huy">
                <button type="submit" style="background-color: inherit;border: none;height: auto;width: auto">
                    <div class="them">
                        Cập nhật
                    </div>
                </button>

                <a href="admin?page=user">
                    <div class="huy">
                        Hủy
                    </div>
                </a>

            </div>
        </form>


        <%--        <div class="dien-thong-tin">--%>
        <%--            <div class="box">--%>
        <%--                Id sản phẩm--%>
        <%--                <input type="text">--%>
        <%--                Tên sản phẩm--%>
        <%--                <input type="text">--%>
        <%--                Nhà sản xuất--%>
        <%--                <input type="text">--%>
        <%--                Xuất sứ--%>
        <%--                <input type="text">--%>
        <%--            </div>--%>


        <%--            <div class="box">--%>
        <%--                Loại sản phẩm--%>
        <%--                <input type="text">--%>
        <%--                Giá bán--%>
        <%--                <input type="text">--%>
        <%--                Số lượng--%>
        <%--                <input type="text">--%>
        <%--                Giảm giá--%>
        <%--                <input type="text" placeholder="1% - 100%">--%>
        <%--            </div>--%>


        <%--        </div>--%>

        <%--        <div class="hinh-anh">--%>
        <%--            Hình ảnh--%>
        <%--            <input type="text">--%>
        <%--        </div>--%>

        <%--        <div class="chi-tiet">--%>
        <%--            Chi tiết--%>
        <%--            <textarea></textarea>--%>
        <%--        </div>--%>

        <%--        <div class="button-them-huy">--%>
        <%--            <a href="quanlysanpham.html">--%>
        <%--                <div class="them">--%>
        <%--                    Thêm sản phẩm--%>
        <%--                </div>--%>
        <%--            </a>--%>

        <%--            <a href="quanlysanpham.html">--%>
        <%--                <div class="huy">--%>
        <%--                    Hủy--%>
        <%--                </div>--%>
        <%--            </a>--%>
        <%--            <!-- <button class="them">Thêm sản phẩm</button>--%>
        <%--            <button class="huy">Hủy</button> -->--%>
        <%--        </div>--%>
    </div>
</div>
</body>
</html>