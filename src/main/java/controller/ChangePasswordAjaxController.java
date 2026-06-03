package controller;

import dao.UserDAO;
import model.User;
import Services.SendEmail;
import Security.Security;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Random;

@WebServlet("/html/change-password-ajax")
public class ChangePasswordAjaxController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute("user");
        
        if (sessionUser == null) {
            resp.getWriter().write("{\"status\":\"error\", \"message\":\"Bạn chưa đăng nhập!\"}");
            return;
        }
        
        String action = req.getParameter("action");
        if (action == null) {
            resp.getWriter().write("{\"status\":\"error\", \"message\":\"Hành động không hợp lệ!\"}");
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        
        if ("sendOTP".equals(action)) {
            String oldpass = req.getParameter("oldpass");
            String newpass1 = req.getParameter("newpass1");
            String newpass2 = req.getParameter("newpass2");
            
            if (oldpass == null || oldpass.trim().isEmpty() ||
                newpass1 == null || newpass1.trim().isEmpty() ||
                newpass2 == null || newpass2.trim().isEmpty()) {
                resp.getWriter().write("{\"status\":\"error\", \"message\":\"Vui lòng điền đầy đủ thông tin!\"}");
                return;
            }
            
            User user = userDAO.getUserById(sessionUser.getUserID());
            if (user == null) {
                resp.getWriter().write("{\"status\":\"error\", \"message\":\"Người dùng không tồn tại!\"}");
                return;
            }
            
            if (!user.getPassword().equals(oldpass)) {
                resp.getWriter().write("{\"status\":\"error\", \"message\":\"Mật khẩu cũ không chính xác!\"}");
                return;
            }
            
            if (!newpass1.matches("^(?=.*[a-z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}$")) {
                resp.getWriter().write("{\"status\":\"error\", \"message\":\"Mật khẩu mới phải từ 8 kí tự, gồm ít nhất 1 chữ thường, 1 số và 1 ký tự đặc biệt!\"}");
                return;
            }
            
            if (!newpass1.equals(newpass2)) {
                resp.getWriter().write("{\"status\":\"error\", \"message\":\"Xác nhận mật khẩu mới không đúng!\"}");
                return;
            }
            
            Random random = new Random();
            int code = random.nextInt(89999) + 10000;
            
            session.setAttribute("changePassOtp", code);
            session.setAttribute("changePassPendingNewPassword", newpass1);
            session.setAttribute("changePassOtpExpiry", System.currentTimeMillis() + 5 * 60 * 1000); // 5 minutes validity
            
            try {
                SendEmail emailService = new SendEmail();
                String subject = "Mã xác thực OTP đổi mật khẩu";
                String content = "Chào " + user.getFullName() + ",\n\n"
                        + "Bạn đang thực hiện yêu cầu thay đổi mật khẩu cho tài khoản tại Nhà Thuốc.\n"
                        + "Mã OTP xác thực của bạn là: " + code + "\n"
                        + "Mã này có hiệu lực trong vòng 5 phút. Vui lòng không chia sẻ mã này với bất kỳ ai.\n\n"
                        + "Nếu bạn không thực hiện yêu cầu này, vui lòng bỏ qua email này.\n\n"
                        + "Trân trọng,\nNhà Thuốc";
                emailService.sendEmail(Security.EMAIL, Security.PASS, user.getEmail(), subject, content);
                resp.getWriter().write("{\"status\":\"success\", \"message\":\"Mã OTP đã được gửi đến email của bạn.\"}");
            } catch (Exception e) {
                e.printStackTrace();
                resp.getWriter().write("{\"status\":\"error\", \"message\":\"Không thể gửi email OTP. Vui lòng thử lại sau!\"}");
            }
            
        } else if ("verifyOTP".equals(action)) {
            String otpInput = req.getParameter("otp");
            Integer sessionOtp = (Integer) session.getAttribute("changePassOtp");
            String pendingPass = (String) session.getAttribute("changePassPendingNewPassword");
            Long expiry = (Long) session.getAttribute("changePassOtpExpiry");
            
            if (sessionOtp == null || pendingPass == null || expiry == null) {
                resp.getWriter().write("{\"status\":\"error\", \"message\":\"Yêu cầu xác thực không hợp lệ hoặc phiên giao dịch đã hết hạn!\"}");
                return;
            }
            
            if (System.currentTimeMillis() > expiry) {
                session.removeAttribute("changePassOtp");
                session.removeAttribute("changePassPendingNewPassword");
                session.removeAttribute("changePassOtpExpiry");
                resp.getWriter().write("{\"status\":\"error\", \"message\":\"Mã OTP đã hết hạn! Vui lòng thực hiện lại.\"}");
                return;
            }
            
            int otpCode = 0;
            try {
                otpCode = Integer.parseInt(otpInput);
            } catch (NumberFormatException e) {
            }
            
            if (otpCode != sessionOtp) {
                resp.getWriter().write("{\"status\":\"error\", \"message\":\"Mã OTP không chính xác!\"}");
                return;
            }
            
            User user = userDAO.getUserById(sessionUser.getUserID());
            if (user == null) {
                resp.getWriter().write("{\"status\":\"error\", \"message\":\"Người dùng không tồn tại!\"}");
                return;
            }
            
            if (userDAO.updatePassword(user, pendingPass)) {
                sessionUser.setPassword(pendingPass);
                session.setAttribute("user", sessionUser);
                
                session.removeAttribute("changePassOtp");
                session.removeAttribute("changePassPendingNewPassword");
                session.removeAttribute("changePassOtpExpiry");
                
                resp.getWriter().write("{\"status\":\"success\", \"message\":\"Đổi mật khẩu thành công!\"}");
            } else {
                resp.getWriter().write("{\"status\":\"error\", \"message\":\"Cập nhật mật khẩu thất bại. Vui lòng thử lại!\"}");
            }
        } else {
            resp.getWriter().write("{\"status\":\"error\", \"message\":\"Hành động không hợp lệ!\"}");
        }
    }
}
