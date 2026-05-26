<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="../css/adminLayout.css">
    <!-- Common CSS for features -->
    <link rel="stylesheet" href="../css/managerBills.css">
    <link rel="stylesheet" href="../css/managerUsers.css">
    <link rel="stylesheet" href="../css/managerProducts.css">
    <link rel="stylesheet" href="../css/managerVouchers.css">
    <link rel="stylesheet" href="../css/managerInventory.css">
    <link rel="stylesheet" href="../css/statistics.css">
    <!-- Chart.js for statistics page -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body>
<div class="noi-dung">
    <!-- Sidebar -->
    <div class="muc-luc">
        <div class="title">
            <p>Admin</p>
        </div>
        <ul id="sidebar-menu">
            <li>
                <a href="admin?page=product" data-page="product">
                    <div class="a">Quản lý sản phẩm</div>
                </a>
            </li>
            <li>
                <a href="admin?page=user" data-page="user">
                    <div class="a">Quản lý thành viên</div>
                </a>
            </li>
            <li>
                <a href="admin?page=bill" data-page="bill">
                    <div class="a">Quản lý hóa đơn</div>
                </a>
            </li>
            <li>
                <a href="admin?page=voucher" data-page="voucher">
                    <div class="a">Quản lý loại sản phẩm</div>
                </a>
            </li>
            <li>
                <a href="admin?page=inventory" data-page="inventory">
                    <div class="a">Quản lý tồn kho</div>
                </a>
            </li>
            <li>
                <a href="admin?page=statistics" data-page="statistics">
                    <div class="a">Thống kê</div>
                </a>
            </li>
            <li class="back-home">
                <a href="index.jsp">
                    <div class="a">Quay về trang chủ</div>
                </a>
            </li>
        </ul>
    </div>

    <!-- Main Content -->
    <div id="main-content">
        <%
            String contentPage = (String) request.getAttribute("contentPage");
            if (contentPage != null) {
        %>
            <jsp:include page="<%= contentPage %>" />
        <%
            } else {
        %>
            <div class="page-title">Chào mừng đến với trang Quản trị</div>
            <p>Vui lòng chọn một chức năng từ menu bên trái.</p>
        <%
            }
        %>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        // Highlight active menu
        const urlParams = new URLSearchParams(window.location.search);
        let currentPage = urlParams.get('page');
        if(!currentPage) {
            // Check if there's a default from request attribute
            currentPage = '<%= request.getParameter("page") != null ? request.getParameter("page") : "" %>';
        }
        
        function setActiveLink(page) {
            document.querySelectorAll('#sidebar-menu a').forEach(a => a.classList.remove('active'));
            if(page) {
                const activeLink = document.querySelector(`#sidebar-menu a[data-page="\${page}"]`);
                if(activeLink) activeLink.classList.add('active');
            }
        }
        
        setActiveLink(currentPage);

        // AJAX Navigation
        document.querySelectorAll('#sidebar-menu a[data-page]').forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const targetUrl = this.getAttribute('href');
                const page = this.getAttribute('data-page');
                
                // Fetch the new content
                fetch(targetUrl, {
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                .then(response => {
                    if(!response.ok) throw new Error("Network response was not ok");
                    return response.text();
                })
                .then(html => {
                    document.getElementById('main-content').innerHTML = html;
                    window.history.pushState({page: page}, '', targetUrl);
                    setActiveLink(page);
                    // Re-execute scripts injected via innerHTML (e.g. Chart.js in statistics)
                    document.getElementById('main-content').querySelectorAll('script').forEach(oldScript => {
                        const newScript = document.createElement('script');
                        newScript.textContent = oldScript.textContent;
                        oldScript.parentNode.replaceChild(newScript, oldScript);
                    });
                })
                .catch(error => console.error('Error fetching page:', error));
            });
        });

        window.addEventListener('popstate', (e) => {
            if(e.state && e.state.page) {
                const targetUrl = `admin?page=\${e.state.page}`;
                fetch(targetUrl, { headers: { 'X-Requested-With': 'XMLHttpRequest' } })
                .then(response => response.text())
                .then(html => {
                    document.getElementById('main-content').innerHTML = html;
                    setActiveLink(e.state.page);
                    document.getElementById('main-content').querySelectorAll('script').forEach(oldScript => {
                        const newScript = document.createElement('script');
                        newScript.textContent = oldScript.textContent;
                        oldScript.parentNode.replaceChild(newScript, oldScript);
                    });
                });
            }
        });
    });
</script>
</body>
</html>
