package vn.pildo.laptopshop.controller.client;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import vn.pildo.laptopshop.domain.CartItem;
import vn.pildo.laptopshop.domain.Product;
import vn.pildo.laptopshop.domain.User;
import vn.pildo.laptopshop.service.CartService;
import vn.pildo.laptopshop.service.ProductService;
import vn.pildo.laptopshop.service.UserService;

@Controller
public class CartController {

    private final CartService cartService;
    private final ProductService productService;
    private final UserService userService;

    public CartController(CartService cartService, ProductService productService, UserService userService) {
        this.cartService = cartService;
        this.productService = productService;
        this.userService = userService;
    }

    // ----------------------------------------------------------------
    // Xem giỏ hàng
    // ----------------------------------------------------------------
    @GetMapping("/cart")
    public String getCartPage(Model model, Authentication auth) {
        if (auth == null || !auth.isAuthenticated()) {
            return "redirect:/login";
        }

        User user = userService.getUserByEmail(auth.getName());
        List<CartItem> cartItems = cartService.getCartByUser(user);
        double totalPrice = cartService.getTotalPrice(cartItems);

        // Gợi ý sản phẩm: tất cả sản phẩm (bạn có thể lọc theo category sau)
        List<Product> suggestedProducts = productService.getAllProducts();

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("suggestedProducts", suggestedProducts);

        return "client/cart";
    }

    // ----------------------------------------------------------------
    // Thêm vào giỏ từ trang sản phẩm (POST /add-to-cart/{productId})
    // Sau khi thêm -> quay lại đúng trang đang đứng (Referer), không mở detail
    // ----------------------------------------------------------------
    @PostMapping("/add-to-cart/{productId}")
    public String addToCart(@PathVariable long productId,
                            Authentication auth,
                            HttpServletRequest request,
                            HttpSession session) {
        if (auth == null || !auth.isAuthenticated()) {
            return "redirect:/login";
        }

        User user = userService.getUserByEmail(auth.getName());
        Product product = productService.getProductById(productId);

        if (product != null) {
            cartService.addToCart(user, product);
            session.setAttribute("cartCount", cartService.countCartItems(user));
        }

        // Quay lại đúng trang đang đứng, fallback về trang chủ
        String referer = request.getHeader("Referer");
        return "redirect:" + (referer != null ? referer : "/");
    }

    // ----------------------------------------------------------------
    // Thêm vào giỏ từ trang giỏ hàng (gợi ý sp) -> redirect /cart
    // ----------------------------------------------------------------
    @PostMapping("/cart/add/{productId}")
    public String addToCartFromCart(@PathVariable long productId,
                                    Authentication auth,
                                    HttpSession session) {
        if (auth == null || !auth.isAuthenticated()) {
            return "redirect:/login";
        }

        User user = userService.getUserByEmail(auth.getName());
        Product product = productService.getProductById(productId);

        if (product != null) {
            cartService.addToCart(user, product);
            session.setAttribute("cartCount", cartService.countCartItems(user));
        }
        return "redirect:/cart";
    }

    // ----------------------------------------------------------------
    // Xóa 1 item (POST /cart/delete/{cartItemId})
    // ----------------------------------------------------------------
    @PostMapping("/cart/delete/{cartItemId}")
    public String deleteCartItem(@PathVariable long cartItemId,
                                 Authentication auth,
                                 HttpSession session) {
        cartService.removeItem(cartItemId);
        if (auth != null && auth.isAuthenticated()) {
            User user = userService.getUserByEmail(auth.getName());
            session.setAttribute("cartCount", cartService.countCartItems(user));
        }
        return "redirect:/cart";
    }

    // ----------------------------------------------------------------
    // Xóa toàn bộ giỏ (POST /cart/clear)
    // ----------------------------------------------------------------
    @PostMapping("/cart/clear")
    public String clearCart(Authentication auth, HttpSession session) {
        if (auth != null && auth.isAuthenticated()) {
            User user = userService.getUserByEmail(auth.getName());
            cartService.clearCart(user);
            session.setAttribute("cartCount", 0);
        }
        return "redirect:/cart";
    }

    // ----------------------------------------------------------------
    // Cập nhật số lượng (POST /cart/update/{cartItemId})
    // ----------------------------------------------------------------
    @PostMapping("/cart/update/{cartItemId}")
    public String updateQuantity(@PathVariable long cartItemId,
                                 int quantity,
                                 Authentication auth,
                                 HttpSession session) {
        cartService.updateQuantity(cartItemId, quantity);
        if (auth != null && auth.isAuthenticated()) {
            User user = userService.getUserByEmail(auth.getName());
            session.setAttribute("cartCount", cartService.countCartItems(user));
        }
        return "redirect:/cart";
    }
}
