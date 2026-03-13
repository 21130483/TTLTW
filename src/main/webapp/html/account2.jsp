<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Nhà Thuốc</title>

    <link rel="stylesheet" href="../css/account2.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"></script>
</head>

<body>
<%@ page import="model.Account" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%
    User user = (User) session.getAttribute("user");
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
                        <li class="menu_account choose">
                            <i class="fa-solid fa-user"></i>
                            Thông tin cá nhân
                        </li>
                    </a>

                    <a href="listbill?status=all">
                        <li class="menu_account">
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
                    Thông tin cá nhân
                </div>

                <div class="content">
                    <div class="infor">
                        <form action="user-edit?userId=<%=user.getUserID()%>" method="post">
                            <div class="infor_row">
                                Họ và tên
                                <input name="full_name" value="<%=user.getFullName()%>">
                            </div>

                            <div class="infor_row">
                                Số điện thoại
                                <input name="phone_number" value="<%=user.getPhoneNumbers()%>">
                            </div>

                            <div class="infor_row">
                                Giới tính
                                <div style="display: grid;grid-template-columns: 1fr 1fr">
                                    <div style="font-size: 20px;justify-content: center">
                                        Nam<input type="radio" name="gender" value="nam"
                                        <%
                                       if (user.getGender().equals("nam")){
                                    %>
                                                  checked
                                        <%
                                        }
                                    %>
                                    >
                                    </div>
                                    <div style="font-size: 20px">
                                        Nữ<input type="radio" name="gender" value="nữ"
                                        <%
                                       if (user.getGender().equals("nữ")){
                                    %>
                                                 checked
                                        <%
                                        }
                                    %>
                                    >
                                    </div>

                                </div>

                            </div>

                            <div class="infor_row">
                                Ngày sinh
                                <input name="dob" type="date" value="<%=user.getDobString()%>">
                            </div>

                            <div class="infor_row">
                                Email
                                <input name="email" value="<%=user.getEmail()%>">
                            </div>
                            <button type="submit">Cập nhật thông tin</button>
                        </form>
                    </div>

                </div>


            </div>
        </div>
    </div>

</div>

<jsp:include page="footer.jsp"></jsp:include>

</body>

</html>