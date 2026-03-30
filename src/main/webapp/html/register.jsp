<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
  <title>Register</title>
  <style>
          .error-message {
              color: red;
              font-size: 0.8em;
              margin-top: -10px;
              margin-bottom: 10px;
              display: block;
          }
      </style>
</head>
<body>

<div class = "section">
  <div class="form-container">
    <form action="${pageContext.request.contextPath}/register" method="POST">
    <div class="form">
      <h2 class="form-title"><span>Đăng ký</span></h2>
      <c:if test="${not empty error}">
        <span class="error-message">${error}</span>
      </c:if>
    </div>
    <div class="form-group">
      <input type="text" name="username" class="form-style" placeholder="Họ và tên" id="username" value="${param.username}" required>
      <i class="input-icon fa-regular fa-user"></i>
    </div>
    <div class="form-group">
      <input type="email" name="email" class="form-style" placeholder="Email" id="email" value="${param.email}" required>
      <i class="input-icon fa-regular fa-envelope"></i>
    </div>
    <c:if test="${not empty invalidateEmail}">
      <span class="error-message">${invalidateEmail}</span>
    </c:if>
    <div class="form-group">
      <input type="text" name="phoneNumbers" class="form-style" placeholder="Số điện thoại" id="phoneNumbers" value="${param.phoneNumbers}" required>
      <i class="input-icon fa-solid fa-phone"></i>
    </div>
    <div class="form-group">
      <input type="date" name="dob" class="form-style" placeholder="Ngày sinh" id="dob" value="${param.dob}" required>
      <i class="input-icon fa-regular fa-calendar" style="top: 15px;"></i>
    </div>
    <div class="form-group">
      <select name="gender" class="form-style" style="background-color: #1f2029; color: #c4c3ca;" required>
        <option value="" disabled ${empty param.gender ? 'selected' : ''}>Giới tính</option>
        <option value="nam" ${param.gender == 'nam' ? 'selected' : ''}>Nam</option>
        <option value="nữ" ${param.gender == 'nữ' ? 'selected' : ''}>Nữ</option>
        <option value="khác" ${param.gender == 'khác' ? 'selected' : ''}>Khác</option>
      </select>
      <i class="input-icon fa-solid fa-venus-mars"></i>
    </div>
    <div class="form-group">
      <input type="password" name="password" class="form-style" placeholder="Mật khẩu" id="password" required>
      <i class="input-icon fa-solid fa-unlock-keyhole"></i>
    </div>
    <c:if test="${not empty invalidatePassword}">
      <span class="error-message">${invalidatePassword}</span>
    </c:if>
    <div class="form-group">
      <input type="password" name="confirmPassword" class="form-style" placeholder="Nhập lại mật khẩu" id="confirmPassword" required>
      <i class="input-icon fa-solid fa-unlock-keyhole"></i>
    </div>
    <c:if test="${not empty invalidateConfimPassword}">
      <span class="error-message">${invalidateConfimPassword}</span>
    </c:if>
    <button type="submit" class="btn">ĐĂNG KÝ</button>
    </form>
    <div class="login-link">
      <p> Bạn đã có tài khoản?
        <a href="login.jsp" class="signin">Đăng nhập</a></p>
      <div class = "form-icon">
        <button class="fb-btn">
          <a href="#" class = "icon">
            <img src="${pageContext.request.contextPath}/image/login/fb.png">Đăng nhập bằng Facebook</a></button>
        <button class="google-btn">
          <a href="#" class = "icon">
            <img src="${pageContext.request.contextPath}/image/login/google.png">Đăng nhập bằng Google</a>
        </button>
      </div>
    </div>
  </div>
</div>
</body>
</html>
