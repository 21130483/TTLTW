package controller;

import dao.UserDAO;
import model.User;
import model.Role;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/html/edituser")
public class EditUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(id);
        List<Role> allRoles = UserDAO.getAllRoles();
        req.setAttribute("editUser", user);
        req.setAttribute("allRoles", allRoles);
        req.getRequestDispatcher("EditUser.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Boolean access = Boolean.valueOf(req.getParameter("access"));
        
        String[] roleParams = req.getParameterValues("roles");
        List<Integer> roleIDs = new ArrayList<>();
        if (roleParams != null) {
            for (String roleParam : roleParams) {
                try {
                    roleIDs.add(Integer.parseInt(roleParam));
                } catch (NumberFormatException e) {
                }
            }
        }
        
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(id);
        
        UserDAO.updateUserRoles(id, roleIDs);
        
        if (user.getAccess() != access) {
            userDAO.updateUser(id, "access", String.valueOf(access));
        }
        req.getRequestDispatcher("admin?page=user").forward(req, resp);
    }
}

