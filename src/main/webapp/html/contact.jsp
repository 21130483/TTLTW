<<<<<<< HEAD
=======

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
>>>>>>> 21130440-NguyenThanhLuu
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <link rel="stylesheet" href="../css/contact.css">

</head>

<body>
  <div class="contact-main">
    <div class="contact-button">
      <i class="fa-solid fa-phone fa-bounce" style="color: #0f63f5; font-size: 32px;"></i>
    </div>

    <div class="contact-box">
      <div class="contact-info">
        <a href="#" style="text-decoration: none;">
          <span></span>
          <span></span>
          <span></span>
          <span></span>
          <h2>Thông tin liên lạc</h2>
          <h2>Email:</h2>
          <p style="color: #000;">LuuLongPhuoc@gamil.com</p>
          <h2>Số điện thoại:</h2>
          <p style="color: #000;">0162 ngày mai nói tiếp</p>
          <h2>Địa chỉ:</h2>
          <p style="color: #000;">Số 123,Tổ 3, Khu phố 6, Linh Trung, Thủ Đức, TP HCM</p>
        </a>
      </div>

    </div>
  </div>

</body>
  <script>
    $(document).ready(function () {
      $(".contact-button").click(function (e) {
        e.stopPropagation(); // khi click vào body - phần này thì nó sẽ ẩn đi
        $(".contact-info").toggle();
      });

      $(document).click(function (e) {
        if (!$(e.target).closest('.contact-info').length) {
          $(".contact-info").hide();
        }
      });

      $(".contact-info").click(function (e) {
        e.stopPropagation(); 
      });
    });
  </script>
</html>