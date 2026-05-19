package controller;

import dao.UserDAO;
import Security.Security;
import Services.SendEmail;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Random;

@WebServlet(name = "VerifyController", value = "/verify")
public class VerifyController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if(user == null) {
            resp.sendRedirect(req.getContextPath() + "/html/login.jsp");
            return;
        }

        Random random = new Random();
        int code = random.nextInt(89999) + 10000;
        session.setAttribute("verifyCode", code);

        SendEmail email = new SendEmail();
        email.sendEmail(Security.EMAIL, Security.PASS,user.getEmail(),"Xác thực Email",String.valueOf(code));
        req.getRequestDispatcher("/html/VerifyEmail.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        
        Integer code = (Integer) session.getAttribute("verifyCode");
        int codeVerify = 0;
        try {
            codeVerify = Integer.parseInt(req.getParameter("verify"));
        } catch (NumberFormatException e) {
            // handle parse exception
        }

        if(code == null || code != codeVerify){
            req.setAttribute("err", "Nhập mã không chính xác");
            req.getRequestDispatcher("/html/VerifyEmail.jsp").forward(req,resp);
        }
        else{
            User user = (User) session.getAttribute("user");
            UserDAO userDAO = new UserDAO();
            if(userDAO.verifyEmail(user.getEmail())){
                user.setVerifyEmail(true);
                session.setAttribute("user", user);
                session.removeAttribute("verifyCode");
                resp.sendRedirect(req.getContextPath() + "/html/index.jsp");
            } else {
                req.setAttribute("err", "Có lỗi xảy ra, vui lòng thử lại");
                req.getRequestDispatcher("/html/VerifyEmail.jsp").forward(req,resp);
            }
        }
    }
}