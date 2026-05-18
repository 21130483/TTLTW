package controller;

import Utils.GoogleUtils;
import dao.UserDAO;
import model.GooglePojo;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginGoogleController", value = "/login-google")
public class LoginGoogleController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        if (code == null || code.isEmpty()) {
            req.setAttribute("content", "Đăng nhập bằng Google thất bại.");
            req.getRequestDispatcher("/html/login.jsp").forward(req, resp);
            return;
        }

        try {
            String accessToken = GoogleUtils.getToken(code);
            GooglePojo googlePojo = GoogleUtils.getUserInfo(accessToken);

            String email = googlePojo.getEmail();
            String name = googlePojo.getName();

            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserByEmail(email);

            if (user == null) {
                // Đăng ký tài khoản mới nếu chưa tồn tại
                boolean isSuccess = userDAO.registerWithGoogle(email, name);
                if (isSuccess) {
                    user = userDAO.getUserByEmail(email);
                } else {
                    req.setAttribute("content", "Lỗi tạo tài khoản từ Google.");
                    req.getRequestDispatcher("/html/login.jsp").forward(req, resp);
                    return;
                }
            }

            // Đăng nhập thành công, thiết lập session
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60);

            // Vì đăng nhập bằng Google nên tài khoản đã được verify
            resp.sendRedirect(req.getContextPath() + "/html/index.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("content", "Có lỗi xảy ra: " + e.getMessage());
            req.getRequestDispatcher("/html/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
