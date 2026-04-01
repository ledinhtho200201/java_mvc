# Hướng Dẫn Tích Hợp Đăng Nhập Dùng Keycloak (OAuth2)

Dự án LaptopShop đã được bổ sung khả năng đăng nhập một chạm (Single Sign-On / SSO) bằng **Keycloak** thông qua chuẩn **OAuth2 / OpenID Connect**.

Dưới đây là các bước quy trình chi tiết để bạn có thể cấu hình và sử dụng.

---

## 1. Yêu Cầu Cốt Lõi
- Bạn cần một server **Keycloak** (chạy bằng Docker hoặc Native). Ví dụ: `http://localhost:8080`
- Trong Server Keycloak, bạn cần thiết lập ít nhất:
  1. Một **Realm** (Ví dụ: `laptopshop`)
  2. Một **Client** (Ví dụ: `laptopshop-client`)
  3. Ít nhất một **User** thử nghiệm trong Realm này.

## 2. Các File Mã Nguồn Đã Thay Đổi

1. **`pom.xml`**: Thêm thư viện cấu hình `spring-boot-starter-oauth2-client`.
2. **`SecurityConfig.java`**: Thêm chuỗi `.oauth2Login()` vào trong quy trình xác thực của Spring Security.
3. **`CustomOAuth2UserService.java`**: Lớp Service tùy chỉnh mới. Mục đích:
    - Khi Keycloak trả về thông tin User (email, tên), lớp này sẽ tự động kiểm tra xem user này đã tồn tại trong database (MySQL) của Laptopshop chưa.
    - Nếu chưa, hệ thống **tự động tạo (đăng ký) User mới** trong Database với mật khẩu ảo và gán role là `USER`.
4. **`CustomSuccessHandler.java`**: Hoạt động bình thường với cơ chế OAuth2 vì Keycloak user attributes được đồng bộ chuẩn với Spring Security principal.
5. **`application.properties`**: Chứa thông tin kết nối tới Keycloak Server.
6. **`login.jsp`**: Đã chèn thêm nút chuyển hướng **"Đăng nhập với Keycloak"** trỏ tới endpoint `/oauth2/authorization/keycloak`.

---

## 3. Cách Setup Server Keycloak (Dành Cho Cấu Hình Local Của Bạn)

Nếu chưa cài đặt Keycloak, cách nhanh nhất là chạy bằng Docker:
```bash
docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:22.0.1 start-dev
```

Đăng nhập vào bảng điều khiển Keycloak (http://localhost:8080/admin) và thực hiện:

### Bước 3.1: Tạo Realm
- Click nút **Create Realm**
- Nhập tên: `laptopshop`

### Bước 3.2: Tạo Client cho dự án LaptopShop
- Chọn `laptopshop` realm -> **Clients** -> **Create client**
- **Client ID**: `laptopshop-client`
- Client authentication: Gạt sang `On` (để lấy được Client Secret)
- **Valid Redirect URIs**: Chú ý đoạn này CỰC KỲ QUAN TRỌNG, hãy điền đường dẫn về Spring Boot của bạn:
  - `http://localhost:8080/login/oauth2/code/keycloak`
- Mở tab **Credentials** của Client vừa tạo, copy đoạn mã **Client Secret**.

### Bước 3.3: Tạo User Test Trong Keycloak
- Chọn **Users** -> **Add user**
- Điền: `Email`, `First Name`, `Last Name`. Chú ý: *Bắt buộc phải điền Email* vì Laptopshop dùng email để định danh.
- Chuyển sang tab **Credentials**, đặt Password (tắt Temporary để có thể đăng nhập ngay).

---

## 4. Cấu Hình Lại Spring Boot

Mở file `src/main/resources/application.properties` và điều chỉnh các dòng liên quan Keycloak với thông tin tương ứng ở Bước 3. (Tôi đã thiết lập khung sẵn cho bạn)

```properties
# ID của client bạn vừa tạo ở bước 3.2
spring.security.oauth2.client.registration.keycloak.client-id=laptopshop-client

# Secret bạn copy ở tab Credentials của Client trong Keycloak
spring.security.oauth2.client.registration.keycloak.client-secret=MÃ_SECRET_CỦA_BẠN

# Issuer URI chứa link tới realm của bạn
spring.security.oauth2.client.provider.keycloak.issuer-uri=http://localhost:8080/realms/laptopshop
```

---

## 5. Tiến Hành Kiểm Tra

1. Chạy lại dự án Laptopshop Spring Boot.
2. Vào trang đăng nhập: `http://localhost:8080/login`
3. Click vào nút: **<i class="bi bi-shield-lock"></i> Đăng nhập với Keycloak**
4. Trình duyệt sẽ chuyển hướng (redirect) bạn sang trang Đăng nhập của bản dựng Keycloak.
5. Nhập User của bước 3.3.
6. Trình duyệt tự động đá về `http://localhost:8080/` với trạng thái đã đăng nhập thành công. Lần phân giải kế tiếp, hệ thống tìm thấy Entity User đó trong SQL Database của bạn!
