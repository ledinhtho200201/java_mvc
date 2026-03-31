<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- =============================================
     FEATURES / SERVICES BAR
     ============================================= -->
<section class="features-bar">
    <div class="container">
        <div class="row g-0">

            <div class="col-6 col-md-3">
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="bi bi-truck"></i>
                    </div>
                    <div class="feature-text">
                        <div class="feature-title">Miễn phí giao hàng</div>
                        <div class="feature-desc">Đơn hàng từ 5 triệu</div>
                    </div>
                </div>
            </div>

            <div class="col-6 col-md-3">
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="bi bi-shield-check"></i>
                    </div>
                    <div class="feature-text">
                        <div class="feature-title">Bảo hành chính hãng</div>
                        <div class="feature-desc">12 - 36 tháng</div>
                    </div>
                </div>
            </div>

            <div class="col-6 col-md-3">
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="bi bi-arrow-counterclockwise"></i>
                    </div>
                    <div class="feature-text">
                        <div class="feature-title">Đổi trả dễ dàng</div>
                        <div class="feature-desc">30 ngày miễn phí</div>
                    </div>
                </div>
            </div>

            <div class="col-6 col-md-3">
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="bi bi-headset"></i>
                    </div>
                    <div class="feature-text">
                        <div class="feature-title">Hỗ trợ 24/7</div>
                        <div class="feature-desc">Tư vấn tận tình</div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

<!-- =============================================
     PRODUCT CATEGORIES
     ============================================= -->
<section class="section-padding-sm" style="background:#f8f9fa;">
    <div class="container">
        <div class="section-header text-center">
            <div class="section-label">Danh mục nổi bật</div>
            <h2 class="section-title">Khám phá <span>Sản phẩm</span></h2>
        </div>
        <div class="row g-3 justify-content-center">
            <div class="col-6 col-sm-4 col-md-2">
                <a href="#" class="category-card">
                    <span class="cat-icon">💻</span>
                    <div class="cat-name">Gaming</div>
                    <div class="cat-count">120+ sản phẩm</div>
                </a>
            </div>
            <div class="col-6 col-sm-4 col-md-2">
                <a href="#" class="category-card">
                    <span class="cat-icon">📱</span>
                    <div class="cat-name">Văn phòng</div>
                    <div class="cat-count">85+ sản phẩm</div>
                </a>
            </div>
            <div class="col-6 col-sm-4 col-md-2">
                <a href="#" class="category-card">
                    <span class="cat-icon">🎨</span>
                    <div class="cat-name">Đồ họa</div>
                    <div class="cat-count">46+ sản phẩm</div>
                </a>
            </div>
            <div class="col-6 col-sm-4 col-md-2">
                <a href="#" class="category-card">
                    <span class="cat-icon">🖥️</span>
                    <div class="cat-name">Máy bàn</div>
                    <div class="cat-count">32+ sản phẩm</div>
                </a>
            </div>
            <div class="col-6 col-sm-4 col-md-2">
                <a href="#" class="category-card">
                    <span class="cat-icon">🖱️</span>
                    <div class="cat-name">Phụ kiện</div>
                    <div class="cat-count">200+ sản phẩm</div>
                </a>
            </div>
            <div class="col-6 col-sm-4 col-md-2">
                <a href="#" class="category-card">
                    <span class="cat-icon">🔋</span>
                    <div class="cat-name">Pin & Sạc</div>
                    <div class="cat-count">60+ sản phẩm</div>
                </a>
            </div>
        </div>
    </div>
</section>

<!-- =============================================
     FEATURED PRODUCTS
     ============================================= -->
<section class="section-padding" style="background:#fff;">
    <div class="container">
        <div class="d-flex justify-content-between align-items-end mb-4 flex-wrap gap-3">
            <div class="section-header mb-0">
                <div class="section-label">Bán chạy nhất</div>
                <h2 class="section-title">Sản phẩm <span>Nổi bật</span></h2>
            </div>
            <!-- Filter tabs -->
            <ul class="nav nav-pills gap-2">
                <li class="nav-item">
                    <a class="nav-link active py-1 px-3" href="#" style="background:var(--highlight);font-size:.85rem;">Tất cả</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link py-1 px-3" href="#" style="font-size:.85rem;">Gaming</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link py-1 px-3" href="#" style="font-size:.85rem;">Văn phòng</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link py-1 px-3" href="#" style="font-size:.85rem;">Đồ họa</a>
                </li>
            </ul>
        </div>

        <div class="row g-4">

            <c:forEach var="product" items="${products}">
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="product-card">
                        <div class="product-img-wrap">
                            <button class="btn-wishlist"><i class="bi bi-heart"></i></button>
                            <a href="/product/${product.id}">
                                <c:choose>
                                    <c:when test="${not empty product.image}">
                                        <img src="/images/product/${product.image}" alt="${product.name}"
                                             style="width:100%;height:160px;object-fit:cover;"/>
                                    </c:when>
                                    <c:otherwise>
                                        <div style="width:100%;height:160px;display:flex;align-items:center;justify-content:center;background:#f4f6fb;color:#ccc;font-size:2.5rem;">
                                            <i class="bi bi-laptop"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </div>
                        <div class="product-body">
                            <div class="product-brand">${product.factory}</div>
                            <a href="/product/${product.id}" class="product-name" style="text-decoration:none;color:inherit;">${product.name}</a>
                            <div class="product-specs">
                                <c:if test="${not empty product.shortDesc}">
                                    <span class="product-spec-tag">${product.shortDesc}</span>
                                </c:if>
                            </div>
                            <div class="product-price-wrap">
                                <div>
                                    <span class="product-price">
                                        <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ
                                    </span>
                                </div>
                                <form method="POST" action="/add-to-cart/${product.id}" class="m-0">
                                    <button type="submit" class="btn-add-cart">
                                        <i class="bi bi-cart-plus"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty products}">
                <div class="col-12 text-center py-5" style="color:#9ca3af;">
                    <i class="bi bi-box-seam" style="font-size:3rem;"></i>
                    <p class="mt-2">Chưa có sản phẩm nào.</p>
                </div>
            </c:if>

        </div>

        <div class="text-center mt-4">
            <a href="#" class="btn btn-outline-dark px-4 py-2 rounded-pill">
                Xem tất cả sản phẩm <i class="bi bi-arrow-right ms-1"></i>
            </a>
        </div>
    </div>
</section>

<!-- =============================================
     PROMOTIONAL BANNERS
     ============================================= -->
<section class="section-padding-sm" style="background:#f8f9fa;">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-6">
                <div class="promo-banner promo-banner-1">
                    <div class="promo-label"><i class="bi bi-controller me-1"></i> Gaming Sale</div>
                    <div class="promo-title">Laptop Gaming<br>RTX 4000 Series</div>
                    <div class="promo-discount">-20%</div>
                    <a href="#" class="btn-promo">Mua ngay →</a>
                </div>
            </div>
            <div class="col-md-6">
                <div class="promo-banner promo-banner-2">
                    <div class="promo-label"><i class="bi bi-briefcase me-1"></i> Business Week</div>
                    <div class="promo-title">Laptop Văn phòng<br>Siêu mỏng nhẹ</div>
                    <div class="promo-discount">-15%</div>
                    <a href="#" class="btn-promo">Khám phá →</a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- =============================================
     BRANDS
     ============================================= -->
<section class="section-padding-sm" style="background:#fff; border-top:1px solid #eee; overflow-x: hidden;">
    <div class="container text-center mb-4">
        <div class="section-label">Thương hiệu uy tín</div>
    </div>
    <style>
        .brand-ticker-wrap {
            overflow: hidden;
            position: relative;
            width: 100vw;
            margin-left: calc(-50vw + 50%);
            background: linear-gradient(90deg, #fff 0%, rgba(255,255,255,0) 10%, rgba(255,255,255,0) 90%, #fff 100%);
            padding-top: 1rem;
            padding-bottom: 2.5rem;
        }
            .brand-ticker-wrap::before, .brand-ticker-wrap::after {
                content: "";
                position: absolute;
                top: 0;
                bottom: 0;
                width: 10%;
                z-index: 2;
                pointer-events: none;
            }
            .brand-ticker-wrap::before {
                left: 0;
                background: linear-gradient(to right, #fff, transparent);
            }
            .brand-ticker-wrap::after {
                right: 0;
                background: linear-gradient(to left, #fff, transparent);
            }

            .brand-ticker {
                display: flex;
                width: max-content;
                animation: ticker 35s linear infinite;
                will-change: transform;
                -webkit-backface-visibility: hidden;
                backface-visibility: hidden;
                transform: translateZ(0);
            }

            .brand-ticker:hover {
                animation-play-state: paused;
            }

            .brand-track {
                display: flex;
                gap: 5rem;
                padding-right: 5rem; /* Match gap so it loops seamlessly */
                will-change: transform;
            }

            @keyframes ticker {
                0% { transform: translate3d(0, 0, 0); }
                100% { transform: translate3d(-50%, 0, 0); }
            }

            .brand-item {
                font-size: 1.8rem;
                font-weight: 800;
                color: #d1d1d1;
                letter-spacing: -1px;
                transition: transform 0.3s ease, color 0.3s ease;
                cursor: pointer;
                text-transform: uppercase;
                user-select: none;
                display: flex;
                align-items: center;
                justify-content: center;
                white-space: nowrap;
                -webkit-font-smoothing: antialiased;
                -moz-osx-font-smoothing: grayscale;
            }

            /* Hover/Active states with brand colors */
            .brand-item.b-asus:hover { color: #00539b; transform: scale(1.1); }
            .brand-item.b-lenovo:hover { color: #e2231a; transform: scale(1.1); text-transform: capitalize;}
            .brand-item.b-apple:hover { color: #555; transform: scale(1.1); text-transform: capitalize;}
            .brand-item.b-dell:hover { color: #0076ce; transform: scale(1.1); }
            .brand-item.b-hp:hover { color: #0096d6; transform: scale(1.1); }
            .brand-item.b-acer:hover { color: #83b81a; transform: scale(1.1); text-transform: capitalize;}
            .brand-item.b-msi:hover { color: #ed1c24; transform: scale(1.1); }
        </style>

        <div class="brand-ticker-wrap">
            <div class="brand-ticker">
                <!-- Group 1 -->
                <div class="brand-track">
                    <div class="brand-item b-asus">ASUS</div>
                    <div class="brand-item b-lenovo">Lenovo</div>
                    <div class="brand-item b-apple">Apple</div>
                    <div class="brand-item b-dell">Dell</div>
                    <div class="brand-item b-hp">HP</div>
                    <div class="brand-item b-acer">Acer</div>
                    <div class="brand-item b-msi">MSI</div>
                </div>
                
                <!-- Group 2 -->
                <div class="brand-track">
                    <div class="brand-item b-asus">ASUS</div>
                    <div class="brand-item b-lenovo">Lenovo</div>
                    <div class="brand-item b-apple">Apple</div>
                    <div class="brand-item b-dell">Dell</div>
                    <div class="brand-item b-hp">HP</div>
                    <div class="brand-item b-acer">Acer</div>
                    <div class="brand-item b-msi">MSI</div>
                </div>

                <!-- Group 3 (Extra buffer for ultra wide screens) -->
                <div class="brand-track">
                    <div class="brand-item b-asus">ASUS</div>
                    <div class="brand-item b-lenovo">Lenovo</div>
                    <div class="brand-item b-apple">Apple</div>
                    <div class="brand-item b-dell">Dell</div>
                    <div class="brand-item b-hp">HP</div>
                    <div class="brand-item b-acer">Acer</div>
                    <div class="brand-item b-msi">MSI</div>
                </div>

                <!-- Group 4 -->
                <div class="brand-track">
                    <div class="brand-item b-asus">ASUS</div>
                    <div class="brand-item b-lenovo">Lenovo</div>
                    <div class="brand-item b-apple">Apple</div>
                    <div class="brand-item b-dell">Dell</div>
                    <div class="brand-item b-hp">HP</div>
                    <div class="brand-item b-acer">Acer</div>
                    <div class="brand-item b-msi">MSI</div>
                </div>
            </div>
        </div>

