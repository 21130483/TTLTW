package controller;

import dao.CartsDAO;
import model.Cart;
import model.Carts;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/html/carts") // Đổi lại URL cho đồng bộ với AJAX
public class CartsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            List<Cart> cartList = CartsDAO.getCartByUserId(user.getUserID());
            System.out.println(cartList.size());
            Carts carts = new Carts();
            carts.setCarts(cartList);
            req.setAttribute("carts", carts);
            req.getRequestDispatcher("/html/cart.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        // 1. KIỂM TRA ĐĂNG NHẬP
        if (user == null) {
            // Trả về mã lỗi 401 để thông báo cho AJAX biết là chưa đăng nhập
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return; // Dừng xử lý các câu lệnh phía dưới
        }

        // 2. NẾU ĐÃ ĐĂNG NHẬP, TIẾP TỤC XỬ LÝ THÊM VÀO GIỎ HÀNG
        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = 1; // Mặc định thêm 1 sản phẩm

            // Gọi DAO thực hiện thêm vào cơ sở dữ liệu
            boolean success = CartsDAO.addToCart(user.getUserID(), productId, quantity);

            if (success) {
                // Lấy lại danh sách giỏ để cập nhật số lượng hiển thị trên icon giỏ hàng
                List<Cart> currentCart = CartsDAO.getCartByUserId(user.getUserID());
                int totalSize = currentCart.size();

                resp.setContentType("text/plain");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write(String.valueOf(totalSize));
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}