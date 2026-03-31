<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Thông tin giao hàng - LaptopShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="/css/client.css" rel="stylesheet"/>
    <style>
        body { background: #f8f9fa; }

        /* Steps */
        .checkout-steps { background:#fff; border-bottom:1px solid #eee; padding:1.2rem 0; }
        .step-list { display:flex; align-items:center; gap:0; justify-content:center; }
        .step-item { display:flex; align-items:center; gap:.5rem; font-size:.82rem; color:#aaa; font-weight:500; }
        .step-item.active { color:var(--highlight); }
        .step-item.done   { color:#28a745; }
        .step-num {
            width:28px; height:28px; border-radius:50%;
            border:2px solid #ddd; display:flex; align-items:center;
            justify-content:center; font-size:.75rem; font-weight:700;
            background:#fff; flex-shrink:0;
        }
        .step-item.active .step-num { border-color:var(--highlight); color:var(--highlight); }
        .step-item.done   .step-num { border-color:#28a745; background:#28a745; color:#fff; }
        .step-divider { width:48px; height:2px; background:#eee; margin:0 .5rem; }
        .step-divider.done { background:#28a745; }

        /* Layout */
        .checkout-wrap { max-width:960px; margin:2rem auto; padding:0 1rem 4rem; }

        /* Card */
        .ck-card {
            background:#fff; border-radius:14px;
            box-shadow:0 2px 16px rgba(0,0,0,.07);
            padding:1.8rem; margin-bottom:1.2rem;
        }
        .ck-card h5 {
            font-size:1rem; font-weight:700; color:var(--primary);
            margin-bottom:1.4rem; padding-bottom:.7rem;
            border-bottom:1px solid #f0f0f0;
            display:flex; align-items:center; gap:.5rem;
        }

        /* Form */
        .form-label { font-size:.85rem; font-weight:600; color:#444; }
        .form-control, .form-select {
            border-radius:8px; border:1.5px solid #e5e7eb;
            font-size:.9rem; padding:.6rem .9rem;
        }
        .form-control:focus, .form-select:focus {
            border-color:var(--highlight); box-shadow:0 0 0 3px rgba(233,69,96,.1);
        }

        /* Payment method cards */
        .payment-cards { display:flex; flex-direction:column; gap:.7rem; }
        .payment-card {
            border:2px solid #e5e7eb; border-radius:10px;
            padding:.9rem 1.1rem; cursor:pointer;
            display:flex; align-items:center; gap:1rem;
            transition:all .2s;
        }
        .payment-card:hover { border-color:#ccc; }
        .payment-card input[type=radio] { display:none; }
        .payment-card.selected { border-color:var(--highlight); background:#fff5f7; }
        .payment-card .pm-icon {
            width:44px; height:44px; border-radius:10px;
            display:flex; align-items:center; justify-content:center;
            font-size:1.3rem; flex-shrink:0;
        }
        .pm-bank  { background:#e8f4fd; color:#2196F3; }
        .pm-momo  { background:#ffe0f0; color:#ae2d68; }
        .pm-cod   { background:#e8f5e9; color:#2e7d32; }
        .payment-card .pm-info { flex:1; }
        .payment-card .pm-name { font-weight:700; font-size:.9rem; color:var(--primary); }
        .payment-card .pm-desc { font-size:.78rem; color:#888; margin-top:.1rem; }

        /* Order summary sidebar */
        .order-summary { background:#fff; border-radius:14px; box-shadow:0 2px 16px rgba(0,0,0,.07); overflow:hidden; }
        .order-summary .summary-head {
            background:var(--primary); color:#fff;
            padding:1rem 1.4rem; font-size:.92rem; font-weight:700;
        }
        .order-summary .summary-body { padding:1.2rem 1.4rem; }
        .summary-item { display:flex; align-items:center; gap:.8rem; padding:.6rem 0; border-bottom:1px solid #f5f5f5; }
        .summary-item img { width:44px; height:44px; object-fit:contain; border-radius:6px; background:#f8f9fa; }
        .summary-item .si-name { font-size:.82rem; font-weight:600; color:var(--primary); flex:1; }
        .summary-item .si-qty  { font-size:.78rem; color:#aaa; }
        .summary-item .si-price{ font-size:.85rem; font-weight:700; color:var(--highlight); white-space:nowrap; }
        .summary-total { display:flex; justify-content:space-between; align-items:center; margin-top:1rem; padding-top:.8rem; border-top:2px solid #f0f0f0; }
        .summary-total .label { font-weight:700; font-size:.95rem; }
        .summary-total .amount { font-size:1.3rem; font-weight:800; color:var(--highlight); }

        .btn-place-order {
            width:100%; background:var(--highlight); color:#fff; border:none;
            padding:.85rem; border-radius:10px; font-size:1rem; font-weight:700;
            transition:all .3s; margin-top:1.2rem;
        }
        .btn-place-order:hover { background:#c73652; transform:translateY(-1px); box-shadow:0 6px 20px rgba(233,69,96,.35); }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/view/client/header.jsp" %>

<!-- Steps -->
<div class="checkout-steps">
    <div class="container">
        <div class="step-list">
            <div class="step-item done">
                <div class="step-num"><i class="bi bi-check-lg"></i></div>
                <span>Giỏ hàng</span>
            </div>
            <div class="step-divider done"></div>
            <div class="step-item active">
                <div class="step-num">2</div>
                <span>Thông tin giao hàng</span>
            </div>
            <div class="step-divider"></div>
            <div class="step-item">
                <div class="step-num">3</div>
                <span>Thanh toán</span>
            </div>
            <div class="step-divider"></div>
            <div class="step-item">
                <div class="step-num">4</div>
                <span>Hoàn thành</span>
            </div>
        </div>
    </div>
</div>

<div class="checkout-wrap">
    <form method="POST" action="/checkout" id="checkoutForm">

        <div class="row g-4">
            <!-- LEFT -->
            <div class="col-lg-7">

                <!-- Thông tin người nhận -->
                <div class="ck-card">
                    <h5><i class="bi bi-person-lines-fill text-highlight"></i> Thông tin người nhận</h5>
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" name="receiverName" class="form-control"
                                   value="${user.fullName}" required placeholder="Nguyễn Văn A"/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                            <input type="tel" name="receiverPhone" class="form-control"
                                   value="${user.phone}" required placeholder="0901 234 567"/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" value="${user.email}" disabled/>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Địa chỉ giao hàng <span class="text-danger">*</span></label>
                            <input type="text" name="receiverAddress" class="form-control"
                                   value="${user.address}" required placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố"/>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Ghi chú cho người giao hàng</label>
                            <textarea name="note" class="form-control" rows="2"
                                      placeholder="Giao giờ hành chính, gọi trước 30 phút..."></textarea>
                        </div>
                    </div>
                </div>

                <!-- Phương thức thanh toán -->
                <div class="ck-card">
                    <h5><i class="bi bi-credit-card-2-front text-highlight"></i> Phương thức thanh toán</h5>
                    <div class="payment-cards" id="paymentCards">

                        <label class="payment-card selected" id="card-BANK_TRANSFER">
                            <input type="radio" name="paymentMethod" value="BANK_TRANSFER" checked/>
                            <div class="pm-icon pm-bank"><i class="bi bi-bank2"></i></div>
                            <div class="pm-info">
                                <div class="pm-name">Chuyển khoản ngân hàng</div>
                                <div class="pm-desc">Quét QR VietQR — tiền về ngay, xử lý đơn nhanh nhất</div>
                            </div>
                            <i class="bi bi-check-circle-fill text-highlight fs-5"></i>
                        </label>

                        <label class="payment-card" id="card-MOMO">
                            <input type="radio" name="paymentMethod" value="MOMO"/>
                            <div class="pm-icon pm-momo">
                                <i class="bi bi-wallet2"></i>
                            </div>
                            <div class="pm-info">
                                <div class="pm-name">Ví MoMo</div>
                                <div class="pm-desc">Chuyển MoMo qua số điện thoại</div>
                            </div>
                            <i class="bi bi-circle text-muted fs-5" id="check-MOMO"></i>
                        </label>

                        <label class="payment-card" id="card-COD">
                            <input type="radio" name="paymentMethod" value="COD"/>
                            <div class="pm-icon pm-cod"><i class="bi bi-cash-coin"></i></div>
                            <div class="pm-info">
                                <div class="pm-name">Thanh toán khi nhận hàng (COD)</div>
                                <div class="pm-desc">Trả tiền mặt khi nhận hàng tại nhà</div>
                            </div>
                            <i class="bi bi-circle text-muted fs-5" id="check-COD"></i>
                        </label>

                    </div>
                </div>

            </div>

            <!-- RIGHT: Order summary -->
            <div class="col-lg-5">
                <div class="order-summary" style="position:sticky;top:90px;">
                    <div class="summary-head">
                        <i class="bi bi-receipt me-2"></i>Đơn hàng của bạn
                    </div>
                    <div class="summary-body">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="summary-item">
                                <c:choose>
                                    <c:when test="${not empty item.product.image}">
                                        <img src="/images/product/${item.product.image}" alt="${item.product.name}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <div style="width:44px;height:44px;background:#f4f6fb;border-radius:6px;display:flex;align-items:center;justify-content:center;color:#ccc;font-size:1.2rem;flex-shrink:0;">
                                            <i class="bi bi-laptop"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="si-name">
                                    ${item.product.name}
                                    <div class="si-qty">x${item.quantity}</div>
                                </div>
                                <div class="si-price">
                                    <fmt:formatNumber value="${item.product.price * item.quantity}"
                                                      type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                                </div>
                            </div>
                        </c:forEach>

                        <div class="d-flex justify-content-between mt-3" style="font-size:.85rem;color:#666;">
                            <span>Tạm tính</span>
                            <span><fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ</span>
                        </div>
                        <div class="d-flex justify-content-between mt-1" style="font-size:.85rem;color:#666;">
                            <span>Phí giao hàng</span>
                            <span class="text-success fw-600">Miễn phí</span>
                        </div>

                        <div class="summary-total">
                            <span class="label">Tổng cộng</span>
                            <span class="amount">
                                <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                            </span>
                        </div>

                        <button type="submit" class="btn-place-order">
                            <i class="bi bi-lock-fill me-2"></i>Xác nhận đặt hàng
                        </button>

                        <div class="d-flex align-items-center justify-content-center gap-2 mt-2" style="font-size:.75rem;color:#aaa;">
                            <i class="bi bi-shield-check"></i> Thanh toán bảo mật SSL
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/view/client/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Highlight payment card khi chọn
    document.querySelectorAll('.payment-card').forEach(function(card) {
        card.addEventListener('click', function() {
            document.querySelectorAll('.payment-card').forEach(function(c) {
                c.classList.remove('selected');
                var ico = c.querySelector('i.fs-5');
                if (ico) { ico.className = 'bi bi-circle text-muted fs-5'; }
            });
            this.classList.add('selected');
            var ico = this.querySelector('i.fs-5');
            if (ico) { ico.className = 'bi bi-check-circle-fill text-highlight fs-5'; }
        });
    });
</script>
</body>
</html>
