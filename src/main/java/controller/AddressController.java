package controller;

import dao.AddressDAO;
import model.Address;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/html/address-controller")
public class AddressController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        String active = req.getParameter("active");
        if (active.equals("remove")) {
            int addressId = Integer.parseInt(req.getParameter("addressId"));

        } else {
            String city = req.getParameter("city");
            String district = req.getParameter("district");
            String ward = req.getParameter("ward");
            String detail = req.getParameter("detail");
            if (city != null && district != null && ward != null && detail != null) {
                AddressDAO addressDAO = new AddressDAO();
                switch (active) {
                    case "add":
                        addressDAO.addAddress(user.getUserID(), city, district, ward, detail);
                        break;
                    case "edit":
                        int id = Integer.parseInt(req.getParameter("addressId"));
                        Address address = addressDAO.getAddressById(id);
                        if (!address.getCity().equals(city)) {
                            addressDAO.editAddress(user.getUserID(), "city", city);
                        }
                        if (!address.getDistrict().equals(district)) {
                            addressDAO.editAddress(user.getUserID(), "district", district);
                        }
                        if (!address.getWard().equals(ward)) {
                            addressDAO.editAddress(user.getUserID(), "ward", ward);
                        }
                        if (!address.getDetail().equals(detail)) {
                            addressDAO.editAddress(user.getUserID(), "ward", ward);
                        }

                        break;
                    default:
                        System.out.println("sai cau lenh");
                }
            }


        }
        req.getRequestDispatcher("account").forward(req, resp);

    }
}
