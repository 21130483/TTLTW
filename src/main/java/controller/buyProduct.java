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
        HttpSession session = req.getSession();
        model.User user = (model.User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String active = req.getParameter("active");
        java.util.Set<Integer> checkedProductIds = (java.util.Set<Integer>) session.getAttribute("checkedProductIds");
        if (checkedProductIds == null) {
            checkedProductIds = new java.util.HashSet<>();
        }

        if ("all".equals(active)) {
            java.util.List<Cart> cartList = dao.CartsDAO.getCartByUserId(user.getUserID());
            boolean allChecked = true;
            for (Cart c : cartList) {
                if (!checkedProductIds.contains(c.getProductId())) {
                    allChecked = false;
                    break;
                }
            }
            if (allChecked) {
                checkedProductIds.clear();
            } else {
                for (Cart c : cartList) {
                    checkedProductIds.add(c.getProductId());
                }
            }
        } else if ("normal".equals(active)) {
            try {
                int productID = Integer.parseInt(req.getParameter("id"));
                if (checkedProductIds.contains(productID)) {
                    checkedProductIds.remove(productID);
                } else {
                    checkedProductIds.add(productID);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        session.setAttribute("checkedProductIds", checkedProductIds);
        resp.sendRedirect("carts");
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        super.doPost(req, resp);
    }
}
