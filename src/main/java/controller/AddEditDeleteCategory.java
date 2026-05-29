package controller;

import dao.CategoryDAO;
import model.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/html/category")
public class AddEditDeleteCategory extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String active = req.getParameter("active");
        if (active == null) active = "";

        switch (active) {
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("id", id);
                req.setAttribute("active", active);
                req.getRequestDispatcher("addEditVoucher.jsp").forward(req, resp);
                break;

            case "delete":
                int idDelete = Integer.parseInt(req.getParameter("id"));
                CategoryDAO.softDeleteCategory(idDelete);
                resp.sendRedirect("admin?page=voucher");
                break;

            case "restore":
                int idRestore = Integer.parseInt(req.getParameter("id"));
                CategoryDAO.restoreCategory(idRestore);
                resp.sendRedirect("admin?page=voucher");
                break;

            default:
                resp.sendRedirect("admin?page=voucher");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String active = req.getParameter("active");
        CategoryDAO categoryDAO = new CategoryDAO();

        if ("add".equals(active)) {
            String name = req.getParameter("name");
            if (name != null && !name.trim().isEmpty()) {
                int newId = CategoryDAO.getIdNewCategory();
                CategoryDAO.addCategory(newId, name.trim());
            }
        } else if ("edit".equals(active)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            Category category = CategoryDAO.getCategoryById(id);
            if (category != null && name != null && !name.trim().isEmpty()) {
                if (!category.getName().equals(name.trim())) {
                    CategoryDAO.updateCategory(id, name.trim());
                }
            }
        }

        String requestedWith = req.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(requestedWith)) {
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("success");
        } else {
            resp.sendRedirect("admin?page=voucher");
        }
    }
}
