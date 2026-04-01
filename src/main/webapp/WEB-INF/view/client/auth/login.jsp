<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Đăng nhập - LaptopShop</title>
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
        .login-card {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            max-width: 420px;
            width: 100%;
        }
        .login-header {
            background: var(--primary);
            padding: 2rem 2.5rem 1.6rem;
            text-align: center;
        }
        .login-header .brand {
            font-size: 1.5rem;
            font-weight: 800;
            color: #fff;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 0.6rem;
        }
        .login-header .brand span { color: var(--highlight); }
        .login-header p {
            color: rgba(255,255,255,0.6);
            font-size: 0.88rem;
            margin: 0;
        }
        .login-body { padding: 2rem 2.5rem 1.5rem; }
        .login-footer { padding: 0 2.5rem 2rem; text-align: center; }

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
        .btn-login-submit {
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
        .btn-login-submit:hover {
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
        .link-register {
            color: var(--highlight);
            text-decoration: none;
            font-weight: 600;
        }
        .link-register:hover {
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
        .error-msg {
            font-size: 0.85rem;
            color: #dc2626;
            text-align: center;
            margin-bottom: 1rem;
            padding: 0.5rem;
            background: #fef2f2;
            border-radius: 8px;
        }
        .success-msg {
            font-size: 0.85rem;
            color: #16a34a;
            text-align: center;
            margin-bottom: 1rem;
            padding: 0.5rem;
            background: #f0fdf4;
            border-radius: 8px;
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="login-header">
        <a href="/" class="brand"><i class="bi bi-laptop me-2"></i>Laptop<span>Shop</span></a>
        <p>Đăng nhập tài khoản</p>
    </div>

    <div class="login-body">

        <c:if test="${param.error != null}">
            <div class="error-msg">
                <i class="bi bi-exclamation-circle me-1"></i>Email hoặc mật khẩu không đúng
            </div>
        </c:if>

        <c:if test="${param.expired != null}">
            <div class="error-msg" style="background:#fff7ed;color:#ea580c;border-color:#fed7aa;">
                <i class="bi bi-clock me-1"></i>Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại
            </div>
        </c:if>

        <c:if test="${param.logout != null}">
            <div class="success-msg">
                <i class="bi bi-check-circle me-1"></i>Đăng xuất thành công
            </div>
        </c:if>

        <form method="POST" action="/login">

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label-s">Email</label>
                <div class="input-group-icon">
                    <i class="bi bi-envelope"></i>
                    <input type="email" name="username" class="form-control form-control-s"
                           placeholder="example@gmail.com" required>
                </div>
            </div>

            <!-- Mật khẩu -->
            <div class="mb-3">
                <label class="form-label-s">Mật khẩu</label>
                <div class="input-group-icon">
                    <i class="bi bi-lock"></i>
                    <input type="password" name="password" class="form-control form-control-s"
                           placeholder="Nhập mật khẩu" required>
                    <button type="button" class="toggle-pw" onclick="togglePassword(this)">
                        <i class="bi bi-eye"></i>
                    </button>
                </div>
            </div>

            <!-- Remember + Forgot -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="remember" name="remember-me">
                    <label class="form-check-label" for="remember" style="font-size:.82rem;color:#6b7080;">Ghi nhớ</label>
                </div>
                <a href="#" style="font-size:.82rem;color:var(--highlight);text-decoration:none;">Quên mật khẩu?</a>
            </div>

            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <button type="submit" class="btn-login-submit">
                <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
            </button>

        </form>

        <div class="divider">hoặc</div>

        <!-- OAUTH2 / KEYCLOAK LOGIN BUTTON -->
        <a href="/oauth2/authorization/keycloak" class="btn btn-outline-dark w-100" style="border-radius: 10px; font-weight: 600;">
            <i class="bi bi-shield-lock me-2"></i> Đăng nhập với Keycloak
        </a>

    </div>

    <div class="login-footer">
        <p style="font-size:0.88rem;color:#6b7080;">
            Chưa có tài khoản? <a href="/register" class="link-register">Đăng ký ngay</a>
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
