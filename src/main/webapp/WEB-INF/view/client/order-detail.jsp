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

        /* Tracking Stepper */
        .tracking-card {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 16px rgba(0, 0, 0, .07);
            padding: 2.2rem 1.5rem 1.5rem;
            margin-bottom: 1.2rem;
            position: relative;
        }
        .track-stepper {
            display: flex;
            justify-content: space-between;
            position: relative;
            margin-bottom: 1.5rem;
        }
        .track-stepper::before {
            content: '';
            position: absolute;
            top: 24px;
            left: 12.5%;
            right: 12.5%;
            height: 6px;
            background: #f0f0f5;
            z-index: 1;
            border-radius: 3px;
        }
        .track-progress {
            position: absolute;
            top: 24px;
            left: 12.5%;
            height: 6px;
            background: var(--highlight, #e94560);
            z-index: 2;
            transition: width 1.5s cubic-bezier(0.22, 1, 0.36, 1);
            border-radius: 3px;
        }
        .truck-moving {
            position: absolute;
            top: -24px;
            right: -15px;
            font-size: 1.8rem;
            color: var(--highlight, #e94560);
            background: #fff;
            z-index: 5;
            border-radius: 50%;
            animation: bump 0.4s infinite alternate;
            padding: 0 2px;
        }
        @keyframes bump {
            0% { transform: translateY(0); }
            100% { transform: translateY(-4px); }
        }
        .track-step {
            width: 25%;
            text-align: center;
            position: relative;
            z-index: 3;
        }
        .track-icon {
            width: 54px;
            height: 54px;
            border-radius: 50%;
            background: #fff;
            border: 3px solid #f0f0f5;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            color: #ccc;
            margin: 0 auto 0.6rem;
            transition: all 0.4s;
        }
        .track-step.done .track-icon, .track-step.current .track-icon {
            border-color: var(--highlight, #e94560);
            color: var(--highlight, #e94560);
        }
        .track-step.done .track-icon {
            background: var(--highlight, #e94560);
            color: #fff;
        }
        .track-label {
            font-size: .85rem;
            font-weight: 600;
            color: #999;
        }
        .track-step.done .track-label, .track-step.current .track-label {
            color: var(--primary, #2b2b2b);
        }
        .track-step.current .track-icon {
            box-shadow: 0 0 0 5px rgba(233, 69, 96, 0.15);
        }
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

    <!-- TÍNH TOÁN KHOẢNG TRẠNG THÁI -->
    <c:set var="pWidth" value="0%"/>
    <c:set var="stepNum" value="1"/>
    <c:choose>
        <c:when test="${order.status == 'COMPLETED'}">
            <c:set var="pWidth" value="75%"/>
            <c:set var="stepNum" value="4"/>
        </c:when>
        <c:when test="${order.status == 'SHIPPING'}">
            <c:set var="pWidth" value="50%"/>
            <c:set var="stepNum" value="3"/>
        </c:when>
        <c:when test="${order.status == 'PROCESSING'}">
            <c:set var="pWidth" value="25%"/>
            <c:set var="stepNum" value="2"/>
        </c:when>
        <c:when test="${order.status == 'PENDING_PAYMENT'}">
            <c:set var="pWidth" value="0%"/>
            <c:set var="stepNum" value="1"/>
        </c:when>
        <c:otherwise>
            <c:set var="stepNum" value="-1"/>
        </c:otherwise>
    </c:choose>

    <!-- TRACKING STEPPER COMPONENT -->
    <c:if test="${stepNum != -1}">
        <div class="tracking-card">
            <div class="track-stepper">
                <div class="track-progress" id="truckProgress" style="width: 0%;" data-target="${pWidth}">
                    <i class="bi bi-truck truck-moving"></i>
                </div>
                
                <div class="track-step ${stepNum >= 1 ? 'done' : ''} ${stepNum == 1 ? 'current' : ''}">
                    <div class="track-icon"><i class="bi bi-receipt"></i></div>
                    <div class="track-label">Đơn hàng đã đặt</div>
                </div>
                <div class="track-step ${stepNum >= 2 ? 'done' : ''} ${stepNum == 2 ? 'current' : ''}">
                    <div class="track-icon"><i class="bi bi-box-seam"></i></div>
                    <div class="track-label">Đã xác nhận</div>
                </div>
                <div class="track-step ${stepNum >= 3 ? 'done' : ''} ${stepNum == 3 ? 'current' : ''}">
                    <div class="track-icon"><i class="bi bi-truck"></i></div>
                    <div class="track-label">Đang giao hàng</div>
                </div>
                <div class="track-step ${stepNum >= 4 ? 'done' : ''} ${stepNum == 4 ? 'current' : ''}">
                    <div class="track-icon"><i class="bi bi-house-check"></i></div>
                    <div class="track-label">Giao thành công</div>
                </div>
            </div>
            
            <div class="text-center mt-4" style="font-size: .95rem; color: #666;">
                <c:choose>
                    <c:when test="${stepNum == 1}"><strong>Chờ thanh toán:</strong> Bạn vui lòng hoàn tất phần thanh toán để hệ thống chuẩn bị gửi hàng nhé!</c:when>
                    <c:when test="${stepNum == 2}"><strong>Tin vui!</strong> Đơn hàng đã được xác nhận. Gói hàng đang được thao tác đóng gói để vận chuyển đi.</c:when>
                    <c:when test="${stepNum == 3}"><strong>Ting ting!</strong> Xe tải đang trên đường giao hàng đến bạn. Vui lòng chú ý điện thoại nhé!</c:when>
                    <c:when test="${stepNum == 4}"><strong>Thành công!</strong> Cảm ơn bạn đã tin tưởng và mua sắm tại LaptopShop 🎉.</c:when>
                </c:choose>
            </div>
        </div>
    </c:if>

    <!-- LIVE TRACKING MAP (Chỉ hiện khi đang giao hàng) -->
    <c:if test="${stepNum == 3}">
        <div class="tracking-card" style="padding: 1.5rem;">
            <h6 style="font-weight: 800; color: var(--primary); margin-bottom: 1.2rem; font-size: 1.05rem;">
                <i class="bi bi-geo-alt-fill me-2" style="color: var(--highlight);"></i>Bản đồ hành trình trực tiếp
            </h6>
            <div class="d-flex justify-content-between mb-3 flex-wrap gap-2" style="font-size: .88rem;">
                <span class="d-inline-flex align-items-center bg-light px-3 py-2 rounded-3" style="border: 1px solid #eee;">
                    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" width="30" height="30" class="me-2" alt="shipper">
                    <div>
                        <div style="font-weight: 700; color: var(--primary); line-height: 1;">Shipper: Nguyễn Văn A</div>
                        <div style="font-size: .75rem; color: #888; margin-top: 4px;">0987.654.321 &bull; 29A1-123.45</div>
                    </div>
                </span>
                <span class="d-inline-flex align-items-center text-success" style="font-weight: 700; background: #e8f5e9; padding: 0 1rem; border-radius: 20px;">
                    <i class="bi bi-stopwatch me-1" style="font-size: 1.2rem;"></i> Dự kiến đến trong: 15 phút
                </span>
            </div>
            <div id="deliveryMap" style="height: 380px; border-radius: 12px; z-index: 1; border: 1px solid #ddd; box-shadow: inset 0 2px 5px rgba(0,0,0,.05);"></div>
        </div>
    </c:if>

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

<!-- Thư viện bản đồ Leaflet (Track Map) -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 1. Hiệu ứng xe tải chạy trên thanh Tracking
        setTimeout(function() {
            var tp = document.getElementById('truckProgress');
            if (tp) {
                tp.style.width = tp.getAttribute('data-target');
            }
        }, 200);

        // 2. Khởi tạo Bản đồ nếu Element tồn tại
        var mapEl = document.getElementById('deliveryMap');
        if (mapEl) {
            // Tọa độ giả định
            var shopPos = [21.028511, 105.804817];
            var homePos = [21.012345, 105.812345];
            var shipperPos = [21.020000, 105.808000];

            // Khởi tạo map
            var map = L.map('deliveryMap', { scrollWheelZoom: false }).setView(shipperPos, 14);
            L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png', {
                attribution: '&copy; OpenStreetMap',
                maxZoom: 19
            }).addTo(map);

            // Icon tuỳ chỉnh
            var shopIcon = L.icon({
                iconUrl: 'https://cdn-icons-png.flaticon.com/512/3081/3081840.png',
                iconSize: [36, 36], iconAnchor: [18, 36]
            });
            var homeIcon = L.icon({
                iconUrl: 'https://cdn-icons-png.flaticon.com/512/25/25694.png',
                iconSize: [32, 32], iconAnchor: [16, 32]
            });
            var shipperIcon = L.icon({
                iconUrl: 'https://cdn-icons-png.flaticon.com/512/411/411763.png',
                iconSize: [46, 46], iconAnchor: [23, 23]
            });

            // Gắn Marker lên map
            L.marker(shopPos, {icon: shopIcon}).addTo(map).bindPopup("<b>LaptopShop Store</b><br/>Kho hàng");
            L.marker(homePos, {icon: homeIcon}).addTo(map).bindPopup("<b>Nơi nhận</b><br/>${order.receiverAddress}");
            
            var shipperMarker = L.marker(shipperPos, {icon: shipperIcon, zIndexOffset: 1000})
                .addTo(map)
                .bindPopup("<div style='text-align:center;'><b>Tài xế đang di chuyển</b><br/><span style='color:var(--highlight)'>Sắp tới nơi rồi!</span></div>")
                .openPopup();

            // Vẽ đường đi (Polyline) dashed
            var latlngs = [
                shopPos,
                [21.024000, 105.806000],
                shipperPos,
                [21.016000, 105.810000],
                homePos
            ];
            var polyline = L.polyline(latlngs, {
                color: '#e94560', 
                dashArray: '6, 8', 
                weight: 4
            }).addTo(map);

            // Auto zoom để nhìn thấy toàn bộ lộ trình
            map.fitBounds(polyline.getBounds(), {padding: [40, 40]});

            // Hiệu ứng di chuyển nhỏ (giả lập live tracking)
            setInterval(function() {
                shipperPos[0] -= 0.000015;
                shipperPos[1] += 0.000015;
                shipperMarker.setLatLng(shipperPos);
            }, 800);
        }
    });
</script>
</body>
</html>
