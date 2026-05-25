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
<div class="section">
    <div class="form-container">
        <div class="form">
            <h2 class="form-title"><span>Quên mật khẩu</span></h2>
        </div>
        
        <!-- Hiển thị thông báo lỗi hoặc thành công -->
        <% if (request.getAttribute("error") != null) { %>
            <div style="color: red; margin-bottom: 10px; text-align: center;"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            <div style="color: green; margin-bottom: 10px; text-align: center;"><%= request.getAttribute("success") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/forgot" method="POST">
            <div class="form-group">
                <input type="email" name="email" class="form-style" placeholder="Nhập địa chỉ Email của bạn" id="logemail" required autocomplete="off">
                <i class="input-icon fa-regular fa-envelope"></i>
            </div>
            <button type="submit" class="btn">Gửi link khôi phục</button>
        </form>
        <div class="register-link">
            <p>Bạn đã nhớ lại mật khẩu?
                <a href="${pageContext.request.contextPath}/html/login.jsp" class="login">Đăng nhập</a></p>
        </div>
    </div>
</div>
</body>
</html>
