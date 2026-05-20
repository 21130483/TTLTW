package controller;

import dao.UserDAO;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ResetPasswordController", value = "/reset-password")
public class ResetPasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        if (token == null || token.trim().isEmpty()) {
            req.setAttribute("error", "Đường dẫn không hợp lệ.");
            req.getRequestDispatcher("html/error.jsp").forward(req, resp); // Forward to an error page or login
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByResetToken(token);

        if (user == null) {
            req.setAttribute("error", "Đường dẫn đã hết hạn hoặc không hợp lệ.");
            req.getRequestDispatcher("html/error.jsp").forward(req, resp);
            return;
        }

        // Token hợp lệ, hiển thị form đổi mật khẩu
        req.setAttribute("token", token);
        req.getRequestDispatcher("html/resetPassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String token = req.getParameter("token");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        if (token == null || token.trim().isEmpty()) {
            req.setAttribute("error", "Yêu cầu không hợp lệ.");
            req.getRequestDispatcher("html/resetPassword.jsp").forward(req, resp);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByResetToken(token);

        if (user == null) {
            req.setAttribute("error", "Đường dẫn đã hết hạn hoặc không hợp lệ.");
            req.getRequestDispatcher("html/resetPassword.jsp").forward(req, resp);
            return;
        }

        if (password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập mật khẩu mới.");
            req.setAttribute("token", token);
            req.getRequestDispatcher("html/resetPassword.jsp").forward(req, resp);
            return;
        }

        if (!password.matches("^(?=.*[a-z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}$")) {
            req.setAttribute("error", "Mật khẩu phải từ 8 kí tự, gồm ít nhất 1 chữ thường, 1 số và 1 ký tự đặc biệt.");
            req.setAttribute("token", token);
            req.getRequestDispatcher("html/resetPassword.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            req.setAttribute("token", token);
            req.getRequestDispatcher("html/resetPassword.jsp").forward(req, resp);
            return;
        }

        // Băm mật khẩu bằng BCrypt
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));

        if (userDAO.updatePasswordAndClearToken(user.getUserID(), hashedPassword)) {
            // Cập nhật thành công
            req.setAttribute("success", "Đổi mật khẩu thành công. Vui lòng đăng nhập lại.");
            req.getRequestDispatcher("html/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Có lỗi xảy ra khi cập nhật mật khẩu, vui lòng thử lại.");
            req.setAttribute("token", token);
            req.getRequestDispatcher("html/resetPassword.jsp").forward(req, resp);
        }
    }
}
