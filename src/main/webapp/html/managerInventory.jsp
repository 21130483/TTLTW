<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="dao.OriginDAO" %>
<%@ page import="dao.CategoryDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String searchIdStr = request.getParameter("searchId");
    String searchName = request.getParameter("searchName");
    if (searchIdStr == null) searchIdStr = "";
    if (searchName == null) searchName = "";
    
    List<Product> list = (List<Product>) request.getAttribute("getAllProducts");
    
    Integer totalStockVal = (Integer) request.getAttribute("totalStock");
    int totalStock = totalStockVal != null ? totalStockVal : 0;
    
    Integer lowStockVal = (Integer) request.getAttribute("lowStockCount");
    int lowStockCount = lowStockVal != null ? lowStockVal : 0;
    
    Integer outStockVal = (Integer) request.getAttribute("outOfStockCount");
    int outOfStockCount = outStockVal != null ? outStockVal : 0;
    
    Integer totalProdVal = (Integer) request.getAttribute("totalProducts");
    int totalProducts = totalProdVal != null ? totalProdVal : 0;
    
    java.text.DecimalFormat df = new java.text.DecimalFormat("#,###");
%>

    <div class="quan-ly">
        <h1 class="title-stat">Quản lý Kho hàng &amp; Tồn kho</h1>
        <p class="subtitle">Theo dõi số lượng, tình trạng và thực hiện cập nhật nhập kho trực tiếp.</p>

        <!-- KPI Summary Cards -->
        <div class="kpi-container">
            <div class="kpi-card total-prod">
                <div>
                    <span class="kpi-title">Tổng loại sản phẩm</span>
                    <div class="kpi-value"><%= df.format(totalProducts) %></div>
                </div>
            </div>
            <div class="kpi-card total-stock">
                <div>
                    <span class="kpi-title">Tổng số lượng tồn</span>
                    <div class="kpi-value"><%= df.format(totalStock) %> cái</div>
                </div>
            </div>
            <div class="kpi-card low-stock">
                <div>
                    <span class="kpi-title">Sản phẩm sắp hết hàng (&lt; 20)</span>
                    <div class="kpi-value"><%= df.format(lowStockCount) %></div>
                </div>
            </div>
            <div class="kpi-card out-stock">
                <div>
                    <span class="kpi-title">Sản phẩm đã hết hàng</span>
                    <div class="kpi-value"><%= df.format(outOfStockCount) %></div>
                </div>
            </div>
        </div>

        <!-- Filter & Search Form -->
        <div class="filter-box">
            <h3 class="filter-title">Bộ lọc &amp; Tìm kiếm</h3>
            <form action="admin" method="get" class="filter-form">
                <input type="hidden" name="page" value="inventory">
                
                <input type="text" name="searchId" value="<%= searchIdStr %>" placeholder="Nhập ID sản phẩm..." class="filter-input">
                <input type="text" name="searchName" value="<%= searchName %>" placeholder="Nhập tên sản phẩm..." class="filter-input">
                
                <div style="display: flex; gap: 10px;">
                    <button type="submit" class="filter-btn">Tìm kiếm</button>
                    <% if (!searchIdStr.isEmpty() || !searchName.isEmpty()) { %>
                        <a href="admin?page=inventory" class="filter-clear-btn">Xóa lọc</a>
                    <% } %>
                </div>
            </form>
        </div>

        <!-- Products Stock Table -->
        <div class="table-box">
            <table class="inventory-table">
                <thead>
                <tr>
                    <th style="width: 80px;">Mã SP</th>
                    <th>Tên sản phẩm</th>
                    <th style="width: 140px;">Trạng thái</th>
                    <th style="width: 120px; text-align: right;">Đã bán</th>
                    <th style="width: 160px; text-align: right;">Giá bán</th>
                    <th style="width: 220px; text-align: center;">Điều chỉnh tồn kho</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (list != null && !list.isEmpty()) {
                        for (Product p : list) {
                            // Determine stock level status
                            String badgeClass = "badge-safe";
                            String statusText = "An toàn";
                            if (p.getQuantity() == 0) {
                                badgeClass = "badge-out";
                                statusText = "Hết hàng";
                            } else if (p.getQuantity() < 20) {
                                badgeClass = "badge-low";
                                statusText = "Sắp hết";
                            }
                %>
                <tr>
                    <td><span class="prod-id">#<%= p.getProductID() %></span></td>
                    <td>
                        <div class="prod-name" title="<%= p.getName() %>"><%= p.getName() %></div>
                    </td>
                    <td>
                        <span class="badge <%= badgeClass %>"><%= statusText %></span>
                    </td>
                    <td style="text-align: right; font-weight: 600;"><%= p.getOrderedNumbers() %></td>
                    <td style="text-align: right; font-weight: 600; color: #2d3748;"><%= p.getPriceHaveDots() %></td>
                    <td style="text-align: center;">
                        <form action="admin?page=inventory&action=update" method="post" class="update-form">
                            <input type="hidden" name="productID" value="<%= p.getProductID() %>">
                            <input type="hidden" name="searchId" value="<%= searchIdStr %>">
                            <input type="hidden" name="searchName" value="<%= searchName %>">
                            <input type="number" name="quantity" value="<%= p.getQuantity() %>" min="0" class="qty-input">
                            <button type="submit" class="qty-btn">Cập nhật</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="6" style="text-align: center; color: #a0aec0; padding: 40px;">
                        Không tìm thấy sản phẩm nào phù hợp với bộ lọc.
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
