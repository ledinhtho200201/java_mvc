package vn.pildo.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductController {

    @GetMapping("/admin/product")
    public String getProductPage(Model model) {
        return "admin/product/product-table";
    }
}
