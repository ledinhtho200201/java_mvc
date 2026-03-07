<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>LaptopShop - Chuyên laptop chính hãng giá tốt</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <!-- Custom Client CSS -->
    <link href="/css/client.css" rel="stylesheet"/>
</head>
<body>

    <!-- ========== HEADER ========== -->
    <%@ include file="/WEB-INF/view/client/header.jsp" %>

    <!-- ========== BANNER ========== -->
    <%@ include file="/WEB-INF/view/client/banner.jsp" %>

    <!-- ========== FEATURES, CATEGORIES, PRODUCTS ========== -->
    <%@ include file="/WEB-INF/view/client/feature.jsp" %>

    <!-- ========== FOOTER ========== -->
    <%@ include file="/WEB-INF/view/client/footer.jsp" %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script>
        // Wishlist toggle
        $(document).ready(function () {
            $('.btn-wishlist').on('click', function () {
                const icon = $(this).find('i');
                icon.toggleClass('bi-heart bi-heart-fill');
                icon.css('color', icon.hasClass('bi-heart-fill') ? '#e94560' : '');
            });

            // Add to cart animation
            $('.btn-add-cart').on('click', function () {
                const btn = $(this);
                btn.html('<i class="bi bi-check-lg"></i>');
                btn.css('background', '#28a745');
                setTimeout(function () {
                    btn.html('<i class="bi bi-cart-plus"></i>');
                    btn.css('background', '');
                }, 1500);
            });

            // Search focus
            $('.search-bar input').on('focus', function () {
                $(this).parent().addClass('focused');
            }).on('blur', function () {
                $(this).parent().removeClass('focused');
            });
        });
    </script>
</body>
</html>
