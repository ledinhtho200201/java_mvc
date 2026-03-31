<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Chi tiet don hang - LaptopShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="/css/client.css" rel="stylesheet"/>
    <style>
        body { background: #f8f9fa; }
        .detail-wrap { max-width: 900px; margin: 2rem auto; padding: 0 1rem 4rem; }
        .page-head {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 16px rgba(0, 0, 0, .07);
            padding: 1.2rem 1.4rem;
            margin-bottom: 1.2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: .8rem;
            flex-wrap: wrap;
        }
        .order-code { font-size: 1.1rem; font-weight: 800; color: var(--primary); }
        .order-date { font-size: .82rem; color: #888; }
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: .35rem;
            padding: .35rem .9rem;
            border-radius: 20px;
            font-size: .78rem;
            font-weight: 700;
        }
        .s-PENDING_PAYMENT { background: #fff9c4; color: #b45309; }
        .s-PROCESSING { background: #dcfce7; color: #15803d; }
        .s-COMPLETED { background: #e0f2fe; color: #0369a1; }
        .s-CANCELLED { background: #fee2e2; color: #b91c1c; }

        .card-box {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 16px rgba(0, 0, 0, .07);
            overflow: hidden;
            margin-bottom: 1rem;
        }
        .card-head {
            background: var(--primary);
            color: #fff;
            padding: .85rem 1.2rem;
            font-size: .9rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: .5rem;
        }
        .card-body { padding: 1.1rem 1.2rem; }

        .row-info {
            display: flex;
            gap: .6rem;
            padding: .48rem 0;
            border-bottom: 1px solid #f3f3f3;
            font-size: .88rem;
        }
        .row-info:last-child { border-bottom: none; }
        .row-info .label { min-width: 130px; color: #888; }
        .row-info .value { color: var(--primary); font-weight: 600; }

        .item-row {
            display: flex;
            align-items: center;
            gap: .9rem;
            padding: .7rem 0;
            border-bottom: 1px solid #f3f3f3;
        }
        .item-row:last-child { border-bottom: none; }
        .item-img {
            width: 56px;
            height: 56px;
            object-fit: contain;
            border-radius: 8px;
            background: #f7f8fa;
            border: 1px solid #eee;
            padding: 4px;
            flex-shrink: 0;
        }
        .item-name { flex: 1; font-size: .9rem; color: var(--primary); font-weight: 600; }
        .item-qty { font-size: .8rem; color: #999; }
        .item-price { font-size: .92rem; font-weight: 700; color: var(--highlight); white-space: nowrap; }

        .total-line { display: flex; justify-content: space-between; padding: .35rem 0; font-size: .88rem; }
        .total-final { font-size: 1.15rem; font-weight: 800; color: var(--highlight); }

        .action-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: .7rem;
            margin-top: .9rem;
        }
        .btn-back {
            border: 1.5px solid var(--primary);
            color: var(--primary);
            text-decoration: none;
            border-radius: 22px;
            padding: .45rem 1rem;
            font-weight: 700;
            font-size: .84rem;
        }
        .btn-back:hover { background: var(--primary); color: #fff; }
        .btn-pay {
            border: none;
            background: var(--highlight);
            color: #fff;
            text-decoration: none;
            border-radius: 22px;
            padding: .5rem 1.1rem;
            font-weight: 700;
            font-size: .84rem;
        }
        .btn-pay:hover { background: #c73652; color: #fff; }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/view/client/header.jsp" %>

<div class="detail-wrap">
    <div class="page-head">
        <div>
            <div class="order-code">${order.orderCode}</div>
            <div class="order-date">
                <i class="bi bi-clock me-1"></i>
                ${order.formattedCreatedAt}
            </div>
        </div>
        <span class="status-badge s-${order.status}">
            <c:choose>
                <c:when test="${order.status == 'PENDING_PAYMENT'}"><i class="bi bi-clock-history"></i>Cho thanh toan</c:when>
                <c:when test="${order.status == 'PROCESSING'}"><i class="bi bi-arrow-repeat"></i>Dang xu ly</c:when>
                <c:when test="${order.status == 'COMPLETED'}"><i class="bi bi-check-circle"></i>Hoan thanh</c:when>
                <c:otherwise><i class="bi bi-x-circle"></i>Da huy</c:otherwise>
            </c:choose>
        </span>
    </div>

    <div class="card-box">
        <div class="card-head"><i class="bi bi-geo-alt-fill"></i>Thong tin giao hang</div>
        <div class="card-body">
            <div class="row-info"><span class="label">Nguoi nhan</span><span class="value">${order.receiverName}</span></div>
            <div class="row-info"><span class="label">So dien thoai</span><span class="value">${order.receiverPhone}</span></div>
            <div class="row-info"><span class="label">Dia chi</span><span class="value">${order.receiverAddress}</span></div>
            <c:if test="${not empty order.note}">
                <div class="row-info"><span class="label">Ghi chu</span><span class="value">${order.note}</span></div>
            </c:if>
            <div class="row-info">
                <span class="label">Thanh toan</span>
                <span class="value">
                    <c:choose>
                        <c:when test="${order.paymentMethod == 'BANK_TRANSFER'}"><i class="bi bi-bank2"></i> Chuyen khoan ngan hang</c:when>
                        <c:when test="${order.paymentMethod == 'MOMO'}"><i class="bi bi-wallet2"></i> Vi MoMo</c:when>
                        <c:otherwise><i class="bi bi-cash-coin"></i> Thanh toan khi nhan hang</c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>
    </div>

    <div class="card-box">
        <div class="card-head"><i class="bi bi-bag-check"></i>San pham</div>
        <div class="card-body">
            <c:forEach var="detail" items="${order.orderDetails}">
                <div class="item-row">
                    <c:choose>
                        <c:when test="${not empty detail.product.image}">
                            <img class="item-img" src="/images/product/${detail.product.image}" alt="${detail.product.name}"/>
                        </c:when>
                        <c:otherwise>
                            <div class="item-img d-flex align-items-center justify-content-center text-muted">
                                <i class="bi bi-laptop"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="item-name">
                        ${detail.product.name}
                        <div class="item-qty">x${detail.quantity}</div>
                    </div>
                    <div class="item-price">
                        <fmt:formatNumber value="${detail.price * detail.quantity}" type="number" groupingUsed="true" maxFractionDigits="0"/>d
                    </div>
                </div>
            </c:forEach>

            <div class="total-line mt-2"><span>Tam tinh</span><span><fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>d</span></div>
            <div class="total-line" style="color:#28a745;"><span>Phi van chuyen</span><span>Mien phi</span></div>
            <div class="total-line" style="border-top:2px solid #f0f0f0; padding-top:.6rem;">
                <span style="font-weight:700;">Tong cong</span>
                <span class="total-final"><fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/>d</span>
            </div>

            <div class="action-row">
                <a class="btn-back" href="/orders"><i class="bi bi-arrow-left"></i>Quay lai danh sach don</a>
                <c:if test="${order.status == 'PENDING_PAYMENT'}">
                    <a class="btn-pay" href="/payment/${order.id}"><i class="bi bi-credit-card"></i>Thanh toan ngay</a>
                </c:if>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/view/client/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
