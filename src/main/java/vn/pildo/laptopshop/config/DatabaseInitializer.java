package vn.pildo.laptopshop.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import vn.pildo.laptopshop.domain.Product;
import vn.pildo.laptopshop.repository.ProductRepository;

@Component
public class DatabaseInitializer implements CommandLineRunner {

    private final ProductRepository productRepository;

    public DatabaseInitializer(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @Override
    public void run(String... args) {
        if (productRepository.count() > 0) {
            return;
        }

        Product[] products = {
            createProduct("ASUS ROG Strix G16 Gaming", 35990000, 12, "ASUS", "Gaming",
                "Intel i9-13980HX, RTX 4070, 16GB DDR5, 1TB SSD, 165Hz",
                "Laptop gaming cao cấp với hiệu năng mạnh mẽ, màn hình 16 inch 165Hz, bàn phím RGB per-key.",
                "asus.jpg"),

            createProduct("Dell XPS 15 9530", 42990000, 8, "Dell", "Đồ họa",
                "Intel i7-13700H, RTX 4060, 32GB DDR5, 1TB SSD, OLED 3.5K",
                "Laptop doanh nhân cao cấp với màn hình OLED 3.5K sắc nét, thiết kế mỏng nhẹ sang trọng.",
                "dell.jpg"),

            createProduct("Lenovo IdeaPad Slim 5", 16990000, 25, "Lenovo", "Văn phòng",
                "AMD Ryzen 5 7530U, 16GB RAM, 512GB SSD, 14 inch FHD",
                "Laptop văn phòng mỏng nhẹ, pin lâu, hiệu năng ổn định cho công việc hàng ngày.",
                "lenovo.jpg"),

            createProduct("HP Pavilion 15", 14990000, 30, "HP", "Học sinh - Sinh viên",
                "Intel i5-1335U, 8GB RAM, 512GB SSD, 15.6 inch FHD",
                "Laptop giá tốt cho sinh viên, thiết kế hiện đại, đầy đủ cổng kết nối.",
                "hp.jpg"),

            createProduct("MacBook Air M3 15 inch", 37990000, 15, "Apple", "Doanh nhân",
                "Apple M3 chip, 16GB RAM, 512GB SSD, Liquid Retina 15.3 inch",
                "MacBook Air với chip M3 mạnh mẽ, pin 18 giờ, fanless siêu mỏng nhẹ chỉ 1.51kg.",
                "macbook.jpg"),

            createProduct("Acer Nitro V 15", 22990000, 18, "Acer", "Gaming",
                "Intel i5-13420H, RTX 4050, 16GB DDR5, 512GB SSD, 144Hz",
                "Laptop gaming tầm trung với card đồ họa RTX 4050, tản nhiệt kép hiệu quả.",
                "acer.jpg"),

            createProduct("MSI Katana 15 B13V", 27990000, 10, "MSI", "Gaming",
                "Intel i7-13620H, RTX 4060, 16GB DDR5, 512GB SSD, 144Hz",
                "Laptop gaming MSI với thiết kế hầm hố, hiệu năng khủng cho mọi tựa game.",
                "msi.jpg"),

            createProduct("Samsung Galaxy Book3 Pro", 32990000, 7, "Samsung", "Doanh nhân",
                "Intel i7-1360P, 16GB RAM, 512GB SSD, AMOLED 14 inch",
                "Laptop siêu mỏng nhẹ với màn hình AMOLED sống động, pin trâu cả ngày làm việc.",
                "samsung.jpg"),

            createProduct("LG Gram 16 2024", 34990000, 5, "LG", "Văn phòng",
                "Intel i7-1360P, 32GB RAM, 1TB SSD, 16 inch WQXGA",
                "Laptop nhẹ nhất phân khúc 16 inch chỉ 1.19kg, đạt chuẩn quân đội MIL-STD-810H.",
                "lg.jpg"),

            createProduct("Lenovo ThinkPad X1 Carbon Gen 11", 45990000, 6, "Lenovo", "Workstation",
                "Intel i7-1365U vPro, 32GB RAM, 1TB SSD, 14 inch 2.8K OLED",
                "Laptop doanh nghiệp hàng đầu, bảo mật cao với vân tay + IR camera, bàn phím tốt nhất thế giới.",
                "thinkpad.jpg"),
        };

        for (Product p : products) {
            productRepository.save(p);
        }

        System.out.println(">>> Seeded " + products.length + " products into database.");
    }

    private Product createProduct(String name, double price, long quantity,
                                   String factory, String target,
                                   String shortDesc, String detailDesc, String image) {
        Product p = new Product();
        p.setName(name);
        p.setPrice(price);
        p.setQuantity(quantity);
        p.setFactory(factory);
        p.setTarget(target);
        p.setShortDesc(shortDesc);
        p.setDetailDesc(detailDesc);
        p.setImage(image);
        return p;
    }
}
