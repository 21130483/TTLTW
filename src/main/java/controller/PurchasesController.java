package controller;

import dao.ProductDAO;
import dao.PurchasesDAO;
import dao.CartsDAO;
import dao.AddressDAO;
import model.Cart;
import model.Product;
import model.User;
import model.Address;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Set;

@WebServlet("/html/purchase")
public class PurchasesController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String addressType = req.getParameter("addressType");
        String address = "";
        if ("new".equals(addressType)) {
            String city = req.getParameter("city");
            String district = req.getParameter("district");
            String ward = req.getParameter("ward");
            String addressdetail = req.getParameter("addressdetail");
            address = city + ", " + district + ", " + ward + ", " + addressdetail;

            if (city != null && !city.isEmpty() && district != null && !district.isEmpty() && ward != null && !ward.isEmpty() && addressdetail != null && !addressdetail.isEmpty()) {
                AddressDAO.addAddress(user.getUserID(), city, district, ward, addressdetail);
            }
        } else {
            try {
                int addressId = Integer.parseInt(addressType);
                Address addrObj = AddressDAO.getAddressById(addressId);
                if (addrObj != null) {
                    address = addrObj.getDetail() + ", " + addrObj.getWard() + ", " + addrObj.getDistrict() + ", " + addrObj.getCity();
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        String comment = (req.getParameter("comment") != null) ? req.getParameter("comment") : "";
        String paymentMethod = req.getParameter("payment");

        List<Cart> cartList = CartsDAO.getCartByUserId(user.getUserID());
        Set<Integer> checkedProductIds = (Set<Integer>) session.getAttribute("checkedProductIds");
        
        int newPurchaseId = PurchasesDAO.newPurchaseID();
        int totalAmount = 0;

        if (checkedProductIds != null && !checkedProductIds.isEmpty()) {
            for (Cart c : cartList) {
                if (checkedProductIds.contains(c.getProductId())) {
                    Product p = c.getProduct();
                    int itemTotal = p.getPrice() * c.getQuantity();
                    totalAmount += itemTotal;

                    PurchasesDAO.addPurchase(newPurchaseId, p.getProductID(), user.getUserID(), c.getQuantity(), itemTotal, address, comment);
                    
                    ProductDAO.updateProduct(p.getProductID(), "quantity", String.valueOf(p.getQuantity() - c.getQuantity()));
                    
                    CartsDAO.removeFromCart(user.getUserID(), p.getProductID());
                    
                    checkedProductIds.remove(c.getProductId());
                }
            }
            session.setAttribute("checkedProductIds", checkedProductIds);
        }

        totalAmount += 25000;

        List<Cart> remainingCart = CartsDAO.getCartByUserId(user.getUserID());
        session.setAttribute("sizeCart", remainingCart.size());

        if ("bank_transfer".equals(paymentMethod)) {
            session.setAttribute("lastOrderAmount", totalAmount);
            session.setAttribute("lastOrderId", newPurchaseId);
            resp.sendRedirect("bank-payment.jsp");
        } else {
            resp.sendRedirect("account");
        }
    }
}
