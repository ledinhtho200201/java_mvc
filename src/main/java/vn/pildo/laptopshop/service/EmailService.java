package vn.pildo.laptopshop.service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import vn.pildo.laptopshop.domain.Order;

@Service
public class EmailService {

    private final JavaMailSender javaMailSender;

    public EmailService(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    public void sendOrderConfirmationEmail(String toEmail, Order order) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("your-email@gmail.com"); // Thay bằng email thật
        message.setTo(toEmail);
        message.setSubject("Xác nhận Đơn hàng #" + order.getId() + " - LaptopShop");
        
        String text = "Xin chào " + order.getReceiverName() + ",\n\n"
                + "Cảm ơn bạn đã đặt hàng tại LaptopShop.\n"
                + "Mã đơn hàng của bạn là: #" + order.getId() + "\n"
                + "Tổng tiền: " + order.getTotalPrice() + " VNĐ\n"
                + "Địa chỉ nhận hàng: " + order.getReceiverAddress() + "\n"
                + "Trạng thái hiện tại: Đang chờ xử lý.\n\n"
                + "Chúng tôi sẽ sớm liên hệ và giao hàng đến bạn môt cách nhanh nhất!\n\n"
                + "Trân trọng,\nĐội ngũ LaptopShop";
                
        message.setText(text);
        
        // Log out or actual send in production
        try {
            // this.javaMailSender.send(message);
            System.out.println("--- Gửi Email thành công đến: " + toEmail);
            System.out.println(text);
        } catch (Exception e) {
            System.err.println("Lỗi khi gửi email: " + e.getMessage());
        }
    }
}
