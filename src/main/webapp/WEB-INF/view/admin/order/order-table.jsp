<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quản lý đơn hàng - LaptopShop Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        :root { --sidebar-w: 240px; --primary: #1a1a2e; --accent: #e94560; }
        body { background: #f4f6fb; font-family: 'Segoe UI', sans-serif; }

        .sidebar { width: var(--sidebar-w); min-height: 100vh; background: var(--primary); position: fixed; top: 0; left: 0; display: flex; flex-direction: column; z-index: 100; }
        .sidebar-brand { padding: 1.4rem 1.5rem; font-size: 1.25rem; font-weight: 800; color: #fff; border-bottom: 1px solid rgba(255,255,255,0.08); text-decoration: none; }
        .sidebar-brand span { color: var(--accent); }
        .sidebar-label { font-size: 0.68rem; text-transform: uppercase; letter-spacing: 1px; color: rgba(255,255,255,0.35); padding: 1.2rem 1.5rem 0.4rem; }
        .sidebar-link { display: flex; align-items: center; gap: 0.75rem; padding: 0.65rem 1.5rem; color: rgba(255,255,255,0.65); text-decoration: none; font-size: 0.9rem; font-weight: 500; transition: all 0.2s; border-left: 3px solid transparent; }
        .sidebar-link:hover { background: rgba(255,255,255,0.06); color: #fff; }
        .sidebar-link.active { background: rgba(233,69,96,0.15); color: #fff; border-left-color: var(--accent); }
        .sidebar-link i { font-size: 1rem; width: 20px; text-align: center; }

        .main-wrap { margin-left: var(--sidebar-w); min-height: 100vh; display: flex; flex-direction: column; }
        .topbar { background: #fff; padding: 0.85rem 1.8rem; border-bottom: 1px solid #e8ecf0; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 50; }
        .topbar-title { font-size: 1rem; font-weight: 700; color: #1a1a2e; }
        .content { padding: 1.8rem; flex: 1; }

        .card-admin { background: #fff; border-radius: 14px; box-shadow: 0 2px 12px rgba(0,0,0,0.06); border: none; }
        .card-admin .card-header { background: transparent; border-bottom: 1px solid #f0f2f5; padding: 1.1rem 1.5rem; display: flex; align-items: center; justify-content: space-between; }
        .card-header-title { font-size: 1rem; font-weight: 700; color: #1a1a2e; }

        .table thead th { background: #f8f9fc; color: #6b7080; font-size: 0.78rem; text-transform: uppercase; letter-spacing: 0.5px; font-weight: 600; border: none; padding: 0.85rem 1rem; }
        .table tbody td { padding: 0.9rem 1rem; vertical-align: middle; border-color: #f0f2f5; font-size: 0.88rem; color: #374151; }
        .table tbody tr:hover { background: #fafbff; }

        .badge-pending  { background: #fff7ed; color: #ea580c; font-size: 0.72rem; padding: 3px 9px; border-radius: 10px; font-weight: 600; }
        .badge-done     { background: #f0fdf4; color: #16a34a; font-size: 0.72rem; padding: 3px 9px; border-radius: 10px; font-weight: 600; }
        .badge-cancel   { background: #f9fafb; color: #6b7280; font-size: 0.72rem; padding: 3px 9px; border-radius: 10px; font-weight: 600; }

        .search-input { border: 1.5px solid #e5e7eb; border-radius: 8px; padding: 0.45rem 0.9rem 0.45rem 2.3rem; font-size: 0.85rem; width: 220px; }
        .search-wrap { position: relative; }
        .search-wrap i { position: absolute; left: 0.75rem; top: 50%; transform: translateY(-50%); color: #9ca3af; font-size: 0.85rem; }

        .empty-state { text-align: center; padding: 4rem 1rem; color: #9ca3af; }
        .empty-state i { font-size: 3.5rem; margin-bottom: 1rem; display: block; }
        .empty-state p { font-size: 0.9rem; }
    </style>
</head>
<body>

<aside class="sidebar">
    <a href="/admin/dashboard" class="sidebar-brand"><i class="bi bi-laptop me-2"></i>Laptop<span>Shop</span></a>
    <div class="sidebar-label">Tổng quan</div>
    <a href="/admin/dashboard" class="sidebar-link"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <div class="sidebar-label">Quản lý</div>
    <a href="/admin/product" class="sidebar-link"><i class="bi bi-box-seam"></i> Sản phẩm</a>
    <a href="/admin/user" class="sidebar-link"><i class="bi bi-people"></i> Người dùng</a>
    <a href="/admin/order" class="sidebar-link active"><i class="bi bi-cart3"></i> Đơn hàng</a>
    <div class="sidebar-label">Hệ thống</div>
    <a href="#" class="sidebar-link"><i class="bi bi-gear"></i> Cài đặt</a>
    <a href="#" class="sidebar-link"><i class="bi bi-box-arrow-left"></i> Đăng xuất</a>
</aside>

<div class="main-wrap">
    <div class="topbar">
        <div class="topbar-title">Quản lý đơn hàng <small class="ms-2" style="font-weight:400;color:#8a92a6;">/ Danh sách</small></div>
        <div class="d-flex align-items-center gap-2">
            <span style="font-size:.85rem;color:#6b7080;">Admin</span>
            <div style="width:32px;height:32px;border-radius:50%;background:#e94560;display:flex;align-items:center;justify-content:center;color:#fff;font-size:.8rem;font-weight:700;">A</div>
        </div>
    </div>

    <div class="content">
        <!-- Stats -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-lg-3">
                <div class="card-admin p-3 d-flex align-items-center gap-3">
                    <div style="width:44px;height:44px;border-radius:10px;background:#fff7ed;display:flex;align-items:center;justify-content:center;font-size:1.2rem;color:#ea580c;">
                        <i class="bi bi-cart3"></i>
                    </div>
                    <div>
                        <div style="font-size:1.4rem;font-weight:800;color:#1a1a2e;">0</div>
                        <div style="font-size:0.75rem;color:#8a92a6;">Tổng đơn hàng</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-lg-3">
                <div class="card-admin p-3 d-flex align-items-center gap-3">
                    <div style="width:44px;height:44px;border-radius:10px;background:#f0fdf4;display:flex;align-items:center;justify-content:center;font-size:1.2rem;color:#16a34a;">
                        <i class="bi bi-check2-circle"></i>
                    </div>
                    <div>
                        <div style="font-size:1.4rem;font-weight:800;color:#1a1a2e;">0</div>
                        <div style="font-size:0.75rem;color:#8a92a6;">Đã hoàn thành</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Table Card -->
        <div class="card-admin">
            <div class="card-header">
                <span class="card-header-title"><i class="bi bi-receipt me-2 text-danger"></i>Danh sách đơn hàng</span>
                <div class="search-wrap">
                    <i class="bi bi-search"></i>
                    <input type="text" class="search-input" placeholder="Tìm đơn hàng...">
                </div>
            </div>

            <div class="table-responsive">
                <table class="table mb-0">
                    <thead>
                        <tr>
                            <th>Mã đơn</th>
                            <th>Khách hàng</th>
                            <th>Sản phẩm</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Ngày đặt</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="7">
                                <div class="empty-state">
                                    <i class="bi bi-cart-x"></i>
                                    <p>Chưa có đơn hàng nào.<br>
                                    <small>Tính năng quản lý đơn hàng sẽ được cập nhật sớm.</small></p>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
