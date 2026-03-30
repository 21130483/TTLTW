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
        String phoneNumbers = req.getParameter("phoneNumbers");
        String dob = req.getParameter("dob");
        String gender = req.getParameter("gender");

        UserDAO userDAO = new UserDAO();
        boolean hasError = false;

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("invalidateEmail", "Vui lòng nhập Email");
            hasError = true;
        } else if (!Validator.validateEmail(email)) {
            req.setAttribute("invalidateEmail", "Email không đúng định dạng");
            hasError = true;
        } else if (userDAO.checkEmailExist(email)) { // Gọi hàm từ UserDAO
            req.setAttribute("invalidateEmail", "Email đã được sử dụng để đăng ký");
            hasError = true;
        }

        if (password == null || password.length() < 6) {
            req.setAttribute("invalidatePassword", "Mật khẩu phải từ 6 kí tự trở lên");
            hasError = true;
        }

        if (confirmPassword == null || !confirmPassword.equals(password)) {
            req.setAttribute("invalidateConfimPassword", "Mật khẩu nhập lại không khớp");
            hasError = true;
        }

        if (hasError) {
            req.getRequestDispatcher("/html/register.jsp").forward(req, resp);
            return;
        }

        boolean isSuccess = userDAO.resgisterWithEmail(email, username, password, phoneNumbers, dob, gender);

        if (isSuccess) {
            req.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
            req.getRequestDispatcher("/html/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Đã có lỗi xảy ra trong quá trình đăng ký. Vui lòng thử lại sau.");
            req.getRequestDispatcher("/html/register.jsp").forward(req, resp);
        }
//        if(email.length()==0){
//            req.setAttribute("invalidateEmail", "Vui lòng nhập trường này");
//            req.getRequestDispatcher("register.jsp").forward(req,resp);
//        }
//
//        if(!confirmPassword.equals(password)){
//            req.setAttribute("invalidateConfimPassword","Mật khẩu không khớp");
//            req.getRequestDispatcher("register.jsp").forward(req,resp);
//        }
//
//        if (!Validator.validateEmail(email)) {
//            error = "Email không đúng định dạng";
//        }
//        if(password.length() <6){
//            req.setAttribute("invalidatePassword","Mật khẩu phải nhiều hơn 6 kí tự");
//            req.getRequestDispatcher("register.jsp").forward(req,resp);
//        }
//        if(userDAO.checkEmailExist(email)){
//            req.setAttribute("invalidateEmail","Email đã được đăng kí");
//            req.getRequestDispatcher("register.jsp").forward(req,resp);
//        }
//        if(userDAO.resgisterWithEmail(email,username,password)){
//            resp.sendRedirect("login.jsp");
//        }
    }
}