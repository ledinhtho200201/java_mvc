package vn.pildo.laptopshop.controller.admin;

import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.pildo.laptopshop.domain.Order;
import vn.pildo.laptopshop.service.OrderService;

import java.util.List;

@Controller
public class OrderController {

    private final OrderService orderService;
    private final SimpMessagingTemplate messagingTemplate;

    public OrderController(OrderService orderService, SimpMessagingTemplate messagingTemplate) {
        this.orderService = orderService;
        this.messagingTemplate = messagingTemplate;
    }

    @GetMapping("/admin/order")
    public String getOrderPage(Model model) {
        List<Order> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "admin/order/order-table";
    }

    @PostMapping("/admin/order/update-status/{id}")
    public String updateOrderStatus(@PathVariable long id, @RequestParam("status") String status) {
        orderService.updateOrderStatus(id, status);
        
        Order order = orderService.getOrderById(id);
        if(order != null && order.getUser() != null) {
            String message = "Đơn hàng #" + id + " \u0111\u00e3 chuy\u1ec3n sang tr\u1ea1ng th\u00e1i: " + status;
            // Send payload to specific user via generalized topic
            // In real app, consider using convertAndSendToUser
            messagingTemplate.convertAndSend("/topic/order-updates", order.getUser().getEmail() + "|" + message);
        }

        return "redirect:/admin/order";
    }
}
