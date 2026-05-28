package controller;

import dao.PurchasesDAO;
import model.Purchases;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/html/bill")
public class ManagerBill extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String active = req.getParameter("active");
        int idPurchase = Integer.parseInt(req.getParameter("purchaseid"));
        int idUser = Integer.parseInt(req.getParameter("userid"));
        int idProduct = Integer.parseInt(req.getParameter("productid"));
        PurchasesDAO purchasesDAO = new PurchasesDAO();
        Purchases purchases = purchasesDAO.getPurchaseById(idPurchase);
        switch (active) {
            case "confirm":
                int status = purchases.getStatus()+1;
                purchasesDAO.updatePurchase(idPurchase,idUser,idProduct, "status", String.valueOf(status));
                break;
            case "cancel":
                purchasesDAO.updatePurchase(idPurchase,idUser,idProduct, "status", String.valueOf(-1));
                break;
        }
        req.getRequestDispatcher("admin?page=bill").forward(req,resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int userID = Integer.parseInt(req.getParameter("userID"));
            int productID = Integer.parseInt(req.getParameter("productID"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int price = Integer.parseInt(req.getParameter("price"));
            String address = req.getParameter("address");
            String comment = req.getParameter("comment");

            int newPurchaseId = PurchasesDAO.newPurchaseID();
            boolean success = PurchasesDAO.addPurchase(newPurchaseId, productID, userID, quantity, price, address, comment);
            
            if (success) {
                resp.setStatus(HttpServletResponse.SC_OK);
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
