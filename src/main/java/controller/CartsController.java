package controller;

import dao.CartsDAO;
import model.Cart;
import model.Carts;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/html/carts") // Đổi lại URL cho đồng bộ với AJAX
public class CartsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            List<Cart> cartList = CartsDAO.getCartByUserId(user.getUserID());
            System.out.println(cartList.size());

            java.util.Set<Integer> checkedProductIds = (java.util.Set<Integer>) session.getAttribute("checkedProductIds");
            if (checkedProductIds == null) {
                checkedProductIds = new java.util.HashSet<>();
                for (Cart c : cartList) {
                    checkedProductIds.add(c.getProductId());
                }
                session.setAttribute("checkedProductIds", checkedProductIds);
            }

            for (Cart c : cartList) {
                if (checkedProductIds.contains(c.getProductId())) {
                    c.setChecked(true);
                } else {
                    c.setChecked(false);
                }
            }

            Carts carts = new Carts();
            carts.setCarts(cartList);
            req.setAttribute("carts", carts);
            req.getRequestDispatcher("/html/cart.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = 1;
            boolean success = CartsDAO.addToCart(user.getUserID(), productId, quantity);

            if (success) {
                List<Cart> currentCart = CartsDAO.getCartByUserId(user.getUserID());
                int totalSize = currentCart.size();

                session.setAttribute("sizeCart", totalSize);

                resp.setContentType("text/plain");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write(String.valueOf(totalSize));
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}