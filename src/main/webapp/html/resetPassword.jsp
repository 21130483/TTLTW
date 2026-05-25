<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <title>Reset Password</title>
</head>
<body>
<div class="section">
    <div class="form-container">
        <div class="form">
            <h2 class="form-title"><span>Đặt lại mật khẩu</span></h2>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <div style="color: red; margin-bottom: 10px; text-align: center;"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/reset-password" method="POST">
            <input type="hidden" name="token" value="${token}">
            
            <div class="form-group">
                <input type="password" name="password" class="form-style" placeholder="Nhập mật khẩu mới" required>
                <i class="input-icon fa-solid fa-lock"></i>
            </div>
            
            <div class="form-group">
                <input type="password" name="confirmPassword" class="form-style" placeholder="Xác nhận mật khẩu mới" required>
                <i class="input-icon fa-solid fa-lock"></i>
            </div>
            
            <button type="submit" class="btn">Đổi mật khẩu</button>
        </form>
        <div class="register-link">
            <p>Trở lại <a href="${pageContext.request.contextPath}/html/login.jsp" class="login">Đăng nhập</a></p>
        </div>
    </div>
</div>
</body>
</html>
