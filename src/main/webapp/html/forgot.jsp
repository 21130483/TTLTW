<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="../css/login.css">

    <title>Forgot Password</title>
</head>
<body>
<div class = "section">
    <div class = "form-container">
        <div class = "form">
            <h2 class ="form-title"><span>Quên mật khẩu</span></h2>
        </div>
        <div class = "form-group">
            <input type="email" name="logemail" class="form-style" placeholder="Email hoặc tên đăng nhập" id="logemail" autocomplete="off">
            <i class="input-icon fa-regular fa-envelope"></i>
        </div>
        <button class="btn">Tiếp tục</button>
        <div class = "register-link">
            <p> Bạn đã có tài khoản?
                <a href="login.jsp" class = "login">Đăng nhập</a></p>
        </div>
    </div>
</div>

</body>
</html>
