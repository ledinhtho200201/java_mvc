package vn.pildo.laptopshop.controller.client;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import vn.pildo.laptopshop.domain.Order;
import vn.pildo.laptopshop.domain.User;
import vn.pildo.laptopshop.service.OrderService;
import vn.pildo.laptopshop.service.UserService;

@Controller
public class OrdersController {

    private final OrderService orderService;
    private final UserService userService;

    public OrdersController(OrderService orderService, UserService userService) {
        this.orderService = orderService;
        this.userService = userService;
    }

    @GetMapping("/orders")
    public String getOrders(Model model, Authentication auth) {
        if (auth == null || !auth.isAuthenticated()) return "redirect:/login";
        User user = userService.getUserByEmail(auth.getName());
        List<Order> orders = orderService.getOrdersByUser(user);
        model.addAttribute("orders", orders);
        return "client/orders";
    }

    @GetMapping("/orders/{orderId}")
    public String getOrderDetail(@PathVariable long orderId, Model model, Authentication auth) {
        if (auth == null || !auth.isAuthenticated()) return "redirect:/login";
        Order order = orderService.getOrderById(orderId);
        if (order == null) return "redirect:/orders";
        // Bảo vệ: chỉ xem đơn của chính mình
        User user = userService.getUserByEmail(auth.getName());
        if (order.getUser().getId() != user.getId()) return "redirect:/orders";
        model.addAttribute("order", order);
        return "client/order-detail";
    }
}
