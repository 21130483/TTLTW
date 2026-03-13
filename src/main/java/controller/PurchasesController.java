package controller;

import dao.ProductDAO;
import dao.PurchasesDAO;
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
import java.util.Map;

@WebServlet("/html/purchase")
public class PurchasesController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");
        PurchasesDAO purchasesDAO = new PurchasesDAO();
        ProductDAO productDAO = new ProductDAO();
        int newPurchaseId = purchasesDAO.newPurchaseID();
        String city = req.getParameter("city");
        String district = req.getParameter("district");
        String ward = req.getParameter("ward");
        String addressdetail = req.getParameter("addressdetail");
        String address = city+", "+district+", "+ward+", "+addressdetail;
        String comment =(req.getParameter("comment")!=null)?req.getParameter("comment"):"";
        for (Map.Entry<Product, Integer> entry : cart.getCart().entrySet()){
            Product p = entry.getKey();
            purchasesDAO.addPurchase(newPurchaseId,p.getProductID(), user.getUserID(), cart.getCart().get(p), p.getPrice()*cart.getCart().get(p),address,comment);
            productDAO.updateProduct(p.getProductID(), "quantity", String.valueOf(p.getQuantity() - entry.getValue()));
        }

        cart.deletedProdcutBuyFromCart();
        session.setAttribute("cart", cart);
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}
