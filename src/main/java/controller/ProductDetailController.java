package controller;

import dao.ProductDAO;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
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
        req.setAttribute("productDetail",product);
        req.setAttribute("getProductRelated",relateToProduct);
        req.setAttribute("numberImg",numberImg);
        req.getRequestDispatcher("product.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        System.out.println("chay do post");
        int productID = Integer.parseInt(req.getParameter("id"));
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productID);
        List<Product> relateToProduct = productDAO.getRelateProduct(product,4);
        String path = req.getServletContext().getRealPath("");
        int numberImg = product.getNumberImg(path);
        req.setAttribute("productDetail",product);
        req.setAttribute("getProductRelated",relateToProduct);
        req.setAttribute("numberImg",numberImg);
        req.getRequestDispatcher("product.jsp").forward(req, resp);

    }
}
