<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>${product.name} - LaptopShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="/css/client.css" rel="stylesheet"/>
    <style>
        .detail-img-wrap {
            background: #f8f9fa;
            border-radius: 14px;
            padding: 2rem;
            text-align: center;
            position: sticky;
            top: 100px;
        }
        .detail-img-wrap img {
            max-width: 100%;
            max-height: 360px;
            object-fit: contain;
            border-radius: 8px;
        }
        .detail-img-placeholder {
            height: 300px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ccc;
            font-size: 5rem;
        }
        .detail-brand {
            font-size: 0.82rem;
            color: var(--text-muted);
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: 1px;
        }
        .detail-name {
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--primary);
            line-height: 1.3;
            margin: 0.4rem 0 1rem;
        }
        .detail-price {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--highlight);
        }
        .detail-badge {
            display: inline-block;
            padding: 0.3rem 0.9rem;
            border-radius: 20px;
            font-size: 0.78rem;
            font-weight: 600;
        }
        .badge-factory { background: #eef2ff; color: #4f46e5; }
        .badge-target  { background: #f0fdf4; color: #16a34a; }
        .badge-stock   { background: #fef9e7; color: #d97706; }

        .spec-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1rem 1.2rem;
            margin-top: 1.2rem;
        }
        .spec-card h6 {
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }
        .spec-card p {
            font-size: 0.88rem;
            color: #555;
            margin: 0;
            line-height: 1.6;
        }

        .detail-desc {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 14px;
            padding: 1.8rem;
            margin-top: 2rem;
        }
        .detail-desc h5 {
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 1rem;
            padding-bottom: 0.6rem;
            border-bottom: 2px solid #f0f0f0;
        }
        .detail-desc p {
            font-size: 0.92rem;
            color: #555;
            line-height: 1.8;
        }

        .btn-buy {
            background: var(--highlight);
            color: #fff;
            border: none;
            padding: 0.75rem 2.5rem;
            border-radius: 30px;
            font-size: 1rem;
            font-weight: 700;
            transition: all 0.3s;
        }
        .btn-buy:hover {
            background: #c73652;
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(233,69,96,0.3);
        }
        .btn-cart-outline {
            background: transparent;
            border: 2px solid var(--primary);
            color: var(--primary);
            padding: 0.7rem 2rem;
            border-radius: 30px;
            font-size: 1rem;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-cart-outline:hover {
            background: var(--primary);
            color: #fff;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/view/client/header.jsp" %>

<!-- Breadcrumb -->
<div class="page-breadcrumb">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/" style="color:var(--highlight);text-decoration:none;">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="/" style="color:var(--highlight);text-decoration:none;">Sản phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
            </ol>
        </nav>
    </div>
</div>

<!-- Product Detail -->
<section style="padding:2.5rem 0 3rem; background:#fff;">
    <div class="container">
        <div class="row g-4">

            <!-- Image -->
            <div class="col-lg-5">
                <div class="detail-img-wrap">
                    <c:choose>
                        <c:when test="${not empty product.image}">
                            <img src="/images/product/${product.image}" alt="${product.name}"/>
                        </c:when>
                        <c:otherwise>
                            <div class="detail-img-placeholder"><i class="bi bi-laptop"></i></div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Info -->
            <div class="col-lg-7">
                <div class="detail-brand">${product.factory}</div>
                <h1 class="detail-name">${product.name}</h1>

                <div class="d-flex flex-wrap gap-2 mb-3">
                    <span class="detail-badge badge-factory">${product.factory}</span>
                    <span class="detail-badge badge-target">${product.target}</span>
                    <span class="detail-badge badge-stock">
                        <i class="bi bi-box-seam me-1"></i>Còn ${product.quantity} sản phẩm
                    </span>
                </div>

                <div class="detail-price mb-3">
                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ
                </div>

                <c:if test="${not empty product.shortDesc}">
                    <div class="spec-card">
                        <h6><i class="bi bi-cpu me-1"></i>Cấu hình tóm tắt</h6>
                        <p>${product.shortDesc}</p>
                    </div>
                </c:if>

                <div class="d-flex gap-3 mt-4">
                    <button class="btn-buy"><i class="bi bi-bag-check me-2"></i>Mua ngay</button>
                    <form method="POST" action="/add-to-cart/${product.id}" class="m-0">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button type="submit" class="btn-cart-outline">
                            <i class="bi bi-cart-plus me-2"></i>Thêm vào giỏ
                        </button>
                    </form>
                </div>

                <!-- Features -->
                <div class="row g-3 mt-3">
                    <div class="col-6">
                        <div class="d-flex align-items-center gap-2" style="font-size:.85rem;color:#555;">
                            <i class="bi bi-shield-check" style="color:var(--highlight);font-size:1.1rem;"></i>
                            Bảo hành chính hãng 24 tháng
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="d-flex align-items-center gap-2" style="font-size:.85rem;color:#555;">
                            <i class="bi bi-truck" style="color:var(--highlight);font-size:1.1rem;"></i>
                            Miễn phí giao hàng toàn quốc
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="d-flex align-items-center gap-2" style="font-size:.85rem;color:#555;">
                            <i class="bi bi-arrow-counterclockwise" style="color:var(--highlight);font-size:1.1rem;"></i>
                            Đổi trả trong 30 ngày
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="d-flex align-items-center gap-2" style="font-size:.85rem;color:#555;">
                            <i class="bi bi-credit-card" style="color:var(--highlight);font-size:1.1rem;"></i>
                            Trả góp 0% lãi suất
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- Detail description -->
        <c:if test="${not empty product.detailDesc}">
            <div class="detail-desc">
                <h5><i class="bi bi-file-text me-2"></i>Mô tả chi tiết</h5>
                <p>${product.detailDesc}</p>
            </div>
        </c:if>

    </div>
</section>

<%@ include file="/WEB-INF/view/client/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
