package controller;

import dao.PurchasesDAO;
import dao.UserDAO;
import model.User;
import util.HttpUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/html/user-edit")
public class UserEdit extends HttpServlet {
    PurchasesDAO purchasesDAO = new PurchasesDAO();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(sessionUser.getUserID());
        if (user != null) {
            String fullName = req.getParameter("full_name");
            String gender = req.getParameter("gender");
            String dobString = req.getParameter("dob");

            user.setFullName(fullName);
            user.setGender(gender);
            if (dobString != null && !dobString.trim().isEmpty()) {
                try {
                    user.setDob(Date.valueOf(dobString));
                } catch (IllegalArgumentException e) {
                    // keep previous dob if parsing fails
                }
            }
            userDAO.updateUser1(user);

            User updatedUser = userDAO.getUserById(user.getUserID());
            session.setAttribute("user", updatedUser);
            req.setAttribute("listOrderItem", purchasesDAO.getAllPurchases(updatedUser.getUserID()));
            req.getRequestDispatcher("account").forward(req, resp);
        } else {
            resp.sendRedirect("login.jsp");
        }
    }
}
