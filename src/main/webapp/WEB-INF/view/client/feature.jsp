<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

            <!-- Product 1 -->
            <div class="col-6 col-md-4 col-lg-3">
                <div class="product-card">
                    <div class="product-img-wrap">
                        <span class="badge-sale">-15%</span>
                        <button class="btn-wishlist"><i class="bi bi-heart"></i></button>
                        <svg width="160" height="110" viewBox="0 0 160 110" xmlns="http://www.w3.org/2000/svg">
                            <rect x="10" y="5" width="140" height="88" rx="6" fill="#1a1a2e"/>
                            <rect x="16" y="11" width="128" height="76" rx="4" fill="#0d1117"/>
                            <rect x="20" y="15" width="120" height="68" rx="3" fill="linear-gradient(135deg,#e94560,#0f3460)"/>
                            <rect x="20" y="15" width="120" height="68" rx="3" fill="#e94560" opacity="0.15"/>
                            <text x="80" y="52" font-family="Arial" font-size="11" font-weight="bold" fill="white" text-anchor="middle">ASUS ROG</text>
                            <text x="80" y="66" font-family="Arial" font-size="8" fill="rgba(255,255,255,0.7)" text-anchor="middle">Strix G16 RTX4070</text>
                            <rect x="5" y="92" width="150" height="16" rx="3" fill="#1a1a2e"/>
                            <rect x="55" y="96" width="50" height="8" rx="2" fill="#2d3748"/>
                        </svg>
                    </div>
                    <div class="product-body">
                        <div class="product-brand">ASUS ROG</div>
                        <div class="product-name">ASUS ROG Strix G16 Gaming RTX 4070 165Hz</div>
                        <div class="product-specs">
                            <span class="product-spec-tag">Intel i9-13980HX</span>
                            <span class="product-spec-tag">16GB DDR5</span>
                            <span class="product-spec-tag">1TB SSD</span>
                        </div>
                        <div class="product-rating">
                            <span class="stars"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i></span>
                            <span class="review-count">(128)</span>
                        </div>
                        <div class="product-price-wrap">
                            <div>
                                <span class="product-price-old">48.990.000đ</span>
                                <span class="product-price">41.641.000đ</span>
                            </div>
                            <button class="btn-add-cart"><i class="bi bi-cart-plus"></i></button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product 2 -->
            <div class="col-6 col-md-4 col-lg-3">
                <div class="product-card">
                    <div class="product-img-wrap">
                        <span class="badge-new">Mới</span>
                        <button class="btn-wishlist"><i class="bi bi-heart"></i></button>
                        <svg width="160" height="110" viewBox="0 0 160 110" xmlns="http://www.w3.org/2000/svg">
                            <rect x="10" y="5" width="140" height="88" rx="6" fill="#c0c0c0"/>
                            <rect x="16" y="11" width="128" height="76" rx="4" fill="#1a1a1a"/>
                            <rect x="20" y="15" width="120" height="68" rx="3" fill="#2d2d2d"/>
                            <circle cx="80" cy="49" r="12" fill="#e94560" opacity="0.8"/>
                            <text x="80" y="54" font-family="Arial" font-size="10" font-weight="bold" fill="white" text-anchor="middle">M</text>
                            <text x="80" y="70" font-family="Arial" font-size="8" fill="rgba(255,255,255,0.7)" text-anchor="middle">MacBook Pro M3</text>
                            <rect x="5" y="92" width="150" height="16" rx="3" fill="#c0c0c0"/>
                            <rect x="55" y="96" width="50" height="8" rx="2" fill="#a0a0a0"/>
                        </svg>
                    </div>
                    <div class="product-body">
                        <div class="product-brand">Apple</div>
                        <div class="product-name">MacBook Pro 14 inch M3 Pro 2024</div>
                        <div class="product-specs">
                            <span class="product-spec-tag">M3 Pro</span>
                            <span class="product-spec-tag">18GB RAM</span>
                            <span class="product-spec-tag">512GB SSD</span>
                        </div>
                        <div class="product-rating">
                            <span class="stars"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i></span>
                            <span class="review-count">(256)</span>
                        </div>
                        <div class="product-price-wrap">
                            <div>
                                <span class="product-price-old">&nbsp;</span>
                                <span class="product-price">52.990.000đ</span>
                            </div>
                            <button class="btn-add-cart"><i class="bi bi-cart-plus"></i></button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product 3 -->
            <div class="col-6 col-md-4 col-lg-3">
                <div class="product-card">
                    <div class="product-img-wrap">
                        <span class="badge-sale">-20%</span>
                        <button class="btn-wishlist"><i class="bi bi-heart"></i></button>
                        <svg width="160" height="110" viewBox="0 0 160 110" xmlns="http://www.w3.org/2000/svg">
                            <rect x="10" y="5" width="140" height="88" rx="6" fill="#2c2c2c"/>
                            <rect x="16" y="11" width="128" height="76" rx="4" fill="#0d1117"/>
                            <rect x="20" y="15" width="120" height="68" rx="3" fill="#1a1a2e"/>
                            <text x="80" y="46" font-family="Arial" font-size="10" font-weight="bold" fill="#00aeff" text-anchor="middle">ThinkPad</text>
                            <text x="80" y="60" font-family="Arial" font-size="9" fill="rgba(255,255,255,0.8)" text-anchor="middle">X1 Carbon</text>
                            <text x="80" y="72" font-family="Arial" font-size="7" fill="rgba(255,255,255,0.5)" text-anchor="middle">Gen 12</text>
                            <rect x="5" y="92" width="150" height="16" rx="3" fill="#2c2c2c"/>
                            <rect x="55" y="96" width="50" height="8" rx="2" fill="#3d3d3d"/>
                        </svg>
                    </div>
                    <div class="product-body">
                        <div class="product-brand">Lenovo</div>
                        <div class="product-name">Lenovo ThinkPad X1 Carbon Gen 12 Ultrabook</div>
                        <div class="product-specs">
                            <span class="product-spec-tag">Intel Ultra 7</span>
                            <span class="product-spec-tag">32GB LPDDR5</span>
                            <span class="product-spec-tag">1TB SSD</span>
                        </div>
                        <div class="product-rating">
                            <span class="stars"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i></span>
                            <span class="review-count">(74)</span>
                        </div>
                        <div class="product-price-wrap">
                            <div>
                                <span class="product-price-old">45.500.000đ</span>
                                <span class="product-price">36.400.000đ</span>
                            </div>
                            <button class="btn-add-cart"><i class="bi bi-cart-plus"></i></button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product 4 -->
            <div class="col-6 col-md-4 col-lg-3">
                <div class="product-card">
                    <div class="product-img-wrap">
                        <button class="btn-wishlist"><i class="bi bi-heart"></i></button>
                        <svg width="160" height="110" viewBox="0 0 160 110" xmlns="http://www.w3.org/2000/svg">
                            <rect x="10" y="5" width="140" height="88" rx="6" fill="#1a1a2e"/>
                            <rect x="16" y="11" width="128" height="76" rx="4" fill="#0d1117"/>
                            <rect x="20" y="15" width="120" height="68" rx="3" fill="#0f3460"/>
                            <text x="80" y="46" font-family="Arial" font-size="9" font-weight="bold" fill="#ffd700" text-anchor="middle">HP OMEN</text>
                            <text x="80" y="60" font-family="Arial" font-size="8" fill="rgba(255,255,255,0.8)" text-anchor="middle">16 RTX 4060</text>
                            <text x="80" y="72" font-family="Arial" font-size="7" fill="rgba(255,255,255,0.5)" text-anchor="middle">QHD 165Hz</text>
                            <rect x="5" y="92" width="150" height="16" rx="3" fill="#1a1a2e"/>
                            <rect x="55" y="96" width="50" height="8" rx="2" fill="#2d3748"/>
                        </svg>
                    </div>
                    <div class="product-body">
                        <div class="product-brand">HP</div>
                        <div class="product-name">HP OMEN 16 Gaming RTX 4060 QHD 165Hz</div>
                        <div class="product-specs">
                            <span class="product-spec-tag">AMD Ryzen 7</span>
                            <span class="product-spec-tag">16GB DDR5</span>
                            <span class="product-spec-tag">512GB SSD</span>
                        </div>
                        <div class="product-rating">
                            <span class="stars"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i></span>
                            <span class="review-count">(93)</span>
                        </div>
                        <div class="product-price-wrap">
                            <div>
                                <span class="product-price-old">&nbsp;</span>
                                <span class="product-price">32.990.000đ</span>
                            </div>
                            <button class="btn-add-cart"><i class="bi bi-cart-plus"></i></button>
                        </div>
                    </div>
                </div>
            </div>

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
<section class="section-padding-sm" style="background:#fff; border-top:1px solid #eee;">
    <div class="container">
        <div class="text-center mb-4">
            <div class="section-label">Thương hiệu uy tín</div>
        </div>
        <div class="row align-items-center justify-content-center g-4 text-center">
            <div class="col-4 col-md-2">
                <div style="font-size:1.5rem; font-weight:800; color:#aaa; letter-spacing:-1px;">ASUS</div>
            </div>
            <div class="col-4 col-md-2">
                <div style="font-size:1.3rem; font-weight:700; color:#aaa;">Lenovo</div>
            </div>
            <div class="col-4 col-md-2">
                <div style="font-size:1.3rem; font-weight:700; color:#aaa; letter-spacing:-0.5px;">Apple</div>
            </div>
            <div class="col-4 col-md-2">
                <div style="font-size:1.3rem; font-weight:800; color:#aaa;">Dell</div>
            </div>
            <div class="col-4 col-md-2">
                <div style="font-size:1.3rem; font-weight:700; color:#aaa;">HP</div>
            </div>
            <div class="col-4 col-md-2">
                <div style="font-size:1.3rem; font-weight:700; color:#aaa;">Acer</div>
            </div>
        </div>
    </div>
</section>
