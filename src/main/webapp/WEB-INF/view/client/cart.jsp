<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Giỏ hàng - LaptopShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="/css/client.css" rel="stylesheet"/>
    <style>
        /* =============================================
           CART PAGE STYLES
           ============================================= */

        /* Breadcrumb */
        .cart-breadcrumb {
            background: #fff;
            border-bottom: 1px solid #eee;
            padding: 0.8rem 0;
        }

        .cart-breadcrumb .breadcrumb {
            margin: 0;
            font-size: 0.85rem;
        }

        .cart-breadcrumb .breadcrumb-item a {
            color: var(--accent);
            text-decoration: none;
        }

        .cart-breadcrumb .breadcrumb-item a:hover {
            color: var(--highlight);
        }

        /* Progress Steps */
        .cart-steps {
            background: #fff;
            border-bottom: 1px solid #eee;
            padding: 1.2rem 0;
        }

        .step-list {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0;
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .step-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            position: relative;
        }

        .step-item + .step-item::before {
            content: '';
            width: 60px;
            height: 2px;
            background: #dee2e6;
            margin: 0 0.8rem;
        }

        .step-item.active + .step-item::before,
        .step-item.done + .step-item::before {
            background: var(--highlight);
        }

        .step-circle {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            border: 2px solid #dee2e6;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: 700;
            background: #fff;
            color: #aaa;
            flex-shrink: 0;
            transition: var(--transition);
        }

        .step-item.done .step-circle {
            background: var(--highlight);
            border-color: var(--highlight);
            color: #fff;
        }

        .step-item.active .step-circle {
            background: var(--primary);
            border-color: var(--primary);
            color: #fff;
            box-shadow: 0 0 0 4px rgba(26,26,46,0.12);
        }

        .step-label {
            font-size: 0.82rem;
            font-weight: 600;
            color: #aaa;
        }

        .step-item.active .step-label { color: var(--primary); }
        .step-item.done .step-label  { color: var(--highlight); }

        /* Main Layout */
        .cart-wrapper {
            padding: 2rem 0 4rem;
            background: #f8f9fa;
            min-height: 60vh;
        }

        /* ---- Cart Table Card ---- */
        .cart-card {
            background: #fff;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .cart-card-header {
            padding: 1.2rem 1.5rem;
            border-bottom: 1px solid #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .cart-card-header h5 {
            font-size: 1rem;
            font-weight: 700;
            color: var(--primary);
            margin: 0;
        }

        .btn-clear-cart {
            font-size: 0.82rem;
            color: #dc3545;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.3rem;
            transition: var(--transition);
        }

        .btn-clear-cart:hover {
            color: #a71d2a;
        }

        /* Cart Item Row */
        .cart-item {
            display: flex;
            align-items: center;
            gap: 1.2rem;
            padding: 1.2rem 1.5rem;
            border-bottom: 1px solid #f5f5f5;
            transition: var(--transition);
        }

        .cart-item:last-child { border-bottom: none; }

        .cart-item:hover { background: #fafafa; }

        .cart-item-check input[type="checkbox"] {
            width: 17px;
            height: 17px;
            cursor: pointer;
            accent-color: var(--highlight);
        }

        .cart-item-img {
            width: 90px;
            height: 75px;
            object-fit: contain;
            border-radius: 8px;
            background: #f8f9fa;
            padding: 6px;
            flex-shrink: 0;
        }

        .cart-item-info { flex: 1; min-width: 0; }

        .cart-item-brand {
            font-size: 0.72rem;
            font-weight: 700;
            text-transform: uppercase;
            color: var(--text-muted);
            letter-spacing: 0.5px;
        }

        .cart-item-name {
            font-size: 0.92rem;
            font-weight: 700;
            color: var(--primary);
            margin: 0.2rem 0 0.4rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            line-height: 1.4;
        }

        .cart-item-name a {
            color: inherit;
            text-decoration: none;
        }

        .cart-item-name a:hover { color: var(--highlight); }

        .cart-item-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 4px;
        }

        .cart-item-tag {
            background: #f0f4ff;
            color: var(--accent);
            font-size: 0.68rem;
            padding: 2px 7px;
            border-radius: 10px;
            font-weight: 500;
        }

        /* Qty control */
        .qty-control {
            display: flex;
            align-items: center;
            border: 1.5px solid #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
            width: fit-content;
        }

        .qty-btn {
            background: #f5f5f5;
            border: none;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
            color: #555;
            cursor: pointer;
            transition: var(--transition);
            flex-shrink: 0;
        }

        .qty-btn:hover { background: var(--highlight); color: #fff; }
        .qty-btn:disabled { opacity: 0.4; cursor: not-allowed; }

        .qty-input {
            width: 40px;
            height: 32px;
            border: none;
            text-align: center;
            font-size: 0.88rem;
            font-weight: 700;
            color: var(--primary);
            background: #fff;
            outline: none;
        }

        /* Price col */
        .cart-item-price {
            text-align: right;
            flex-shrink: 0;
            min-width: 110px;
        }

        .cart-item-price .price-unit {
            font-size: 0.75rem;
            color: var(--text-muted);
            text-decoration: line-through;
        }

        .cart-item-price .price-current {
            font-size: 1.05rem;
            font-weight: 800;
            color: var(--highlight);
            line-height: 1.2;
        }

        .cart-item-price .price-subtotal {
            font-size: 0.75rem;
            color: var(--text-muted);
            margin-top: 2px;
        }

        /* Delete btn */
        .btn-delete-item {
            background: none;
            border: none;
            color: #ccc;
            font-size: 1rem;
            cursor: pointer;
            padding: 4px;
            border-radius: 6px;
            transition: var(--transition);
            flex-shrink: 0;
        }

        .btn-delete-item:hover { color: #dc3545; background: #fff5f5; }

        /* Select all bar */
        .cart-select-all {
            padding: 0.8rem 1.5rem;
            background: #f8f9fa;
            border-top: 1px solid #eee;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 0.8rem;
        }

        .cart-select-all label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--primary);
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Continue shopping */
        .btn-continue {
            font-size: 0.85rem;
            color: var(--accent);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            transition: var(--transition);
            font-weight: 600;
        }

        .btn-continue:hover { color: var(--highlight); }

        /* ---- Order Summary Card ---- */
        .summary-card {
            background: #fff;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            position: sticky;
            top: 80px;
        }

        .summary-card-header {
            padding: 1.2rem 1.5rem;
            border-bottom: 1px solid #f0f0f0;
        }

        .summary-card-header h5 {
            font-size: 1rem;
            font-weight: 700;
            color: var(--primary);
            margin: 0;
        }

        .summary-body { padding: 1.5rem; }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.88rem;
            color: #555;
            margin-bottom: 0.85rem;
        }

        .summary-row .label { color: #777; }
        .summary-row .value { font-weight: 600; color: var(--primary); }
        .summary-row .value.discount { color: #28a745; }
        .summary-row .value.free {
            color: #28a745;
            font-weight: 700;
        }

        .summary-divider {
            border: none;
            border-top: 1px dashed #e0e0e0;
            margin: 1rem 0;
        }

        .summary-total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .summary-total-row .total-label {
            font-size: 0.95rem;
            font-weight: 700;
            color: var(--primary);
        }

        .summary-total-row .total-price {
            font-size: 1.5rem;
            font-weight: 900;
            color: var(--highlight);
            letter-spacing: -0.5px;
        }

        .summary-vat {
            font-size: 0.75rem;
            color: var(--text-muted);
            text-align: right;
            margin-top: 2px;
        }

        /* Coupon */
        .coupon-wrap {
            margin: 1rem 0;
        }

        .coupon-wrap .input-group input {
            border-radius: 8px 0 0 8px;
            border: 1.5px solid #e0e0e0;
            border-right: none;
            font-size: 0.85rem;
            padding: 0.5rem 0.9rem;
        }

        .coupon-wrap .input-group input:focus {
            outline: none;
            box-shadow: none;
            border-color: var(--accent);
        }

        .coupon-wrap .btn-apply {
            background: var(--primary);
            color: #fff;
            border: none;
            border-radius: 0 8px 8px 0;
            font-size: 0.82rem;
            font-weight: 700;
            padding: 0 1rem;
            transition: var(--transition);
            white-space: nowrap;
        }

        .coupon-wrap .btn-apply:hover { background: var(--highlight); }

        /* Checkout button */
        .btn-checkout {
            background: var(--highlight);
            color: #fff;
            border: none;
            border-radius: 10px;
            padding: 0.85rem;
            font-size: 1rem;
            font-weight: 700;
            width: 100%;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            text-decoration: none;
        }

        .btn-checkout:hover {
            background: #c73652;
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(233,69,96,0.35);
        }

        /* Trust badges */
        .trust-badges {
            display: flex;
            flex-direction: column;
            gap: 0.6rem;
            margin-top: 1.2rem;
            padding-top: 1.2rem;
            border-top: 1px solid #f0f0f0;
        }

        .trust-badge-item {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            font-size: 0.8rem;
            color: #666;
        }

        .trust-badge-item i {
            color: #28a745;
            font-size: 0.9rem;
            flex-shrink: 0;
        }

        /* ---- You May Also Like ---- */
        .suggest-section {
            margin-top: 2rem;
        }

        .suggest-card {
            background: #fff;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .suggest-card-header {
            padding: 1.2rem 1.5rem;
            border-bottom: 1px solid #f0f0f0;
        }

        .suggest-card-header h5 {
            font-size: 1rem;
            font-weight: 700;
            color: var(--primary);
            margin: 0;
        }

        .suggest-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #f5f5f5;
            transition: var(--transition);
        }

        .suggest-item:last-child { border-bottom: none; }
        .suggest-item:hover { background: #fafafa; }

        .suggest-item img {
            width: 65px;
            height: 55px;
            object-fit: contain;
            background: #f8f9fa;
            border-radius: 8px;
            padding: 4px;
            flex-shrink: 0;
        }

        .suggest-item-info { flex: 1; min-width: 0; }

        .suggest-item-name {
            font-size: 0.83rem;
            font-weight: 700;
            color: var(--primary);
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            line-height: 1.4;
        }

        .suggest-item-price {
            font-size: 0.9rem;
            font-weight: 800;
            color: var(--highlight);
            margin-top: 0.2rem;
        }

        .btn-suggest-add {
            background: var(--primary);
            color: #fff;
            border: none;
            border-radius: 7px;
            padding: 0.35rem 0.75rem;
            font-size: 0.78rem;
            font-weight: 600;
            transition: var(--transition);
            white-space: nowrap;
            flex-shrink: 0;
        }

        .btn-suggest-add:hover { background: var(--highlight); color: #fff; }

        /* ---- Empty Cart ---- */
        .empty-cart-wrap {
            text-align: center;
            padding: 4rem 2rem;
        }

        .empty-cart-icon {
            font-size: 5rem;
            color: #dee2e6;
            margin-bottom: 1.2rem;
            display: block;
        }

        .empty-cart-wrap h4 {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 0.6rem;
        }

        .empty-cart-wrap p {
            color: var(--text-muted);
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
        }

        .btn-go-shop {
            background: var(--highlight);
            color: #fff;
            border: none;
            border-radius: 25px;
            padding: 0.65rem 2rem;
            font-weight: 700;
            font-size: 0.92rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: var(--transition);
        }

        .btn-go-shop:hover {
            background: #c73652;
            color: #fff;
            transform: translateY(-2px);
        }

        /* Responsive tweaks */
        @media (max-width: 768px) {
            .cart-item { flex-wrap: wrap; }
            .cart-item-price { min-width: auto; }
            .step-label { display: none; }
            .step-item + .step-item::before { width: 30px; }
        }
    </style>
</head>
<body>

    <!-- ========== HEADER ========== -->
    <%@ include file="/WEB-INF/view/client/header.jsp" %>

    <!-- ========== BREADCRUMB ========== -->
    <div class="cart-breadcrumb">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/"><i class="bi bi-house me-1"></i>Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Giỏ hàng</li>
                </ol>
            </nav>
        </div>
    </div>

    <!-- ========== PROGRESS STEPS ========== -->
    <div class="cart-steps">
        <div class="container">
            <ul class="step-list">
                <li class="step-item active">
                    <div class="step-circle"><i class="bi bi-cart3"></i></div>
                    <span class="step-label">Giỏ hàng</span>
                </li>
                <li class="step-item">
                    <div class="step-circle">2</div>
                    <span class="step-label">Thông tin giao hàng</span>
                </li>
                <li class="step-item">
                    <div class="step-circle">3</div>
                    <span class="step-label">Thanh toán</span>
                </li>
                <li class="step-item">
                    <div class="step-circle">4</div>
                    <span class="step-label">Hoàn thành</span>
                </li>
            </ul>
        </div>
    </div>

    <!-- ========== MAIN CONTENT ========== -->
    <section class="cart-wrapper">
        <div class="container">

            <%-- Kiểm tra giỏ hàng rỗng --%>
            <c:choose>
                <c:when test="${empty cartItems}">

                    <!-- ===== EMPTY CART ===== -->
                    <div class="cart-card">
                        <div class="empty-cart-wrap">
                            <i class="bi bi-cart-x empty-cart-icon"></i>
                            <h4>Giỏ hàng của bạn đang trống</h4>
                            <p>Hãy thêm sản phẩm vào giỏ hàng để tiến hành mua sắm nhé!</p>
                            <a href="/" class="btn-go-shop">
                                <i class="bi bi-bag-heart"></i> Mua sắm ngay
                            </a>
                        </div>
                    </div>

                </c:when>
                <c:otherwise>

                    <div class="row g-4 align-items-start">

                        <!-- ==================== LEFT: CART ITEMS ==================== -->
                        <div class="col-lg-8">

                            <div class="cart-card">
                                <!-- Header -->
                                <div class="cart-card-header">
                                    <h5><i class="bi bi-cart3 me-2 text-highlight"></i>Giỏ hàng (<span id="totalItems">${fn:length(cartItems)}</span> sản phẩm)</h5>
                                    <form method="POST" action="/cart/clear" class="m-0">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <button type="submit" class="btn-clear-cart"
                                                onclick="return confirm('Xóa toàn bộ giỏ hàng?')">
                                            <i class="bi bi-trash3"></i> Xóa tất cả
                                        </button>
                                    </form>
                                </div>

                                <!-- Items -->
                                <c:forEach var="item" items="${cartItems}" varStatus="loop">
                                <div class="cart-item" id="cart-item-${item.id}">

                                    <!-- Checkbox -->
                                    <div class="cart-item-check">
                                        <input type="checkbox" class="item-check" value="${item.id}" checked />
                                    </div>

                                    <!-- Image -->
                                    <img src="/images/product/${item.product.image}"
                                         alt="${item.product.name}"
                                         class="cart-item-img"/>

                                    <!-- Info -->
                                    <div class="cart-item-info">
                                        <div class="cart-item-brand">${item.product.factory}</div>
                                        <div class="cart-item-name">
                                            <a href="/product/${item.product.id}">${item.product.name}</a>
                                        </div>
                                        <div class="cart-item-tags">
                                            <span class="cart-item-tag">Bảo hành 12 tháng</span>
                                            <span class="cart-item-tag">Chính hãng</span>
                                        </div>
                                    </div>

                                    <!-- Quantity -->
                                    <div class="qty-control">
                                        <button class="qty-btn qty-minus"
                                                data-id="${item.id}"
                                                <c:if test="${item.quantity <= 1}">disabled</c:if>>
                                            <i class="bi bi-dash"></i>
                                        </button>
                                        <input type="text" class="qty-input" value="${item.quantity}"
                                               data-id="${item.id}"
                                               data-price="${item.product.price}" readonly/>
                                        <button class="qty-btn qty-plus" data-id="${item.id}">
                                            <i class="bi bi-plus"></i>
                                        </button>
                                    </div>

                                    <!-- Price -->
                                    <div class="cart-item-price">
                                        <fmt:formatNumber value="${item.product.price * 1.1}" type="number" groupingUsed="true" maxFractionDigits="0" var="oldPrice"/>
                                        <span class="price-unit">${oldPrice}đ</span>
                                        <div class="price-current">
                                            <fmt:formatNumber value="${item.product.price}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                                        </div>
                                        <div class="price-subtotal" id="subtotal-${item.id}">
                                            x${item.quantity} = <fmt:formatNumber value="${item.product.price * item.quantity}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                                        </div>
                                    </div>

                                    <!-- Delete -->
                                    <form method="POST" action="/cart/delete/${item.id}" class="m-0">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <button type="submit" class="btn-delete-item" title="Xóa sản phẩm">
                                            <i class="bi bi-x-lg"></i>
                                        </button>
                                    </form>

                                </div>
                                </c:forEach>

                                <!-- Select All & Continue -->
                                <div class="cart-select-all">
                                    <label>
                                        <input type="checkbox" id="selectAll" checked />
                                        Chọn tất cả (${fn:length(cartItems)} sản phẩm)
                                    </label>
                                    <a href="/" class="btn-continue">
                                        <i class="bi bi-arrow-left"></i> Tiếp tục mua sắm
                                    </a>
                                </div>
                            </div>

                            <!-- ===== SUGGESTED PRODUCTS ===== -->
                            <c:if test="${not empty suggestedProducts}">
                            <div class="suggest-section">
                                <div class="suggest-card">
                                    <div class="suggest-card-header">
                                        <h5><i class="bi bi-lightning-charge-fill text-warning me-2"></i>Có thể bạn cũng thích</h5>
                                    </div>
                                    <c:forEach var="sp" items="${suggestedProducts}" begin="0" end="3">
                                    <div class="suggest-item">
                                        <img src="/images/product/${sp.image}" alt="${sp.name}"/>
                                        <div class="suggest-item-info">
                                            <div class="suggest-item-name">${sp.name}</div>
                                            <div class="suggest-item-price">
                                                <fmt:formatNumber value="${sp.price}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                                            </div>
                                        </div>
                                        <form method="POST" action="/cart/add/${sp.id}" class="m-0">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <button type="submit" class="btn-suggest-add">
                                                <i class="bi bi-cart-plus me-1"></i>Thêm
                                            </button>
                                        </form>
                                    </div>
                                    </c:forEach>
                                </div>
                            </div>
                            </c:if>

                        </div>

                        <!-- ==================== RIGHT: ORDER SUMMARY ==================== -->
                        <div class="col-lg-4">
                            <div class="summary-card">

                                <div class="summary-card-header">
                                    <h5><i class="bi bi-receipt me-2 text-highlight"></i>Tóm tắt đơn hàng</h5>
                                </div>

                                <div class="summary-body">

                                    <!-- Rows -->
                                    <div class="summary-row">
                                        <span class="label">Tạm tính (<span id="summaryCount">${fn:length(cartItems)}</span> sản phẩm)</span>
                                        <span class="value" id="summarySubtotal">
                                            <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                                        </span>
                                    </div>

                                    <div class="summary-row">
                                        <span class="label"><i class="bi bi-tag me-1 text-success"></i>Giảm giá</span>
                                        <span class="value discount">- 0đ</span>
                                    </div>

                                    <div class="summary-row">
                                        <span class="label"><i class="bi bi-truck me-1"></i>Phí vận chuyển</span>
                                        <span class="value free">Miễn phí</span>
                                    </div>

                                    <!-- Coupon -->
                                    <div class="coupon-wrap">
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="Nhập mã giảm giá..." id="couponInput"/>
                                            <button class="btn-apply" onclick="applyCoupon()">Áp dụng</button>
                                        </div>
                                        <div id="couponMsg" style="font-size:0.75rem; margin-top:0.4rem;"></div>
                                    </div>

                                    <hr class="summary-divider"/>

                                    <!-- Total -->
                                    <div class="summary-total-row">
                                        <span class="total-label">Tổng cộng</span>
                                        <div>
                                            <div class="total-price" id="summaryTotal">
                                                <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                                            </div>
                                            <div class="summary-vat">(Đã bao gồm VAT)</div>
                                        </div>
                                    </div>

                                    <!-- Savings badge -->
                                    <div class="mt-3 p-2 rounded-3 d-flex align-items-center gap-2"
                                         style="background:#fff8f0; border:1px solid #ffe0b2;">
                                        <i class="bi bi-piggy-bank-fill text-warning fs-5"></i>
                                        <span style="font-size:0.8rem; color:#e65100; font-weight:600;">
                                            Bạn tiết kiệm được <strong>0đ</strong> cho đơn hàng này
                                        </span>
                                    </div>

                                    <!-- Checkout button -->
                                    <a href="/checkout" class="btn-checkout mt-3">
                                        <i class="bi bi-lock-fill"></i> Tiến hành đặt hàng
                                    </a>

                                    <!-- Trust Badges -->
                                    <div class="trust-badges">
                                        <div class="trust-badge-item">
                                            <i class="bi bi-shield-check-fill"></i>
                                            <span>Thanh toán an toàn & bảo mật 100%</span>
                                        </div>
                                        <div class="trust-badge-item">
                                            <i class="bi bi-truck"></i>
                                            <span>Miễn phí giao hàng toàn quốc đơn từ 5 triệu</span>
                                        </div>
                                        <div class="trust-badge-item">
                                            <i class="bi bi-arrow-counterclockwise"></i>
                                            <span>Đổi trả miễn phí trong vòng 7 ngày</span>
                                        </div>
                                        <div class="trust-badge-item">
                                            <i class="bi bi-headset"></i>
                                            <span>Hỗ trợ 24/7 — Hotline: 1900 1234</span>
                                        </div>
                                    </div>

                                    <!-- Payment methods -->
                                    <div class="mt-3 text-center">
                                        <div style="font-size:0.75rem; color:var(--text-muted); margin-bottom:0.5rem;">Chấp nhận thanh toán</div>
                                        <div class="d-flex justify-content-center gap-2 flex-wrap">
                                            <span class="badge bg-light text-dark border fw-bold" style="font-size:0.75rem;">VISA</span>
                                            <span class="badge bg-light text-dark border fw-bold" style="font-size:0.75rem;">Mastercard</span>
                                            <span class="badge bg-light text-dark border fw-bold" style="font-size:0.75rem;">MoMo</span>
                                            <span class="badge bg-light text-dark border fw-bold" style="font-size:0.75rem;">ZaloPay</span>
                                            <span class="badge bg-light text-dark border fw-bold" style="font-size:0.75rem;">COD</span>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div><%-- end row --%>

                </c:otherwise>
            </c:choose>

        </div>
    </section>

    <!-- ========== FOOTER ========== -->
    <%@ include file="/WEB-INF/view/client/footer.jsp" %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script>
        /* =============================================
           CART PAGE SCRIPTS
           ============================================= */

        // ---- Select All ----
        $('#selectAll').on('change', function () {
            $('.item-check').prop('checked', $(this).is(':checked'));
        });

        $('.item-check').on('change', function () {
            const total = $('.item-check').length;
            const checked = $('.item-check:checked').length;
            $('#selectAll').prop('indeterminate', checked > 0 && checked < total);
            $('#selectAll').prop('checked', checked === total);
        });

        // ---- Quantity buttons ----
        function formatVND(num) {
            return num.toLocaleString('vi-VN') + 'đ';
        }

        $(document).on('click', '.qty-minus', function () {
            const id = $(this).data('id');
            const input = $('.qty-input[data-id="' + id + '"]');
            let val = parseInt(input.val());
            if (val > 1) {
                val--;
                input.val(val);
                $(this).prop('disabled', val <= 1);
                updateSubtotal(id, val, parseFloat(input.data('price')));
            }
        });

        $(document).on('click', '.qty-plus', function () {
            const id = $(this).data('id');
            const input = $('.qty-input[data-id="' + id + '"]');
            let val = parseInt(input.val()) + 1;
            input.val(val);
            $(this).siblings('.qty-minus').prop('disabled', false);
            updateSubtotal(id, val, parseFloat(input.data('price')));
        });

        function updateSubtotal(id, qty, price) {
            const subtotal = qty * price;
            $('#subtotal-' + id).html(
                'x' + qty + ' = ' + formatVND(subtotal)
            );
            recalcTotal();
        }

        function recalcTotal() {
            let total = 0;
            $('.qty-input').each(function () {
                const qty   = parseInt($(this).val());
                const price = parseFloat($(this).data('price'));
                total += qty * price;
            });
            $('#summaryTotal').text(formatVND(total));
            $('#summarySubtotal').text(formatVND(total));
        }

        // ---- Coupon ----
        const VALID_COUPONS = { 'LAPTOP10': 10, 'SAVE200K': 5 };

        function applyCoupon() {
            const code = $('#couponInput').val().trim().toUpperCase();
            const msgEl = $('#couponMsg');
            if (VALID_COUPONS[code]) {
                msgEl.html('<span style="color:#28a745;"><i class="bi bi-check-circle me-1"></i>Áp dụng mã <strong>' + code + '</strong> thành công! Giảm ' + VALID_COUPONS[code] + '%</span>');
            } else if (code === '') {
                msgEl.html('<span style="color:#dc3545;"><i class="bi bi-x-circle me-1"></i>Vui lòng nhập mã giảm giá.</span>');
            } else {
                msgEl.html('<span style="color:#dc3545;"><i class="bi bi-x-circle me-1"></i>Mã giảm giá không hợp lệ hoặc đã hết hạn.</span>');
            }
        }

        $('#couponInput').on('keypress', function (e) {
            if (e.which === 13) applyCoupon();
        });

        // ---- Suggest add-to-cart feedback ----
        $(document).on('click', '.btn-suggest-add', function (e) {
            const btn = $(this);
            const originalHtml = btn.html();
            btn.html('<i class="bi bi-check-lg me-1"></i>Đã thêm').css('background', '#28a745');
            setTimeout(function () {
                btn.html(originalHtml).css('background', '');
            }, 1500);
        });
    </script>

</body>
</html>
