<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Đơn hàng của tôi - LaptopShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="/css/client.css" rel="stylesheet"/>
    <style>
        body { background: #f8f9fa; }

        /* ── Page header ── */
        .page-hero {
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            color: #fff;
            padding: 2.2rem 0 1.8rem;
        }
        .page-hero h2 { font-size: 1.6rem; font-weight: 800; margin: 0; }
        .page-hero p  { font-size: .88rem; opacity: .7; margin: .3rem 0 0; }

        /* ── Filter tabs ── */
        .filter-bar {
            background: #fff;
            border-bottom: 1px solid #eee;
            overflow-x: auto;
        }
        .filter-tabs {
            display: flex;
            gap: 0;
            min-width: max-content;
        }
        .filter-tab {
            padding: .85rem 1.4rem;
            font-size: .85rem;
            font-weight: 600;
            color: #888;
            cursor: pointer;
            border-bottom: 3px solid transparent;
            white-space: nowrap;
            transition: all .2s;
            background: none;
            border-top: none;
            border-left: none;
            border-right: none;
        }
        .filter-tab:hover  { color: var(--primary); }
        .filter-tab.active { color: var(--highlight); border-bottom-color: var(--highlight); }

        /* ── Wrapper ── */
        .orders-wrap { max-width: 860px; margin: 2rem auto; padding: 0 1rem 4rem; }

        /* ── Empty state ── */
        .empty-orders {
            background: #fff; border-radius: 14px;
            box-shadow: 0 2px 16px rgba(0,0,0,.06);
            padding: 4rem 2rem; text-align: center;
        }
        .empty-orders i   { font-size: 4rem; color: #dde; display: block; margin-bottom: 1rem; }
        .empty-orders h5  { font-weight: 700; color: var(--primary); }
        .empty-orders p   { color: #aaa; font-size: .9rem; }
        .btn-shop-now {
            background: var(--highlight); color: #fff; border: none;
            border-radius: 25px; padding: .65rem 2rem;
            font-weight: 700; font-size: .92rem;
            text-decoration: none; display: inline-block;
            transition: all .3s; margin-top: .5rem;
        }
        .btn-shop-now:hover { background: #c73652; color: #fff; transform: translateY(-1px); }

        /* ── Order card ── */
        .order-card {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 14px rgba(0,0,0,.06);
            overflow: hidden;
            margin-bottom: 1.2rem;
            border: 1.5px solid transparent;
            transition: all .25s;
        }
        .order-card:hover { border-color: #e0e7ff; box-shadow: 0 4px 24px rgba(0,0,0,.10); }

        /* card header */
        .oc-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: .9rem 1.4rem;
            border-bottom: 1px solid #f3f3f3;
            flex-wrap: wrap;
            gap: .5rem;
        }
        .oc-code   { font-weight: 800; font-size: .92rem; color: var(--primary); }
        .oc-date   { font-size: .78rem; color: #aaa; margin-top: 1px; }
        .oc-status {
            display: inline-flex; align-items: center; gap: .35rem;
            padding: .3rem .9rem; border-radius: 20px;
            font-size: .75rem; font-weight: 700;
        }
        .s-PENDING_PAYMENT { background: #fff9c4; color: #b45309; }
        .s-PROCESSING       { background: #dcfce7; color: #15803d; }
        .s-COMPLETED        { background: #e0f2fe; color: #0369a1; }
        .s-CANCELLED        { background: #fee2e2; color: #b91c1c; }

        /* card body — product thumbnails */
        .oc-body { padding: 1rem 1.4rem; display: flex; align-items: center; gap: 1.2rem; flex-wrap: wrap; }
        .oc-thumbs { display: flex; gap: .4rem; flex-wrap: wrap; flex: 1; }
        .oc-thumb {
            width: 58px; height: 58px;
            border-radius: 8px; background: #f8f9fa;
            object-fit: contain; padding: 4px;
            border: 1px solid #eee;
        }
        .oc-thumb-more {
            width: 58px; height: 58px; border-radius: 8px;
            background: #f0f0f5; display: flex;
            align-items: center; justify-content: center;
            font-size: .78rem; font-weight: 700; color: #888;
            border: 1px solid #eee;
        }
        .oc-summary { text-align: right; flex-shrink: 0; }
        .oc-item-count { font-size: .78rem; color: #aaa; margin-bottom: .2rem; }
        .oc-total { font-size: 1.1rem; font-weight: 800; color: var(--highlight); }

        /* card footer */
        .oc-foot {
            padding: .8rem 1.4rem;
            background: #fafafa;
            border-top: 1px solid #f3f3f3;
            display: flex; align-items: center;
            justify-content: space-between; flex-wrap: wrap; gap: .5rem;
        }
        .oc-payment { font-size: .78rem; color: #999; display: flex; align-items: center; gap: .35rem; }
        .btn-detail {
            font-size: .82rem; font-weight: 700;
            color: var(--accent); text-decoration: none;
            display: inline-flex; align-items: center; gap: .35rem;
            padding: .35rem .9rem; border: 1.5px solid var(--accent);
            border-radius: 20px; transition: all .2s;
        }
        .btn-detail:hover { background: var(--accent); color: #fff; }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/view/client/header.jsp" %>

<!-- Page hero -->
<div class="page-hero">
    <div class="container">
        <h2><i class="bi bi-box-seam me-2"></i>Đơn hàng của tôi</h2>
        <p>Theo dõi và quản lý toàn bộ đơn hàng</p>
    </div>
</div>

<!-- Filter tabs -->
<div class="filter-bar">
    <div class="container p-0">
        <div class="filter-tabs">
            <button class="filter-tab active" data-filter="ALL">Tất cả</button>
            <button class="filter-tab" data-filter="PENDING_PAYMENT">Chờ thanh toán</button>
            <button class="filter-tab" data-filter="PROCESSING">Đang xử lý</button>
            <button class="filter-tab" data-filter="COMPLETED">Hoàn thành</button>
            <button class="filter-tab" data-filter="CANCELLED">Đã huỷ</button>
        </div>
    </div>
</div>

<div class="orders-wrap">

    <c:choose>
        <c:when test="${empty orders}">
            <div class="empty-orders">
                <i class="bi bi-bag-x"></i>
                <h5>Bạn chưa có đơn hàng nào</h5>
                <p>Hãy khám phá hàng ngàn laptop chính hãng với giá tốt nhất!</p>
                <a href="/" class="btn-shop-now"><i class="bi bi-bag-heart me-1"></i>Mua sắm ngay</a>
            </div>
        </c:when>
        <c:otherwise>

            <c:forEach var="order" items="${orders}">
            <div class="order-card" data-status="${order.status}">

                <!-- Header -->
                <div class="oc-head">
                    <div>
                        <div class="oc-code">${order.orderCode}</div>
                        <div class="oc-date">
                            <i class="bi bi-clock me-1"></i>
                            ${order.formattedCreatedAt}
                        </div>
                    </div>
                    <span class="oc-status s-${order.status}">
                        <c:choose>
                            <c:when test="${order.status == 'PENDING_PAYMENT'}">
                                <i class="bi bi-clock-history"></i> Chờ thanh toán
                            </c:when>
                            <c:when test="${order.status == 'PROCESSING'}">
                                <i class="bi bi-arrow-repeat"></i> Đang xử lý
                            </c:when>
                            <c:when test="${order.status == 'COMPLETED'}">
                                <i class="bi bi-check-circle"></i> Hoàn thành
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-x-circle"></i> Đã huỷ
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>

                <!-- Thumbnails + total -->
                <div class="oc-body">
                    <div class="oc-thumbs">
                        <c:forEach var="detail" items="${order.orderDetails}" begin="0" end="3" varStatus="loop">
                            <c:choose>
                                <c:when test="${loop.index == 3 && fn:length(order.orderDetails) > 4}">
                                    <div class="oc-thumb-more">+${fn:length(order.orderDetails) - 3}</div>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${not empty detail.product.image}">
                                            <img class="oc-thumb"
                                                 src="/images/product/${detail.product.image}"
                                                 alt="${detail.product.name}"
                                                 title="${detail.product.name} x${detail.quantity}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="oc-thumb" style="display:flex;align-items:center;justify-content:center;color:#ccc;font-size:1.4rem;">
                                                <i class="bi bi-laptop"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <div class="oc-summary">
                        <div class="oc-item-count">${fn:length(order.orderDetails)} sản phẩm</div>
                        <div class="oc-total">
                            <fmt:formatNumber value="${order.totalPrice}"
                                              type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <div class="oc-foot">
                    <span class="oc-payment">
                        <c:choose>
                            <c:when test="${order.paymentMethod == 'BANK_TRANSFER'}">
                                <i class="bi bi-bank2"></i> Chuyển khoản ngân hàng
                            </c:when>
                            <c:when test="${order.paymentMethod == 'MOMO'}">
                                <i class="bi bi-wallet2"></i> Ví MoMo
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-cash-coin"></i> Thanh toán khi nhận hàng
                            </c:otherwise>
                        </c:choose>
                    </span>
                    <div class="d-flex gap-2">
                        <%-- Nếu còn chờ thanh toán → cho thanh toán lại --%>
                        <c:if test="${order.status == 'PENDING_PAYMENT'}">
                            <a href="/payment/${order.id}" class="btn-detail"
                               style="border-color:var(--highlight);color:var(--highlight);">
                                <i class="bi bi-credit-card"></i> Thanh toán
                            </a>
                        </c:if>
                        <a href="/orders/${order.id}" class="btn-detail">
                            <i class="bi bi-eye"></i> Chi tiết
                        </a>
                    </div>
                </div>

            </div>
            </c:forEach>

        </c:otherwise>
    </c:choose>

</div>

<%@ include file="/WEB-INF/view/client/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ── Filter tabs ───────────────────────────────────────────────
    document.querySelectorAll('.filter-tab').forEach(function(tab) {
        tab.addEventListener('click', function() {
            document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
            this.classList.add('active');

            var filter = this.dataset.filter;
            document.querySelectorAll('.order-card').forEach(function(card) {
                if (filter === 'ALL' || card.dataset.status === filter) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });

            // Hiện empty state nếu không có đơn nào khớp
            var visible = document.querySelectorAll('.order-card:not([style*="none"])').length;
            var emptyMsg = document.getElementById('emptyFilter');
            if (!emptyMsg) {
                emptyMsg = document.createElement('div');
                emptyMsg.id = 'emptyFilter';
                emptyMsg.className = 'empty-orders';
                emptyMsg.innerHTML = '<i class="bi bi-funnel" style="font-size:2.5rem;color:#dde;display:block;margin-bottom:.8rem;"></i>' +
                    '<h5>Không có đơn hàng nào</h5><p>Không có đơn ở trạng thái này.</p>';
                document.querySelector('.orders-wrap').appendChild(emptyMsg);
            }
            emptyMsg.style.display = visible === 0 ? '' : 'none';
        });
    });
</script>
</body>
</html>
