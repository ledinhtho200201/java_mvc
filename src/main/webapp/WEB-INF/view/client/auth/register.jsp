<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Đăng ký - LaptopShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        :root { --primary: #1a1a2e; --highlight: #e94560; }
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            font-family: 'Segoe UI', sans-serif;
            padding: 2rem 1rem;
        }
        .register-card {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            max-width: 480px;
            width: 100%;
        }
        .register-header {
            background: var(--primary);
            padding: 2rem 2.5rem 1.6rem;
            text-align: center;
        }
        .register-header .brand {
            font-size: 1.5rem;
            font-weight: 800;
            color: #fff;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 0.6rem;
        }
        .register-header .brand span { color: var(--highlight); }
        .register-header p {
            color: rgba(255,255,255,0.6);
            font-size: 0.88rem;
            margin: 0;
        }
        .register-body { padding: 2rem 2.5rem 1.5rem; }
        .register-footer { padding: 0 2.5rem 2rem; text-align: center; }

        .form-label-s {
            font-size: 0.82rem;
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.3rem;
        }
        .form-control-s {
            border: 1.5px solid #e5e7eb;
            border-radius: 10px;
            padding: 0.6rem 0.9rem 0.6rem 2.6rem;
            font-size: 0.9rem;
            color: #374151;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-control-s:focus {
            border-color: var(--highlight);
            box-shadow: 0 0 0 3px rgba(233,69,96,0.1);
            outline: none;
        }
        .form-control-s.is-invalid {
            border-color: #dc2626;
        }
        .form-control-s.is-invalid:focus {
            box-shadow: 0 0 0 3px rgba(220,38,38,0.12);
        }
        .input-group-icon {
            position: relative;
        }
        .input-group-icon > i {
            position: absolute;
            left: 0.9rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            font-size: 0.95rem;
            z-index: 2;
        }
        .error-msg {
            font-size: 0.78rem;
            color: #dc2626;
            margin-top: 0.25rem;
        }
        .btn-register {
            background: var(--highlight);
            color: #fff;
            border: none;
            padding: 0.7rem;
            border-radius: 10px;
            font-size: 0.95rem;
            font-weight: 700;
            width: 100%;
            transition: all 0.3s;
        }
        .btn-register:hover {
            background: #c73652;
            color: #fff;
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(233,69,96,0.35);
        }
        .divider {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin: 1.2rem 0;
            color: #9ca3af;
            font-size: 0.82rem;
        }
        .divider::before, .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #e5e7eb;
        }
        .link-login {
            color: var(--highlight);
            text-decoration: none;
            font-weight: 600;
        }
        .link-login:hover {
            text-decoration: underline;
            color: #c73652;
        }
        .toggle-pw {
            position: absolute;
            right: 0.9rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #9ca3af;
            cursor: pointer;
            z-index: 2;
            font-size: 0.95rem;
        }
        .toggle-pw:hover { color: #555; }
    </style>
</head>
<body>

<div class="register-card">
    <div class="register-header">
        <a href="/" class="brand"><i class="bi bi-laptop me-2"></i>Laptop<span>Shop</span></a>
        <p>Tạo tài khoản mới</p>
    </div>

    <div class="register-body">
        <form:form method="POST" action="/register" modelAttribute="registerUser">

            <!-- Họ + Tên -->
            <div class="row g-3 mb-3">
                <div class="col-6">
                    <label class="form-label-s">Họ <span style="color:var(--highlight);">*</span></label>
                    <div class="input-group-icon">
                        <i class="bi bi-person"></i>
                        <form:input type="text" path="firstName"
                                   cssClass="form-control form-control-s"
                                   cssErrorClass="form-control form-control-s is-invalid"
                                   placeholder="Nguyễn"/>
                    </div>
                    <form:errors path="firstName" cssClass="error-msg"/>
                </div>
                <div class="col-6">
                    <label class="form-label-s">Tên <span style="color:var(--highlight);">*</span></label>
                    <div class="input-group-icon">
                        <i class="bi bi-person"></i>
                        <form:input type="text" path="lastName"
                                   cssClass="form-control form-control-s"
                                   cssErrorClass="form-control form-control-s is-invalid"
                                   placeholder="Văn A"/>
                    </div>
                    <form:errors path="lastName" cssClass="error-msg"/>
                </div>
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label-s">Email <span style="color:var(--highlight);">*</span></label>
                <div class="input-group-icon">
                    <i class="bi bi-envelope"></i>
                    <form:input type="email" path="email"
                               cssClass="form-control form-control-s"
                               cssErrorClass="form-control form-control-s is-invalid"
                               placeholder="example@gmail.com"/>
                </div>
                <form:errors path="email" cssClass="error-msg"/>
                <c:if test="${not empty emailError}">
                    <div class="error-msg">${emailError}</div>
                </c:if>
            </div>

            <!-- Mật khẩu -->
            <div class="mb-3">
                <label class="form-label-s">Mật khẩu <span style="color:var(--highlight);">*</span></label>
                <div class="input-group-icon">
                    <i class="bi bi-lock"></i>
                    <form:password path="password"
                               cssClass="form-control form-control-s"
                               cssErrorClass="form-control form-control-s is-invalid"
                               placeholder="Ít nhất 6 ký tự"/>
                    <button type="button" class="toggle-pw" onclick="togglePassword(this)">
                        <i class="bi bi-eye"></i>
                    </button>
                </div>
                <form:errors path="password" cssClass="error-msg"/>
            </div>

            <!-- Xác nhận mật khẩu -->
            <div class="mb-4">
                <label class="form-label-s">Xác nhận mật khẩu <span style="color:var(--highlight);">*</span></label>
                <div class="input-group-icon">
                    <i class="bi bi-lock-fill"></i>
                    <form:password path="confirmPassword"
                               cssClass="form-control form-control-s"
                               cssErrorClass="form-control form-control-s is-invalid"
                               placeholder="Nhập lại mật khẩu"/>
                    <button type="button" class="toggle-pw" onclick="togglePassword(this)">
                        <i class="bi bi-eye"></i>
                    </button>
                </div>
                <form:errors path="confirmPassword" cssClass="error-msg"/>
            </div>

            <button type="submit" class="btn-register">
                <i class="bi bi-person-plus me-1"></i> Đăng ký
            </button>

        </form:form>

        <div class="divider">hoặc</div>
    </div>

    <div class="register-footer">
        <p style="font-size:0.88rem;color:#6b7080;">
            Đã có tài khoản? <a href="/login" class="link-login">Đăng nhập</a>
        </p>
    </div>
</div>

<script>
    function togglePassword(btn) {
        const input = btn.parentElement.querySelector('input');
        const icon = btn.querySelector('i');
        if (input.type === 'password') {
            input.type = 'text';
            icon.className = 'bi bi-eye-slash';
        } else {
            input.type = 'password';
            icon.className = 'bi bi-eye';
        }
    }
</script>
</body>
</html>
