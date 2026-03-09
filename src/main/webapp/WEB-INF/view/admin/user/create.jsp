<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Thêm người dùng - LaptopShop Admin</title>
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

        .form-card { background: #fff; border-radius: 14px; box-shadow: 0 2px 12px rgba(0,0,0,0.06); border: none; overflow: hidden; }
        .form-card-header { background: var(--primary); padding: 1.2rem 1.8rem; }
        .form-card-header h5 { color: #fff; font-weight: 700; margin: 0; font-size: 1rem; }
        .form-card-body { padding: 1.8rem; }

        .form-label-s { font-size: 0.82rem; font-weight: 600; color: #374151; margin-bottom: 0.35rem; }
        .required { color: var(--accent); }

        .form-control, .form-select {
            border: 1.5px solid #e5e7eb; border-radius: 8px; padding: 0.55rem 0.9rem;
            font-size: 0.88rem; color: #374151; transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--accent); box-shadow: 0 0 0 3px rgba(233,69,96,0.1); outline: none;
        }
        .form-control.is-invalid, .form-select.is-invalid { border-color: #dc2626; }

        .upload-area {
            border: 2px dashed #e5e7eb; border-radius: 10px; padding: 1.5rem;
            text-align: center; cursor: pointer; transition: all 0.2s; background: #fafbff;
        }
        .upload-area:hover, .upload-area.dragover { border-color: var(--accent); background: #fff5f7; }
        .upload-area .upload-icon { font-size: 2rem; color: #ccc; }
        .upload-area.has-file .upload-icon { color: var(--accent); }
        .upload-area small { color: #9ca3af; font-size: 0.78rem; }

        #avatarPreview {
            width: 80px; height: 80px; object-fit: cover;
            border-radius: 50%; display: none; margin: 0.6rem auto 0; border: 3px solid #e5e7eb;
        }

        .btn-submit { background: var(--accent); color: #fff; border: none; padding: 0.65rem 2rem; border-radius: 8px; font-weight: 600; font-size: 0.9rem; transition: background 0.2s; }
        .btn-submit:hover { background: #c73652; color: #fff; }

        .error-msg { font-size: 0.78rem; color: #dc2626; margin-top: 0.25rem; }
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
            <a href="/admin/user" style="color:#8a92a6;text-decoration:none;font-size:.85rem;font-weight:400;">
                Người dùng
            </a>
            <span style="color:#8a92a6;margin:0 .4rem;">/</span>
            Thêm người dùng mới
        </div>
        <div class="d-flex align-items-center gap-2">
            <span style="font-size:.85rem;color:#6b7080;">Admin</span>
            <div style="width:32px;height:32px;border-radius:50%;background:#e94560;display:flex;align-items:center;justify-content:center;color:#fff;font-size:.8rem;font-weight:700;">A</div>
        </div>
    </div>

    <div class="content">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="form-card">
                    <div class="form-card-header">
                        <h5><i class="bi bi-person-plus me-2"></i>Thêm người dùng mới</h5>
                    </div>
                    <div class="form-card-body">

                        <c:if test="${not empty uploadError}">
                            <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
                                <i class="bi bi-exclamation-triangle me-2"></i>${uploadError}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form:form method="post" action="/admin/user/create"
                                   modelAttribute="newUser"
                                   enctype="multipart/form-data"
                                   id="createUserForm" novalidate="true">

                            <div class="row g-3">

                                <!-- Email -->
                                <div class="col-md-6">
                                    <label class="form-label-s">Email <span class="required">*</span></label>
                                    <form:input type="email" path="email" class="form-control"
                                               placeholder="name@example.com"/>
                                    <form:errors path="email" cssClass="error-msg"/>
                                </div>

                                <!-- Password -->
                                <div class="col-md-6">
                                    <label class="form-label-s">Mật khẩu <span class="required">*</span></label>
                                    <form:input type="password" path="password" class="form-control"
                                               placeholder="Tối thiểu 6 ký tự"/>
                                    <form:errors path="password" cssClass="error-msg"/>
                                </div>

                                <!-- Full Name -->
                                <div class="col-md-6">
                                    <label class="form-label-s">Họ tên <span class="required">*</span></label>
                                    <form:input type="text" path="fullName" class="form-control"
                                               placeholder="Nguyen Van A"/>
                                    <form:errors path="fullName" cssClass="error-msg"/>
                                </div>

                                <!-- Role -->
                                <div class="col-md-6">
                                    <label class="form-label-s">Role <span class="required">*</span></label>
                                    <form:select path="role" class="form-select">
                                        <form:option value="" label="-- Chọn role --"/>
                                        <form:option value="USER" label="USER"/>
                                        <form:option value="ADMIN" label="ADMIN"/>
                                    </form:select>
                                    <form:errors path="role" cssClass="error-msg"/>
                                </div>

                                <!-- Phone -->
                                <div class="col-md-6">
                                    <label class="form-label-s">Số điện thoại</label>
                                    <form:input type="tel" path="phone" class="form-control"
                                               placeholder="0123456789"/>
                                </div>

                                <!-- Address -->
                                <div class="col-md-6">
                                    <label class="form-label-s">Địa chỉ</label>
                                    <form:input type="text" path="address" class="form-control"
                                               placeholder="Số nhà, đường, thành phố"/>
                                </div>

                                <!-- Avatar Upload -->
                                <div class="col-12">
                                    <label class="form-label-s">Ảnh đại diện</label>
                                    <div class="upload-area" id="uploadArea"
                                         onclick="document.getElementById('avatarFile').click()">
                                        <i class="bi bi-cloud-upload upload-icon" id="uploadIcon"></i>
                                        <div id="uploadText" style="font-size:.85rem;color:#6b7080;margin-top:.4rem;">
                                            Nhấn để chọn ảnh hoặc kéo thả vào đây
                                        </div>
                                        <small>PNG, JPG, WEBP — tối đa 5MB</small>
                                        <img id="avatarPreview" src="" alt="Preview"/>
                                    </div>
                                    <input type="file" id="avatarFile" name="avatarFile"
                                           accept="image/*" style="display:none;">
                                </div>

                            </div><!-- /row -->

                            <div class="d-flex gap-2 mt-4">
                                <button type="submit" class="btn-submit">
                                    <i class="bi bi-check-lg me-1"></i>Tạo người dùng
                                </button>
                                <a href="/admin/user" class="btn btn-light px-4">Hủy</a>
                            </div>

                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const avatarInput = document.getElementById('avatarFile');
    const uploadArea  = document.getElementById('uploadArea');
    const preview     = document.getElementById('avatarPreview');
    const uploadIcon  = document.getElementById('uploadIcon');
    const uploadText  = document.getElementById('uploadText');

    avatarInput.addEventListener('change', function () {
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

    uploadArea.addEventListener('dragover', e => { e.preventDefault(); uploadArea.classList.add('dragover'); });
    uploadArea.addEventListener('dragleave', () => uploadArea.classList.remove('dragover'));
    uploadArea.addEventListener('drop', e => {
        e.preventDefault();
        uploadArea.classList.remove('dragover');
        avatarInput.files = e.dataTransfer.files;
        avatarInput.dispatchEvent(new Event('change'));
    });
</script>
</body>
</html>
