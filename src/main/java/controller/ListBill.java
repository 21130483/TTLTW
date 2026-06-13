package controller;

import dao.PurchasesDAO;
import dao.OrderDAO;
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

@WebServlet("/html/listbill")
public class ListBill extends HttpServlet {
    PurchasesDAO purchasesDAO = new PurchasesDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        req.getParameter("page");

        if (user != null) {
            String action = req.getParameter("action");
            if ("confirmPayment".equals(action)) {
                String purchaseIdStr = req.getParameter("purchaseID");
                Integer purchaseID = null;
                if (purchaseIdStr != null && !purchaseIdStr.isEmpty()) {
                    try {
                        purchaseID = Integer.parseInt(purchaseIdStr);
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                }
                if (purchaseID == null) {
                    purchaseID = (Integer) session.getAttribute("lastOrderId");
                }
                if (purchaseID != null) {
                    PurchasesDAO.updatePaymentStatus(purchaseID, 1);
                    session.removeAttribute("lastOrderId");
                    session.removeAttribute("lastOrderAmount");
                }
                resp.sendRedirect("listbill?status=0");
                return;
            }

            String status = req.getParameter("status");
            List<Purchases> purchasesList = new ArrayList<>();
            if(status.equals("all")){
                purchasesList = purchasesDAO.getPurchaseByUserId(user.getUserID());
            }else {
                purchasesList = purchasesDAO.getPurchaseByUserIdAndStatus(user.getUserID(), Integer.parseInt(status));
            }

            req.setAttribute("getPurchaseList", purchasesList);
            req.setAttribute("getStatus", status);
            req.getRequestDispatcher("purchase.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        
        if ("cancel".equals(action)) {
            resp.setContentType("application/json;charset=UTF-8");
            String orderIdStr = req.getParameter("purchaseID");
            String reason = req.getParameter("reason");
            
            if (reason == null || reason.trim().isEmpty()) {
                reason = "Người dùng hủy";
            }
            
            if (orderIdStr == null || orderIdStr.isEmpty()) {
                resp.getWriter().write("{\"success\": false, \"message\": \"Mã đơn hàng không hợp lệ!\"}");
                return;
            }
            
            try {
                int orderId = Integer.parseInt(orderIdStr);
                List<Purchases> purchasesList = PurchasesDAO.getPurchaseByPurchaseID(orderId);
                
                if (purchasesList == null || purchasesList.isEmpty()) {
                    resp.getWriter().write("{\"success\": false, \"message\": \"Đơn hàng không tồn tại!\"}");
                    return;
                }
                
                // Check validation rules
                for (Purchases p : purchasesList) {
                    if (p.getStatus() == 1) {
                        resp.getWriter().write("{\"success\": false, \"message\": \"Đơn hàng đang giao, không thể hủy!\"}");
                        return;
                    }
                    if (p.getStatus() == 2) {
                        resp.getWriter().write("{\"success\": false, \"message\": \"Đơn hàng đã hoàn thành, không thể hủy!\"}");
                        return;
                    }
                    if (p.getStatus() == -1) {
                        resp.getWriter().write("{\"success\": false, \"message\": \"Đơn hàng đã được hủy trước đó!\"}");
                        return;
                    }
                    if (p.getPaymentStatus() == 1) {
                        resp.getWriter().write("{\"success\": false, \"message\": \"Đơn hàng đã thanh toán, không thể hủy!\"}");
                        return;
                    }
                }
                
                OrderDAO orderDAO = new OrderDAO();
                boolean result = orderDAO.cancel(orderId, reason);
                if (result) {
                    resp.getWriter().write("{\"success\": true, \"message\": \"Hủy đơn hàng thành công!\"}");
                } else {
                    resp.getWriter().write("{\"success\": false, \"message\": \"Hủy đơn hàng thất bại, vui lòng thử lại!\"}");
                }
            } catch (NumberFormatException e) {
                resp.getWriter().write("{\"success\": false, \"message\": \"Mã đơn hàng không đúng định dạng!\"}");
            }
            return;
        }

        // Fallback for default post behavior
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            String status = req.getParameter("status");
            List<Purchases> purchasesList = new ArrayList<>();
            if(status.equals("all")){
                purchasesList = purchasesDAO.getPurchaseByUserId(user.getUserID());
            }else {
                purchasesList = purchasesDAO.getPurchaseByUserIdAndStatus(user.getUserID(), Integer.parseInt(status));
            }
            req.setAttribute("getPurchaseList", purchasesList);
            req.setAttribute("getStatus", status);
            req.getRequestDispatcher("purchase.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("login.jsp");
        }
    }
}