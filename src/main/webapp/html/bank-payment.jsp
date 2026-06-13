<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán Chuyển Khoản - Nhà Thuốc</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            margin: 0;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
        }
        .container {
            background: rgba(255, 255, 255, 0.95);
            max-width: 600px;
            width: 100%;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 30px;
            text-align: center;
        }
        .header h2 {
            color: #1a365d;
            margin-bottom: 5px;
        }
        .timer {
            background-color: #fee2e2;
            color: #dc2626;
            display: inline-block;
            padding: 6px 15px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 14px;
            margin-bottom: 25px;
        }
        .qr-card {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 20px;
            background: #fff;
            display: inline-block;
            margin-bottom: 25px;
        }
        .qr-image {
            width: 250px;
            height: 250px;
            border-radius: 8px;
        }
        .info-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            text-align: left;
        }
        .info-table th, .info-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #edf2f7;
        }
        .info-table th {
            color: #718096;
            font-weight: 500;
            width: 40%;
        }
        .info-table td {
            color: #2d3748;
            font-weight: bold;
        }
        .btn-copy {
            background: none;
            border: none;
            color: #3182ce;
            cursor: pointer;
            margin-left: 8px;
            font-size: 14px;
        }
        .btn-copy:hover {
            color: #2b6cb0;
            text-decoration: underline;
        }
        .footer-buttons {
            display: flex;
            gap: 15px;
        }
        .btn-confirm {
            flex: 2;
            background: #48bb78;
            color: white;
            border: none;
            padding: 14px;
            border-radius: 8px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            transition: 0.2s;
        }
        .btn-confirm:hover {
            background: #38a169;
        }
        .btn-cancel {
            flex: 1;
            background: #e2e8f0;
            color: #4a5568;
            border: none;
            padding: 14px;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.2s;
        }
        .btn-cancel:hover {
            background: #cbd5e0;
        }
    </style>
</head>
<body>

<%
    Integer orderId = (Integer) session.getAttribute("lastOrderId");
    Integer amount = (Integer) session.getAttribute("lastOrderAmount");
    
    if (orderId == null || amount == null) {
        response.sendRedirect("account");
        return;
    }

    String bankId = "MB";
    String accountNo = "0963383021";
    String accountName = "NGUYEN VAN A";
    String template = "compact";
    String transferContent = "THANHTOAN DH" + orderId;

    String qrUrl = "https://img.vietqr.io/image/" + bankId + "-" + accountNo + "-" + template + ".jpg"
                 + "?amount=" + amount
                 + "&addInfo=" + java.net.URLEncoder.encode(transferContent, "UTF-8")
                 + "&accountName=" + java.net.URLEncoder.encode(accountName, "UTF-8");
%>

<div class="container">
    <div class="header">
        <h2>Thanh Toán Chuyển Khoản Ngân Hàng</h2>
        <p style="color: #718096; margin-top: 5px;">Vui lòng chuyển khoản đúng thông tin dưới đây để hoàn tất đơn hàng</p>
    </div>

    <div class="timer">
        <i class="fa-regular fa-clock"></i> Đơn hàng sẽ giữ trong: <span id="countdown">10:00</span>
    </div>

    <div class="qr-card">
        <img class="qr-image" src="<%= qrUrl %>" alt="Mã QR Chuyển Khoản VietQR">
        <p style="font-size: 13px; color: #718096; margin: 10px 0 0 0;"><i class="fa-solid fa-qrcode"></i> Mở ứng dụng ngân hàng quét mã QR để điền nhanh</p>
    </div>

    <table class="info-table">
        <tr>
            <th>Ngân hàng</th>
            <td>MB Bank (Ngân hàng Quân Đội)</td>
        </tr>
        <tr>
            <th>Số tài khoản</th>
            <td>
                <span id="account-no"><%= accountNo %></span>
                <button class="btn-copy" onclick="copyText('account-no')"><i class="fa-regular fa-copy"></i> Sao chép</button>
            </td>
        </tr>
        <tr>
            <th>Chủ tài khoản</th>
            <td><%= accountName %></td>
        </tr>
        <tr>
            <th>Số tiền</th>
            <td>
                <span id="amount-val"><%= String.format("%,d", amount) %>đ</span>
                <button class="btn-copy" onclick="copyTextVal('amount-val', '<%= amount %>')"><i class="fa-regular fa-copy"></i> Sao chép</button>
            </td>
        </tr>
        <tr>
            <th>Nội dung chuyển khoản</th>
            <td style="color: #dc2626;">
                <span id="content-text"><%= transferContent %></span>
                <button class="btn-copy" onclick="copyText('content-text')"><i class="fa-regular fa-copy"></i> Sao chép</button>
            </td>
        </tr>
    </table>

    <div class="footer-buttons">
        <button class="btn-cancel" onclick="location.href='account'">Quay lại</button>
        <button class="btn-confirm" onclick="confirmPayment()">Tôi đã chuyển khoản thành công</button>
    </div>
</div>

<script>
    function copyText(elementId) {
        var text = document.getElementById(elementId).innerText;
        navigator.clipboard.writeText(text).then(function() {
            alert("Đã sao chép: " + text);
        });
    }

    function copyTextVal(elementId, val) {
        navigator.clipboard.writeText(val).then(function() {
            alert("Đã sao chép số tiền: " + val);
        });
    }

    var timeRemaining = 600; 
    var timerElement = document.getElementById("countdown");
    var interval = setInterval(function() {
        var minutes = Math.floor(timeRemaining / 60);
        var seconds = timeRemaining % 60;
        seconds = seconds < 10 ? '0' + seconds : seconds;
        timerElement.innerText = minutes + ":" + seconds;
        
        if (timeRemaining <= 0) {
            clearInterval(interval);
            alert("Thời gian giữ đơn hàng đã hết hạn. Vui lòng thử lại!");
            location.href = "account";
        }
        timeRemaining--;
    }, 1000);

    function confirmPayment() {
        alert("Cảm ơn bạn đã thanh toán! Hệ thống đang kiểm tra giao dịch của bạn. Đơn hàng sẽ được duyệt ngay sau khi tiền vào tài khoản.");
        location.href = "listbill?action=confirmPayment&purchaseID=<%= orderId %>";
    }
</script>
</body>
</html>
