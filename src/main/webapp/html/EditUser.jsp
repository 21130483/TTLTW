<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="model.Role" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    User user = (User) request.getAttribute("editUser");
    List<Role> allRoles = (List<Role>) request.getAttribute("allRoles");
    if (user == null) {
        int id = Integer.parseInt(request.getParameter("id"));
        dao.UserDAO userDAO = new dao.UserDAO();
        user = userDAO.getUserById(id);
    }
    if (allRoles == null) {
        allRoles = dao.UserDAO.getAllRoles();
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa thành viên - Admin</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f7fafc;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            color: #2d3748;
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .header-section {
            margin-bottom: 24px;
        }

        .header-section h1 {
            font-size: 28px;
            font-weight: 700;
            color: #1a202c;
            margin: 0 0 6px 0;
        }

        .header-section p {
            font-size: 14px;
            color: #718096;
            margin: 0;
        }

        .edit-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            overflow: hidden;
        }

        .card-body {
            padding: 30px;
        }

        .grid-layout {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }

        @media (max-width: 768px) {
            .grid-layout {
                grid-template-columns: 1fr;
            }
        }

        .section-title {
            font-size: 16px;
            font-weight: 600;
            color: #4a5568;
            margin-top: 0;
            margin-bottom: 20px;
            border-bottom: 2px solid #edf2f7;
            padding-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #4a5568;
            margin-bottom: 6px;
        }

        .form-control {
            width: 100%;
            height: 40px;
            padding: 8px 12px;
            border: 1px solid #cbd5e0;
            border-radius: 6px;
            font-size: 14px;
            background-color: #fff;
            color: #2d3748;
            box-sizing: border-box;
        }

        .form-control-readonly {
            background-color: #edf2f7;
            color: #718096;
            cursor: not-allowed;
        }

        .checkbox-container {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-top: 10px;
        }

        .checkbox-item {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            padding: 10px;
            border: 1px solid #edf2f7;
            border-radius: 6px;
            background-color: #f7fafc;
        }

        .checkbox-item input[type="checkbox"] {
            margin-top: 4px;
            width: 16px;
            height: 16px;
            cursor: pointer;
        }

        .checkbox-label-wrapper {
            display: flex;
            flex-direction: column;
        }

        .checkbox-title {
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
        }

        .checkbox-desc {
            font-size: 12px;
            color: #718096;
            margin-top: 2px;
        }

        .permissions-list {
            margin-top: 6px;
            display: flex;
            flex-wrap: wrap;
            gap: 4px;
        }

        .perm-badge {
            font-size: 10px;
            background-color: #ebf8ff;
            color: #2b6cb0;
            padding: 2px 6px;
            border-radius: 4px;
            border: 1px solid #bee3f8;
        }

        .actions-section {
            padding: 20px 30px;
            background-color: #f7fafc;
            border-top: 1px solid #e2e8f0;
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }

        .btn {
            height: 40px;
            padding: 0 24px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s, border-color 0.2s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            box-sizing: border-box;
        }

        .btn-primary {
            background-color: #3182ce;
            color: #ffffff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #2b6cb0;
        }

        .btn-secondary {
            background-color: #ffffff;
            color: #4a5568;
            border: 1px solid #cbd5e0;
        }

        .btn-secondary:hover {
            background-color: #f7fafc;
            border-color: #a0aec0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header-section">
            <h1>Thông tin thành viên</h1>
            <p>Xem thông tin chi tiết và điều chỉnh vai trò, quyền hạn truy cập của thành viên.</p>
        </div>

        <div class="edit-card">
            <form action="edituser" method="post">
                <input type="hidden" name="id" value="<%= user.getUserID() %>">
                
                <div class="card-body">
                    <div class="grid-layout">
                        <div>
                            <h3 class="section-title">Thông tin cơ bản</h3>
                            
                            <div class="form-group">
                                <label>Mã thành viên</label>
                                <input type="text" value="#<%= user.getUserID() %>" class="form-control form-control-readonly" disabled>
                            </div>
                            
                            <div class="form-group">
                                <label>Họ và tên</label>
                                <input type="text" value="<%= user.getFullName() %>" class="form-control form-control-readonly" disabled>
                            </div>
                            
                            <div class="form-group">
                                <label>Email liên hệ</label>
                                <input type="text" value="<%= user.getEmail() %>" class="form-control form-control-readonly" disabled>
                            </div>
                            
                            <div class="form-group">
                                <label>Số điện thoại</label>
                                <input type="text" value="<%= user.getPhoneNumbers() != null ? user.getPhoneNumbers() : "" %>" class="form-control form-control-readonly" disabled>
                            </div>

                            <div class="form-group">
                                <label>Ngày sinh</label>
                                <input type="text" value="<%= user.getDob() != null ? user.getDob().toString() : "" %>" class="form-control form-control-readonly" disabled>
                            </div>

                            <div class="form-group">
                                <label>Giới tính</label>
                                <input type="text" value="<%= user.getGender() != null ? user.getGender() : "" %>" class="form-control form-control-readonly" disabled>
                            </div>
                        </div>

                        <div>
                            <h3 class="section-title">Trạng thái &amp; Vai trò</h3>
                            
                            <div class="form-group">
                                <label for="access">Trạng thái hoạt động</label>
                                <select id="access" name="access" class="form-control">
                                    <option value="true" <%= user.getAccess() ? "selected" : "" %>>Cho phép hoạt động</option>
                                    <option value="false" <%= !user.getAccess() ? "selected" : "" %>>Chặn quyền truy cập</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Vai trò trong hệ thống</label>
                                <div class="checkbox-container">
                                    <%
                                        if (allRoles != null) {
                                            for (Role role : allRoles) {
                                                boolean hasThisRole = false;
                                                if (user.getRoles() != null) {
                                                    for (Role uRole : user.getRoles()) {
                                                        if (uRole.getRoleID() == role.getRoleID()) {
                                                            hasThisRole = true;
                                                            break;
                                                        }
                                                    }
                                                }
                                    %>
                                    <div class="checkbox-item">
                                        <input type="checkbox" id="role_<%= role.getRoleID() %>" name="roles" value="<%= role.getRoleID() %>" <%= hasThisRole ? "checked" : "" %>>
                                        <div class="checkbox-label-wrapper">
                                            <label for="role_<%= role.getRoleID() %>" class="checkbox-title"><%= role.getRoleName() %></label>
                                            <span class="checkbox-desc"><%= role.getDescription() %></span>
                                            
                                            <div class="permissions-list">
                                                <%
                                                    if (role.getRoleID() == 1) {
                                                %>
                                                    <span class="perm-badge">Sản phẩm</span>
                                                    <span class="perm-badge">Thành viên</span>
                                                    <span class="perm-badge">Hóa đơn</span>
                                                    <span class="perm-badge">Voucher</span>
                                                    <span class="perm-badge">Thống kê</span>
                                                    <span class="perm-badge">Tồn kho</span>
                                                <%
                                                    } else if (role.getRoleID() == 2) {
                                                %>
                                                    <span class="perm-badge">Xem &amp; Mua sản phẩm</span>
                                                    <span class="perm-badge">Quản lý giỏ hàng</span>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                    <%
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="actions-section">
                    <a href="admin?page=user" class="btn btn-secondary">Hủy</a>
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>