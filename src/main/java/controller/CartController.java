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
        String active = req.getParameter("active");
        if (true) {

        }
        int productID = Integer.parseInt(req.getParameter("id"));
        String page = req.getParameter("page");


        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productID);
        if (page.equals("products")) {
            page = "findProduct";
        } else if (page.equals("product")) {
            page = "product-detail?id=" + productID;
        } else {
            page += ".jsp";
        }
        switch (active) {
            case "add":
//                cart.addProduct(product);
                break;

            case "remove":
                boolean clearAll = Boolean.parseBoolean(req.getParameter("clearAll"));
//                cart.removeProduct(product, clearAll);
                break;

            default:
                System.out.println("sai cau lenh");
        }


        HttpSession session = req.getSession();
        session.setAttribute("cart", cart);
        req.getRequestDispatcher(page).forward(req, resp);


    }
}
