<%@page contentType="text/html" pageEncoding="UTF-8"%>
<aside class="sidebar">
    <a href="/admin/dashboard" class="sidebar-brand"><i class="bi bi-laptop me-2"></i>Laptop<span>Shop</span></a>

    <div class="sidebar-label">Tổng quan</div>
    <a href="/admin/dashboard" class="sidebar-link ${activePage == 'dashboard' ? 'active' : ''}">
        <i class="bi bi-speedometer2"></i> Dashboard
    </a>

    <div class="sidebar-label">Quản lý</div>
    <a href="/admin/product" class="sidebar-link ${activePage == 'product' ? 'active' : ''}">
        <i class="bi bi-box-seam"></i> Sản phẩm
    </a>
    <a href="/admin/user" class="sidebar-link ${activePage == 'user' ? 'active' : ''}">
        <i class="bi bi-people"></i> Người dùng
    </a>
    <a href="/admin/order" class="sidebar-link ${activePage == 'order' ? 'active' : ''}">
        <i class="bi bi-cart3"></i> Đơn hàng
    </a>

    <div class="sidebar-label">Hệ thống</div>
    <a href="#" class="sidebar-link"><i class="bi bi-gear"></i> Cài đặt</a>
    <form method="POST" action="/logout" class="m-0">
        <button type="submit" class="sidebar-link w-100 text-start border-0 bg-transparent" style="cursor:pointer;">
            <i class="bi bi-box-arrow-left"></i> Đăng xuất
        </button>
    </form>
</aside>
