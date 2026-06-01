package controller;

import dao.ProductDAO;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/html/searchAjax")
public class SearchAjax extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("UTF-8");
        String text = req.getParameter("text");
        PrintWriter out = resp.getWriter();
        
        if (text == null || text.trim().isEmpty()) {
            return;
        }
        
        List<Product> list = ProductDAO.getFindProducts(text);
        
        if (list == null || list.isEmpty()) {
            out.println("<li class=\"item\" style=\"padding: 10px; color: #777; text-align: center;\">Không tìm thấy sản phẩm</li>");
            return;
        }

        for (int i = 0; i < Math.min(list.size(), 5); i++) {
            Product p = list.get(i);
            out.println("<li class=\"item\">");
            out.println("<a href=\"product-detail?id=" + p.getProductID() + "\" style=\"display: flex; align-items: center; padding: 10px; color: black; text-decoration: none; border-bottom: 1px solid #eee;\" onmouseover=\"this.style.backgroundColor='#f9f9f9'\" onmouseout=\"this.style.backgroundColor='transparent'\">");
            out.println("<img src=\"" + p.getPathFirstImage(req.getServletContext().getRealPath("")) + "\" style=\"width: 40px; height: 40px; object-fit: cover; margin-right: 15px; border-radius: 4px; border: 1px solid #ddd;\">");
            out.println("<div style=\"display: flex; flex-direction: column;\">");
            out.println("<span style=\"font-size: 14px; font-weight: bold;\">" + p.getName() + "</span>");
            out.println("<span style=\"font-size: 13px; color: #d9534f; margin-top: 5px;\">" + p.getPriceHaveDots() + "</span>");
            out.println("</div>");
            out.println("</a>");
            out.println("</li>");
        }
    }
}
