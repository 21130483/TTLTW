package controller;
import dao.CartsDAO;
import dao.ProductDAO;
import model.Cart;
import model.Product;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


@WebServlet("/html/cart")
public class CartController extends HttpServlet {
    private static Cart cart = new Cart();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {

            resp.sendRedirect("login.jsp");
            return;
        }
        List<Cart> cartList = CartsDAO.getCartByUserId(user.getUserID());

        req.setAttribute("cartList", cartList);

        req.getRequestDispatcher("cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String active = req.getParameter("active");
        int productID = Integer.parseInt(req.getParameter("id"));
        String page = req.getParameter("page");

        switch (active) {
            case "add":
                CartsDAO.addToCart(user.getUserID(), productID, 1);
                break;

            case "remove":
                boolean clearAll = Boolean.parseBoolean(req.getParameter("clearAll"));
                if (clearAll) {
                    CartsDAO.removeFromCart(user.getUserID(), productID);
                    java.util.Set<Integer> checkedProductIds = (java.util.Set<Integer>) session.getAttribute("checkedProductIds");
                    if (checkedProductIds != null) {
                        checkedProductIds.remove(productID);
                        session.setAttribute("checkedProductIds", checkedProductIds);
                    }
                } else {
                    int currentQty = CartsDAO.getQuantityInCart(user.getUserID(), productID);
                    if (currentQty <= 1) {
                        CartsDAO.removeFromCart(user.getUserID(), productID);
                        java.util.Set<Integer> checkedProductIds = (java.util.Set<Integer>) session.getAttribute("checkedProductIds");
                        if (checkedProductIds != null) {
                            checkedProductIds.remove(productID);
                            session.setAttribute("checkedProductIds", checkedProductIds);
                        }
                    } else {
                        CartsDAO.updateQuantity(user.getUserID(), productID, currentQty - 1);
                    }
                }
                break;

            default:
                System.out.println("sai cau lenh");
        }

        // Cập nhật lại số lượng giỏ hàng trong session
        List<Cart> currentCart = CartsDAO.getCartByUserId(user.getUserID());
        session.setAttribute("sizeCart", currentCart.size());

        if (page.equals("cart") || page.equals("carts")) {
            resp.sendRedirect("carts");
        } else if (page.equals("products")) {
            resp.sendRedirect("findProduct");
        } else if (page.equals("product")) {
            resp.sendRedirect("product-detail?id=" + productID);
        } else {
            resp.sendRedirect(page + ".jsp");
        }
    }
}
