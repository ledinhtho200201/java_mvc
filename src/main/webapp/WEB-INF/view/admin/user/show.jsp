<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Chi tiết người dùng - LaptopShop Admin</title>
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

        .detail-card { background: #fff; border-radius: 14px; box-shadow: 0 2px 12px rgba(0,0,0,0.06); border: none; overflow: hidden; }

        .detail-header {
            background: var(--primary);
            padding: 2rem 2rem 3.5rem;
            position: relative;
            text-align: center;
        }
        .detail-header::after {
            content: '';
            position: absolute;
            bottom: -1px; left: 0; right: 0;
            height: 32px;
            background: #fff;
            border-radius: 32px 32px 0 0;
        }

        .avatar-wrap {
            position: relative;
            display: inline-block;
            margin-bottom: 0.5rem;
        }
        .avatar-img {
            width: 96px; height: 96px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid rgba(255,255,255,0.3);
        }
        .avatar-placeholder {
            width: 96px; height: 96px;
            border-radius: 50%;
            background: var(--accent);
            display: flex; align-items: center; justify-content: center;
            color: #fff; font-size: 2rem; font-weight: 700;
            border: 4px solid rgba(255,255,255,0.3);
        }
        .user-name { color: #fff; font-size: 1.2rem; font-weight: 700; margin: 0.4rem 0 0.2rem; }
        .user-email { color: rgba(255,255,255,0.6); font-size: 0.85rem; }

        .badge-role-admin { background: #fef2f2; color: #dc2626; font-size: 0.75rem; padding: 4px 12px; border-radius: 20px; font-weight: 600; }
        .badge-role-user  { background: #eff6ff; color: #2563eb; font-size: 0.75rem; padding: 4px 12px; border-radius: 20px; font-weight: 600; }

        .detail-body { padding: 1rem 2rem 2rem; }

        .info-row { display: flex; align-items: flex-start; gap: 0.8rem; padding: 0.9rem 0; border-bottom: 1px solid #f0f2f5; }
        .info-row:last-child { border-bottom: none; }
        .info-icon { width: 36px; height: 36px; border-radius: 9px; display: flex; align-items: center; justify-content: center; font-size: 0.95rem; flex-shrink: 0; margin-top: 1px; }
        .info-label { font-size: 0.75rem; color: #9ca3af; font-weight: 500; margin-bottom: 2px; }
        .info-value { font-size: 0.9rem; color: #1a1a2e; font-weight: 600; }
        .info-value.empty { color: #d1d5db; font-style: italic; font-weight: 400; }

        .btn-edit { background: var(--accent); color: #fff; border: none; padding: 0.6rem 1.6rem; border-radius: 8px; font-weight: 600; font-size: 0.9rem; text-decoration: none; display: inline-flex; align-items: center; gap: 0.4rem; transition: background 0.2s; }
        .btn-edit:hover { background: #c73652; color: #fff; }
        .btn-back { background: #f4f6fb; color: #374151; border: none; padding: 0.6rem 1.6rem; border-radius: 8px; font-weight: 600; font-size: 0.9rem; text-decoration: none; display: inline-flex; align-items: center; gap: 0.4rem; transition: background 0.2s; }
        .btn-back:hover { background: #e5e7eb; color: #374151; }
    </style>
</head>
<body>

<aside class="sidebar">
    <a href="/admin/dashboard" class="sidebar-brand"><i class="bi bi-laptop me-2"></i>Laptop<span>Shop</span></a>
    <div class="sidebar-label">Tổng quan</div>
    <a href="/admin/dashboard" class="sidebar-link"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <div class="sidebar-label">Quản lý</div>
    <a href="/admin/product" class="sidebar-link"><i class="bi bi-box-seam"></i> Sản phẩm</a>
    <a href="/admin/user" class="sidebar-link active"><i class="bi bi-people"></i> Người dùng</a>
    <a href="/admin/order" class="sidebar-link"><i class="bi bi-cart3"></i> Đơn hàng</a>
    <div class="sidebar-label">Hệ thống</div>
    <a href="#" class="sidebar-link"><i class="bi bi-gear"></i> Cài đặt</a>
    <a href="#" class="sidebar-link"><i class="bi bi-box-arrow-left"></i> Đăng xuất</a>
</aside>

<div class="main-wrap">
    <div class="topbar">
        <div class="topbar-title">
            <a href="/admin/user" style="color:#8a92a6;text-decoration:none;font-size:.85rem;font-weight:400;">Người dùng</a>
            <span style="color:#8a92a6;margin:0 .4rem;">/</span>
            Chi tiết #${user.id}
        </div>
        <div class="d-flex align-items-center gap-2">
            <span style="font-size:.85rem;color:#6b7080;">Admin</span>
            <div style="width:32px;height:32px;border-radius:50%;background:#e94560;display:flex;align-items:center;justify-content:center;color:#fff;font-size:.8rem;font-weight:700;">A</div>
        </div>
    </div>

    <div class="content">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="detail-card">

                    <!-- Header with avatar -->
                    <div class="detail-header">
                        <div class="avatar-wrap">
                            <c:choose>
                                <c:when test="${not empty user.avatar}">
                                    <img src="/images/avatar/${user.avatar}" alt="${user.fullName}" class="avatar-img"/>
                                </c:when>
                                <c:otherwise>
                                    <div class="avatar-placeholder">${user.fullName.substring(0,1).toUpperCase()}</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="user-name">${user.fullName}</div>
                        <div class="user-email">${user.email}</div>
                        <div style="margin-top:.6rem;">
                            <c:choose>
                                <c:when test="${user.role == 'ADMIN'}">
                                    <span class="badge-role-admin">ADMIN</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-role-user">USER</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Info rows -->
                    <div class="detail-body">
                        <div class="info-row">
                            <div class="info-icon" style="background:#eef2ff;color:#4f46e5;"><i class="bi bi-hash"></i></div>
                            <div>
                                <div class="info-label">ID</div>
                                <div class="info-value">${user.id}</div>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="info-icon" style="background:#f0fdf4;color:#16a34a;"><i class="bi bi-envelope"></i></div>
                            <div>
                                <div class="info-label">Email</div>
                                <div class="info-value">${user.email}</div>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="info-icon" style="background:#fff7ed;color:#ea580c;"><i class="bi bi-telephone"></i></div>
                            <div>
                                <div class="info-label">Số điện thoại</div>
                                <c:choose>
                                    <c:when test="${not empty user.phone}">
                                        <div class="info-value">${user.phone}</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="info-value empty">Chưa cập nhật</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="info-icon" style="background:#fdf4ff;color:#9333ea;"><i class="bi bi-geo-alt"></i></div>
                            <div>
                                <div class="info-label">Địa chỉ</div>
                                <c:choose>
                                    <c:when test="${not empty user.address}">
                                        <div class="info-value">${user.address}</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="info-value empty">Chưa cập nhật</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="info-icon" style="background:#fef2f2;color:#dc2626;"><i class="bi bi-shield-check"></i></div>
                            <div>
                                <div class="info-label">Role</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${user.role == 'ADMIN'}">
                                            <span class="badge-role-admin">ADMIN</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-role-user">USER</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex gap-2 mt-4">
                            <a href="/admin/user/update/${user.id}" class="btn-edit">
                                <i class="bi bi-pencil"></i> Chỉnh sửa
                            </a>
                            <a href="/admin/user" class="btn-back">
                                <i class="bi bi-arrow-left"></i> Quay lại
                            </a>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
