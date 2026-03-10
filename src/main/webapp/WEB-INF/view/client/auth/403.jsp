<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>403 - Không có quyền truy cập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #0f0f1a;
            font-family: 'Segoe UI', sans-serif;
            overflow: hidden;
        }

        /* Animated background */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background:
                radial-gradient(ellipse at 20% 50%, rgba(233, 69, 96, 0.15) 0%, transparent 60%),
                radial-gradient(ellipse at 80% 20%, rgba(99, 102, 241, 0.15) 0%, transparent 60%),
                radial-gradient(ellipse at 60% 80%, rgba(16, 185, 129, 0.08) 0%, transparent 60%);
            animation: bgPulse 6s ease-in-out infinite alternate;
            pointer-events: none;
        }

        @keyframes bgPulse {
            0%   { opacity: 0.6; }
            100% { opacity: 1; }
        }

        .container {
            text-align: center;
            padding: 2rem;
            position: relative;
            z-index: 1;
        }

        /* Big 403 number */
        .error-code {
            font-size: clamp(8rem, 20vw, 14rem);
            font-weight: 900;
            line-height: 1;
            letter-spacing: -0.05em;
            background: linear-gradient(135deg, #e94560 0%, #6366f1 50%, #e94560 100%);
            background-size: 200% auto;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: shimmer 3s linear infinite;
            filter: drop-shadow(0 0 40px rgba(233, 69, 96, 0.4));
        }

        @keyframes shimmer {
            0%   { background-position: 0% center; }
            100% { background-position: 200% center; }
        }

        /* Lock icon */
        .lock-wrap {
            margin: 1rem auto;
            width: 80px;
            height: 80px;
            background: rgba(233, 69, 96, 0.1);
            border: 2px solid rgba(233, 69, 96, 0.3);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: lockPulse 2s ease-in-out infinite;
        }

        .lock-wrap i {
            font-size: 2rem;
            color: #e94560;
        }

        @keyframes lockPulse {
            0%, 100% { transform: scale(1);     box-shadow: 0 0 0 0 rgba(233,69,96,0.4); }
            50%       { transform: scale(1.08);  box-shadow: 0 0 0 16px rgba(233,69,96,0); }
        }

        .title {
            font-size: 1.6rem;
            font-weight: 700;
            color: #f1f1f1;
            margin: 1rem 0 0.5rem;
        }

        .subtitle {
            color: rgba(255,255,255,0.45);
            font-size: 0.95rem;
            max-width: 380px;
            margin: 0 auto 2.5rem;
            line-height: 1.6;
        }

        /* Buttons */
        .btn-group-custom {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-home {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.8rem;
            background: linear-gradient(135deg, #e94560, #c73652);
            color: #fff;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s;
            box-shadow: 0 4px 20px rgba(233,69,96,0.35);
        }

        .btn-home:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(233,69,96,0.5);
            color: #fff;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.8rem;
            background: transparent;
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            border: 1.5px solid rgba(255,255,255,0.15);
            transition: all 0.3s;
            cursor: pointer;
        }

        .btn-back:hover {
            border-color: rgba(255,255,255,0.4);
            color: #fff;
            background: rgba(255,255,255,0.05);
            transform: translateY(-2px);
        }

        /* Floating particles */
        .particles {
            position: fixed;
            inset: 0;
            pointer-events: none;
            overflow: hidden;
        }

        .particle {
            position: absolute;
            border-radius: 50%;
            opacity: 0;
            animation: float linear infinite;
        }

        @keyframes float {
            0%   { transform: translateY(100vh) scale(0); opacity: 0; }
            10%  { opacity: 0.6; }
            90%  { opacity: 0.3; }
            100% { transform: translateY(-10vh) scale(1); opacity: 0; }
        }
    </style>
</head>
<body>

<!-- Floating particles -->
<div class="particles" id="particles"></div>

<div class="container">
    <div class="error-code">403</div>

    <div class="lock-wrap">
        <i class="bi bi-shield-lock-fill"></i>
    </div>

    <h1 class="title">Truy cập bị từ chối</h1>
    <p class="subtitle">Bạn không có quyền truy cập vào trang này. Vui lòng đăng nhập với tài khoản có quyền phù hợp.</p>

    <div class="btn-group-custom">
        <a href="/" class="btn-home">
            <i class="bi bi-house-fill"></i> Về trang chủ
        </a>
        <button onclick="history.back()" class="btn-back">
            <i class="bi bi-arrow-left"></i> Quay lại
        </button>
    </div>
</div>

<script>
    // Generate floating particles
    const container = document.getElementById('particles');
    const colors = ['#e94560', '#6366f1', '#10b981', '#f59e0b'];
    for (let i = 0; i < 25; i++) {
        const p = document.createElement('div');
        p.className = 'particle';
        const size = Math.random() * 6 + 3;
        p.style.cssText = `
            width: ${size}px; height: ${size}px;
            left: ${Math.random() * 100}%;
            background: ${colors[Math.floor(Math.random() * colors.length)]};
            animation-duration: ${Math.random() * 10 + 8}s;
            animation-delay: ${Math.random() * 8}s;
        `;
        container.appendChild(p);
    }
</script>
</body>
</html>
