package controller;

import model.Cart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/html/buy-product")
public class buyProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String active = req.getParameter("active");
        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        switch (active) {
            case "all":
                if (cart.cartEqualChecked()) {
                    cart.removeAll();
                } else {
                    cart.addAll();

                }
                break;
            case "normal":
                int productID = Integer.parseInt(req.getParameter("id"));
                if (cart.getProductChecked().contains(productID)) {
                    cart.removeProductChecked(productID);
                } else {
                    cart.addProductChecked(productID);
                }
                break;

            default:
        }
        session.setAttribute("cart",cart);
        req.getRequestDispatcher("cart.jsp").forward(req,resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        super.doPost(req, resp);
    }
}
