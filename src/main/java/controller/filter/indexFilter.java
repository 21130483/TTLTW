package controller.filter;

import dao.ProductDAO;
import model.Product;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import java.io.IOException;
import java.util.List;

@WebFilter("/html/*")
public class indexFilter extends HttpFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        getShowBestSelling(req,res);
        getShowBestFaceMask(req,res);
        getShowNewProduct(req,res);
        chain.doFilter(req, res);
    }

    private void getShowNewProduct(ServletRequest req, ServletResponse res) {
        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.getNewProduct(5);
        req.setAttribute("getNewProduct", products);
    }

    private void getShowBestFaceMask(ServletRequest req, ServletResponse res) {
        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.getBestFaceMask(5);
        req.setAttribute("getBestFaceMask", products);
    }

    private void getShowBestSelling(ServletRequest req, ServletResponse res) {
        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.getBestSelling(5);
        req.setAttribute("getBestSelling", products);

    }

//    private
}
