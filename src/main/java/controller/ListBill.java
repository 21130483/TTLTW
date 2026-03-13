package controller;

import dao.PurchasesDAO;
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


//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        HttpSession session = req.getSession();
//        User user = (User) session.getAttribute("user");
//        req.getParameter("page");
//
//        if (user != null) {
//            String status = req.getParameter("status");
//            List<Purchases> purchasesList = new ArrayList<>();
//            if(status.equals("all")){
//                purchasesList = purchasesDAO.getPurchaseByUserId(user.getUserID());
//            }else {
//                purchasesList = purchasesDAO.getPurchaseByUserIdAndStatus(user.getUserID(), Integer.parseInt(status));
//            }
//            System.out.println(status+" la status");
//
//            req.setAttribute("getPurchaseList", purchasesList);
//            req.setAttribute("getStatus", status);
//            req.getRequestDispatcher("purchase.jsp").forward(req, resp);
//        } else {
//            resp.sendRedirect("login.jsp");
//        }
//    }
}