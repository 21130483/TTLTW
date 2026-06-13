package controller;

import dao.ReviewDAO;
import model.Review;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/html/add-review")
public class AddReviewController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            int productID = Integer.parseInt(req.getParameter("productID"));
            int rating = Integer.parseInt(req.getParameter("rating"));
            String content = req.getParameter("content");

            if (content != null && !content.trim().isEmpty()) {
                if (ReviewDAO.hasPurchased(user.getUserID(), productID)) {
                    Review review = new Review(productID, user.getUserID(), rating, content.trim());
                    ReviewDAO.addReview(review);
                }
            }
            resp.sendRedirect("product-detail?id=" + productID);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("index.jsp");
        }
    }
}
