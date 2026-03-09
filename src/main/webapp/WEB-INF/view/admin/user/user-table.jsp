<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quản lý người dùng - LaptopShop Admin</title>
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

        .avatar-thumb { width: 36px; height: 36px; border-radius: 50%; object-fit: cover; background: #f4f6fb; }
        .avatar-placeholder { width: 36px; height: 36px; border-radius: 50%; background: #e94560; display: flex; align-items: center; justify-content: center; color: #fff; font-size: 0.78rem; font-weight: 700; }

        .badge-role-admin { background: #fef2f2; color: #dc2626; font-size: 0.72rem; padding: 3px 9px; border-radius: 10px; font-weight: 600; }
        .badge-role-user  { background: #eff6ff; color: #2563eb; font-size: 0.72rem; padding: 3px 9px; border-radius: 10px; font-weight: 600; }

        .btn-action { width: 30px; height: 30px; display: inline-flex; align-items: center; justify-content: center; border-radius: 7px; border: none; font-size: 0.8rem; transition: all 0.2s; text-decoration: none; }
        .btn-action.view   { background: #f0fdf4; color: #16a34a; }
        .btn-action.edit   { background: #fff8e6; color: #d97706; }
        .btn-action.delete { background: #fef2f2; color: #dc2626; }
        .btn-action:hover  { filter: brightness(0.9); }

        .btn-create { background: var(--accent); color: #fff; border: none; padding: 0.5rem 1.1rem; border-radius: 8px; font-size: 0.88rem; font-weight: 600; display: inline-flex; align-items: center; gap: 0.4rem; text-decoration: none; transition: background 0.2s; }
        .btn-create:hover { background: #c73652; color: #fff; }

        .search-input { border: 1.5px solid #e5e7eb; border-radius: 8px; padding: 0.45rem 0.9rem 0.45rem 2.3rem; font-size: 0.85rem; width: 220px; }
        .search-wrap { position: relative; }
        .search-wrap i { position: absolute; left: 0.75rem; top: 50%; transform: translateY(-50%); color: #9ca3af; font-size: 0.85rem; }

        .empty-state { text-align: center; padding: 3rem 1rem; color: #9ca3af; }
        .empty-state i { font-size: 3rem; margin-bottom: 0.8rem; display: block; }
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
        <div class="topbar-title">Quản lý người dùng <small class="ms-2" style="font-weight:400;color:#8a92a6;">/ Danh sách</small></div>
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
                    <div style="width:44px;height:44px;border-radius:10px;background:#eef2ff;display:flex;align-items:center;justify-content:center;font-size:1.2rem;color:#4f46e5;">
                        <i class="bi bi-people"></i>
                    </div>
                    <div>
                        <div style="font-size:1.4rem;font-weight:800;color:#1a1a2e;">${listUser.size()}</div>
                        <div style="font-size:0.75rem;color:#8a92a6;">Tổng người dùng</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Table Card -->
        <div class="card-admin">
            <div class="card-header">
                <span class="card-header-title"><i class="bi bi-table me-2 text-danger"></i>Danh sách người dùng</span>
                <div class="d-flex align-items-center gap-2">
                    <div class="search-wrap">
                        <i class="bi bi-search"></i>
                        <input type="text" class="search-input" id="searchInput" placeholder="Tìm người dùng...">
                    </div>
                    <a href="/admin/user/create" class="btn-create">
                        <i class="bi bi-plus-lg"></i> Thêm người dùng
                    </a>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table mb-0" id="userTable">
                    <thead>
                        <tr>
                            <th style="width:50px;">ID</th>
                            <th style="width:50px;">Ảnh</th>
                            <th>Họ tên</th>
                            <th>Email</th>
                            <th>SĐT</th>
                            <th>Role</th>
                            <th style="width:110px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody id="userTableBody">
                        <c:choose>
                            <c:when test="${empty listUser}">
                                <tr>
                                    <td colspan="7">
                                        <div class="empty-state">
                                            <i class="bi bi-people"></i>
                                            Chưa có người dùng nào.
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="user" items="${listUser}">
                                    <tr id="user-row-${user.id}">
                                        <td><span style="color:#9ca3af;">#${user.id}</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty user.avatar}">
                                                    <img src="/images/avatar/${user.avatar}" alt="${user.fullName}" class="avatar-thumb"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="avatar-placeholder">${user.fullName.substring(0,1).toUpperCase()}</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="font-weight:600;color:#1a1a2e;">${user.fullName}</td>
                                        <td style="color:#6b7080;">${user.email}</td>
                                        <td>${user.phone}</td>
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
                                        <td>
                                            <div class="d-flex gap-1">
                                                <a href="/admin/user/${user.id}" class="btn-action view" title="Xem"><i class="bi bi-eye"></i></a>
                                                <a href="/admin/user/update/${user.id}" class="btn-action edit" title="Sửa"><i class="bi bi-pencil"></i></a>
                                                <button class="btn-action delete delete-btn"
                                                        data-user-id="${user.id}"
                                                        data-user-name="${user.fullName}"
                                                        title="Xóa">
                                                    <i class="bi bi-trash3"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Delete Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width:400px;">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-body text-center p-4">
                <div style="width:64px;height:64px;background:#fef2f2;border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 1rem;font-size:1.6rem;color:#dc2626;">
                    <i class="bi bi-trash3"></i>
                </div>
                <h6 style="font-weight:700;margin-bottom:.4rem;">Xóa người dùng?</h6>
                <p style="font-size:.85rem;color:#6b7080;margin-bottom:1.5rem;">
                    Bạn chắc chắn muốn xóa <strong id="deleteUserName"></strong>?<br>
                    Hành động này không thể hoàn tác.
                </p>
                <div class="d-flex gap-2 justify-content-center">
                    <button class="btn btn-light px-4" data-bs-dismiss="modal">Hủy</button>
                    <button class="btn btn-danger px-4" id="confirmDeleteBtn">Xóa</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
$(function () {
    let deleteId = null;

    $(document).on('click', '.delete-btn', function () {
        deleteId = $(this).data('user-id');
        $('#deleteUserName').text($(this).data('user-name'));
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    });

    $('#confirmDeleteBtn').on('click', function () {
        if (!deleteId) return;
        $.ajax({
            url: '/admin/user/delete/' + deleteId,
            type: 'DELETE',
            success: function () {
                $('#user-row-' + deleteId).fadeOut(300, function () { $(this).remove(); });
                bootstrap.Modal.getInstance(document.getElementById('deleteModal')).hide();
            },
            error: function () { alert('Có lỗi xảy ra, vui lòng thử lại.'); }
        });
    });

    $('#searchInput').on('input', function () {
        const q = $(this).val().toLowerCase();
        $('#userTableBody tr').each(function () {
            $(this).toggle($(this).text().toLowerCase().includes(q));
        });
    });
});
</script>
</body>
</html>
