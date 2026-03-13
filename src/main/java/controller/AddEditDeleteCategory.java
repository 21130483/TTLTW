package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Category;
import model.Product;

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
        switch (active) {
            case "add":
                req.setAttribute("active", active);
                req.getRequestDispatcher("addEditVoucher.jsp").forward(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("id", id);
                req.setAttribute("active", active);
                req.getRequestDispatcher("addEditVoucher.jsp").forward(req, resp);
                break;
            case "delete":
                int idDelete = Integer.parseInt(req.getParameter("id"));
                ProductDAO productDAO = new ProductDAO();
                if (productDAO.countProductByCategory(idDelete) == 0) {
                    CategoryDAO categoryDAO = new CategoryDAO();
                    categoryDAO.deleteCategory(idDelete);
                }
                req.getRequestDispatcher("admin?page=voucher").forward(req, resp);
                break;
            default:
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String active = req.getParameter("active");
        CategoryDAO categoryDAO = new CategoryDAO();
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");


        if (active.equals("edit")) {
            Category category = categoryDAO.getCategoryById(id);
            if (!category.getName().equals(name)) {
                categoryDAO.updateCategory(id, name);
            }
        } else {
            categoryDAO.addCategory(id, name);
        }

        req.getRequestDispatcher("admin?page=voucher").forward(req, resp);
    }
}
