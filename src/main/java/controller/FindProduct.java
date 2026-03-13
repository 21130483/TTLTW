package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Category;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@WebServlet("/html/findProduct")
public class FindProduct extends HttpServlet {
    List<Product> list = new ArrayList<>();
    private static String textFindProducts = "";

    private int categoryID = 0;

    private int currentPage;

    private int numberPages;

    //    0 là những sản phẩm liên quan
    //    1 là những sản phẩm mới nhất
    //    2 là những sản phẩm bán chạy
    int detail = 0;
    //    0 là những sản phẩm liên quan
    //    1 là những sản phẩm mới nhất
    //    2 là những sản phẩm bán chạy

    //    0 là ko sắp xếp theo giá
    //    1 là giá từ cao đến thấp
    //    2 là giá từ thấp đến cao
    int priceBy = 0;

    boolean betweenTo = false;
    int from = 0;
    int to = 0;

    CategoryDAO categoryDAO = new CategoryDAO();
    List<Category> categories = categoryDAO.getAllCategory();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String active = req.getParameter("active");
        switch (active) {
            case "price":
                if (priceBy == 2) {
                    priceBy = 0;
                } else {
                    priceBy++;
                    sortPrice();
                }
                detail = 0;
                currentPage = 1;
                break;
            case "detail":
                detail = Integer.parseInt(req.getParameter("detail"));
                priceBy = 0;
                sortDetail();
                currentPage = 1;
                break;
            case "between":
                from = Integer.parseInt(req.getParameter("from"));
                to = Integer.parseInt(req.getParameter("to"));
                sortBetween();
                currentPage = 1;
                break;
            case "category":
                System.out.println("active " + active);
                categoryID = Integer.parseInt(req.getParameter("categoryID"));
                listByCategory();
                countNumberPages();
                currentPage = 1;
                break;
            case "page":
                currentPage = Integer.parseInt(req.getParameter("page"));
                break;
            default:

        }


        req.setAttribute("textFindProducts", textFindProducts);
        req.setAttribute("getCategoryID", categoryID);
        req.setAttribute("getCategories", categories);
        req.setAttribute("getFindProducts", list);
        req.setAttribute("getnumberPages", numberPages);
        req.setAttribute("getcurrentPage", currentPage);
        req.setAttribute("getpriceBy", priceBy);
        req.setAttribute("getDetail", detail);
        req.setAttribute("getFrom", from);
        req.setAttribute("getTo", to);
        req.getRequestDispatcher("products.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        textFindProducts = req.getParameter("textFindProduct") == null ? "" : (String) req.getParameter("textFindProduct");
        System.out.println(textFindProducts);
        ProductDAO productDAO = new ProductDAO();
        list = productDAO.getFindProducts(textFindProducts);
        categoryID = 0;
        priceBy = 0;
        detail = 0;
        countNumberPages();
        currentPage = 1;
        req.setAttribute("textFindProducts", textFindProducts);
        req.setAttribute("getCategoryID", categoryID);
        req.setAttribute("getCategories", categories);
        req.setAttribute("getFindProducts", list);
        req.setAttribute("getnumberPages", numberPages);
        req.setAttribute("getcurrentPage", currentPage);
        req.setAttribute("getpriceBy", priceBy);
        req.setAttribute("getDetail", detail);
        req.setAttribute("getFrom", from);
        req.setAttribute("getTo", to);
        req.getRequestDispatcher("products.jsp").forward(req, resp);
    }

    public void sortPrice() {
        if (priceBy != 0) {
            Collections.sort(list, new Comparator<Product>() {
                @Override
                public int compare(Product o1, Product o2) {
                    if (priceBy == 1) {
                        return o1.getPrice() - o2.getPrice();
                    } else {
                        return o2.getPrice() - o1.getPrice();
                    }
                }
            });
        } else {
            ProductDAO productDAO = new ProductDAO();
            list = productDAO.getFindProducts(textFindProducts);
        }
    }

    public void sortDetail() {
        if (detail != 0) {
            Collections.sort(list, new Comparator<Product>() {
                @Override
                public int compare(Product o1, Product o2) {
                    if (detail == 1) {
                        return o2.getDateAdded().compareTo(o1.getDateAdded());
                    } else {
                        return o2.getOrderedNumbers() - o1.getOrderedNumbers();
                    }
                }
            });
        } else {
            ProductDAO productDAO = new ProductDAO();
            listByCategory();
        }
    }

    public void sortBetween() {
        ProductDAO productDAO = new ProductDAO();
        list = productDAO.getFindProducts(textFindProducts);
        if (from >= to) {
            from = 0;
            to = 0;
        } else {
//            for (int i = 0; i < list.size(); i++) {
//                if (list.get(i).getPrice() < from || list.get(i).getPrice() > to) {
//                    System.out.println("remove "+i);
//                    list.remove(i);
//                }
//            }
            List<Product> result = new ArrayList<>();
            for (Product p : list) {

                if (p.getPrice() > from && p.getPrice() < to) {
                    result.add(p);
                }
            }
            list = result;
            countNumberPages();
        }
        countNumberPages();

    }

    public void listByCategory() {
        ProductDAO productDAO = new ProductDAO();
        if (categoryID != 0) {
            list = productDAO.getFindProductsCategory(textFindProducts, categoryID);
        } else {
            list = productDAO.getFindProducts(textFindProducts);
        }
    }

    public void countNumberPages() {
        numberPages = (list.size() - 1) / 20 + 1;
    }


}
