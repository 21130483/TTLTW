package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/html/login")
public class Login extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        session.invalidate();
        resp.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email") == null ? "" : (String) req.getParameter("email");
        String pass = req.getParameter("pass") == null ? "" : (String) req.getParameter("pass");
        UserDAO userDAO = new UserDAO();
        User user = userDAO.checkLogin(email, pass);
        if (user != null) {
            if (user.getAccess()) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                resp.sendRedirect("index.jsp");
            }else{
                req.setAttribute("content","Tài khoản của bạn đã bị cấm");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            }

        } else {
            req.setAttribute("content","Sai tài khoản hoặc mật khẩu");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
