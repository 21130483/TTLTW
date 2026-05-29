<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String searchUserId = request.getParameter("searchUserId");
    String searchEmail = request.getParameter("searchEmail");
    String searchName = request.getParameter("searchName");
    String searchPhone = request.getParameter("searchPhone");
    String searchRole = request.getParameter("searchRole");
    String searchAccess = request.getParameter("searchAccess");

    if (searchUserId == null) searchUserId = "";
    if (searchEmail == null) searchEmail = "";
    if (searchName == null) searchName = "";
    if (searchPhone == null) searchPhone = "";
    if (searchRole == null) searchRole = "";
    if (searchAccess == null) searchAccess = "";

    List<User> users = (List<User>) request.getAttribute("getAllUsers");
%>

<div class="quan-ly-thanh-vien">
    <div class="header-section">
        <h1 class="page-title">Quản lý thành viên</h1>
        <p class="subtitle">Quản lý tài khoản người dùng, phân quyền truy cập và kiểm soát trạng thái hoạt động.</p>
    </div>

    <div class="filter-box">
        <h3 class="filter-title">Bộ lọc &amp; Tìm kiếm</h3>
        <form action="admin" method="get" class="filter-form">
            <input type="hidden" name="page" value="user">
            
            <input type="text" name="searchUserId" value="<%= searchUserId %>" placeholder="ID thành viên..." class="filter-input">
            <input type="text" name="searchEmail" value="<%= searchEmail %>" placeholder="Email..." class="filter-input">
            <input type="text" name="searchName" value="<%= searchName %>" placeholder="Họ và tên..." class="filter-input">
            <input type="text" name="searchPhone" value="<%= searchPhone %>" placeholder="Số điện thoại..." class="filter-input">
            
            <select name="searchRole" class="filter-select">
                <option value="">-- Tất cả vai trò --</option>
                <option value="admin" <%= "admin".equals(searchRole) ? "selected" : "" %>>Admin</option>
                <option value="user" <%= "user".equals(searchRole) ? "selected" : "" %>>Khách hàng</option>
            </select>
            
            <select name="searchAccess" class="filter-select">
                <option value="">-- Tất cả trạng thái --</option>
                <option value="true" <%= "true".equals(searchAccess) ? "selected" : "" %>>Hoạt động</option>
                <option value="false" <%= "false".equals(searchAccess) ? "selected" : "" %>>Bị chặn</option>
            </select>
            
            <div class="filter-buttons">
                <button type="submit" class="filter-btn">Tìm kiếm</button>
                <% if (!searchUserId.isEmpty() || !searchEmail.isEmpty() || !searchName.isEmpty() || !searchPhone.isEmpty() || !searchRole.isEmpty() || !searchAccess.isEmpty()) { %>
                    <a href="admin?page=user" class="filter-clear-btn">Xóa lọc</a>
                <% } %>
            </div>
        </form>
    </div>

    <div class="table-box">
        <table class="user-table">
            <thead>
                <tr>
                    <th style="width: 70px;">ID</th>
                    <th>Họ và tên</th>
                    <th>Email</th>
                    <th>Số điện thoại</th>
                    <th>Vai trò</th>
                    <th>Quyền hạn</th>
                    <th style="width: 130px; text-align: center;">Trạng thái</th>
                    <th style="width: 100px; text-align: center;">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (users != null && !users.isEmpty()) {
                        for (User u : users) {
                %>
                <tr>
                    <td><span class="user-id">#<%= u.getUserID() %></span></td>
                    <td><span class="user-name"><%= u.getFullName() %></span></td>
                    <td><span class="user-email"><%= u.getEmail() %></span></td>
                    <td><%= u.getPhoneNumbers() != null ? u.getPhoneNumbers() : "" %></td>
                    <td>
                        <div class="badge-container">
                            <%
                                List<model.Role> uRoles = u.getRoles();
                                if (uRoles != null && !uRoles.isEmpty()) {
                                    for (model.Role r : uRoles) {
                                        String rClass = r.getRoleName().equalsIgnoreCase("ADMIN") ? "badge-admin" : "badge-user";
                            %>
                                        <span class="badge <%= rClass %>"><%= r.getRoleName() %></span>
                            <%
                                    }
                                } else {
                            %>
                                    <span class="badge badge-user">USER</span>
                            <%
                                }
                            %>
                        </div>
                    </td>
                    <td>
                        <div class="perms-container">
                            <%
                                java.util.Set<String> uPerms = u.getPermissions();
                                if (uPerms != null && !uPerms.isEmpty()) {
                                    if (u.getRole()) {
                            %>
                                        <span class="perm-tag all-perms" title="Toàn quyền hệ thống">Tất cả quyền</span>
                            <%
                                    } else {
                                        for (String perm : uPerms) {
                                            String vietnamesePerm = perm;
                                            if ("MANAGE_PRODUCTS".equals(perm)) vietnamesePerm = "Sản phẩm";
                                            else if ("MANAGE_USERS".equals(perm)) vietnamesePerm = "Thành viên";
                                            else if ("MANAGE_BILLS".equals(perm)) vietnamesePerm = "Hóa đơn";
                                            else if ("MANAGE_VOUCHERS".equals(perm)) vietnamesePerm = "Voucher";
                                            else if ("VIEW_STATISTICS".equals(perm)) vietnamesePerm = "Thống kê";
                                            else if ("MANAGE_INVENTORY".equals(perm)) vietnamesePerm = "Tồn kho";
                            %>
                                            <span class="perm-tag"><%= vietnamesePerm %></span>
                            <%
                                        }
                                    }
                                } else {
                            %>
                                    <span class="perm-tag none-perms">Không có</span>
                            <%
                                }
                            %>
                        </div>
                    </td>
                    <td style="text-align: center;">
                        <%
                            if (u.getAccess()) {
                        %>
                            <span class="badge badge-active">Hoạt động</span>
                        <%
                            } else {
                        %>
                            <span class="badge badge-blocked">Bị chặn</span>
                        <%
                            }
                        %>
                    </td>
                    <td style="text-align: center;">
                        <a href="edituser?id=<%=u.getUserID()%>" class="action-btn-link">
                            <button class="sua-btn">Sửa</button>
                        </a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="8" style="text-align: center; color: #a0aec0; padding: 40px;">
                        Không tìm thấy thành viên nào phù hợp với bộ lọc.
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>