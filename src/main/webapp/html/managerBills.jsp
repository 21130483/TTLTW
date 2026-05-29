<%@ page import="java.util.List" %>
<%@ page import="model.Purchases" %>
<%@ page import="model.User" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="model.Product" %>
<%@ page import="dao.ProductDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String searchBillId = request.getParameter("searchBillId") != null ? request.getParameter("searchBillId") : "";
    String searchCusId = request.getParameter("searchCusId") != null ? request.getParameter("searchCusId") : "";
    String searchCusName = request.getParameter("searchCusName") != null ? request.getParameter("searchCusName") : "";
    String searchStatus = request.getParameter("searchStatus") != null ? request.getParameter("searchStatus") : "";
%>

<div class="quan-ly-san-pham">
    <div class="header-container">
        <div class="title">
            <p>Quản lý hóa đơn</p>
        </div>
        <button class="btn-add-invoice" onclick="openInvoiceModal()">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
            Thêm hóa đơn
        </button>
    </div>

    <div class="filter-section">
        <form id="search-invoice-form" action="admin" method="get" class="filter-form">
            <input type="hidden" name="page" value="bill">
            <input type="text" name="searchBillId" value="<%= searchBillId %>" placeholder="ID Hóa đơn" class="filter-input">
            <input type="text" name="searchCusId" value="<%= searchCusId %>" placeholder="ID Khách hàng" class="filter-input">
            <input type="text" name="searchCusName" value="<%= searchCusName %>" placeholder="Tên khách hàng" class="filter-input">
            <select name="searchStatus" class="filter-input">
                <option value="">-- Trạng thái --</option>
                <option value="0" <%= "0".equals(searchStatus) ? "selected" : "" %>>Chờ xác nhận</option>
                <option value="1" <%= "1".equals(searchStatus) ? "selected" : "" %>>Đang giao</option>
                <option value="2" <%= "2".equals(searchStatus) ? "selected" : "" %>>Hoàn thành</option>
                <option value="-1" <%= "-1".equals(searchStatus) ? "selected" : "" %>>Đã hủy</option>
            </select>
            <button type="submit" class="btn-search">Tìm kiếm</button>
            <% if (!searchBillId.isEmpty() || !searchCusId.isEmpty() || !searchCusName.isEmpty() || !searchStatus.isEmpty()) { %>
                <a href="admin?page=bill" class="btn-search" style="background-color: #6c757d; text-decoration: none;">Xóa lọc</a>
            <% } %>
        </form>
    </div>

    <div class="table-container">
        <table class="invoice-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên Sản phẩm</th>
                    <th>Tên Khách hàng</th>
                    <th>Ngày đặt</th>
                    <th>Tổng giá</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Purchases> purchases = (List) request.getAttribute("getAllPurchases");
                    UserDAO userDAO = new UserDAO();
                    ProductDAO productDAO = new ProductDAO();
                    if (purchases != null && !purchases.isEmpty()) {
                        for (Purchases p : purchases) {
                            User user = userDAO.getUserById(p.getUserID());
                            Product product = productDAO.getProductById(p.getProductID());
                            
                            String badgeClass = "status-pending";
                            if (p.getStatus() == 1) badgeClass = "status-delivering";
                            else if (p.getStatus() == 2) badgeClass = "status-completed";
                            else if (p.getStatus() == -1) badgeClass = "status-cancelled";
                %>
                <tr>
                    <td><strong>#<%= p.getPurchaseID() %></strong></td>
                    <td>
                        <div style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" title="<%= product != null ? product.getName() : "N/A" %>">
                            <%= product != null ? product.getName() : "N/A" %>
                        </div>
                    </td>
                    <td><%= user != null ? user.getFullName() : "N/A" %></td>
                    <td><%= p.getOrderDate() != null ? p.getOrderDate() : "N/A" %></td>
                    <td style="font-weight: bold; color: #d35400;"><%= p.getPrice() %> ₫</td>
                    <td><span class="status-badge <%= badgeClass %>"><%= p.getStatusString() %></span></td>
                    <td>
                        <div class="action-buttons">
                            <% if (p.getStatus() == 0) { %>
                                <a href="bill?active=confirm&purchaseid=<%=p.getPurchaseID()%>&userid=<%=p.getUserID()%>&productid=<%=p.getProductID()%>" class="btn-action btn-confirm" onclick="return confirmAction(event, this.href)">Xác nhận</a>
                                <a href="bill?active=cancel&purchaseid=<%=p.getPurchaseID()%>&userid=<%=p.getUserID()%>&productid=<%=p.getProductID()%>" class="btn-action btn-cancel" onclick="return confirmAction(event, this.href)">Hủy</a>
                            <% } else if (p.getStatus() == 1) { %>
                                <a href="bill?active=confirm&purchaseid=<%=p.getPurchaseID()%>&userid=<%=p.getUserID()%>&productid=<%=p.getProductID()%>" class="btn-action btn-confirm" onclick="return confirmAction(event, this.href)">Hoàn thành</a>
                                <a href="bill?active=cancel&purchaseid=<%=p.getPurchaseID()%>&userid=<%=p.getUserID()%>&productid=<%=p.getProductID()%>" class="btn-action btn-cancel" onclick="return confirmAction(event, this.href)">Hủy</a>
                            <% } else { %>
                                <span style="color: #999; font-size: 13px;">Không có</span>
                            <% } %>
                        </div>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="7" style="text-align: center; color: #888; padding: 30px;">Không tìm thấy hóa đơn nào phù hợp.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Add Invoice Modal -->
<div id="addInvoiceModal" class="modal-overlay">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Tạo Hóa đơn Mới</h3>
            <button class="btn-close" onclick="closeInvoiceModal()">&times;</button>
        </div>
        <form id="add-invoice-form" onsubmit="submitAddInvoice(event)">
            <div class="form-group">
                <label for="userID">ID Khách hàng</label>
                <input type="number" id="userID" name="userID" required>
            </div>
            <div class="form-group">
                <label for="productID">ID Sản phẩm</label>
                <input type="number" id="productID" name="productID" required>
            </div>
            <div class="form-group" style="display: flex; gap: 15px;">
                <div style="flex: 1;">
                    <label for="quantity">Số lượng</label>
                    <input type="number" id="quantity" name="quantity" min="1" required>
                </div>
                <div style="flex: 1;">
                    <label for="price">Tổng giá (₫)</label>
                    <input type="number" id="price" name="price" min="0" required>
                </div>
            </div>
            <div class="form-group">
                <label for="address">Địa chỉ giao hàng</label>
                <input type="text" id="address" name="address" required>
            </div>
            <div class="form-group">
                <label for="comment">Ghi chú (Tùy chọn)</label>
                <textarea id="comment" name="comment" rows="2"></textarea>
            </div>
            <button type="submit" class="btn-submit">Lưu Hóa Đơn</button>
        </form>
    </div>
</div>

<script>
    // Since this is loaded via AJAX, we need to bind form submission manually
    document.getElementById('search-invoice-form').addEventListener('submit', function(e) {
        e.preventDefault();
        const url = new URL(this.action);
        const formData = new FormData(this);
        const search = new URLSearchParams(formData).toString();
        const targetUrl = url.pathname + '?' + search;
        
        fetch(targetUrl, { headers: { 'X-Requested-With': 'XMLHttpRequest' } })
            .then(res => res.text())
            .then(html => {
                document.getElementById('main-content').innerHTML = html;
                window.history.pushState({page: 'bill'}, '', targetUrl);
            });
    });

    function openInvoiceModal() {
        document.getElementById('addInvoiceModal').classList.add('active');
    }

    function closeInvoiceModal() {
        document.getElementById('addInvoiceModal').classList.remove('active');
        document.getElementById('add-invoice-form').reset();
    }

    function submitAddInvoice(event) {
        event.preventDefault();
        const formData = new FormData(event.target);
        const data = new URLSearchParams(formData);
        
        fetch('bill', {
            method: 'POST',
            body: data,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        })
        .then(response => {
            if(response.ok) {
                closeInvoiceModal();
                // Reload bill page
                fetch('admin?page=bill', { headers: { 'X-Requested-With': 'XMLHttpRequest' } })
                    .then(res => res.text())
                    .then(html => {
                        document.getElementById('main-content').innerHTML = html;
                    });
            } else {
                alert("Có lỗi xảy ra khi tạo hóa đơn.");
            }
        });
    }

    function confirmAction(e, url) {
        e.preventDefault();
        if(confirm("Bạn có chắc chắn muốn thực hiện hành động này?")) {
            fetch(url)
            .then(() => {
                // Reload bill page
                fetch(window.location.href, { headers: { 'X-Requested-With': 'XMLHttpRequest' } })
                    .then(res => res.text())
                    .then(html => {
                        document.getElementById('main-content').innerHTML = html;
                    });
            });
        }
        return false;
    }
</script>