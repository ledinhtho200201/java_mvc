package vn.pildo.laptopshop.config;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.pildo.laptopshop.domain.User;
import vn.pildo.laptopshop.service.CartService;
import vn.pildo.laptopshop.service.UserService;

public class CustomSuccessHandler implements AuthenticationSuccessHandler {

    private final UserService userService;
    private final CartService cartService;
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    public CustomSuccessHandler(UserService userService, CartService cartService) {
        this.userService = userService;
        this.cartService = cartService;
    }

    protected String determineTargetUrl(final Authentication authentication) {
        Map<String, String> roleTargetUrlMap = new HashMap<>();
        roleTargetUrlMap.put("ROLE_USER", "/");
        roleTargetUrlMap.put("ROLE_ADMIN", "/admin/dashboard");

        final Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (final GrantedAuthority grantedAuthority : authorities) {
            String authorityName = grantedAuthority.getAuthority();
            if (roleTargetUrlMap.containsKey(authorityName)) {
                return roleTargetUrlMap.get(authorityName);
            }
        }
        throw new IllegalStateException();
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return;
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {

        User user = this.userService.getUserByEmail(authentication.getName());
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("avatar", user.getAvatar());
            session.setAttribute("id", user.getId());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("role", user.getRole());
            // Badge giỏ hàng: đếm từ DB
            session.setAttribute("cartCount", cartService.countCartItems(user));
        }

        String targetUrl = determineTargetUrl(authentication);
        if (response.isCommitted()) return;
        redirectStrategy.sendRedirect(request, response, targetUrl);
        clearAuthenticationAttributes(request);
    }
}

