<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.Category" %>
<%@ page import="model.Origin" %>
<%@ page import="dao.OriginDAO" %>
<%@ page import="dao.CategoryDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String searchProductId = request.getParameter("searchProductId");
    String searchName = request.getParameter("searchName");
    String searchCategoryId = request.getParameter("searchCategoryId");
    String searchOriginId = request.getParameter("searchOriginId");
    String searchStatus = request.getParameter("searchStatus");

    if (searchProductId == null) searchProductId = "";
    if (searchName == null) searchName = "";
    if (searchCategoryId == null) searchCategoryId = "";
    if (searchOriginId == null) searchOriginId = "";
    if (searchStatus == null) searchStatus = "";

    List<Product> list = (List<Product>) request.getAttribute("getAllProducts");
    List<Category> categories = (List<Category>) request.getAttribute("getAllCategory");
    List<Origin> origins = (List<Origin>) request.getAttribute("getAllOrigin");

    OriginDAO originDAO = new OriginDAO();
    CategoryDAO categoryDAO = new CategoryDAO();
%>

<div class="quan-ly-san-pham">
    <div class="header-section">
        <h1 class="page-title">Quản lý sản phẩm</h1>
        <p class="subtitle">Quản lý sản phẩm hệ thống, cập nhật thông tin và kiểm soát trạng thái ẩn/hiện.</p>
    </div>

    <div class="them-san-pham-box">
        <a href="add-edit-delete?active=add" class="them-sp-btn-link">
            <button class="them-sp-btn">Thêm sản phẩm mới</button>
        </a>
    </div>

    <div class="filter-box">
        <h3 class="filter-title">Bộ lọc &amp; Tìm kiếm</h3>
        <form action="admin" method="get" class="filter-form">
            <input type="hidden" name="page" value="product">
            
            <input type="text" name="searchProductId" value="<%= searchProductId %>" placeholder="ID sản phẩm..." class="filter-input">
            <input type="text" name="searchName" value="<%= searchName %>" placeholder="Tên sản phẩm..." class="filter-input">
            
            <select name="searchCategoryId" class="filter-select">
                <option value="">-- Tất cả danh mục --</option>
                <% if (categories != null) {
                    for (Category c : categories) { %>
                        <option value="<%= c.getCategoryID() %>" <%= String.valueOf(c.getCategoryID()).equals(searchCategoryId) ? "selected" : "" %>><%= c.getName() %></option>
                <%  }
                } %>
            </select>
            
            <select name="searchOriginId" class="filter-select">
                <option value="">-- Tất cả xuất xứ --</option>
                <% if (origins != null) {
                    for (Origin o : origins) { %>
                        <option value="<%= o.getOriginID() %>" <%= String.valueOf(o.getOriginID()).equals(searchOriginId) ? "selected" : "" %>><%= o.getName() %></option>
                <%  }
                } %>
            </select>
            
            <select name="searchStatus" class="filter-select">
                <option value="">-- Tất cả trạng thái --</option>
                <option value="false" <%= "false".equals(searchStatus) ? "selected" : "" %>>Hiển thị</option>
                <option value="true" <%= "true".equals(searchStatus) ? "selected" : "" %>>Đang ẩn</option>
            </select>
            
            <div class="filter-buttons">
                <button type="submit" class="filter-btn">Tìm kiếm</button>
                <% if (!searchProductId.isEmpty() || !searchName.isEmpty() || !searchCategoryId.isEmpty() || !searchOriginId.isEmpty() || !searchStatus.isEmpty()) { %>
                    <a href="admin?page=product" class="filter-clear-btn">Xóa lọc</a>
                <% } %>
            </div>
        </form>
    </div>

    <div class="table-box">
        <table class="product-table">
            <thead>
                <tr>
                    <th style="width: 70px;">ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Danh mục</th>
                    <th>Xuất xứ</th>
                    <th>Ngày thêm</th>
                    <th style="width: 130px; text-align: center;">Trạng thái</th>
                    <th style="width: 180px; text-align: center;">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (list != null && !list.isEmpty()) {
                        for (Product p : list) {
                %>
                <tr style="<%= p.isHidden() ? "opacity: 0.7;" : "" %>">
                    <td><span class="product-id">#<%= p.getProductID() %></span></td>
                    <td>
                        <span class="product-name" title="<%= p.getName() %>"><%= p.getName() %></span>
                    </td>
                    <td><%= categoryDAO.getCategoryById(p.getCategoryID()).getName() %></td>
                    <td><%= originDAO.getOriginById(p.getOriginID()).getName() %></td>
                    <td><%= p.getDateAdded() %></td>
                    <td style="text-align: center;">
                        <%
                            if (!p.isHidden()) {
                        %>
                            <span class="badge badge-active">Hiển thị</span>
                        <%
                            } else {
                        %>
                            <span class="badge badge-blocked">Đang ẩn</span>
                        <%
                            }
                        %>
                    </td>
                    <td style="text-align: center;">
                        <div class="action-buttons-container">
                            <a href="add-edit-delete?active=edit&id=<%= p.getProductID() %>" class="action-btn-link">
                                <button class="sua-btn">Sửa</button>
                            </a>
                            <a href="add-edit-delete?active=hide&id=<%= p.getProductID() %>" class="action-btn-link" onclick="return confirm('<%= p.isHidden() ? "Hiện sản phẩm này?" : "Ẩn sản phẩm này?" %>')">
                                <button class="toggle-btn <%= p.isHidden() ? "show-btn" : "hide-btn" %>">
                                    <%= p.isHidden() ? "Hiện" : "Ẩn" %>
                                </button>
                            </a>
                        </div>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="7" style="text-align: center; color: #a0aec0; padding: 40px;">
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