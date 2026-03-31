package vn.pildo.laptopshop.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import vn.pildo.laptopshop.domain.CartItem;
import vn.pildo.laptopshop.domain.Order;
import vn.pildo.laptopshop.domain.OrderDetail;
import vn.pildo.laptopshop.domain.User;
import vn.pildo.laptopshop.repository.OrderDetailRepository;
import vn.pildo.laptopshop.repository.OrderRepository;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final CartService cartService;

    public OrderService(OrderRepository orderRepository,
                        OrderDetailRepository orderDetailRepository,
                        CartService cartService) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.cartService = cartService;
    }

    /** Tạo đơn hàng từ giỏ hàng hiện tại của user */
    @Transactional
    public Order createOrder(User user,
                             String receiverName,
                             String receiverPhone,
                             String receiverAddress,
                             String note,
                             String paymentMethod) {

        List<CartItem> cartItems = cartService.getCartByUser(user);
        if (cartItems.isEmpty()) return null;

        double total = cartService.getTotalPrice(cartItems);

        Order order = new Order();
        order.setUser(user);
        order.setReceiverName(receiverName);
        order.setReceiverPhone(receiverPhone);
        order.setReceiverAddress(receiverAddress);
        order.setNote(note);
        order.setTotalPrice(total);
        order.setPaymentMethod(paymentMethod);
        order.setStatus("BANK_TRANSFER".equals(paymentMethod) || "MOMO".equals(paymentMethod)
                ? "PENDING_PAYMENT" : "PROCESSING");
        order.setCreatedAt(LocalDateTime.now());

        // Lưu trước để có id
        order = orderRepository.save(order);

        // Sinh mã đơn hàng: LS-YYYYMMDD-{id}
        String code = "LS-"
                + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"))
                + "-" + String.format("%04d", order.getId());
        order.setOrderCode(code);
        order = orderRepository.save(order);

        // Lưu từng OrderDetail
        for (CartItem item : cartItems) {
            OrderDetail detail = new OrderDetail();
            detail.setOrder(order);
            detail.setProduct(item.getProduct());
            detail.setQuantity(item.getQuantity());
            detail.setPrice(item.getProduct().getPrice()); // Lưu giá tại thời điểm đặt
            orderDetailRepository.save(detail);
        }

        // Xoá giỏ hàng
        cartService.clearCart(user);

        return order;
    }

    public Order getOrderById(long id) {
        return orderRepository.findById(id).orElse(null);
    }

    public List<Order> getOrdersByUser(User user) {
        return orderRepository.findByUserOrderByCreatedAtDesc(user);
    }

    /** Xác nhận đã thanh toán (dùng cho COD hoặc sau khi verify chuyển khoản) */
    public void markAsPaid(long orderId) {
        Order order = getOrderById(orderId);
        if (order != null) {
            order.setStatus("PROCESSING");
            orderRepository.save(order);
        }
    }
}
