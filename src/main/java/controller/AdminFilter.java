package controller;

import dao.*;
import model.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/html/admin")
public class AdminFilter extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null && user.getRole()) {
            String page = req.getParameter("page");
            switch (page) {
                case "product":
//                    int statusProduct = Integer.parseInt(req.getParameter("status"));
                    ProductDAO productDAO = new ProductDAO();
                    CategoryDAO categoryDAO = new CategoryDAO();
                    OriginDAO originDAO = new OriginDAO();
                    List<Category> categories = categoryDAO.getAllCategory();
                    List<Origin> origins = originDAO.getAllOrigin();
                    List<Product> products = productDAO.getAllProduct();
                    req.setAttribute("getAllProducts", products);
                    req.setAttribute("getAllCategory", categories);
                    req.setAttribute("getAllOrigin", origins);
                    page = "managerProducts.jsp";
                    break;

                case "user":
//                    int statusUser = Integer.parseInt(req.getParameter("status"));
                    UserDAO userDAO = new UserDAO();
                    List<User> users = userDAO.getAllUsers();
                    req.setAttribute("getAllUsers", users);
                    page = "managerUsers.jsp";
                    break;
                case "bill":
                    page = "managerBills.jsp";
                    PurchasesDAO purchasesDAO = new PurchasesDAO();
                    List<Purchases> purchases = purchasesDAO.getAllPurchases();
                    req.setAttribute("getAllPurchases", purchases);
                    break;
                case "voucher":
                    page = "managerVouchers.jsp";
                    break;
                default:
                    System.out.println("sai cau lenh");
            }
            req.getRequestDispatcher(page).forward(req, resp);
        } else {
            resp.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null && user.getRole()) {
            String page = req.getParameter("page");
            switch (page) {
                case "product":
//                    int statusProduct = Integer.parseInt(req.getParameter("status"));
                    ProductDAO productDAO = new ProductDAO();
                    List<Product> products = productDAO.getAllProduct();
                    req.setAttribute("getAllProducts", products);
                    page = "managerProducts.jsp";
                    break;

                case "user":
//                    int statusUser = Integer.parseInt(req.getParameter("status"));
                    UserDAO userDAO = new UserDAO();
                    List<User> users = userDAO.getAllUsers();
                    req.setAttribute("getAllUsers", users);
                    page = "managerUsers.jsp";
                    break;
                case "bill":
                    page = "managerBills.jsp";
                    PurchasesDAO purchasesDAO = new PurchasesDAO();
                    List<Purchases> purchases = purchasesDAO.getAllPurchases();
                    req.setAttribute("getAllPurchases", purchases);
                    break;
                case "voucher":
                    page = "managerVouchers.jsp";
                    break;
                default:
                    System.out.println("sai cau lenh");
            }
            req.getRequestDispatcher(page).forward(req, resp);
        } else {
            resp.sendRedirect("index.jsp");
        }
    }
}