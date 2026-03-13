package controller;

import dao.AddressDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import dao.PurchasesDAO;
import model.*;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

//@WebFilter(urlPatterns = "account.jsp",description = "filter cho trang account")
//public class AccountFilter extends HttpFilter {
//    @Override
//    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
//        HttpServletResponse rs = (HttpServletResponse) res;
//        HttpServletRequest rq = (HttpServletRequest) req;
//
//        HttpSession session = rq.getSession();
//        User user = (User) session.getAttribute("user");
//        if (user != null) {
//            chain.doFilter(req,res);
//        }else {
//            rs.sendRedirect("login.jsp");
//        }
//    }
//}
@WebServlet("/html/account")
public class AccountFilter extends HttpServlet {
    PurchasesDAO purchasesDAO = new PurchasesDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            AddressDAO addressDAO = new AddressDAO();
            req.getRequestDispatcher("account2.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            AddressDAO addressDAO = new AddressDAO();
            req.getRequestDispatcher("account2.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("login.jsp");
        }
    }
}
//@WebServlet("/html/account")
//public class AccountFilter extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        HttpSession session = req.getSession();
//        User user = (User) session.getAttribute("user");
//        if (user!=null){
//            AddressDAO addressDAO = new AddressDAO();
//            List<Address> addresses = addressDAO.getAddressByUserId(user.getUserID());
//            req.setAttribute("addresses",addresses);
//            req.getRequestDispatcher("/html/account.jsp").forward(req, resp);
//        }else{
//            resp.sendRedirect("login.jsp");
//        }
//    }
//}
