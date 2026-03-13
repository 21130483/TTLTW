package controller;

import dao.CategoryDAO;
import dao.OriginDAO;
import dao.ProductDAO;
import model.Category;
import model.Origin;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.util.Collection;
import java.util.List;

@MultipartConfig
@WebServlet("/html/add-edit-delete")
public class AddEditDeleteProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String active = req.getParameter("active");
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        OriginDAO originDAO = new OriginDAO();
        List<Category> categories = categoryDAO.getAllCategory();
        List<Origin> origins = originDAO.getAllOrigin();
        switch (active) {
            case "add":
                int addProductID = productDAO.getNewProductID();
                req.setAttribute("idAdd", addProductID);
                req.setAttribute("getCategories", categories);
                req.setAttribute("getOrigins", origins);
                req.setAttribute("active", active);
                req.getRequestDispatcher("addEditProduct.jsp").forward(req, resp);
                break;
            case "edit":
                int editProductID = Integer.parseInt(req.getParameter("id"));
                System.out.println(editProductID);
                Product product = productDAO.getProductById(editProductID);
                req.setAttribute("active", active);
                req.setAttribute("getCategories", categories);
                req.setAttribute("productEdit", product);
                req.setAttribute("getOrigins", origins);
                req.getRequestDispatcher("addEditProduct.jsp").forward(req, resp);
                break;
            case "delete":
                int deleteProductID = Integer.parseInt(req.getParameter("id"));
                productDAO.deleteProduct(deleteProductID);
                deleteImageProduct(req.getServletContext().getRealPath("")+"/image/product/"+deleteProductID);
                req.getRequestDispatcher("admin?page=product").forward(req, resp);
                break;
            default:
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String active = req.getParameter("active");
        ProductDAO productDAO = new ProductDAO();
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String trademark = req.getParameter("trademark");
        int categoryID = Integer.parseInt(req.getParameter("categoryID"));
        int originID = Integer.parseInt(req.getParameter("originID"));
        int price = Integer.parseInt(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        int sale = Integer.parseInt(req.getParameter("sale"));
        String content = req.getParameter("content");
        Collection<Part> parts = req.getParts();
        if (active.equals("edit")) {
            Product editProduct = productDAO.getProductById(id);
            if (!editProduct.getName().equals(name)) {
                productDAO.updateProduct(id, "name", name);
            }
            if (!editProduct.getTrademark().equals(trademark)) {
                productDAO.updateProduct(id, "trademark", trademark);
            }
            if (!editProduct.getContent().equals(content)) {
                productDAO.updateProduct(id, "content", content);
            }
            if (!(editProduct.getCategoryID() == categoryID)) {
                productDAO.updateProduct(id, "categoryID", String.valueOf(categoryID));
            }
            if (!(editProduct.getOriginID() == originID)) {
                productDAO.updateProduct(id, "originID", String.valueOf(originID));
            }
            if (!(editProduct.getPrice() == price)) {
                productDAO.updateProduct(id, "price", String.valueOf(price));
            }
            if (!(editProduct.getQuantity() == quantity)) {
                productDAO.updateProduct(id, "quantity", String.valueOf(quantity));
            }
            if (!(editProduct.getSale() == sale)) {
                productDAO.updateProduct(id, "sale", String.valueOf(sale));
            }
            if (parts != null) {

            }
        } else if (active.equals("add")) {
            productDAO.addProduct(id, name, trademark, content, categoryID, originID, quantity, price, sale);
            String pathFolder = req.getServletContext().getRealPath("") + "/image/product/" + id;
            File folder = new File(pathFolder);
            if (!folder.exists()) {
                folder.mkdir();
            }
            int count = 0;
            for (Part part : parts) {
                if (part.getSubmittedFileName()!=null) {
                    System.out.println(part.getSubmittedFileName());
                    String path = req.getServletContext().getRealPath("") + "/image/product/" + id + "/" + count + ".jpg";
                    part.write(path);
                    count++;
                }
            }
        }
        req.getRequestDispatcher("admin?page=product").forward(req, resp);
    }





    public boolean deleteImageProduct(String path) {
        File file = new File(path);
        System.out.println(file.getAbsoluteFile());
        if (file.exists()) {
            if (file.isDirectory()) {
                if (file.listFiles().length > 0) {
                    for (File fileChild : file.listFiles()) {
                        deleteImageProduct(path + "/" + fileChild.getName());
                    }
                }
                file.delete();
            } else if (file.isFile()) {
                file.delete();
            }

            return true;
        }
        return false;
    }

}
