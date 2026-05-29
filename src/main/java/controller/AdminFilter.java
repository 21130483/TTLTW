package controller;

import dao.*;
import model.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/html/admin")
public class AdminFilter extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null && (user.getRole() || hasAnyAdminPermission(user))) {
            String page = req.getParameter("page");
            if (!checkPermissionForPage(user, page)) {
                resp.sendRedirect("index.jsp");
                return;
            }
            switch (page) {
                case "product":
//                    int statusProduct = Integer.parseInt(req.getParameter("status"));
                    ProductDAO productDAO = new ProductDAO();
                    CategoryDAO categoryDAO = new CategoryDAO();
                    OriginDAO originDAO = new OriginDAO();
                    List<Category> categories = categoryDAO.getAllCategory();
                    List<Origin> origins = originDAO.getAllOrigin();
                    List<Product> products = productDAO.getAllProduct();
                    req.setAttribute("getAllProducts", products);
                    req.setAttribute("getAllCategory", categories);
                    req.setAttribute("getAllOrigin", origins);
                    page = "managerProducts.jsp";
                    break;

                case "user": {
                    UserDAO userDAO = new UserDAO();
                    List<User> users = userDAO.getAllUsers();
                    String searchUserId = req.getParameter("searchUserId");
                    String searchEmail = req.getParameter("searchEmail");
                    String searchName = req.getParameter("searchName");
                    String searchPhone = req.getParameter("searchPhone");
                    String searchRole = req.getParameter("searchRole");
                    String searchAccess = req.getParameter("searchAccess");
                    List<User> filteredUsers = new java.util.ArrayList<>();
                    for (User u : users) {
                        boolean match = true;
                        if (searchUserId != null && !searchUserId.trim().isEmpty()) {
                            if (!String.valueOf(u.getUserID()).equals(searchUserId.trim())) {
                                match = false;
                            }
                        }
                        if (searchEmail != null && !searchEmail.trim().isEmpty()) {
                            if (!u.getEmail().toLowerCase().contains(searchEmail.trim().toLowerCase())) {
                                match = false;
                            }
                        }
                        if (searchName != null && !searchName.trim().isEmpty()) {
                            if (!u.getFullName().toLowerCase().contains(searchName.trim().toLowerCase())) {
                                match = false;
                            }
                        }
                        if (searchPhone != null && !searchPhone.trim().isEmpty()) {
                            if (u.getPhoneNumbers() == null || !u.getPhoneNumbers().contains(searchPhone.trim())) {
                                match = false;
                            }
                        }
                        if (searchRole != null && !searchRole.trim().isEmpty()) {
                            boolean targetIsAdmin = "admin".equalsIgnoreCase(searchRole.trim());
                            if (u.getRole() != targetIsAdmin) {
                                match = false;
                            }
                        }
                        if (searchAccess != null && !searchAccess.trim().isEmpty()) {
                            boolean targetAccess = Boolean.parseBoolean(searchAccess.trim());
                            if (u.getAccess() != targetAccess) {
                                match = false;
                            }
                        }
                        if (match) {
                            filteredUsers.add(u);
                        }
                    }
                    req.setAttribute("getAllUsers", filteredUsers);
                    page = "managerUsers.jsp";
                    break;
                }
                case "bill":
                    page = "managerBills.jsp";
                    PurchasesDAO purchasesDAO = new PurchasesDAO();
                    List<Purchases> allPurchases = purchasesDAO.getAllPurchases();
                    
                    String searchBillId = req.getParameter("searchBillId");
                    String searchCusId = req.getParameter("searchCusId");
                    String searchCusName = req.getParameter("searchCusName");
                    String searchStatus = req.getParameter("searchStatus");
                    
                    UserDAO billUserDAO = new UserDAO();
                    List<Purchases> filteredPurchases = new java.util.ArrayList<>();
                    for(Purchases p : allPurchases) {
                        boolean match = true;
                        try {
                            if(searchBillId != null && !searchBillId.trim().isEmpty() && p.getPurchaseID() != Integer.parseInt(searchBillId.trim())) match = false;
                            if(searchCusId != null && !searchCusId.trim().isEmpty() && p.getUserID() != Integer.parseInt(searchCusId.trim())) match = false;
                            if(searchStatus != null && !searchStatus.trim().isEmpty() && p.getStatus() != Integer.parseInt(searchStatus.trim())) match = false;
                        } catch(NumberFormatException e) {}
                        
                        if(searchCusName != null && !searchCusName.trim().isEmpty()) {
                            User u = billUserDAO.getUserById(p.getUserID());
                            if(u == null || !u.getFullName().toLowerCase().contains(searchCusName.toLowerCase())) {
                                match = false;
                            }
                        }
                        if(match) filteredPurchases.add(p);
                    }
                    
                    req.setAttribute("getAllPurchases", filteredPurchases);
                    break;
                case "voucher":
                    page = "managerVouchers.jsp";
                    break;
                // Thong ke
                case "statistics":
                    page = "statistics.jsp";
                    StatisticsDAO statisticsDAO = new StatisticsDAO();
                    statisticsDAO.checkAndCreateCreatedAtColumn();
                    req.setAttribute("dailyRevenue", statisticsDAO.getDailyRevenue());
                    req.setAttribute("monthlyRevenue", statisticsDAO.getMonthlyRevenue());
                    req.setAttribute("yearlyRevenue", statisticsDAO.getYearlyRevenue());
                    req.setAttribute("avgOrderValue", statisticsDAO.getAverageOrderValue());
                    req.setAttribute("dailyNewCustomers", statisticsDAO.getDailyNewCustomers());
                    req.setAttribute("monthlyNewCustomers", statisticsDAO.getMonthlyNewCustomers());
                    req.setAttribute("yearlyNewCustomers", statisticsDAO.getYearlyNewCustomers());
                    req.setAttribute("topProducts", statisticsDAO.getTopSellingProducts());
                    break;
                //Ton kho
                case "inventory":
                    ProductDAO inventoryProductDAO = new ProductDAO();
                    List<Product> inventoryProducts = inventoryProductDAO.getAllProduct();
                    
                    String searchIdStr = req.getParameter("searchId");
                    String searchName = req.getParameter("searchName");
                    
                    List<Product> filteredProducts = new java.util.ArrayList<>();
                    for (Product p : inventoryProducts) {
                        boolean matches = true;
                        if (searchIdStr != null && !searchIdStr.trim().isEmpty()) {
                            try {
                                int searchId = Integer.parseInt(searchIdStr.trim());
                                if (p.getProductID() != searchId) {
                                    matches = false;
                                }
                            } catch (NumberFormatException e) {
                                // ignore
                            }
                        }
                        if (searchName != null && !searchName.trim().isEmpty()) {
                            if (!p.getName().toLowerCase().contains(searchName.toLowerCase())) {
                                matches = false;
                            }
                        }
                        if (matches) {
                            filteredProducts.add(p);
                        }
                    }
                    
                    int totalStock = 0;
                    int lowStockCount = 0;
                    int outOfStockCount = 0;
                    
                    for (Product p : inventoryProducts) {
                        totalStock += p.getQuantity();
                        if (p.getQuantity() == 0) {
                            outOfStockCount++;
                        } else if (p.getQuantity() < 20) {
                            lowStockCount++;
                        }
                    }
                    
                    req.setAttribute("getAllProducts", filteredProducts);
                    req.setAttribute("totalStock", totalStock);
                    req.setAttribute("lowStockCount", lowStockCount);
                    req.setAttribute("outOfStockCount", outOfStockCount);
                    req.setAttribute("totalProducts", inventoryProducts.size());
                    
                    page = "managerInventory.jsp";
                    break;
                default:
                    System.out.println("sai cau lenh");
            }
            if (req.getHeader("X-Requested-With") != null && req.getHeader("X-Requested-With").equals("XMLHttpRequest")) {
                req.getRequestDispatcher(page).forward(req, resp);
            } else {
                req.setAttribute("contentPage", page);
                req.getRequestDispatcher("adminLayout.jsp").forward(req, resp);
            }
        } else {
            resp.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null && (user.getRole() || hasAnyAdminPermission(user))) {
            String page = req.getParameter("page");
            if (!checkPermissionForPage(user, page)) {
                resp.sendRedirect("index.jsp");
                return;
            }
            switch (page) {
                case "product":
//                    int statusProduct = Integer.parseInt(req.getParameter("status"));
                    ProductDAO productDAO = new ProductDAO();
                    List<Product> products = productDAO.getAllProduct();
                    req.setAttribute("getAllProducts", products);
                    page = "managerProducts.jsp";
                    break;

                case "user": {
                    UserDAO userDAO = new UserDAO();
                    List<User> users = userDAO.getAllUsers();
                    String searchUserId = req.getParameter("searchUserId");
                    String searchEmail = req.getParameter("searchEmail");
                    String searchName = req.getParameter("searchName");
                    String searchPhone = req.getParameter("searchPhone");
                    String searchRole = req.getParameter("searchRole");
                    String searchAccess = req.getParameter("searchAccess");
                    List<User> filteredUsers = new java.util.ArrayList<>();
                    for (User u : users) {
                        boolean match = true;
                        if (searchUserId != null && !searchUserId.trim().isEmpty()) {
                            if (!String.valueOf(u.getUserID()).equals(searchUserId.trim())) {
                                match = false;
                            }
                        }
                        if (searchEmail != null && !searchEmail.trim().isEmpty()) {
                            if (!u.getEmail().toLowerCase().contains(searchEmail.trim().toLowerCase())) {
                                match = false;
                            }
                        }
                        if (searchName != null && !searchName.trim().isEmpty()) {
                            if (!u.getFullName().toLowerCase().contains(searchName.trim().toLowerCase())) {
                                match = false;
                            }
                        }
                        if (searchPhone != null && !searchPhone.trim().isEmpty()) {
                            if (u.getPhoneNumbers() == null || !u.getPhoneNumbers().contains(searchPhone.trim())) {
                                match = false;
                            }
                        }
                        if (searchRole != null && !searchRole.trim().isEmpty()) {
                            boolean targetIsAdmin = "admin".equalsIgnoreCase(searchRole.trim());
                            if (u.getRole() != targetIsAdmin) {
                                match = false;
                            }
                        }
                        if (searchAccess != null && !searchAccess.trim().isEmpty()) {
                            boolean targetAccess = Boolean.parseBoolean(searchAccess.trim());
                            if (u.getAccess() != targetAccess) {
                                match = false;
                            }
                        }
                        if (match) {
                            filteredUsers.add(u);
                        }
                    }
                    req.setAttribute("getAllUsers", filteredUsers);
                    page = "managerUsers.jsp";
                    break;
                }
                case "bill":
                    page = "managerBills.jsp";
                    PurchasesDAO postPurchasesDAO = new PurchasesDAO();
                    List<Purchases> allPostPurchases = postPurchasesDAO.getAllPurchases();
                    req.setAttribute("getAllPurchases", allPostPurchases);
                    break;
                case "voucher":
                    page = "managerVouchers.jsp";
                    break;
                case "statistics":
                    page = "statistics.jsp";
                    StatisticsDAO statisticsDAO = new StatisticsDAO();
                    statisticsDAO.checkAndCreateCreatedAtColumn();
                    req.setAttribute("dailyRevenue", statisticsDAO.getDailyRevenue());
                    req.setAttribute("monthlyRevenue", statisticsDAO.getMonthlyRevenue());
                    req.setAttribute("yearlyRevenue", statisticsDAO.getYearlyRevenue());
                    req.setAttribute("avgOrderValue", statisticsDAO.getAverageOrderValue());
                    req.setAttribute("dailyNewCustomers", statisticsDAO.getDailyNewCustomers());
                    req.setAttribute("monthlyNewCustomers", statisticsDAO.getMonthlyNewCustomers());
                    req.setAttribute("yearlyNewCustomers", statisticsDAO.getYearlyNewCustomers());
                    req.setAttribute("topProducts", statisticsDAO.getTopSellingProducts());
                    break;
                case "inventory":
                    String action = req.getParameter("action");
                    if ("update".equals(action)) {
                        try {
                            int prodId = Integer.parseInt(req.getParameter("productID"));
                            String qtyVal = req.getParameter("quantity");
                            ProductDAO.updateProduct(prodId, "quantity", qtyVal);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    
                    ProductDAO postProductDAO = new ProductDAO();
                    List<Product> postProducts = postProductDAO.getAllProduct();
                    
                    String postSearchIdStr = req.getParameter("searchId");
                    String postSearchName = req.getParameter("searchName");
                    
                    List<Product> postFilteredProducts = new java.util.ArrayList<>();
                    for (Product p : postProducts) {
                        boolean matches = true;
                        if (postSearchIdStr != null && !postSearchIdStr.trim().isEmpty()) {
                            try {
                                int searchId = Integer.parseInt(postSearchIdStr.trim());
                                if (p.getProductID() != searchId) {
                                    matches = false;
                                }
                            } catch (NumberFormatException e) {
                            }
                        }
                        if (postSearchName != null && !postSearchName.trim().isEmpty()) {
                            if (!p.getName().toLowerCase().contains(postSearchName.toLowerCase())) {
                                matches = false;
                            }
                        }
                        if (matches) {
                            postFilteredProducts.add(p);
                        }
                    }
                    
                    int postTotalStock = 0;
                    int postLowStockCount = 0;
                    int postOutOfStockCount = 0;
                    
                    for (Product p : postProducts) {
                        postTotalStock += p.getQuantity();
                        if (p.getQuantity() == 0) {
                            postOutOfStockCount++;
                        } else if (p.getQuantity() < 20) {
                            postLowStockCount++;
                        }
                    }
                    
                    req.setAttribute("getAllProducts", postFilteredProducts);
                    req.setAttribute("totalStock", postTotalStock);
                    req.setAttribute("lowStockCount", postLowStockCount);
                    req.setAttribute("outOfStockCount", postOutOfStockCount);
                    req.setAttribute("totalProducts", postProducts.size());
                    
                    page = "managerInventory.jsp";
                    break;
                default:
                    System.out.println("sai cau lenh");
            }
            if (req.getHeader("X-Requested-With") != null && req.getHeader("X-Requested-With").equals("XMLHttpRequest")) {
                req.getRequestDispatcher(page).forward(req, resp);
            } else {
                req.setAttribute("contentPage", page);
                req.getRequestDispatcher("adminLayout.jsp").forward(req, resp);
            }
        } else {
            resp.sendRedirect("index.jsp");
        }
    }

    private boolean hasAnyAdminPermission(User user) {
        if (user == null) return false;
        return user.hasPermission("MANAGE_PRODUCTS")
            || user.hasPermission("MANAGE_USERS")
            || user.hasPermission("MANAGE_BILLS")
            || user.hasPermission("MANAGE_VOUCHERS")
            || user.hasPermission("VIEW_STATISTICS")
            || user.hasPermission("MANAGE_INVENTORY");
    }

    private boolean checkPermissionForPage(User user, String page) {
        if (user == null) return false;
        if (user.getRole()) {
            return true;
        }
        if (page == null) return false;
        switch (page) {
            case "product":
                return user.hasPermission("MANAGE_PRODUCTS");
            case "user":
                return user.hasPermission("MANAGE_USERS");
            case "bill":
                return user.hasPermission("MANAGE_BILLS");
            case "voucher":
                return user.hasPermission("MANAGE_VOUCHERS");
            case "statistics":
                return user.hasPermission("VIEW_STATISTICS");
            case "inventory":
                return user.hasPermission("MANAGE_INVENTORY");
            default:
                return false;
        }
    }
}