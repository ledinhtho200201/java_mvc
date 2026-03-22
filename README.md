# 💻 LaptopShop — Hướng dẫn sử dụng

Ứng dụng thương mại điện tử bán laptop xây dựng bằng **Spring Boot 3**, **MySQL**, **JSP/JSTL** và **Spring Security**.

---

## 📋 Mục lục

- [Yêu cầu hệ thống](#-yêu-cầu-hệ-thống)
- [Cài đặt & Khởi chạy](#-cài-đặt--khởi-chạy)
- [Cấu hình database](#-cấu-hình-database)
- [Tạo dữ liệu fake (Seed DB)](#-tạo-dữ-liệu-fake-seed-db)
- [Cấu trúc dự án](#-cấu-trúc-dự-án)
- [Tài khoản & Phân quyền](#-tài-khoản--phân-quyền)
- [Các tính năng chính](#-các-tính-năng-chính)
- [Build & Deploy](#-build--deploy)

---

## ⚙️ Yêu cầu hệ thống

| Công cụ        | Phiên bản tối thiểu |
|----------------|---------------------|
| Java (JDK)     | 17+                 |
| MySQL Server   | 8.0+                |
| Apache Maven   | 3.8+ *(hoặc dùng mvnw)* |

---

## 🚀 Cài đặt & Khởi chạy

### Bước 1 — Clone dự án

```bash
git clone <repo-url>
cd laptopshop
```

### Bước 2 — Tạo database MySQL

Mở MySQL client và chạy lệnh:

```sql
CREATE DATABASE laptopshop;
```

### Bước 3 — Cấu hình kết nối database

Mở file `src/main/resources/application.properties` và chỉnh sửa thông tin kết nối cho phù hợp:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/laptopshop
spring.datasource.username=root
spring.datasource.password=12345678
```

> **Lưu ý:** Thay `root` và `12345678` bằng username/password MySQL của bạn.

### Bước 4 — Khởi chạy ứng dụng

**Cách 1 — Dùng Maven Wrapper (khuyến nghị, không cần cài Maven):**

```bash
# Linux / macOS
./mvnw spring-boot:run

# Windows
mvnw.cmd spring-boot:run
```

**Cách 2 — Dùng Maven đã cài sẵn:**

```bash
mvn spring-boot:run
```

### Bước 5 — Truy cập ứng dụng

Mở trình duyệt và vào: **http://localhost:8080**

---

## 🗄️ Cấu hình database

File cấu hình chính: `src/main/resources/application.properties`

```properties
# Kết nối MySQL
spring.datasource.url=jdbc:mysql://localhost:3306/laptopshop
spring.datasource.username=root
spring.datasource.password=12345678
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# JPA / Hibernate — tự động cập nhật schema khi khởi động
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

# Session lưu vào MySQL (hết hạn sau 30 phút)
spring.session.store-type=jdbc
spring.session.jdbc.initialize-schema=always
spring.session.timeout=30m

# Giới hạn upload file ảnh
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB
```

> Hibernate tự động tạo/cập nhật bảng (`ddl-auto=update`) nên **không cần chạy script SQL thủ công**.

---

## 🌱 Tạo dữ liệu fake (Seed DB)

### Tự động khi khởi động

Dự án có sẵn class `DatabaseInitializer.java` — **tự động chạy ngay khi ứng dụng khởi động**.

Nó sẽ kiểm tra: nếu bảng `products` **chưa có dữ liệu** thì tự động thêm **10 sản phẩm laptop mẫu** vào database. Nếu đã có dữ liệu thì bỏ qua.

**Danh sách sản phẩm được seed tự động:**

| # | Tên sản phẩm                         | Giá (VND)  | Số lượng |
|---|--------------------------------------|------------|----------|
| 1 | ASUS ROG Strix G16 Gaming            | 35,990,000 | 12       |
| 2 | Dell XPS 15 9530                     | 42,990,000 | 8        |
| 3 | Lenovo IdeaPad Slim 5                | 16,990,000 | 25       |
| 4 | HP Pavilion 15                       | 14,990,000 | 30       |
| 5 | MacBook Air M3 15 inch               | 37,990,000 | 15       |
| 6 | Acer Nitro V 15                      | 22,990,000 | 18       |
| 7 | MSI Katana 15 B13V                   | 27,990,000 | 10       |
| 8 | Samsung Galaxy Book3 Pro             | 32,990,000 | 7        |
| 9 | LG Gram 16 2024                      | 34,990,000 | 5        |
|10 | Lenovo ThinkPad X1 Carbon Gen 11     | 45,990,000 | 6        |

### Seed thủ công (reset dữ liệu)

Nếu muốn seed lại dữ liệu (ví dụ sau khi xóa sạch bảng), chạy các lệnh SQL:

```sql
-- Xóa dữ liệu cũ (nếu cần reset)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE products;
SET FOREIGN_KEY_CHECKS = 1;
```

Sau đó **restart ứng dụng** — `DatabaseInitializer` sẽ tự động seed lại.

### Thêm Role mặc định

Khi đăng ký tài khoản mới, hệ thống tự gán role `USER`. Để tạo tài khoản `ADMIN`, bạn cần:

**Cách 1 — Tạo qua giao diện admin** (nếu đã có tài khoản admin):
- Vào `/admin/user/create` → chọn Role = ADMIN

**Cách 2 — Insert thẳng vào DB:**

```sql
-- Xem danh sách role hiện có
SELECT * FROM roles;

-- Tạo user admin (password là BCrypt của "123456")
INSERT INTO users (email, name, password, role_id)
VALUES (
  'admin@laptopshop.vn',
  'Admin',
  '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH',
  (SELECT id FROM roles WHERE name = 'ADMIN')
);
```

> **Lưu ý:** Nên tạo admin qua giao diện hoặc đăng ký rồi cập nhật role trong DB để tránh lỗi mã hóa password.

---

## 📁 Cấu trúc dự án

```
laptopshop/
├── pom.xml                              # Cấu hình Maven & dependencies
├── mvnw / mvnw.cmd                      # Maven Wrapper
└── src/
    └── main/
        ├── java/vn/pildo/laptopshop/
        │   ├── LaptopshopApplication.java       # Entry point
        │   ├── config/
        │   │   ├── DatabaseInitializer.java     # 🌱 Seed dữ liệu khi startup
        │   │   ├── SecurityConfig.java          # Cấu hình Spring Security
        │   │   ├── PasswordEncoderConfig.java   # BCrypt encoder
        │   │   ├── WebMvcConfig.java            # View resolver, static files
        │   │   └── CustomSuccessHandler.java    # Redirect sau khi login
        │   ├── controller/
        │   │   ├── admin/                       # Controller trang admin
        │   │   │   ├── DashboardController.java
        │   │   │   ├── ProductController.java
        │   │   │   ├── UserController.java
        │   │   │   └── OrderController.java
        │   │   └── client/                      # Controller trang người dùng
        │   │       ├── AuthController.java      # Đăng nhập / Đăng ký
        │   │       ├── HomePageController.java
        │   │       └── ItemController.java      # Giỏ hàng
        │   ├── domain/                          # Entity (JPA)
        │   │   ├── Product.java
        │   │   ├── User.java
        │   │   ├── Order.java
        │   │   ├── OrderDetail.java
        │   │   ├── Role.java
        │   │   └── dto/RegisterDTO.java
        │   ├── repository/                      # Spring Data JPA
        │   │   ├── ProductRepository.java
        │   │   ├── UserRepository.java
        │   │   └── RoleRepository.java
        │   └── service/                         # Business logic
        │       ├── ProductService.java
        │       ├── UserService.java
        │       ├── CustomUserDetailsService.java
        │       └── UploadService.java           # Upload ảnh
        ├── resources/
        │   ├── application.properties           # Cấu hình ứng dụng
        │   └── static/images/                   # Ảnh sản phẩm & avatar
        └── webapp/WEB-INF/view/                 # JSP views
            ├── admin/                           # Giao diện admin
            └── client/                          # Giao diện người dùng
```

---

## 👤 Tài khoản & Phân quyền

| Role    | Quyền truy cập                                        |
|---------|-------------------------------------------------------|
| `USER`  | Xem sản phẩm, đăng ký, đăng nhập, giỏ hàng           |
| `ADMIN` | Tất cả quyền USER + quản lý sản phẩm, user, đơn hàng |

### Các route chính

| Đường dẫn             | Mô tả                         | Quyền     |
|-----------------------|-------------------------------|-----------|
| `/`                   | Trang chủ                     | Tất cả    |
| `/login`              | Đăng nhập                     | Tất cả    |
| `/register`           | Đăng ký tài khoản             | Tất cả    |
| `/product/{id}`       | Chi tiết sản phẩm             | Tất cả    |
| `/admin/dashboard`    | Dashboard quản trị            | ADMIN     |
| `/admin/product`      | Quản lý sản phẩm              | ADMIN     |
| `/admin/user`         | Quản lý người dùng            | ADMIN     |
| `/admin/order`        | Quản lý đơn hàng              | ADMIN     |

---

## ✨ Các tính năng chính

- **Xác thực & Phân quyền** — Spring Security, form login, remember-me (7 ngày)
- **Quản lý sản phẩm** — CRUD đầy đủ, upload ảnh (tối đa 10MB)
- **Quản lý người dùng** — CRUD, upload avatar
- **Quản lý đơn hàng** — Xem danh sách đơn hàng
- **Session bền vững** — Lưu session vào MySQL, timeout 30 phút
- **Mã hóa mật khẩu** — BCrypt (10 rounds)
- **Seed dữ liệu tự động** — 10 sản phẩm mẫu khi khởi động lần đầu

---

## 📦 Build & Deploy

### Build file JAR

```bash
./mvnw clean package -DskipTests
```

File JAR được tạo tại: `target/laptopshop-0.0.1-SNAPSHOT.jar`

### Chạy file JAR

```bash
java -jar target/laptopshop-0.0.1-SNAPSHOT.jar
```

### Override cấu hình khi chạy production

```bash
java -jar target/laptopshop-0.0.1-SNAPSHOT.jar \
  --spring.datasource.url=jdbc:mysql://prod-host:3306/laptopshop \
  --spring.datasource.username=prod_user \
  --spring.datasource.password=prod_password
```

---

## 🛠️ Xử lý lỗi thường gặp

**Lỗi kết nối database:**
```
Communications link failure
```
→ Kiểm tra MySQL đang chạy và thông tin trong `application.properties` chính xác.

**Lỗi port 8080 đã dùng:**
```
Web server failed to start. Port 8080 was already in use.
```
→ Thêm vào `application.properties`:
```properties
server.port=8081
```

**Lỗi Java version:**
```
Source option 17 is not supported.
```
→ Đảm bảo đang dùng JDK 17+. Kiểm tra bằng: `java -version`
