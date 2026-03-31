package vn.pildo.laptopshop.controller.client;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import vn.pildo.laptopshop.domain.CartItem;
import vn.pildo.laptopshop.domain.Order;
import vn.pildo.laptopshop.domain.User;
import vn.pildo.laptopshop.service.CartService;
import vn.pildo.laptopshop.service.OrderService;
import vn.pildo.laptopshop.service.UserService;

import java.util.List;

@Controller
public class CheckoutController {

    private final CartService cartService;
    private final OrderService orderService;
    private final UserService userService;

    public CheckoutController(CartService cartService,
                              OrderService orderService,
                              UserService userService) {
        this.cartService = cartService;
        this.orderService = orderService;
        this.userService = userService;
    }

    // ── Bước 2: Form thông tin giao hàng ──────────────────────────
    @GetMapping("/checkout")
    public String showCheckout(Model model, Authentication auth) {
        if (auth == null || !auth.isAuthenticated()) return "redirect:/login";

        User user = userService.getUserByEmail(auth.getName());
        List<CartItem> cartItems = cartService.getCartByUser(user);

        if (cartItems.isEmpty()) return "redirect:/cart";

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalPrice", cartService.getTotalPrice(cartItems));
        model.addAttribute("user", user);
        return "client/checkout";
    }

    // ── POST: Xác nhận thông tin → tạo đơn → chuyển sang thanh toán
    @PostMapping("/checkout")
    public String placeOrder(@RequestParam String receiverName,
                             @RequestParam String receiverPhone,
                             @RequestParam String receiverAddress,
                             @RequestParam(required = false) String note,
                             @RequestParam String paymentMethod,
                             Authentication auth,
                             HttpSession session) {

        if (auth == null || !auth.isAuthenticated()) return "redirect:/login";

        User user = userService.getUserByEmail(auth.getName());
        Order order = orderService.createOrder(user, receiverName, receiverPhone,
                receiverAddress, note, paymentMethod);

        if (order == null) return "redirect:/cart";

        // Giỏ đã được clear → reset badge
        session.setAttribute("cartCount", 0);

        // COD → thẳng tới trang thành công
        if ("COD".equals(paymentMethod)) {
            return "redirect:/order-success/" + order.getId();
        }

        // Chuyển khoản / Momo → trang thanh toán
        return "redirect:/payment/" + order.getId();
    }

    // ── Bước 3: Trang thanh toán (QR / Momo) ──────────────────────
    @GetMapping("/payment/{orderId}")
    public String showPayment(@PathVariable long orderId, Model model, Authentication auth) {
        if (auth == null || !auth.isAuthenticated()) return "redirect:/login";

        Order order = orderService.getOrderById(orderId);
        if (order == null) return "redirect:/";
        User user = userService.getUserByEmail(auth.getName());
        if (user == null || order.getUser() == null || order.getUser().getId() != user.getId()) {
            return "redirect:/orders";
        }

        model.addAttribute("order", order);
        return "client/payment";
    }

    // ── POST: Xác nhận đã chuyển khoản ────────────────────────────
    @PostMapping("/payment/{orderId}/confirm")
    public String confirmPayment(@PathVariable long orderId, Authentication auth) {
        if (auth == null || !auth.isAuthenticated()) return "redirect:/login";

        Order order = orderService.getOrderById(orderId);
        User user = userService.getUserByEmail(auth.getName());
        if (order == null || user == null || order.getUser() == null || order.getUser().getId() != user.getId()) {
            return "redirect:/orders";
        }

        orderService.markAsPaid(orderId);
        return "redirect:/order-success/" + orderId;
    }

    // ── Bước 4: Đặt hàng thành công ───────────────────────────────
    @GetMapping("/order-success/{orderId}")
    public String orderSuccess(@PathVariable long orderId, Model model, Authentication auth) {
        if (auth == null || !auth.isAuthenticated()) return "redirect:/login";

        Order order = orderService.getOrderById(orderId);
        if (order == null) return "redirect:/";
        User user = userService.getUserByEmail(auth.getName());
        if (user == null || order.getUser() == null || order.getUser().getId() != user.getId()) {
            return "redirect:/orders";
        }

        model.addAttribute("order", order);
        return "client/order-success";
    }
}
