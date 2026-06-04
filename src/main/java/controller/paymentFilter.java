package controller;

import model.Cart;
import model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/html/payment")
public class paymentFilter extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            java.util.Set<Integer> checkedProductIds = (java.util.Set<Integer>) session.getAttribute("checkedProductIds");
            if (checkedProductIds != null && !checkedProductIds.isEmpty()) {
                resp.sendRedirect("payment.jsp");
            } else {
                req.setAttribute("content", "Bạn chưa chọn sản phẩm nào để mua");
                req.getRequestDispatcher("carts").forward(req, resp);
            }
        } else {
            resp.sendRedirect("login.jsp");
        }
    }
}