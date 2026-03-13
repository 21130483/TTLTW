<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="../css/login.css">

    <title>Login</title>
</head>
<body>
<% String err = (String) request.getAttribute("err") == null ? "" : (String) request.getAttribute("err"); %>
<div class="section">
    <div class="form-container">
        <form method="post" action="login">


            <div class="form">
                <a href="index.jsp" style="text-decoration: none">
                    <h2 class="form-title"><span>Đăng nhập</span></h2>
                </a>
            </div>
            <div>
                <%
                    String content = (String) request.getAttribute("content");
                    if (content != null) {
                %>
                <p style="color: red"><%=content%></p>
                <%
                    }
                %>

            </div>
            <div class="form-group">
                <input type="email" name="email" value="" class="form-style" placeholder="Email hoặc tên đăng nhập"
                       id="logemail"
                       autocomplete="off">
                <i class="input-icon fa-regular fa-envelope"></i>
            </div>
            <div class="form-group">
                <input type="password" name="pass" class="form-style" value="" placeholder="Mật khẩu" id="logpass"
                       autocomplete="off">
                <i class="input-icon fa-solid fa-unlock-keyhole"></i>
            </div>
            <div class="forgot">
                <a href="forgot.jsp" class="forgot-pass">Quên mật khẩu?</a>
            </div>
            <button type="submit" class="btn">ĐĂNG NHẬP</button>
        </form>
        <div class="register-link">
            <p> Bạn chưa có tài khoản?
                <a href="register.jsp" class="signup">Đăng ký</a></p>
        </div>
        <p class="text-center">----- Hoặc -----</p>
        <div class="form-icon">
            <button class="fb-btn">
                <a href="#" class="icon">
                    <img src="../image/login/fb.png">Đăng nhập bằng Facebook</a></button>
            <button class="google-btn">
                <a href="#" class="icon">
                    <img src="../image/login/google.png">Đăng nhập bằng Google</a>
            </button>
        </div>

    </div>
</div>


</body>
</html>