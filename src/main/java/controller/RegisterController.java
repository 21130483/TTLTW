package controller;

import dao.UserDAO;
import Services.Connect;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import Utils.Validator;

@WebServlet(name = "RegisterController", value = "/register")
public class RegisterController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String error = "";
        UserDAO userDAO = new UserDAO();

        if(email.length()==0){
            req.setAttribute("invalidateEmail", "Vui lòng nhập trường này");
            req.getRequestDispatcher("register.jsp").forward(req,resp);
        }

        if(!confirmPassword.equals(password)){
            req.setAttribute("invalidateConfimPassword","Mật khẩu không khớp");
            req.getRequestDispatcher("register.jsp").forward(req,resp);
        }

        if (!Validator.validateEmail(email)) {
            error = "Email không đúng định dạng";
        }
        if(password.length() <6){
            req.setAttribute("invalidatePassword","Mật khẩu phải nhiều hơn 6 kí tự");
            req.getRequestDispatcher("register.jsp").forward(req,resp);
        }
        if(userDAO.checkEmailExist(email)){
            req.setAttribute("invalidateEmail","Email đã được đăng kí");
            req.getRequestDispatcher("register.jsp").forward(req,resp);
        }
        if(userDAO.resgisterWithEmail(email,username,password)){
            resp.sendRedirect("login.jsp");
        }
    }
}