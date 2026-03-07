<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quản lý sản phẩm - LaptopShop Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        :root {
            --sidebar-w: 240px;
            --primary: #1a1a2e;
            --accent: #e94560;
        }

        body { background: #f4f6fb; font-family: 'Segoe UI', sans-serif; }

        /* ---- SIDEBAR ---- */
        .sidebar {
            width: var(--sidebar-w);
            min-height: 100vh;
            background: var(--primary);
            position: fixed;
            top: 0; left: 0;
            display: flex;
            flex-direction: column;
            z-index: 100;
        }

        .sidebar-brand {
            padding: 1.4rem 1.5rem;
            font-size: 1.25rem;
            font-weight: 800;
            color: #fff;
            border-bottom: 1px solid rgba(255,255,255,0.08);
            text-decoration: none;
        }

        .sidebar-brand span { color: var(--accent); }

        .sidebar-label {
            font-size: 0.68rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: rgba(255,255,255,0.35);
            padding: 1.2rem 1.5rem 0.4rem;
        }

        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.65rem 1.5rem;
            color: rgba(255,255,255,0.65);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.2s;
            border-left: 3px solid transparent;
        }

        .sidebar-link:hover {
            background: rgba(255,255,255,0.06);
            color: #fff;
        }

        .sidebar-link.active {
            background: rgba(233,69,96,0.15);
            color: #fff;
            border-left-color: var(--accent);
        }

        .sidebar-link i { font-size: 1rem; width: 20px; text-align: center; }

        /* ---- MAIN ---- */
        .main-wrap {
            margin-left: var(--sidebar-w);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .topbar {
            background: #fff;
            padding: 0.85rem 1.8rem;
            border-bottom: 1px solid #e8ecf0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .topbar-title { font-size: 1rem; font-weight: 700; color: #1a1a2e; }
        .topbar-title small { font-weight: 400; color: #8a92a6; font-size: 0.82rem; }

        .content { padding: 1.8rem; flex: 1; }

        /* ---- CARD ---- */
        .card-admin {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            border: none;
        }

        .card-admin .card-header {
            background: transparent;
            border-bottom: 1px solid #f0f2f5;
            padding: 1.1rem 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .card-header-title {
            font-size: 1rem;
            font-weight: 700;
            color: #1a1a2e;
        }

        /* ---- TABLE ---- */
        .table thead th {
            background: #f8f9fc;
            color: #6b7080;
            font-size: 0.78rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
            border: none;
            padding: 0.85rem 1rem;
        }

        .table tbody td {
            padding: 0.9rem 1rem;
            vertical-align: middle;
            border-color: #f0f2f5;
            font-size: 0.88rem;
            color: #374151;
        }

        .table tbody tr:hover { background: #fafbff; }

        .badge-factory {
            background: #eef2ff;
            color: #4f46e5;
            font-size: 0.72rem;
            padding: 3px 9px;
            border-radius: 10px;
            font-weight: 600;
        }

        .badge-target {
            background: #f0fdf4;
            color: #16a34a;
            font-size: 0.72rem;
            padding: 3px 9px;
            border-radius: 10px;
            font-weight: 600;
        }

        .product-thumb {
            width: 48px; height: 48px;
            object-fit: cover;
            border-radius: 8px;
            background: #f4f6fb;
        }

        .product-thumb-placeholder {
            width: 48px; height: 48px;
            border-radius: 8px;
            background: #f4f6fb;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #bbb;
            font-size: 1.2rem;
        }

        .btn-action {
            width: 30px; height: 30px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 7px;
            border: none;
            font-size: 0.8rem;
            transition: all 0.2s;
            text-decoration: none;
        }

        .btn-action.edit   { background: #fff8e6; color: #d97706; }
        .btn-action.delete { background: #fef2f2; color: #dc2626; }
        .btn-action:hover  { filter: brightness(0.9); }

        .btn-create {
            background: var(--accent);
            color: #fff;
            border: none;
            padding: 0.5rem 1.1rem;
            border-radius: 8px;
            font-size: 0.88rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            transition: background 0.2s;
        }

        .btn-create:hover { background: #c73652; color: #fff; }

        /* ---- MODAL ---- */
        .modal-admin .modal-content {
            border: none;
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
        }

        .modal-admin .modal-header {
            background: var(--primary);
            border-radius: 16px 16px 0 0;
            padding: 1.1rem 1.5rem;
            border: none;
        }

        .modal-admin .modal-title {
            color: #fff;
            font-weight: 700;
            font-size: 1rem;
        }

        .modal-admin .btn-close { filter: invert(1) opacity(.6); }

        .modal-admin .modal-body { padding: 1.5rem; }

        .form-label-admin {
            font-size: 0.82rem;
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.35rem;
        }

        .form-label-admin .required { color: var(--accent); }

        .form-control-admin,
        .form-select-admin {
            border: 1.5px solid #e5e7eb;
            border-radius: 8px;
            padding: 0.55rem 0.9rem;
            font-size: 0.88rem;
            color: #374151;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .form-control-admin:focus,
        .form-select-admin:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(233,69,96,0.1);
            outline: none;
        }

        .form-control-admin.is-invalid { border-color: #dc2626; }

        .upload-area {
            border: 2px dashed #e5e7eb;
            border-radius: 10px;
            padding: 1.2rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.2s;
            background: #fafbff;
        }

        .upload-area:hover, .upload-area.dragover {
            border-color: var(--accent);
            background: #fff5f7;
        }

        .upload-area i { font-size: 2rem; color: #ccc; }
        .upload-area.has-file i { color: var(--accent); }
        .upload-area small { color: #9ca3af; font-size: 0.78rem; }

        #imagePreview {
            width: 80px; height: 80px;
            object-fit: cover;
            border-radius: 8px;
            display: none;
            margin: 0.5rem auto 0;
        }

        .modal-admin .modal-footer {
            border-top: 1px solid #f0f2f5;
            padding: 1rem 1.5rem;
        }

        .btn-submit {
            background: var(--accent);
            color: #fff;
            border: none;
            padding: 0.6rem 1.8rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .btn-submit:hover { background: #c73652; color: #fff; }

        /* ---- SEARCH / FILTER ---- */
        .search-input {
            border: 1.5px solid #e5e7eb;
            border-radius: 8px;
            padding: 0.45rem 0.9rem 0.45rem 2.3rem;
            font-size: 0.85rem;
            width: 220px;
        }

        .search-wrap { position: relative; }
        .search-wrap i {
            position: absolute;
            left: 0.75rem; top: 50%;
            transform: translateY(-50%);
            color: #9ca3af; font-size: 0.85rem;
        }

        /* ---- EMPTY STATE ---- */
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
            color: #9ca3af;
        }

        .empty-state i { font-size: 3rem; margin-bottom: 0.8rem; display: block; }
    </style>
</head>
<body>

<!-- ====================== SIDEBAR ====================== -->
<aside class="sidebar">
    <a href="/" class="sidebar-brand"><i class="bi bi-laptop me-2"></i>Laptop<span>Shop</span></a>

    <div class="sidebar-label">Tổng quan</div>
    <a href="#" class="sidebar-link"><i class="bi bi-speedometer2"></i> Dashboard</a>

    <div class="sidebar-label">Quản lý</div>
    <a href="/admin/product" class="sidebar-link active"><i class="bi bi-box-seam"></i> Sản phẩm</a>
    <a href="/admin/user" class="sidebar-link"><i class="bi bi-people"></i> Người dùng</a>
    <a href="#" class="sidebar-link"><i class="bi bi-cart3"></i> Đơn hàng</a>

    <div class="sidebar-label">Hệ thống</div>
    <a href="#" class="sidebar-link"><i class="bi bi-gear"></i> Cài đặt</a>
    <a href="#" class="sidebar-link"><i class="bi bi-box-arrow-left"></i> Đăng xuất</a>
</aside>

<!-- ====================== MAIN ====================== -->
<div class="main-wrap">

    <!-- Topbar -->
    <div class="topbar">
        <div>
            <div class="topbar-title">
                Quản lý sản phẩm
                <small class="ms-2">/ Danh sách</small>
            </div>
        </div>
        <div class="d-flex align-items-center gap-2">
            <span style="font-size:.85rem; color:#6b7080;">Admin</span>
            <div style="width:32px;height:32px;border-radius:50%;background:#e94560;display:flex;align-items:center;justify-content:center;color:#fff;font-size:.8rem;font-weight:700;">A</div>
        </div>
    </div>

    <!-- Content -->
    <div class="content">

        <!-- Stats row -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-lg-3">
                <div class="card-admin p-3 d-flex align-items-center gap-3">
                    <div style="width:44px;height:44px;border-radius:10px;background:#eef2ff;display:flex;align-items:center;justify-content:center;font-size:1.2rem;color:#4f46e5;">
                        <i class="bi bi-box-seam"></i>
                    </div>
                    <div>
                        <div style="font-size:1.4rem;font-weight:800;color:#1a1a2e;">${productCount != null ? productCount : 0}</div>
                        <div style="font-size:0.75rem;color:#8a92a6;">Tổng sản phẩm</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-lg-3">
                <div class="card-admin p-3 d-flex align-items-center gap-3">
                    <div style="width:44px;height:44px;border-radius:10px;background:#f0fdf4;display:flex;align-items:center;justify-content:center;font-size:1.2rem;color:#16a34a;">
                        <i class="bi bi-check-circle"></i>
                    </div>
                    <div>
                        <div style="font-size:1.4rem;font-weight:800;color:#1a1a2e;">Còn hàng</div>
                        <div style="font-size:0.75rem;color:#8a92a6;">Trạng thái</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product Table Card -->
        <div class="card-admin">
            <div class="card-header">
                <span class="card-header-title"><i class="bi bi-table me-2 text-danger"></i>Danh sách sản phẩm</span>
                <div class="d-flex align-items-center gap-2">
                    <div class="search-wrap">
                        <i class="bi bi-search"></i>
                        <input type="text" class="search-input" id="searchInput" placeholder="Tìm sản phẩm...">
                    </div>
                    <button class="btn-create" data-bs-toggle="modal" data-bs-target="#createProductModal">
                        <i class="bi bi-plus-lg"></i> Thêm sản phẩm
                    </button>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table mb-0" id="productTable">
                    <thead>
                        <tr>
                            <th style="width:50px;">ID</th>
                            <th style="width:60px;">Ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Nhà sản xuất</th>
                            <th>Mục đích</th>
                            <th style="width:90px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody id="productTableBody">
                        <c:choose>
                            <c:when test="${empty listProduct}">
                                <tr>
                                    <td colspan="8">
                                        <div class="empty-state">
                                            <i class="bi bi-box-seam"></i>
                                            Chưa có sản phẩm nào. Nhấn <strong>Thêm sản phẩm</strong> để bắt đầu.
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="product" items="${listProduct}">
                                    <tr id="product-row-${product.id}">
                                        <td><span style="color:#9ca3af;">#${product.id}</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.image}">
                                                    <img src="/images/${product.image}" alt="${product.name}" class="product-thumb"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="product-thumb-placeholder"><i class="bi bi-image"></i></div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div style="font-weight:600;color:#1a1a2e;">${product.name}</div>
                                            <div style="font-size:0.75rem;color:#9ca3af;margin-top:2px;">${product.shortDesc}</div>
                                        </td>
                                        <td style="font-weight:700;color:#e94560;">
                                            <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ
                                        </td>
                                        <td>
                                            <span style="background:#f4f6fb;padding:2px 10px;border-radius:8px;font-size:.82rem;font-weight:600;">
                                                ${product.quantity}
                                            </span>
                                        </td>
                                        <td><span class="badge-factory">${product.factory}</span></td>
                                        <td><span class="badge-target">${product.target}</span></td>
                                        <td>
                                            <div class="d-flex gap-1">
                                                <a href="/admin/product/update/${product.id}" class="btn-action edit" title="Sửa">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <button class="btn-action delete delete-btn"
                                                        data-id="${product.id}"
                                                        data-name="${product.name}"
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
        </div><!-- /card -->

    </div><!-- /content -->
</div><!-- /main-wrap -->


<!-- ====================== MODAL: TẠO SẢN PHẨM ====================== -->
<div class="modal fade modal-admin" id="createProductModal" tabindex="-1" aria-labelledby="createProductModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="createProductModalLabel">
                    <i class="bi bi-plus-circle me-2"></i>Thêm sản phẩm mới
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <form id="createProductForm" action="/admin/product/create" method="post" enctype="multipart/form-data" novalidate>

                    <div class="row g-3">

                        <!-- Tên sản phẩm -->
                        <div class="col-12">
                            <label class="form-label-admin">Tên sản phẩm <span class="required">*</span></label>
                            <input type="text" name="name" class="form-control form-control-admin"
                                   placeholder="VD: ASUS ROG Strix G16 Gaming RTX 4070" required>
                            <div class="invalid-feedback">Vui lòng nhập tên sản phẩm.</div>
                        </div>

                        <!-- Giá + Số lượng -->
                        <div class="col-md-6">
                            <label class="form-label-admin">Giá (VNĐ) <span class="required">*</span></label>
                            <input type="number" name="price" class="form-control form-control-admin"
                                   placeholder="VD: 35990000" min="0" required>
                            <div class="invalid-feedback">Vui lòng nhập giá sản phẩm.</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label-admin">Số lượng <span class="required">*</span></label>
                            <input type="number" name="quantity" class="form-control form-control-admin"
                                   placeholder="VD: 50" min="0" required>
                            <div class="invalid-feedback">Vui lòng nhập số lượng.</div>
                        </div>

                        <!-- Nhà sản xuất + Mục đích -->
                        <div class="col-md-6">
                            <label class="form-label-admin">Nhà sản xuất <span class="required">*</span></label>
                            <select name="factory" class="form-select form-select-admin form-control-admin" required>
                                <option value="" disabled selected>-- Chọn hãng --</option>
                                <option value="ASUS">ASUS</option>
                                <option value="Lenovo">Lenovo</option>
                                <option value="Dell">Dell</option>
                                <option value="HP">HP</option>
                                <option value="Apple">Apple</option>
                                <option value="Acer">Acer</option>
                                <option value="MSI">MSI</option>
                                <option value="Samsung">Samsung</option>
                                <option value="LG">LG</option>
                                <option value="Khác">Khác</option>
                            </select>
                            <div class="invalid-feedback">Vui lòng chọn nhà sản xuất.</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label-admin">Mục đích sử dụng <span class="required">*</span></label>
                            <select name="target" class="form-select form-select-admin form-control-admin" required>
                                <option value="" disabled selected>-- Chọn mục đích --</option>
                                <option value="Gaming">Gaming</option>
                                <option value="Văn phòng">Văn phòng</option>
                                <option value="Đồ họa">Đồ họa</option>
                                <option value="Học sinh - Sinh viên">Học sinh - Sinh viên</option>
                                <option value="Doanh nhân">Doanh nhân</option>
                                <option value="Workstation">Workstation</option>
                            </select>
                            <div class="invalid-feedback">Vui lòng chọn mục đích sử dụng.</div>
                        </div>

                        <!-- Mô tả ngắn -->
                        <div class="col-12">
                            <label class="form-label-admin">Mô tả ngắn</label>
                            <input type="text" name="shortDesc" class="form-control form-control-admin"
                                   placeholder="VD: Intel i9, 16GB DDR5, 1TB SSD, 165Hz">
                        </div>

                        <!-- Mô tả chi tiết -->
                        <div class="col-12">
                            <label class="form-label-admin">Mô tả chi tiết</label>
                            <textarea name="detailDesc" class="form-control form-control-admin"
                                      rows="4" placeholder="Nhập mô tả chi tiết về sản phẩm..."></textarea>
                        </div>

                        <!-- Ảnh sản phẩm -->
                        <div class="col-12">
                            <label class="form-label-admin">Ảnh sản phẩm</label>
                            <div class="upload-area" id="uploadArea" onclick="document.getElementById('imageInput').click()">
                                <i class="bi bi-cloud-upload" id="uploadIcon"></i>
                                <div id="uploadText" style="font-size:.85rem;color:#6b7080;margin-top:.4rem;">
                                    Nhấn để chọn ảnh hoặc kéo thả vào đây
                                </div>
                                <small>PNG, JPG, WEBP — tối đa 5MB</small>
                                <img id="imagePreview" src="" alt="Preview"/>
                            </div>
                            <input type="file" id="imageInput" name="image" accept="image/*" style="display:none;">
                        </div>

                    </div><!-- /row -->
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light px-4" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-submit" id="submitProductBtn">
                    <i class="bi bi-check-lg me-1"></i>Lưu sản phẩm
                </button>
            </div>

        </div>
    </div>
</div>

<!-- ====================== MODAL: XÁC NHẬN XÓA ====================== -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width:400px;">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-body text-center p-4">
                <div style="width:64px;height:64px;background:#fef2f2;border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 1rem;font-size:1.6rem;color:#dc2626;">
                    <i class="bi bi-trash3"></i>
                </div>
                <h6 style="font-weight:700;margin-bottom:.4rem;">Xóa sản phẩm?</h6>
                <p style="font-size:.85rem;color:#6b7080;margin-bottom:1.5rem;">
                    Bạn chắc chắn muốn xóa <strong id="deleteProductName"></strong>?<br>
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

    /* ---- IMAGE UPLOAD PREVIEW ---- */
    const imageInput = document.getElementById('imageInput');
    const uploadArea  = document.getElementById('uploadArea');
    const preview     = document.getElementById('imagePreview');
    const uploadIcon  = document.getElementById('uploadIcon');
    const uploadText  = document.getElementById('uploadText');

    imageInput.addEventListener('change', function () {
        const file = this.files[0];
        if (!file) return;
        const reader = new FileReader();
        reader.onload = e => {
            preview.src = e.target.result;
            preview.style.display = 'block';
            uploadIcon.style.display = 'none';
            uploadText.textContent = file.name;
            uploadArea.classList.add('has-file');
        };
        reader.readAsDataURL(file);
    });

    // Drag & drop
    uploadArea.addEventListener('dragover', e => { e.preventDefault(); uploadArea.classList.add('dragover'); });
    uploadArea.addEventListener('dragleave', () => uploadArea.classList.remove('dragover'));
    uploadArea.addEventListener('drop', e => {
        e.preventDefault();
        uploadArea.classList.remove('dragover');
        imageInput.files = e.dataTransfer.files;
        imageInput.dispatchEvent(new Event('change'));
    });

    /* ---- FORM SUBMIT ---- */
    $('#submitProductBtn').on('click', function () {
        const form = document.getElementById('createProductForm');
        if (!form.checkValidity()) {
            form.classList.add('was-validated');
            return;
        }
        form.submit();
    });

    // Reset validation on modal close
    $('#createProductModal').on('hidden.bs.modal', function () {
        const form = document.getElementById('createProductForm');
        form.reset();
        form.classList.remove('was-validated');
        preview.style.display = 'none';
        uploadIcon.style.display = '';
        uploadText.textContent = 'Nhấn để chọn ảnh hoặc kéo thả vào đây';
        uploadArea.classList.remove('has-file');
    });

    /* ---- DELETE ---- */
    let deleteId = null;

    $(document).on('click', '.delete-btn', function () {
        deleteId = $(this).data('id');
        $('#deleteProductName').text($(this).data('name'));
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    });

    $('#confirmDeleteBtn').on('click', function () {
        if (!deleteId) return;
        $.ajax({
            url: '/admin/product/delete/' + deleteId,
            type: 'DELETE',
            success: function () {
                $('#product-row-' + deleteId).fadeOut(300, function () { $(this).remove(); });
                bootstrap.Modal.getInstance(document.getElementById('deleteModal')).hide();
            },
            error: function () { alert('Có lỗi xảy ra, vui lòng thử lại.'); }
        });
    });

    /* ---- SEARCH ---- */
    $('#searchInput').on('input', function () {
        const q = $(this).val().toLowerCase();
        $('#productTableBody tr').each(function () {
            const text = $(this).text().toLowerCase();
            $(this).toggle(text.includes(q));
        });
    });

});
</script>
</body>
</html>
