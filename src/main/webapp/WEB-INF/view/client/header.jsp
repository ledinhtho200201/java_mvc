<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- =============================================
     TOPBAR
     ============================================= -->
<div class="topbar d-none d-md-block">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center gap-3">
                <span><i class="bi bi-telephone-fill me-1"></i> Hotline: <a href="tel:19001234">1900 1234</a></span>
                <span class="d-none d-lg-inline"><i class="bi bi-envelope-fill me-1"></i> <a href="mailto:support@laptopshop.vn">support@laptopshop.vn</a></span>
            </div>
            <div class="d-flex align-items-center gap-3">
                <span><i class="bi bi-truck me-1"></i> Miễn phí giao hàng đơn từ 5 triệu</span>
                <span class="d-none d-lg-inline"><i class="bi bi-clock me-1"></i> T2 - CN: 8:00 - 21:00</span>
            </div>
        </div>
    </div>
</div>

<!-- =============================================
     MAIN NAVBAR
     ============================================= -->
<nav class="navbar navbar-expand-lg navbar-main">
    <div class="container">

        <!-- Brand -->
        <a class="navbar-brand me-4" href="/">
            <span class="brand-text"><i class="bi bi-laptop me-1"></i>Laptop<span>Shop</span></span>
        </a>

        <!-- Mobile Toggle -->
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <span style="color:#fff; font-size:1.3rem;"><i class="bi bi-list"></i></span>
        </button>

        <!-- Nav Items -->
        <div class="collapse navbar-collapse" id="mainNav">

            <!-- Search Bar -->
            <div class="search-bar me-auto ms-2 my-2 my-lg-0">
                <i class="bi bi-search search-icon"></i>
                <input type="text" placeholder="Tìm laptop, phụ kiện...">
            </div>

            <!-- Nav Links -->
            <ul class="navbar-nav align-items-lg-center gap-1 me-3">
                <li class="nav-item">
                    <a class="nav-link active" href="/"><i class="bi bi-house"></i> Trang chủ</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                        <i class="bi bi-grid"></i> Sản phẩm
                    </a>
                    <ul class="dropdown-menu border-0 shadow">
                        <li><a class="dropdown-item" href="#"><i class="bi bi-laptop me-2 text-primary"></i>Laptop Gaming</a></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-laptop me-2 text-success"></i>Laptop Văn phòng</a></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-laptop me-2 text-info"></i>Laptop Đồ họa</a></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-pc-display me-2 text-warning"></i>Máy tính bàn</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-tag me-2 text-danger"></i>Hàng giảm giá</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="bi bi-cpu"></i> Cấu hình</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="bi bi-headset"></i> Hỗ trợ</a>
                </li>
            </ul>

            <!-- Cart & Login -->
            <div class="d-flex align-items-center gap-3">
                <a href="#" class="cart-badge text-white text-decoration-none">
                    <i class="bi bi-cart3 fs-5"></i>
                    <span class="badge">3</span>
                </a>

                <c:choose>
                    <c:when test="${pageContext.request.userPrincipal != null}">
                        <div class="dropdown">
                            <button class="btn-login dropdown-toggle border-0 d-flex align-items-center gap-2" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.avatar}">
                                        <img src="/images/avatar/${sessionScope.avatar}"
                                             style="width:28px;height:28px;border-radius:50%;object-fit:cover;border:2px solid rgba(255,255,255,0.4);"
                                             alt="avatar"/>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="width:28px;height:28px;border-radius:50%;background:rgba(255,255,255,0.25);display:inline-flex;align-items:center;justify-content:center;font-size:.75rem;font-weight:700;">
                                            ${fn:substring(sessionScope.fullName, 0, 1)}
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                                ${sessionScope.fullName}
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end border-0 shadow">
                                <li><a class="dropdown-item" href="/account"><i class="bi bi-person me-2"></i>Thông tin tài khoản</a></li>
                                <li><a class="dropdown-item" href="/orders"><i class="bi bi-box-seam me-2"></i>Lịch sử mua hàng</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <form method="POST" action="/logout" class="m-0">
                                        <button type="submit" class="dropdown-item text-danger">
                                            <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                        </button>
                                    </form>
                                </li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="/login" class="btn-login">
                            <i class="bi bi-person-circle me-1"></i> Đăng nhập
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </div>
</nav>
