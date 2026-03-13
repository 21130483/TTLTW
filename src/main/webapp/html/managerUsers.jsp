<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="../css/managerUsers.css">
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
                    <div class="a" style="background-color: #007bff;">
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

    <div class="quan-ly-thanh-vien">
        <div class="title">
            <p>Quản lý thành viên</p>
        </div>

        <div class="danh-sach-block">
            <a href="">
                <div class="a">
                    Danh sách Block
                </div>
            </a>
        </div>

        <div class="danh-muc-thanh-vien">
            <div class="ten-cot">
                <input type="text" placeholder="Id thành viên">
                <input type="text" placeholder="Email">
                <input type="text" placeholder="Họ và tên">
                <input type="text" placeholder="Số điện thoại">
                <input type="text" placeholder="Chức vụ">

                <!-- <p>Id thành viên</p>
                <p>Email</p>
                <p>Số điện thoại</p>
                <p>Chức vụ</p> -->
                <div class="button">
                    <button>Tìm kiếm</button>
                </div>
            </div>

            <ul>
                <%
                    List<User> users = (List) request.getAttribute("getAllUsers");
                %>

                <%
                    if (users != null) {
                        for (User u : users) {
                %>

                <li class="box-thanh-vien">
                    <div class="thanh-vien">
                        <p><%=u.getUserID()%>
                        </p>
                        <p><%=u.getEmail()%>
                        </p>
                        <p><%=u.getFullName()%>
                        </p>
                        <p><%=u.getPhoneNumbers()%>
                        </p>
                        <p>
                            <%
                                String role;
                                if (u.getRole()) {
                                    role = "Admin";
                                } else {
                                    role = "Khách hàng";
                                }
                            %>
                            <%=role%>
                        </p>
                        <div class="sua-block">
                            <a href="edituser?id=<%=u.getUserID()%>">
                                <button class="sua">Sửa</button>
                            </a>

<%--                            <button class="block">Block</button>--%>
                        </div>
                    </div>

                </li>
                <%
                        }
                    }
                %>


            </ul>


        </div>
    </div>
</div>
</body>
</html>