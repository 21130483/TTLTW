package controller;

import dao.ProductDAO;
import dao.PurchasesDAO;
import model.Product;
import model.Purchases;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/html/billdetail")
public class BillDetail extends HttpServlet {
    PurchasesDAO purchasesDAO = new PurchasesDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        req.getParameter("page");

        if (user != null) {
            int purchaseId = Integer.parseInt(req.getParameter("purchaseId"));
            List<Integer> productList = new ArrayList<>();
            productList = PurchasesDAO.getProductIdsByPurchaseId(purchaseId);
            Purchases purchases = PurchasesDAO.getPurchaseById(purchaseId);

            req.setAttribute("getProductId", productList);
            req.setAttribute("getPurchase", purchases);
            req.getRequestDispatcher("billdetail.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("login.jsp");
        }
    }



}