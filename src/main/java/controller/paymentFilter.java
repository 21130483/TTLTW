package controller;

import dao.ProductDAO;
import dao.UserDAO;
import model.Cart;
import model.Product;
import model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/html/payment")
public class paymentFilter extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");
        if (user != null) {
            if (cart.getProductChecked().size() != 0){
                resp.sendRedirect("payment.jsp");
            }else {
                req.setAttribute("content","Bạn chưa chọn sản phẩm nào để mua");
                req.getRequestDispatcher("cart.jsp").forward(req, resp);
            }
        } else {
            resp.sendRedirect("login.jsp");
        }


    }
}