package controller;

import dao.ProductDAO;
import dao.ReviewDAO;
import model.Product;
import model.Review;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/html/product-detail")
public class ProductDetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productID = Integer.parseInt(req.getParameter("id"));
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productID);
        List<Product> relateToProduct = productDAO.getRelateProduct(product,4);
        String path = req.getServletContext().getRealPath("");
        int numberImg = product.getNumberImg(path);
        
        List<Review> reviews = ReviewDAO.getReviewsByProductId(productID);
        double avgRating = ReviewDAO.getAverageRating(productID);
        int reviewCount = ReviewDAO.getReviewCount(productID);
        
        boolean hasPurchased = false;
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            hasPurchased = ReviewDAO.hasPurchased(user.getUserID(), productID);
        }

        req.setAttribute("productDetail",product);
        req.setAttribute("getProductRelated",relateToProduct);
        req.setAttribute("numberImg",numberImg);
        req.setAttribute("reviews", reviews);
        req.setAttribute("avgRating", avgRating);
        req.setAttribute("reviewCount", reviewCount);
        req.setAttribute("hasPurchased", hasPurchased);
        req.getRequestDispatcher("product.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productID = Integer.parseInt(req.getParameter("id"));
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productID);
        List<Product> relateToProduct = productDAO.getRelateProduct(product,4);
        String path = req.getServletContext().getRealPath("");
        int numberImg = product.getNumberImg(path);

        List<Review> reviews = ReviewDAO.getReviewsByProductId(productID);
        double avgRating = ReviewDAO.getAverageRating(productID);
        int reviewCount = ReviewDAO.getReviewCount(productID);

        boolean hasPurchased = false;
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            hasPurchased = ReviewDAO.hasPurchased(user.getUserID(), productID);
        }

        req.setAttribute("productDetail",product);
        req.setAttribute("getProductRelated",relateToProduct);
        req.setAttribute("numberImg",numberImg);
        req.setAttribute("reviews", reviews);
        req.setAttribute("avgRating", avgRating);
        req.setAttribute("reviewCount", reviewCount);
        req.setAttribute("hasPurchased", hasPurchased);
        req.getRequestDispatcher("product.jsp").forward(req, resp);
    }
}

