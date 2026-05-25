package controller;

import dao.UserDAO;
import Services.SendEmail;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ForgotController", value = "/forgot")
public class ForgotController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("html/forgot.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        UserDAO userDAO = new UserDAO();

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập Email");
            req.getRequestDispatcher("html/forgot.jsp").forward(req, resp);
            return;
        }

        if (!userDAO.checkEmailExist(email)) {
            // Hiển thị thông báo chung để bảo mật, không tiết lộ email có tồn tại hay không
            req.setAttribute("success", "Nếu email của bạn tồn tại trong hệ thống, chúng tôi đã gửi cho bạn một liên kết để đặt lại mật khẩu.");
            req.getRequestDispatcher("html/forgot.jsp").forward(req, resp);
            return;
        }

        // Tạo token ngẫu nhiên và an toàn
        String token = java.util.UUID.randomUUID().toString();
        // Hết hạn sau 15 phút
        java.sql.Timestamp expiry = new java.sql.Timestamp(System.currentTimeMillis() + 15 * 60 * 1000);

        if (userDAO.updateResetToken(email, token, expiry)) {
            String resetLink = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath() + "/reset-password?token=" + token;
            
            SendEmail sendEmail = new SendEmail();
            String subject = "Yêu cầu khôi phục mật khẩu";
            String content = "Bạn đã yêu cầu khôi phục mật khẩu. Vui lòng click vào đường link sau để đặt lại mật khẩu (có hiệu lực trong 15 phút): \n" + resetLink;
            
            sendEmail.sendEmail(Security.Security.EMAIL, Security.Security.PASS, email, subject, content);

            req.setAttribute("success", "Nếu email của bạn tồn tại trong hệ thống, chúng tôi đã gửi cho bạn một liên kết để đặt lại mật khẩu.");
        } else {
            req.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại sau.");
        }
        
        req.getRequestDispatcher("html/forgot.jsp").forward(req, resp);
    }
}