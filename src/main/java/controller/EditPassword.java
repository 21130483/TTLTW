package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/html/pass-edit")
public class EditPassword extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        String userId = req.getParameter("userId");
        User user = userDAO.getUserById(Integer.parseInt(userId));
        String oldpass = req.getParameter("oldpass");
        String newpass1 = req.getParameter("newpass1");
        String newpass2 = req.getParameter("newpass2");

//        if (user.getPassword().equals(oldpass) && newpass1.equals(newpass2)) {
//            userDAO.updatePassword(user, newpass1);
//        }
        if (user.getPassword().equals(oldpass)) {
            if (newpass1.equals(newpass2) && newpass1!=null) {
                userDAO.updatePassword(user, newpass1);
            }else{
                req.setAttribute("errorSamePass","Xác nhận mật khẩu thất bại");
            }
        }else{
            req.setAttribute("errorOldPass","Mật khẩu cũ không đúng");
        }

        req.getSession().setAttribute("user", user);
        req.getRequestDispatcher("account.jsp").forward(req, resp);
    }
}
