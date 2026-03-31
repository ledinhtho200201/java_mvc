# KIẾN TRÚC TÍCH HỢP VNPAY & WEBSOCKET

Tài liệu này mô tả chi tiết giải pháp kỹ thuật và cách thức triển khai tích hợp cổng thanh toán VNPay và hệ thống thông báo Real-time bằng WebSocket cho dự án LaptopShop.

## 1. Tích hợp thanh toán VNPAY
### Mục đích
Cho phép người dùng thanh toán trực tuyến qua cổng VNPay thay vì chỉ sử dụng hình thức Cash on Delivery (COD) truyền thống.

### Cấu trúc files
- `application.properties`: Chứa cấu hình Secret Key, TmnCode, URL của môi trường Sandbox VNPay.
- `vn.pildo.laptopshop.config.VNPayConfig.java`: Cấu hình thuật toán mã hóa HMAC SHA512 tạo chữ ký điện tử (Secure Hash) và các hàm tiện ích xử lý chuỗi (Build Query String, lấy IP khách hàng).
- `vn.pildo.laptopshop.service.VNPayService.java`: Nơi chứa logic tạo URL thanh toán gửi sang VNPay, bao gồm OrderID, BAmount, Thông tin callback (Return URL).
- `vn.pildo.laptopshop.controller.client.PaymentController.java`: API Controller đóng vai trò nhận request callback (Return URL) từ VNPay trả về sau khi người dùng thanh toán xong (thành công hoặc thất bại) để cập nhật trạng thái đơn hàng.

### Flow hoạt động
1. User chọn phương thức "VNPAY" và bấm "Đặt hàng".
2. `CheckoutController` gọi `VNPayService` để sinh một đường link thanh toán (chứa mã Hash để VNPay xác thực).
3. Hệ thống redirect User sang trang web của VNPay. User quét mã QR hoặc nhập thẻ.
4. Sau khi thanh toán, VNPay tạo chữ ký và redirect User về link `vnpay-return` của hệ thống.
5. Hệ thống kiểm tra đối chiếu (Hash Checksum) từ VNPay. Nếu hợp lệ và Response Code = `00` -> Đổi trạng thái Order thành `PAID` / `PROCESSING` -> Hiển thị trang Success.

---

## 2. Thông báo thời gian thực với WebSockets (STOMP)
### Mục đích
Cập nhật trạng thái đơn hàng (Popup Toast) trực tiếp tới màn hình của khách hàng mà không cần phải F5 tải lại trang khi Admin vừa nhấn nút cập nhật trạng thái.

### Cấu trúc files
- `pom.xml`: Thêm thư viện `spring-boot-starter-websocket`.
- `vn.pildo.laptopshop.config.WebSocketConfig.java`: Khai báo Message Broker (bật `/topic`) và Endpoint để client kết nối (`/ws`).
- Cơ chế Send (Backend): Dùng `SimpMessagingTemplate.convertAndSend("/topic/order-updates/{" + userId + "}", message)`.
- Cơ chế Receive (Frontend JSP/JS): Tại `header.jsp` của phía client, nhúng `sockjs.js` và `stomp.js`. Khi connect thành công, sẽ `stompClient.subscribe()` đúng vào channel `/topic/order-updates/CURRENT_USER_ID`. Mỗi khi có payload gửi về, trigger mã JS để render Toast UI (Popup nhỏ báo "Đơn hàng của bạn đã cập nhật...").

### Flow hoạt động
1. Admin truy cập trang `Quản lý Đơn Hàng` và đổi trạng thái (VD: Chờ xử lý -> Đang giao).
2. Hàm `updateOrderStatus` trong Admin Controller thay đổi DB, đồng thời gọi `SimpMessagingTemplate` bắn 1 bản tin đến Broker.
3. Broker phân phát bản tin này trực tiếp đến Socket Channel của người dùng đang mua hàng đó.
4. Trình duyệt của khách hàng bắt được Event, hiện Toast HTML báo "Đơn hàng #123 của bạn đang trên đường giao tớiiii!".

### Hướng dẫn Config tiếp theo (Dành cho Developer sau)
- VNPAY: Hãy truy cập https://sandbox.vnpayment.vn/apis/ để tạo account test -> Thay thế `vnp_TmnCode` và `vnp_HashSecret` đang để mặc định bằng mã thật của bạn trong `application.properties`.
- WebSocket: Hãy đảm bảo các dependency JS tải đủ, nếu có hệ thống Load Balancer/Proxy (như Nginx) thì nhớ open giao thức `Upgrade: websocket`.
