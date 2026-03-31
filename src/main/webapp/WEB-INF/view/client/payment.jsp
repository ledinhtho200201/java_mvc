<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Thanh toán - LaptopShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="/css/client.css" rel="stylesheet"/>
    <style>
        body { background:#f8f9fa; }

        /* Steps */
        .checkout-steps { background:#fff; border-bottom:1px solid #eee; padding:1.2rem 0; }
        .step-list { display:flex; align-items:center; gap:0; justify-content:center; }
        .step-item { display:flex; align-items:center; gap:.5rem; font-size:.82rem; color:#aaa; font-weight:500; }
        .step-item.active { color:var(--highlight); }
        .step-item.done   { color:#28a745; }
        .step-num { width:28px;height:28px;border-radius:50%;border:2px solid #ddd;display:flex;align-items:center;justify-content:center;font-size:.75rem;font-weight:700;background:#fff;flex-shrink:0; }
        .step-item.active .step-num { border-color:var(--highlight); color:var(--highlight); }
        .step-item.done   .step-num { border-color:#28a745; background:#28a745; color:#fff; }
        .step-divider { width:48px;height:2px;background:#eee;margin:0 .5rem; }
        .step-divider.done { background:#28a745; }

        .payment-wrap { max-width:820px; margin:2rem auto; padding:0 1rem 4rem; }

        /* Order info box */
        .order-info-box {
            background:var(--primary); color:#fff;
            border-radius:14px; padding:1.4rem 1.8rem;
            margin-bottom:1.5rem;
        }
        .order-info-box .order-code { font-size:1.1rem; font-weight:800; letter-spacing:.5px; }
        .order-info-box .order-amount { font-size:2rem; font-weight:900; color:var(--highlight); }

        /* Method tabs */
        .method-tabs { display:flex; gap:.6rem; margin-bottom:1.5rem; }
        .method-tab {
            flex:1; padding:.7rem; border-radius:10px; border:2px solid #e5e7eb;
            text-align:center; cursor:pointer; font-weight:600; font-size:.85rem;
            color:#666; background:#fff; transition:all .2s;
        }
        .method-tab.active { border-color:var(--highlight); color:var(--highlight); background:#fff5f7; }
        .method-tab i { display:block; font-size:1.5rem; margin-bottom:.2rem; }

        /* Bank card */
        .bank-card {
            background:#fff; border-radius:14px;
            box-shadow:0 2px 16px rgba(0,0,0,.07);
            padding:2rem; text-align:center;
        }
        .bank-card .qr-wrap {
            display:inline-block; background:#fff;
            border:3px solid var(--primary); border-radius:14px;
            padding:.8rem; margin:1rem 0;
        }
        .bank-card .qr-wrap img { width:200px; height:200px; display:block; }
        .bank-info { background:#f8f9fa; border-radius:10px; padding:1.2rem 1.5rem; margin:1rem auto; max-width:400px; text-align:left; }
        .bank-row { display:flex; justify-content:space-between; align-items:center; padding:.45rem 0; border-bottom:1px solid #eee; font-size:.88rem; }
        .bank-row:last-child { border:none; }
        .bank-row .lbl { color:#888; }
        .bank-row .val { font-weight:700; color:var(--primary); }
        .bank-row .val.amount { color:var(--highlight); font-size:1.05rem; }
        .btn-copy {
            background:none; border:1px solid #ddd; border-radius:6px;
            padding:2px 8px; font-size:.72rem; color:#666; cursor:pointer;
            margin-left:.4rem; transition:all .2s;
        }
        .btn-copy:hover { background:#f0f0f0; }
        .note-box { background:#fff9e6; border:1px solid #ffe58f; border-radius:8px; padding:.8rem 1rem; font-size:.82rem; color:#856404; margin:1rem 0; text-align:left; }
        .countdown { font-size:.85rem; color:#e94560; font-weight:600; text-align:center; margin:.5rem 0; }

        /* Momo card */
        .momo-card { background:#fff; border-radius:14px; box-shadow:0 2px 16px rgba(0,0,0,.07); padding:2rem; text-align:center; }
        .momo-logo { font-size:3rem; color:#ae2d68; }
        .momo-phone { font-size:2rem; font-weight:900; color:#ae2d68; letter-spacing:2px; margin:1rem 0; }
        .momo-name { font-size:1rem; font-weight:700; color:#333; margin-bottom:.5rem; }
        .momo-amount { font-size:1.3rem; font-weight:800; color:#ae2d68; }

        /* Confirm button */
        .btn-confirm {
            width:100%; background:var(--highlight); color:#fff; border:none;
            padding:.9rem; border-radius:10px; font-size:1rem; font-weight:700;
            transition:all .3s; margin-top:1.5rem;
        }
        .btn-confirm:hover { background:#c73652; transform:translateY(-1px); box-shadow:0 6px 20px rgba(233,69,96,.35); }
        .btn-confirm:disabled { background:#ccc; transform:none; box-shadow:none; cursor:not-allowed; }
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
            <div class="step-item done">
                <div class="step-num"><i class="bi bi-check-lg"></i></div>
                <span>Thông tin giao hàng</span>
            </div>
            <div class="step-divider done"></div>
            <div class="step-item active">
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

<div class="payment-wrap">

    <!-- Order header -->
    <div class="order-info-box">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div>
                <div style="font-size:.78rem;opacity:.7;margin-bottom:.2rem;">MÃ ĐƠN HÀNG</div>
                <div class="order-code">${order.orderCode}</div>
                <div style="font-size:.82rem;opacity:.65;margin-top:.3rem;">
                    ${order.receiverName} &middot; ${order.receiverPhone}
                </div>
            </div>
            <div style="text-align:right;">
                <div style="font-size:.78rem;opacity:.7;margin-bottom:.2rem;">TỔNG TIỀN</div>
                <div class="order-amount">
                    <fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                </div>
            </div>
        </div>
    </div>

    <!-- Method tabs (chỉ hiển thị phương thức đã chọn) -->
    <c:choose>

        <%-- ═══════════════ CHUYỂN KHOẢN NGÂN HÀNG ═══════════════ --%>
        <c:when test="${order.paymentMethod == 'BANK_TRANSFER'}">
            <div class="bank-card">
                <div style="font-size:1rem;font-weight:700;color:var(--primary);margin-bottom:.5rem;">
                    <i class="bi bi-bank2 me-2 text-highlight"></i>Chuyển khoản ngân hàng
                </div>
                <div style="font-size:.85rem;color:#888;">Quét mã QR bên dưới để thanh toán</div>

                <%-- QR VietQR tự động sinh từ thông tin tài khoản --%>
                <div class="qr-wrap">
                    <%--
                        ĐỔI 3 THÔNG SỐ NÀY THÀNH TÀI KHOẢN CỦA BẠN:
                        BANK_ID  : mã ngân hàng (vietcombank, mbbank, techcombank, vpbank, acb...)
                        ACCOUNT  : số tài khoản
                        TEMPLATE : compact2 | qr_only | print
                    --%>
                    <c:set var="bankId"   value="mbbank"/>
                    <c:set var="account"  value="1234567890"/>
                    <c:set var="accName"  value="NGUYEN VAN A"/>
                    <c:set var="amount"   value="${order.totalPrice}"/>
                    <c:set var="addInfo"  value="${order.orderCode}"/>

                    <img src="https://img.vietqr.io/image/${bankId}-${account}-compact2.png?amount=${amount}&addInfo=${addInfo}&accountName=${accName}"
                         alt="QR Chuyển khoản"
                         onerror="this.src='/images/qr-placeholder.png'"/>
                </div>

                <div class="bank-info">
                    <div class="bank-row">
                        <span class="lbl">Ngân hàng</span>
                        <span class="val">MB Bank</span>
                    </div>
                    <div class="bank-row">
                        <span class="lbl">Số tài khoản</span>
                        <span class="val">
                            1234567890
                            <button class="btn-copy" onclick="copyText('1234567890')">Sao chép</button>
                        </span>
                    </div>
                    <div class="bank-row">
                        <span class="lbl">Chủ tài khoản</span>
                        <span class="val">NGUYEN VAN A</span>
                    </div>
                    <div class="bank-row">
                        <span class="lbl">Số tiền</span>
                        <span class="val amount">
                            <fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                            <button class="btn-copy" onclick="copyText('${order.totalPrice}')">Sao chép</button>
                        </span>
                    </div>
                    <div class="bank-row">
                        <span class="lbl">Nội dung CK</span>
                        <span class="val">
                            ${order.orderCode}
                            <button class="btn-copy" onclick="copyText('${order.orderCode}')">Sao chép</button>
                        </span>
                    </div>
                </div>

                <div class="note-box">
                    <i class="bi bi-exclamation-triangle-fill me-1"></i>
                    <strong>Lưu ý:</strong> Nhập đúng nội dung chuyển khoản <strong>${order.orderCode}</strong>
                    để đơn hàng được xác nhận tự động. Đơn hàng sẽ bị huỷ nếu không thanh toán trong <strong>30 phút</strong>.
                </div>
                <div class="countdown" id="countdown"></div>
            </div>
        </c:when>

        <%-- ═══════════════ MOMO ═══════════════ --%>
        <c:when test="${order.paymentMethod == 'MOMO'}">
            <div class="momo-card">
                <div class="momo-logo"><i class="bi bi-wallet2"></i></div>
                <div style="font-size:1rem;font-weight:700;color:#ae2d68;margin:.5rem 0;">
                    Thanh toán qua Ví MoMo
                </div>
                <div style="font-size:.85rem;color:#888;margin-bottom:1rem;">
                    Mở app MoMo → Chuyển tiền → Nhập số điện thoại bên dưới
                </div>

                <div class="momo-phone">
                    <%-- ĐỔI SỐ ĐIỆN THOẠI MOMO CỦA BẠN --%>
                    0901 234 567
                    <button class="btn-copy" onclick="copyText('0901234567')">Sao chép</button>
                </div>
                <div class="momo-name">NGUYEN VAN A</div>

                <div class="bank-info" style="max-width:360px;">
                    <div class="bank-row">
                        <span class="lbl">Số tiền</span>
                        <span class="val amount">
                            <fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                        </span>
                    </div>
                    <div class="bank-row">
                        <span class="lbl">Nội dung</span>
                        <span class="val">
                            ${order.orderCode}
                            <button class="btn-copy" onclick="copyText('${order.orderCode}')">Sao chép</button>
                        </span>
                    </div>
                </div>

                <div class="note-box">
                    <i class="bi bi-exclamation-triangle-fill me-1"></i>
                    Nhập đúng nội dung <strong>${order.orderCode}</strong> khi chuyển MoMo.
                </div>
                <div class="countdown" id="countdown"></div>
            </div>
        </c:when>

    </c:choose>

    <!-- Nút xác nhận -->
    <form method="POST" action="/payment/${order.id}/confirm">
        <button type="submit" class="btn-confirm" id="btnConfirm">
            <i class="bi bi-check2-circle me-2"></i>Tôi đã chuyển tiền — Xác nhận đơn hàng
        </button>
    </form>

    <div class="text-center mt-3">
        <a href="/cart" style="font-size:.82rem;color:#aaa;text-decoration:none;">
            <i class="bi bi-arrow-left me-1"></i> Quay lại giỏ hàng
        </a>
    </div>
</div>

<%@ include file="/WEB-INF/view/client/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ── Sao chép vào clipboard ────────────────────────────────────
    function copyText(text) {
        navigator.clipboard.writeText(text).then(function() {
            showCopied();
        });
    }
    function showCopied() {
        var toast = document.createElement('div');
        toast.textContent = '✓ Đã sao chép!';
        toast.style.cssText = 'position:fixed;bottom:1.5rem;left:50%;transform:translateX(-50%);background:#1a1a2e;color:#fff;padding:.6rem 1.4rem;border-radius:20px;font-size:.85rem;font-weight:600;z-index:9999;animation:fadeInUp .3s ease;';
        document.body.appendChild(toast);
        setTimeout(function() { toast.remove(); }, 1800);
    }

    // ── Đếm ngược 30 phút ─────────────────────────────────────────
    var countdownEl = document.getElementById('countdown');
    if (countdownEl) {
        var seconds = 30 * 60;
        var timer = setInterval(function() {
            seconds--;
            var m = Math.floor(seconds / 60);
            var s = seconds % 60;
            countdownEl.textContent = 'Hết hạn sau: ' + String(m).padStart(2,'0') + ':' + String(s).padStart(2,'0');
            if (seconds <= 0) {
                clearInterval(timer);
                countdownEl.textContent = 'Đơn hàng đã hết hạn thanh toán.';
                countdownEl.style.color = '#888';
                document.getElementById('btnConfirm').disabled = true;
            }
        }, 1000);
    }
</script>
</body>
</html>
