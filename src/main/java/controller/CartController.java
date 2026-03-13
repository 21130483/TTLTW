package controller;

import com.mysql.cj.Session;
import dao.ProductDAO;
import model.Cart;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/html/cart")
public class CartController extends HttpServlet {
    private static Cart cart = new Cart();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
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
                cart.addProduct(product);
                break;

            case "remove":
                boolean clearAll = Boolean.parseBoolean(req.getParameter("clearAll"));
                cart.removeProduct(product, clearAll);
                break;

            default:
                System.out.println("sai cau lenh");
        }


        HttpSession session = req.getSession();
        session.setAttribute("cart", cart);
        req.getRequestDispatcher(page).forward(req, resp);


    }
}
