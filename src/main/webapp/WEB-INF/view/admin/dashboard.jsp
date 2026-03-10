<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Dashboard - LaptopShop Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        :root { --sidebar-w: 240px; --primary: #1a1a2e; --accent: #e94560; }
        body { background: #f4f6fb; font-family: 'Segoe UI', sans-serif; }

        .sidebar { width: var(--sidebar-w); height: 100vh; background: var(--primary); position: fixed; top: 0; left: 0; display: flex; flex-direction: column; z-index: 100; overflow-y: auto; }
        .sidebar-brand { padding: 1.4rem 1.5rem; font-size: 1.25rem; font-weight: 800; color: #fff; border-bottom: 1px solid rgba(255,255,255,0.08); text-decoration: none; display: block; }
        .sidebar-brand span { color: var(--accent); }
        .sidebar-label { font-size: 0.68rem; text-transform: uppercase; letter-spacing: 1px; color: rgba(255,255,255,0.35); padding: 1.2rem 1.5rem 0.4rem; }
        .sidebar-link { display: flex; align-items: center; gap: 0.75rem; padding: 0.65rem 1.5rem; color: rgba(255,255,255,0.65); text-decoration: none; font-size: 0.9rem; font-weight: 500; transition: all 0.2s; border-left: 3px solid transparent; }
        .sidebar-link:hover { background: rgba(255,255,255,0.06); color: #fff; }
        .sidebar-link.active { background: rgba(233,69,96,0.15); color: #fff; border-left-color: var(--accent); }
        .sidebar-link i { font-size: 1rem; width: 20px; text-align: center; }
        .sidebar-logout { margin-top: auto; padding: 1rem 0; border-top: 1px solid rgba(255,255,255,0.08); }

        .main-wrap { margin-left: var(--sidebar-w); min-height: 100vh; display: flex; flex-direction: column; }
        .topbar { background: #fff; padding: 0.85rem 1.8rem; border-bottom: 1px solid #e8ecf0; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 50; }
        .topbar-title { font-size: 1rem; font-weight: 700; color: #1a1a2e; }
        .content { padding: 1.8rem; flex: 1; }

        .stat-card { background: #fff; border-radius: 14px; box-shadow: 0 2px 12px rgba(0,0,0,0.06); border: none; padding: 1.4rem 1.5rem; display: flex; align-items: center; gap: 1rem; }
        .stat-icon { width: 52px; height: 52px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.4rem; flex-shrink: 0; }
        .stat-value { font-size: 1.8rem; font-weight: 800; color: #1a1a2e; line-height: 1; }
        .stat-label { font-size: 0.78rem; color: #8a92a6; margin-top: 3px; }

        .card-admin { background: #fff; border-radius: 14px; box-shadow: 0 2px 12px rgba(0,0,0,0.06); border: none; }
        .card-admin .card-header { background: transparent; border-bottom: 1px solid #f0f2f5; padding: 1.1rem 1.5rem; display: flex; align-items: center; justify-content: space-between; }
        .card-header-title { font-size: 1rem; font-weight: 700; color: #1a1a2e; }

        .table thead th { background: #f8f9fc; color: #6b7080; font-size: 0.78rem; text-transform: uppercase; letter-spacing: 0.5px; font-weight: 600; border: none; padding: 0.85rem 1rem; }
        .table tbody td { padding: 0.9rem 1rem; vertical-align: middle; border-color: #f0f2f5; font-size: 0.88rem; color: #374151; }
        .table tbody tr:hover { background: #fafbff; }

        .badge-role-admin { background: #fef2f2; color: #dc2626; font-size: 0.72rem; padding: 3px 9px; border-radius: 10px; font-weight: 600; }
        .badge-role-user  { background: #eff6ff; color: #2563eb; font-size: 0.72rem; padding: 3px 9px; border-radius: 10px; font-weight: 600; }

        .quick-link { background: #fff; border-radius: 14px; box-shadow: 0 2px 12px rgba(0,0,0,0.06); padding: 1.2rem 1.5rem; display: flex; align-items: center; gap: 0.9rem; text-decoration: none; color: #1a1a2e; transition: box-shadow 0.2s; }
        .quick-link:hover { box-shadow: 0 4px 20px rgba(0,0,0,0.1); color: var(--accent); }
        .quick-link i { font-size: 1.4rem; color: var(--accent); }
        .quick-link span { font-size: 0.9rem; font-weight: 600; }

        .avatar-circle { width: 34px; height: 34px; border-radius: 50%; background: var(--accent); display: flex; align-items: center; justify-content: center; color: #fff; font-size: 0.8rem; font-weight: 700; flex-shrink: 0; }
    </style>
</head>
<body>

<aside class="sidebar">
    <a href="/admin/dashboard" class="sidebar-brand"><i class="bi bi-laptop me-2"></i>Laptop<span>Shop</span></a>
    <div class="sidebar-label">Tổng quan</div>
    <a href="/admin/dashboard" class="sidebar-link active"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <div class="sidebar-label">Quản lý</div>
    <a href="/admin/product" class="sidebar-link"><i class="bi bi-box-seam"></i> Sản phẩm</a>
    <a href="/admin/user" class="sidebar-link"><i class="bi bi-people"></i> Người dùng</a>
    <a href="/admin/order" class="sidebar-link"><i class="bi bi-cart3"></i> Đơn hàng</a>
    <div class="sidebar-logout">
        <div class="sidebar-label" style="padding-top:0;">Hệ thống</div>
        <a href="#" class="sidebar-link"><i class="bi bi-gear"></i> Cài đặt</a>
        <form method="POST" action="/logout" class="m-0">
            <button type="submit" class="sidebar-link w-100 text-start border-0 bg-transparent" style="cursor:pointer;">
                <i class="bi bi-box-arrow-left"></i> Đăng xuất
            </button>
        </form>
    </div>
</aside>

<div class="main-wrap">
    <div class="topbar">
        <div class="topbar-title">Dashboard <small class="ms-2" style="font-weight:400;color:#8a92a6;">/ Tổng quan</small></div>
        <div class="d-flex align-items-center gap-2">
            <span style="font-size:.85rem;color:#6b7080;">${sessionScope.fullName}</span>
            <div class="avatar-circle">A</div>
        </div>
    </div>

    <div class="content">

        <!-- Stats -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-lg-3">
                <div class="stat-card">
                    <div class="stat-icon" style="background:#eef2ff;color:#4f46e5;"><i class="bi bi-people"></i></div>
                    <div>
                        <div class="stat-value">${userCount}</div>
                        <div class="stat-label">Người dùng</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-lg-3">
                <div class="stat-card">
                    <div class="stat-icon" style="background:#f0fdf4;color:#16a34a;"><i class="bi bi-box-seam"></i></div>
                    <div>
                        <div class="stat-value">${productCount}</div>
                        <div class="stat-label">Sản phẩm</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-lg-3">
                <div class="stat-card">
                    <div class="stat-icon" style="background:#fff7ed;color:#ea580c;"><i class="bi bi-cart3"></i></div>
                    <div>
                        <div class="stat-value">${orderCount}</div>
                        <div class="stat-label">Đơn hàng</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-lg-3">
                <div class="stat-card">
                    <div class="stat-icon" style="background:#fef2f2;color:#dc2626;"><i class="bi bi-currency-dollar"></i></div>
                    <div>
                        <div class="stat-value">--</div>
                        <div class="stat-label">Doanh thu</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts row 1: line + donut -->
        <div class="row g-3 mb-4">
            <div class="col-12 col-lg-8">
                <div class="card-admin">
                    <div class="card-header">
                        <span class="card-header-title"><i class="bi bi-graph-up-arrow me-2 text-danger"></i>Doanh thu theo tháng</span>
                        <span style="font-size:.78rem;color:#9ca3af;">6 tháng gần đây</span>
                    </div>
                    <div class="p-3" style="height:260px;">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-12 col-lg-4">
                <div class="card-admin">
                    <div class="card-header">
                        <span class="card-header-title"><i class="bi bi-pie-chart me-2 text-danger"></i>Phân loại người dùng</span>
                    </div>
                    <div class="p-3 d-flex flex-column align-items-center">
                        <div style="position:relative;width:100%;height:200px;">
                            <canvas id="userRoleChart"></canvas>
                        </div>
                        <div class="d-flex gap-3 mt-2">
                            <div class="d-flex align-items-center gap-1" style="font-size:.82rem;">
                                <span style="width:12px;height:12px;border-radius:3px;background:#4f46e5;display:inline-block;"></span>
                                <span style="color:#6b7080;">Admin (${adminCount})</span>
                            </div>
                            <div class="d-flex align-items-center gap-1" style="font-size:.82rem;">
                                <span style="width:12px;height:12px;border-radius:3px;background:#e94560;display:inline-block;"></span>
                                <span style="color:#6b7080;">User (${normalUserCount})</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts row 2: bar chart -->
        <div class="row g-3 mb-4">
            <div class="col-12">
                <div class="card-admin">
                    <div class="card-header">
                        <span class="card-header-title"><i class="bi bi-bar-chart-line me-2 text-danger"></i>Đơn hàng theo tháng</span>
                        <span style="font-size:.78rem;color:#9ca3af;">12 tháng gần đây</span>
                    </div>
                    <div class="p-3" style="height:280px;">
                        <canvas id="orderBarChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick links + Recent Users -->
        <div class="row g-3 mb-4">
            <div class="col-12 col-lg-4">
                <div class="card-admin h-100">
                    <div class="card-header">
                        <span class="card-header-title"><i class="bi bi-lightning me-2 text-danger"></i>Thao tác nhanh</span>
                    </div>
                    <div class="p-3 d-flex flex-column gap-2">
                        <a href="/admin/user/create" class="quick-link">
                            <i class="bi bi-person-plus"></i>
                            <span>Thêm người dùng mới</span>
                        </a>
                        <a href="/admin/product" class="quick-link">
                            <i class="bi bi-plus-circle"></i>
                            <span>Thêm sản phẩm mới</span>
                        </a>
                        <a href="/admin/order" class="quick-link">
                            <i class="bi bi-receipt"></i>
                            <span>Xem đơn hàng</span>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-12 col-lg-8">
                <div class="card-admin h-100">
                    <div class="card-header">
                        <span class="card-header-title"><i class="bi bi-clock-history me-2 text-danger"></i>Người dùng gần đây</span>
                        <a href="/admin/user" style="font-size:.82rem;color:#e94560;text-decoration:none;font-weight:600;">Xem tất cả →</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table mb-0">
                            <thead>
                                <tr>
                                    <th>Họ tên</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${recentUsers}">
                                    <tr>
                                        <td style="font-weight:600;">${user.fullName}</td>
                                        <td style="color:#6b7080;">${user.email}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.role == 'ADMIN'}">
                                                    <span class="badge-role-admin">ADMIN</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge-role-user">USER</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty recentUsers}">
                                    <tr><td colspan="3" style="text-align:center;color:#9ca3af;padding:2rem;">Chưa có dữ liệu</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
<script>
    // Revenue line chart
    new Chart(document.getElementById('revenueChart'), {
        type: 'line',
        data: {
            labels: ['Tháng 10', 'Tháng 11', 'Tháng 12', 'Tháng 1', 'Tháng 2', 'Tháng 3'],
            datasets: [{
                label: 'Doanh thu (triệu đồng)',
                data: [42, 58, 95, 73, 61, 88],
                borderColor: '#e94560',
                backgroundColor: 'rgba(233,69,96,0.08)',
                borderWidth: 2.5,
                pointBackgroundColor: '#e94560',
                pointRadius: 4,
                pointHoverRadius: 6,
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                tooltip: { callbacks: { label: ctx => ' ' + ctx.parsed.y + ' triệu đồng' } }
            },
            scales: {
                x: { grid: { display: false }, ticks: { font: { size: 11 }, color: '#9ca3af' } },
                y: { grid: { color: '#f0f2f5' }, ticks: { font: { size: 11 }, color: '#9ca3af' }, beginAtZero: true }
            }
        }
    });

    // User role doughnut chart
    new Chart(document.getElementById('userRoleChart'), {
        type: 'doughnut',
        data: {
            labels: ['Admin', 'User'],
            datasets: [{
                data: [${adminCount}, ${normalUserCount}],
                backgroundColor: ['#4f46e5', '#e94560'],
                borderWidth: 0,
                hoverOffset: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '68%',
            plugins: {
                legend: { display: false },
                tooltip: { callbacks: { label: ctx => ' ' + ctx.label + ': ' + ctx.parsed } }
            }
        }
    });

    // Orders bar chart
    new Chart(document.getElementById('orderBarChart'), {
        type: 'bar',
        data: {
            labels: ['T4','T5','T6','T7','T8','T9','T10','T11','T12','T1','T2','T3'],
            datasets: [{
                label: 'Đơn hàng',
                data: [12, 19, 15, 27, 23, 31, 28, 42, 55, 38, 29, 44],
                backgroundColor: 'rgba(79,70,229,0.85)',
                borderRadius: 6,
                borderSkipped: false,
                hoverBackgroundColor: '#e94560'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                tooltip: { callbacks: { label: ctx => ' ' + ctx.parsed.y + ' đơn hàng' } }
            },
            scales: {
                x: { grid: { display: false }, ticks: { font: { size: 11 }, color: '#9ca3af' } },
                y: { grid: { color: '#f0f2f5' }, ticks: { font: { size: 11 }, color: '#9ca3af' }, beginAtZero: true }
            }
        }
    });
</script>
</body>
</html>

