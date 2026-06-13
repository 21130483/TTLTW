<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%@ page import="model.Cart" %>
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

    <link rel="stylesheet" href="../css/header.css">
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

<!-- <div class="page"> -->
<div class="header">
    <div class="container">
        <div class="icon-input-info-cart">
            <div class="logo-shop">
                <a href="index.jsp" class="background-logo-shop">
                    <img src="../image/header/LogoPharmacity.png">
                </a>
            </div>


            <form action="findProduct" method="post" style="position: relative;">
                <div class="thanh-tim-san-pham">
                        <span class="input-va-button-tim-kiem">
                            <input class="input" type="text" name="textFindProduct" id="textFindProduct"
                                   placeholder="Tìm tên thuốc, bệnh lý, thực phẩm chức năng..." required
                                   oninput="searchAjax(this.value)">

                            <button type="submit" style="border: none; background: transparent"><i
                                    class="fa-solid fa-magnifying-glass"></i></button>

                        </span>
                </div>
                <ul id="product-suggestions" class="product-suggestions" style="position: absolute; top: 60px; left: 0; right: 0; background: white; border-radius: 5px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); display: none; flex-direction: column; z-index: 1000; text-align: left; padding: 10px 0; margin: 0; list-style: none;">
                </ul>
            </form>


            <div class="info-cart">


                <div class="cart">
                    <div class="button">
                        <a href="carts" class="link-button">
                            <div class="icon">
                                <i class="fa-solid fa-cart-shopping" style="position: relative; display: inline-block;">

                                    <p id="sizeCart" style="position: absolute; top: -10px; right: -10px; background-color: red; color: white; border-radius: 50%; padding: 2px;">
                                        <%= session.getAttribute("sizeCart") != null ? session.getAttribute("sizeCart") : 0 %>
                                    </p>


                                </i>
                            </div>
                            <span class="span-text">Giỏ hàng</span>
                        </a>
                    </div>
                </div>

                <div class="info">
                    <div class="button">
                        <div class="icon">
                            <i class="fa-solid fa-user"></i>
                        </div>
                        <% User user = (User) session.getAttribute("user");%>
                        <% if (user != null) {%>
                        <a href="<c:url value="/html/account"/> " class="link-button">
                            <span class="span-text"><%=user.getFullName()%></span>
                        </a>
                        <% } else {%>
                        <a href="login.jsp" class="link-button">
                            <span class="span-text">Đăng nhập</span>
                        </a>
                        <% }%>

                    </div>
                </div>
            </div>
        </div>


    </div>
</div>
<div class="menu">
    <div class="container">
        <ul class="category-menus">
            <li><a href="findProduct?active=category&categoryID=1" class="category-menu">Khẩu trang</a></li>
            <li><a href="findProduct?active=category&categoryID=3" class="category-menu">Máy đo huyết áp</a></li>
            <li><a href="findProduct?active=category&categoryID=2" class="category-menu">Máy massage</a></li>
            <li><a href="findProduct?active=category&categoryID=6" class="category-menu">Nhiệt kế</a></li>
            <li><a href="findProduct?active=category&categoryID=4" class="category-menu">Băng - Gạc y tế</a></li>
            <li><a href="sick.jsp" class="category-menu">Bệnh</a></li>
<%--            <li><a href="" class="category-menu">Góc sức khỏe</a></li>--%>
            <li><a href="introduce.jsp" class="category-menu">Giới thiệu</a></li>
        </ul>
    </div>
</div>
<!-- </div> -->
</body>

<script>
    function searchAjax(text) {
        var suggestions = document.getElementById('product-suggestions');
        if (text.trim() === '') {
            suggestions.style.display = 'none';
            return;
        }
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'searchAjax?text=' + encodeURIComponent(text), true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var response = xhr.responseText.trim();
                if (response !== '') {
                    suggestions.innerHTML = response;
                    suggestions.style.display = 'flex';
                } else {
                    suggestions.style.display = 'none';
                }
            }
        };
        xhr.send();
    }

    document.addEventListener('click', function(event) {
        var suggestions = document.getElementById('product-suggestions');
        var input = document.getElementById('textFindProduct');
        if (event.target !== input && event.target !== suggestions && !suggestions.contains(event.target)) {
            suggestions.style.display = 'none';
        }
    });
</script>

</html>