<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Đặt hàng thành công - LaptopShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="/css/client.css" rel="stylesheet"/>
    <style>
        body { background:#f8f9fa; }

        /* Steps */
        .checkout-steps { background:#fff; border-bottom:1px solid #eee; padding:1.2rem 0; }
        .step-list { display:flex; align-items:center; gap:0; justify-content:center; }
        .step-item { display:flex; align-items:center; gap:.5rem; font-size:.82rem; color:#aaa; font-weight:500; }
        .step-item.done   { color:#28a745; }
        .step-num { width:28px;height:28px;border-radius:50%;border:2px solid #ddd;display:flex;align-items:center;justify-content:center;font-size:.75rem;font-weight:700;background:#fff;flex-shrink:0; }
        .step-item.done   .step-num { border-color:#28a745; background:#28a745; color:#fff; }
        .step-divider { width:48px;height:2px;background:#eee;margin:0 .5rem; }
        .step-divider.done { background:#28a745; }

        .success-wrap { max-width:680px; margin:2.5rem auto; padding:0 1rem 4rem; }

        /* Hero */
        .success-hero {
            background:#fff; border-radius:16px;
            box-shadow:0 2px 20px rgba(0,0,0,.07);
            padding:3rem 2rem; text-align:center; margin-bottom:1.2rem;
        }
        .success-icon {
            width:80px; height:80px; background:#e8f5e9; border-radius:50%;
            display:flex; align-items:center; justify-content:center;
            font-size:2.5rem; color:#28a745; margin:0 auto 1.2rem;
            animation: popIn .5s cubic-bezier(.175,.885,.32,1.275) both;
        }
        @keyframes popIn {
            from { transform:scale(0); opacity:0; }
            to   { transform:scale(1); opacity:1; }
        }
        .success-title { font-size:1.6rem; font-weight:800; color:var(--primary); margin-bottom:.4rem; }
        .success-subtitle { color:#888; font-size:.92rem; }
        .order-code-badge {
            display:inline-block; background:#f0fdf4; border:1.5px solid #86efac;
            color:#16a34a; border-radius:20px; padding:.35rem 1.2rem;
            font-weight:700; font-size:.95rem; margin:1rem 0;
            letter-spacing:.5px;
        }

        /* Status badge */
        .status-badge {
            display:inline-flex; align-items:center; gap:.4rem;
            padding:.35rem 1rem; border-radius:20px; font-size:.8rem; font-weight:700;
        }
        .status-PENDING_PAYMENT { background:#fff9c4; color:#f59e0b; }
        .status-PROCESSING       { background:#dcfce7; color:#16a34a; }

        /* Detail card */
        .detail-card {
            background:#fff; border-radius:14px;
            box-shadow:0 2px 16px rgba(0,0,0,.07);
            overflow:hidden; margin-bottom:1.2rem;
        }
        .detail-card .dc-head {
            background:var(--primary); color:#fff;
            padding:.9rem 1.4rem; font-size:.9rem; font-weight:700;
            display:flex; align-items:center; gap:.5rem;
        }
        .detail-card .dc-body { padding:1.2rem 1.4rem; }

        /* Info rows */
        .info-row { display:flex; gap:.6rem; padding:.5rem 0; border-bottom:1px solid #f5f5f5; font-size:.88rem; }
        .info-row:last-child { border:none; }
        .info-row .ir-label { color:#888; min-width:130px; flex-shrink:0; }
        .info-row .ir-val { font-weight:600; color:var(--primary); }

        /* Items */
        .order-item { display:flex; align-items:center; gap:.9rem; padding:.7rem 0; border-bottom:1px solid #f5f5f5; }
        .order-item:last-child { border:none; }
        .order-item img { width:52px; height:52px; object-fit:contain; border-radius:8px; background:#f8f9fa; }
        .order-item .oi-name { font-size:.88rem; font-weight:600; color:var(--primary); flex:1; }
        .order-item .oi-qty  { font-size:.8rem; color:#aaa; }
        .order-item .oi-price{ font-size:.9rem; font-weight:700; color:var(--highlight); white-space:nowrap; }

        /* Total */
        .total-row { display:flex; justify-content:space-between; align-items:center; padding:.5rem 0; font-size:.88rem; }
        .total-final { font-size:1.2rem; font-weight:800; color:var(--highlight); }

        /* Actions */
        .btn-continue {
            background:var(--highlight); color:#fff; border:none;
            padding:.75rem 2rem; border-radius:30px; font-weight:700;
            font-size:.95rem; text-decoration:none; transition:all .3s;
            display:inline-block;
        }
        .btn-continue:hover { background:#c73652; color:#fff; transform:translateY(-1px); }
        .btn-outline-orders {
            background:transparent; border:2px solid var(--primary); color:var(--primary);
            padding:.7rem 2rem; border-radius:30px; font-weight:600;
            font-size:.92rem; text-decoration:none; transition:all .3s;
            display:inline-block;
        }
        .btn-outline-orders:hover { background:var(--primary); color:#fff; }

        /* Payment method label */
        .pm-label { font-size:.82rem; color:#666; }
        .pm-label i { margin-right:.3rem; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/view/client/header.jsp" %>

<!-- Steps — tất cả done -->
<div class="checkout-steps">
    <div class="container">
        <div class="step-list">
            <div class="step-item done"><div class="step-num"><i class="bi bi-check-lg"></i></div><span>Giỏ hàng</span></div>
            <div class="step-divider done"></div>
            <div class="step-item done"><div class="step-num"><i class="bi bi-check-lg"></i></div><span>Thông tin giao hàng</span></div>
            <div class="step-divider done"></div>
            <div class="step-item done"><div class="step-num"><i class="bi bi-check-lg"></i></div><span>Thanh toán</span></div>
            <div class="step-divider done"></div>
            <div class="step-item done"><div class="step-num"><i class="bi bi-check-lg"></i></div><span>Hoàn thành</span></div>
        </div>
    </div>
</div>

<div class="success-wrap">

    <!-- Hero -->
    <div class="success-hero">
        <div class="success-icon"><i class="bi bi-check-lg"></i></div>
        <div class="success-title">Đặt hàng thành công!</div>
        <div class="success-subtitle">Cảm ơn bạn đã tin tưởng LaptopShop 🎉</div>
        <div class="order-code-badge">${order.orderCode}</div>

        <div>
            <c:choose>
                <c:when test="${order.status == 'PENDING_PAYMENT'}">
                    <span class="status-badge status-PENDING_PAYMENT">
                        <i class="bi bi-clock-history"></i> Chờ xác nhận thanh toán
                    </span>
                    <div style="font-size:.82rem;color:#888;margin-top:.6rem;">
                        Chúng tôi sẽ xác nhận đơn hàng sau khi nhận được thanh toán của bạn.
                    </div>
                </c:when>
                <c:otherwise>
                    <span class="status-badge status-PROCESSING">
                        <i class="bi bi-box-seam"></i> Đang xử lý đơn hàng
                    </span>
                    <div style="font-size:.82rem;color:#888;margin-top:.6rem;">
                        Đơn hàng đang được chuẩn bị và sẽ được giao trong 1–3 ngày làm việc.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Thông tin giao hàng -->
    <div class="detail-card">
        <div class="dc-head"><i class="bi bi-geo-alt-fill"></i> Thông tin giao hàng</div>
        <div class="dc-body">
            <div class="info-row">
                <span class="ir-label">Người nhận</span>
                <span class="ir-val">${order.receiverName}</span>
            </div>
            <div class="info-row">
                <span class="ir-label">Số điện thoại</span>
                <span class="ir-val">${order.receiverPhone}</span>
            </div>
            <div class="info-row">
                <span class="ir-label">Địa chỉ giao</span>
                <span class="ir-val">${order.receiverAddress}</span>
            </div>
            <c:if test="${not empty order.note}">
            <div class="info-row">
                <span class="ir-label">Ghi chú</span>
                <span class="ir-val">${order.note}</span>
            </div>
            </c:if>
            <div class="info-row">
                <span class="ir-label">Phương thức</span>
                <span class="ir-val">
                    <c:choose>
                        <c:when test="${order.paymentMethod == 'BANK_TRANSFER'}">
                            <i class="bi bi-bank2 text-primary"></i> Chuyển khoản ngân hàng
                        </c:when>
                        <c:when test="${order.paymentMethod == 'MOMO'}">
                            <i class="bi bi-wallet2" style="color:#ae2d68"></i> Ví MoMo
                        </c:when>
                        <c:otherwise>
                            <i class="bi bi-cash-coin text-success"></i> Thanh toán khi nhận hàng
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>
    </div>

    <!-- Danh sách sản phẩm -->
    <div class="detail-card">
        <div class="dc-head"><i class="bi bi-bag-check"></i> Sản phẩm đặt mua</div>
        <div class="dc-body">
            <c:forEach var="detail" items="${order.orderDetails}">
                <div class="order-item">
                    <c:choose>
                        <c:when test="${not empty detail.product.image}">
                            <img src="/images/product/${detail.product.image}" alt="${detail.product.name}"/>
                        </c:when>
                        <c:otherwise>
                            <div style="width:52px;height:52px;background:#f4f6fb;border-radius:8px;display:flex;align-items:center;justify-content:center;color:#ccc;font-size:1.4rem;flex-shrink:0;">
                                <i class="bi bi-laptop"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="oi-name">
                        ${detail.product.name}
                        <div class="oi-qty">x${detail.quantity}</div>
                    </div>
                    <div class="oi-price">
                        <fmt:formatNumber value="${detail.price * detail.quantity}"
                                          type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                    </div>
                </div>
            </c:forEach>

            <div class="total-row mt-2" style="font-size:.85rem;color:#666;">
                <span>Tạm tính</span>
                <span><fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ</span>
            </div>
            <div class="total-row" style="font-size:.85rem;color:#28a745;">
                <span>Phí giao hàng</span>
                <span>Miễn phí</span>
            </div>
            <div class="total-row pt-2" style="border-top:2px solid #f0f0f0;">
                <span style="font-weight:700;">Tổng cộng</span>
                <span class="total-final">
                    <fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                </span>
            </div>
        </div>
    </div>

    <!-- Actions -->
    <div class="d-flex gap-3 flex-wrap justify-content-center mt-2">
        <a href="/" class="btn-continue">
            <i class="bi bi-house me-1"></i> Tiếp tục mua sắm
        </a>
        <a href="/orders" class="btn-outline-orders">
            <i class="bi bi-box-seam me-1"></i> Xem đơn hàng của tôi
        </a>
    </div>

</div>

<%@ include file="/WEB-INF/view/client/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
