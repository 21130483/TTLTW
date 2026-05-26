<%@ page import="java.util.List" %>
<%@ page import="dao.StatisticsDAO.RevenueStat" %>
<%@ page import="dao.StatisticsDAO.NewCustomerStat" %>
<%@ page import="dao.StatisticsDAO.ProductStat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<RevenueStat> dailyRevenue = (List<RevenueStat>) request.getAttribute("dailyRevenue");
    List<RevenueStat> monthlyRevenue = (List<RevenueStat>) request.getAttribute("monthlyRevenue");
    List<RevenueStat> yearlyRevenue = (List<RevenueStat>) request.getAttribute("yearlyRevenue");
    Double avgOrderValueVal = (Double) request.getAttribute("avgOrderValue");
    double avgOrderValue = avgOrderValueVal != null ? avgOrderValueVal : 0.0;

    List<NewCustomerStat> dailyNewCustomers = (List<NewCustomerStat>) request.getAttribute("dailyNewCustomers");
    List<NewCustomerStat> monthlyNewCustomers = (List<NewCustomerStat>) request.getAttribute("monthlyNewCustomers");
    List<NewCustomerStat> yearlyNewCustomers = (List<NewCustomerStat>) request.getAttribute("yearlyNewCustomers");

    List<ProductStat> topProducts = (List<ProductStat>) request.getAttribute("topProducts");

    double totalRevenue = 0;
    if (yearlyRevenue != null) {
        for (RevenueStat r : yearlyRevenue) {
            totalRevenue += r.getRevenue();
        }
    }

    int totalNewCustomers = 0;
    if (yearlyNewCustomers != null) {
        for (NewCustomerStat c : yearlyNewCustomers) {
            totalNewCustomers += c.getCount();
        }
    }

    java.text.DecimalFormat df = new java.text.DecimalFormat("#,###");
%>


    <div class="quan-ly">
        <h1 class="title-stat">Thống kê hoạt động kinh doanh</h1>

        <div class="kpi-container">
            <div class="kpi-card revenue">
                <span class="kpi-title">Tổng Doanh thu</span>
                <span class="kpi-value"><%= df.format(totalRevenue) %> Đồng</span>
            </div>
            <div class="kpi-card">
                <span class="kpi-title">Đơn hàng trung bình (AOV)</span>
                <span class="kpi-value"><%= df.format(avgOrderValue) %> Đồng</span>
            </div>
            <div class="kpi-card customers">
                <span class="kpi-title">Tổng Khách hàng mới</span>
                <span class="kpi-value"><%= df.format(totalNewCustomers) %></span>
            </div>
        </div>

        <div class="stat-tabs">
            <button class="tab-btn active" onclick="switchTab('daily')">Theo Ngày</button>
            <button class="tab-btn" onclick="switchTab('monthly')">Theo Tháng</button>
            <button class="tab-btn" onclick="switchTab('yearly')">Theo Năm</button>
        </div>

        <div id="dailyTab" class="tab-content active">
            <div class="charts-grid">
                <div class="chart-box">
                    <h3 class="chart-title">Doanh thu theo ngày</h3>
                    <canvas id="dailyRevenueChart"></canvas>
                </div>
                <div class="chart-box">
                    <h3 class="chart-title">Khách hàng mới theo ngày</h3>
                    <canvas id="dailyCustomerChart"></canvas>
                </div>
            </div>
            <div class="table-box">
                <h3 class="table-title">Chi tiết doanh thu &amp; khách hàng theo ngày</h3>
                <table class="stat-table">
                    <thead>
                    <tr>
                        <th>Thời gian</th>
                        <th class="text-right">Doanh thu</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if (dailyRevenue != null) {
                            for (RevenueStat r : dailyRevenue) {
                    %>
                    <tr>
                        <td><%= r.getTimePeriod() %></td>
                        <td class="text-right"><%= df.format(r.getRevenue()) %> Đồng</td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="monthlyTab" class="tab-content">
            <div class="charts-grid">
                <div class="chart-box">
                    <h3 class="chart-title">Doanh thu theo tháng</h3>
                    <canvas id="monthlyRevenueChart"></canvas>
                </div>
                <div class="chart-box">
                    <h3 class="chart-title">Khách hàng mới theo tháng</h3>
                    <canvas id="monthlyCustomerChart"></canvas>
                </div>
            </div>
            <div class="table-box">
                <h3 class="table-title">Chi tiết doanh thu &amp; khách hàng theo tháng</h3>
                <table class="stat-table">
                    <thead>
                    <tr>
                        <th>Thời gian</th>
                        <th class="text-right">Doanh thu</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if (monthlyRevenue != null) {
                            for (RevenueStat r : monthlyRevenue) {
                    %>
                    <tr>
                        <td><%= r.getTimePeriod() %></td>
                        <td class="text-right"><%= df.format(r.getRevenue()) %> Đồng</td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="yearlyTab" class="tab-content">
            <div class="charts-grid">
                <div class="chart-box">
                    <h3 class="chart-title">Doanh thu theo năm</h3>
                    <canvas id="yearlyRevenueChart"></canvas>
                </div>
                <div class="chart-box">
                    <h3 class="chart-title">Khách hàng mới theo năm</h3>
                    <canvas id="yearlyCustomerChart"></canvas>
                </div>
            </div>
            <div class="table-box">
                <h3 class="table-title">Chi tiết doanh thu &amp; khách hàng theo năm</h3>
                <table class="stat-table">
                    <thead>
                    <tr>
                        <th>Thời gian</th>
                        <th class="text-right">Doanh thu</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if (yearlyRevenue != null) {
                            for (RevenueStat r : yearlyRevenue) {
                    %>
                    <tr>
                        <td><%= r.getTimePeriod() %></td>
                        <td class="text-right"><%= df.format(r.getRevenue()) %> Đồng</td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="charts-grid">
            <div class="chart-box" style="grid-column: span 2;">
                <h3 class="chart-title">Top 10 sản phẩm bán chạy</h3>
                <canvas id="topProductsChart" style="max-height: 400px;"></canvas>
            </div>
        </div>

        <div class="table-box">
            <h3 class="table-title">Bảng chi tiết top sản phẩm bán chạy</h3>
            <table class="stat-table">
                <thead>
                <tr>
                    <th>Mã SP</th>
                    <th>Tên sản phẩm</th>
                    <th class="text-right">Số lượng đã bán</th>
                    <th class="text-right">Tổng doanh thu mang lại</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (topProducts != null) {
                        for (ProductStat p : topProducts) {
                %>
                <tr>
                    <td><%= p.getProductID() %></td>
                    <td><%= p.getName() %></td>
                    <td class="text-right"><%= p.getTotalSold() %></td>
                    <td class="text-right"><%= df.format(p.getTotalRevenue()) %> Đồng</td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

<script>
    // Destroy existing charts on canvas before re-creating (AJAX reload support)
    ['dailyRevenueChart','dailyCustomerChart','monthlyRevenueChart','monthlyCustomerChart',
     'yearlyRevenueChart','yearlyCustomerChart','topProductsChart'].forEach(function(id) {
        var existing = Chart.getChart(id);
        if (existing) existing.destroy();
    });

    function switchTab(tabId) {
        document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
        document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));

        event.target.classList.add('active');
        document.getElementById(tabId + 'Tab').classList.add('active');
    }

    const dailyLabels = [
        <%
            if (dailyRevenue != null) {
                for (int i = dailyRevenue.size() - 1; i >= 0; i--) {
                    out.print("'" + dailyRevenue.get(i).getTimePeriod() + "'" + (i > 0 ? "," : ""));
                }
            }
        %>
    ];
    const dailyRevenueData = [
        <%
            if (dailyRevenue != null) {
                for (int i = dailyRevenue.size() - 1; i >= 0; i--) {
                    out.print(dailyRevenue.get(i).getRevenue() + (i > 0 ? "," : ""));
                }
            }
        %>
    ];

    const dailyCustomerLabels = [
        <%
            if (dailyNewCustomers != null) {
                for (int i = dailyNewCustomers.size() - 1; i >= 0; i--) {
                    out.print("'" + dailyNewCustomers.get(i).getTimePeriod() + "'" + (i > 0 ? "," : ""));
                }
            }
        %>
    ];
    const dailyCustomerData = [
        <%
            if (dailyNewCustomers != null) {
                for (int i = dailyNewCustomers.size() - 1; i >= 0; i--) {
                    out.print(dailyNewCustomers.get(i).getCount() + (i > 0 ? "," : ""));
                }
            }
        %>
    ];

    const monthlyLabels = [
        <%
            if (monthlyRevenue != null) {
                for (int i = monthlyRevenue.size() - 1; i >= 0; i--) {
                    out.print("'" + monthlyRevenue.get(i).getTimePeriod() + "'" + (i > 0 ? "," : ""));
                }
            }
        %>
    ];
    const monthlyRevenueData = [
        <%
            if (monthlyRevenue != null) {
                for (int i = monthlyRevenue.size() - 1; i >= 0; i--) {
                    out.print(monthlyRevenue.get(i).getRevenue() + (i > 0 ? "," : ""));
                }
            }
        %>
    ];

    const monthlyCustomerLabels = [
        <%
            if (monthlyNewCustomers != null) {
                for (int i = monthlyNewCustomers.size() - 1; i >= 0; i--) {
                    out.print("'" + monthlyNewCustomers.get(i).getTimePeriod() + "'" + (i > 0 ? "," : ""));
                }
            }
        %>
    ];
    const monthlyCustomerData = [
        <%
            if (monthlyNewCustomers != null) {
                for (int i = monthlyNewCustomers.size() - 1; i >= 0; i--) {
                    out.print(monthlyNewCustomers.get(i).getCount() + (i > 0 ? "," : ""));
                }
            }
        %>
    ];

    const yearlyLabels = [
        <%
            if (yearlyRevenue != null) {
                for (int i = yearlyRevenue.size() - 1; i >= 0; i--) {
                    out.print("'" + yearlyRevenue.get(i).getTimePeriod() + "'" + (i > 0 ? "," : ""));
                }
            }
        %>
    ];
    const yearlyRevenueData = [
        <%
            if (yearlyRevenue != null) {
                for (int i = yearlyRevenue.size() - 1; i >= 0; i--) {
                    out.print(yearlyRevenue.get(i).getRevenue() + (i > 0 ? "," : ""));
                }
            }
        %>
    ];

    const yearlyCustomerLabels = [
        <%
            if (yearlyNewCustomers != null) {
                for (int i = yearlyNewCustomers.size() - 1; i >= 0; i--) {
                    out.print("'" + yearlyNewCustomers.get(i).getTimePeriod() + "'" + (i > 0 ? "," : ""));
                }
            }
        %>
    ];
    const yearlyCustomerData = [
        <%
            if (yearlyNewCustomers != null) {
                for (int i = yearlyNewCustomers.size() - 1; i >= 0; i--) {
                    out.print(yearlyNewCustomers.get(i).getCount() + (i > 0 ? "," : ""));
                }
            }
        %>
    ];

    const topProductNames = [
        <%
            if (topProducts != null) {
                for (int i = 0; i < topProducts.size(); i++) {
                    String cleanName = topProducts.get(i).getName().replace("'", "\\'");
                    if (cleanName.length() > 30) {
                        cleanName = cleanName.substring(0, 27) + "...";
                    }
                    out.print("'" + cleanName + "'" + (i < topProducts.size() - 1 ? "," : ""));
                }
            }
        %>
    ];
    const topProductSoldQty = [
        <%
            if (topProducts != null) {
                for (int i = 0; i < topProducts.size(); i++) {
                    out.print(topProducts.get(i).getTotalSold() + (i < topProducts.size() - 1 ? "," : ""));
                }
            }
        %>
    ];

    new Chart(document.getElementById('dailyRevenueChart'), {
        type: 'line',
        data: {
            labels: dailyLabels,
            datasets: [{
                label: 'Doanh thu (Đồng)',
                data: dailyRevenueData,
                borderColor: '#28a745',
                backgroundColor: 'rgba(40, 167, 69, 0.1)',
                borderWidth: 2,
                fill: true,
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    new Chart(document.getElementById('dailyCustomerChart'), {
        type: 'bar',
        data: {
            labels: dailyCustomerLabels,
            datasets: [{
                label: 'Khách hàng mới',
                data: dailyCustomerData,
                backgroundColor: '#17a2b8',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 1
                    }
                }
            }
        }
    });

    new Chart(document.getElementById('monthlyRevenueChart'), {
        type: 'line',
        data: {
            labels: monthlyLabels,
            datasets: [{
                label: 'Doanh thu (Đồng)',
                data: monthlyRevenueData,
                borderColor: '#28a745',
                backgroundColor: 'rgba(40, 167, 69, 0.1)',
                borderWidth: 2,
                fill: true,
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    new Chart(document.getElementById('monthlyCustomerChart'), {
        type: 'bar',
        data: {
            labels: monthlyCustomerLabels,
            datasets: [{
                label: 'Khách hàng mới',
                data: monthlyCustomerData,
                backgroundColor: '#17a2b8',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 1
                    }
                }
            }
        }
    });

    new Chart(document.getElementById('yearlyRevenueChart'), {
        type: 'line',
        data: {
            labels: yearlyLabels,
            datasets: [{
                label: 'Doanh thu (Đồng)',
                data: yearlyRevenueData,
                borderColor: '#28a745',
                backgroundColor: 'rgba(40, 167, 69, 0.1)',
                borderWidth: 2,
                fill: true,
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    new Chart(document.getElementById('yearlyCustomerChart'), {
        type: 'bar',
        data: {
            labels: yearlyCustomerLabels,
            datasets: [{
                label: 'Khách hàng mới',
                data: yearlyCustomerData,
                backgroundColor: '#17a2b8',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 1
                    }
                }
            }
        }
    });

    new Chart(document.getElementById('topProductsChart'), {
        type: 'bar',
        data: {
            labels: topProductNames,
            datasets: [{
                label: 'Số lượng đã bán',
                data: topProductSoldQty,
                backgroundColor: '#007bff',
                borderWidth: 1
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true,
            scales: {
                x: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 1
                    }
                }
            }
        }
    });
</script>

