package controller;

import dao.OrderDAO;
import dao.PurchasesDAO;
import model.Purchases;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/html/cancel")
public class CancelOrder extends HttpServlet {
    OrderDAO orderDAO = new OrderDAO();
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        String orderIdStr = req.getParameter("purchaseID");
        String reason = req.getParameter("reason");
        
        if (reason == null || reason.trim().isEmpty()) {
            reason = "Người dùng hủy";
        }
        
        if (orderIdStr == null || orderIdStr.isEmpty()) {
            resp.sendRedirect("account?status=failed");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            List<Purchases> purchasesList = PurchasesDAO.getPurchaseByPurchaseID(orderId);
            
            if (purchasesList == null || purchasesList.isEmpty()) {
                resp.sendRedirect("account?status=failed");
                return;
            }
                     
            for (Purchases p : purchasesList) {
                if (p.getStatus() == 1) {
                    resp.sendRedirect("account?status=failed");
                    return;
                }
                if (p.getStatus() == 2) {
                    resp.sendRedirect("account?status=failed");
                    return;
                }
                if (p.getStatus() == -1) {
                    resp.sendRedirect("account?status=failed");
                    return;
                }
                if (p.getPaymentStatus() == 1) {
                    resp.sendRedirect("account?status=failed");
                    return;
                }
            }
            
            boolean result = orderDAO.cancel(orderId, reason);
            if (result) {
                resp.sendRedirect("account");
            } else {
                resp.sendRedirect("account?status=failed");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect("account?status=failed");
        }
    }
}
