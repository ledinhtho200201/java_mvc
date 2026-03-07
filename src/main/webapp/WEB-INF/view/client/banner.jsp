<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- =============================================
     HERO BANNER (CAROUSEL)
     ============================================= -->
<section class="hero-section">
    <div id="heroBanner" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#heroBanner" data-bs-slide-to="0" class="active"></button>
            <button type="button" data-bs-target="#heroBanner" data-bs-slide-to="1"></button>
            <button type="button" data-bs-target="#heroBanner" data-bs-slide-to="2"></button>
        </div>

        <div class="carousel-inner">

            <!-- Slide 1 -->
            <div class="carousel-item active">
                <div class="container">
                    <div class="row align-items-center min-vh-50 py-4">
                        <div class="col-lg-6" data-bs-theme="dark">
                            <div class="hero-badge">
                                <i class="bi bi-lightning-charge-fill me-1"></i> Flash Sale - Hôm nay
                            </div>
                            <h1 class="hero-title">
                                Laptop Gaming<br>
                                <span>RTX 4070</span> Series
                            </h1>
                            <p class="hero-subtitle">
                                Trải nghiệm gaming đỉnh cao với card đồ họa RTX 4070,
                                màn hình 165Hz, RAM 16GB DDR5 tốc độ cao.
                            </p>
                            <div class="d-flex flex-wrap gap-3">
                                <a href="#" class="btn-hero-primary">
                                    <i class="bi bi-cart3 me-2"></i>Mua ngay
                                </a>
                                <a href="#" class="btn-hero-secondary">
                                    <i class="bi bi-play-circle me-2"></i>Xem chi tiết
                                </a>
                            </div>
                            <div class="hero-stats">
                                <div class="hero-stat-item">
                                    <div class="stat-number">500+</div>
                                    <div class="stat-label">Sản phẩm</div>
                                </div>
                                <div class="hero-stat-item">
                                    <div class="stat-number">50K+</div>
                                    <div class="stat-label">Khách hàng</div>
                                </div>
                                <div class="hero-stat-item">
                                    <div class="stat-number">4.9★</div>
                                    <div class="stat-label">Đánh giá</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 d-none d-lg-block">
                            <div class="hero-image-wrap">
                                <!-- Placeholder image với SVG laptop -->
                                <svg width="480" height="320" viewBox="0 0 480 320" xmlns="http://www.w3.org/2000/svg">
                                    <defs>
                                        <linearGradient id="laptopGrad1" x1="0%" y1="0%" x2="100%" y2="100%">
                                            <stop offset="0%" style="stop-color:#2d3748;stop-opacity:1" />
                                            <stop offset="100%" style="stop-color:#1a202c;stop-opacity:1" />
                                        </linearGradient>
                                        <linearGradient id="screenGrad1" x1="0%" y1="0%" x2="100%" y2="100%">
                                            <stop offset="0%" style="stop-color:#e94560;stop-opacity:1" />
                                            <stop offset="100%" style="stop-color:#0f3460;stop-opacity:1" />
                                        </linearGradient>
                                    </defs>
                                    <!-- Laptop lid -->
                                    <rect x="60" y="20" width="360" height="230" rx="12" fill="url(#laptopGrad1)"/>
                                    <!-- Screen bezel -->
                                    <rect x="75" y="35" width="330" height="205" rx="8" fill="#0d1117"/>
                                    <!-- Screen content -->
                                    <rect x="82" y="42" width="316" height="191" rx="5" fill="url(#screenGrad1)"/>
                                    <!-- Screen glow -->
                                    <rect x="82" y="42" width="316" height="191" rx="5" fill="url(#screenGrad1)" opacity="0.7"/>
                                    <!-- RTX Logo on screen -->
                                    <text x="240" y="140" font-family="Arial" font-size="28" font-weight="bold" fill="white" text-anchor="middle">RTX 4070</text>
                                    <text x="240" y="170" font-family="Arial" font-size="14" fill="rgba(255,255,255,0.7)" text-anchor="middle">GAMING SERIES</text>
                                    <!-- Keyboard base -->
                                    <rect x="30" y="248" width="420" height="50" rx="6" fill="url(#laptopGrad1)"/>
                                    <rect x="30" y="292" width="420" height="6" rx="3" fill="#0f1923"/>
                                    <!-- Touchpad -->
                                    <rect x="185" y="257" width="110" height="30" rx="4" fill="#1a2535"/>
                                    <!-- Keyboard keys hint -->
                                    <rect x="55" y="254" width="8" height="5" rx="1" fill="#2d3748"/>
                                    <rect x="68" y="254" width="8" height="5" rx="1" fill="#2d3748"/>
                                    <rect x="81" y="254" width="8" height="5" rx="1" fill="#2d3748"/>
                                    <rect x="94" y="254" width="8" height="5" rx="1" fill="#2d3748"/>
                                    <rect x="55" y="264" width="12" height="5" rx="1" fill="#2d3748"/>
                                    <rect x="72" y="264" width="8" height="5" rx="1" fill="#2d3748"/>
                                    <rect x="85" y="264" width="8" height="5" rx="1" fill="#2d3748"/>
                                    <!-- RGB glow -->
                                    <rect x="30" y="295" width="420" height="3" rx="1.5" fill="#e94560" opacity="0.6"/>
                                </svg>
                                <div class="hero-floating-card card-1">
                                    <i class="bi bi-star-fill"></i> RTX 4070 Ti 12GB
                                </div>
                                <div class="hero-floating-card card-2">
                                    <i class="bi bi-fire"></i> Giảm 15% hôm nay
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Slide 2 -->
            <div class="carousel-item">
                <div class="container">
                    <div class="row align-items-center min-vh-50 py-4">
                        <div class="col-lg-6">
                            <div class="hero-badge">
                                <i class="bi bi-briefcase-fill me-1"></i> Văn phòng & Doanh nhân
                            </div>
                            <h1 class="hero-title">
                                ThinkPad &<br>
                                <span>MacBook</span> Pro
                            </h1>
                            <p class="hero-subtitle">
                                Laptop dành cho dân văn phòng và doanh nhân.
                                Mỏng nhẹ, pin trâu, hiệu năng vượt trội.
                            </p>
                            <div class="d-flex flex-wrap gap-3">
                                <a href="#" class="btn-hero-primary">
                                    <i class="bi bi-bag me-2"></i>Khám phá ngay
                                </a>
                                <a href="#" class="btn-hero-secondary">
                                    <i class="bi bi-compare me-2"></i>So sánh
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-6 d-none d-lg-block text-center">
                            <svg width="460" height="300" viewBox="0 0 460 300" xmlns="http://www.w3.org/2000/svg">
                                <defs>
                                    <linearGradient id="laptopGrad2" x1="0%" y1="0%" x2="100%" y2="100%">
                                        <stop offset="0%" style="stop-color:#d4d4d4;stop-opacity:1" />
                                        <stop offset="100%" style="stop-color:#a0a0a0;stop-opacity:1" />
                                    </linearGradient>
                                </defs>
                                <rect x="55" y="15" width="350" height="220" rx="14" fill="url(#laptopGrad2)"/>
                                <rect x="68" y="28" width="324" height="196" rx="8" fill="#1a1a1a"/>
                                <rect x="75" y="35" width="310" height="182" rx="5" fill="#2d2d2d"/>
                                <circle cx="230" cy="126" r="18" fill="#e94560" opacity="0.9"/>
                                <text x="230" y="132" font-family="Arial" font-size="16" font-weight="bold" fill="white" text-anchor="middle">M</text>
                                <text x="230" y="175" font-family="Arial" font-size="13" fill="rgba(255,255,255,0.8)" text-anchor="middle">MacBook Pro</text>
                                <rect x="25" y="233" width="410" height="48" rx="6" fill="url(#laptopGrad2)"/>
                                <rect x="25" y="275" width="410" height="6" rx="3" fill="#888"/>
                                <rect x="178" y="241" width="104" height="28" rx="5" fill="#b8b8b8"/>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Slide 3 -->
            <div class="carousel-item">
                <div class="container">
                    <div class="row align-items-center min-vh-50 py-4">
                        <div class="col-lg-6">
                            <div class="hero-badge">
                                <i class="bi bi-brush-fill me-1"></i> Đồ họa & Thiết kế
                            </div>
                            <h1 class="hero-title">
                                Workstation<br>
                                <span>Đồ họa</span> Pro
                            </h1>
                            <p class="hero-subtitle">
                                Màn hình 4K OLED, Quadro RTX, RAM 64GB ECC.
                                Phù hợp cho designer, video editor, 3D artist.
                            </p>
                            <div class="d-flex flex-wrap gap-3">
                                <a href="#" class="btn-hero-primary">
                                    <i class="bi bi-palette me-2"></i>Xem bộ sưu tập
                                </a>
                                <a href="#" class="btn-hero-secondary">
                                    <i class="bi bi-info-circle me-2"></i>Tư vấn miễn phí
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-6 d-none d-lg-block text-center">
                            <svg width="460" height="300" viewBox="0 0 460 300" xmlns="http://www.w3.org/2000/svg">
                                <defs>
                                    <linearGradient id="laptopGrad3" x1="0%" y1="0%" x2="100%" y2="100%">
                                        <stop offset="0%" style="stop-color:#1a1a2e;stop-opacity:1"/>
                                        <stop offset="100%" style="stop-color:#16213e;stop-opacity:1"/>
                                    </linearGradient>
                                    <linearGradient id="screenGrad3" x1="0%" y1="0%" x2="100%" y2="100%">
                                        <stop offset="0%" style="stop-color:#8b5cf6;stop-opacity:1"/>
                                        <stop offset="100%" style="stop-color:#06b6d4;stop-opacity:1"/>
                                    </linearGradient>
                                </defs>
                                <rect x="55" y="15" width="350" height="220" rx="12" fill="url(#laptopGrad3)"/>
                                <rect x="70" y="30" width="320" height="195" rx="8" fill="#0d1117"/>
                                <rect x="77" y="37" width="306" height="181" rx="5" fill="url(#screenGrad3)"/>
                                <text x="230" y="130" font-family="Arial" font-size="22" font-weight="bold" fill="white" text-anchor="middle">QUADRO RTX</text>
                                <text x="230" y="160" font-family="Arial" font-size="12" fill="rgba(255,255,255,0.7)" text-anchor="middle">WORKSTATION PRO</text>
                                <rect x="25" y="233" width="410" height="48" rx="6" fill="url(#laptopGrad3)"/>
                                <rect x="25" y="275" width="410" height="6" rx="3" fill="#0d1117"/>
                                <rect x="178" y="241" width="104" height="28" rx="5" fill="#1a2535"/>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- Carousel Controls -->
        <button class="carousel-control-prev" type="button" data-bs-target="#heroBanner" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#heroBanner" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>
</section>
