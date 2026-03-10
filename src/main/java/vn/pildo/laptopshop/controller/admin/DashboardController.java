package vn.pildo.laptopshop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.pildo.laptopshop.domain.User;
import vn.pildo.laptopshop.service.ProductService;
import vn.pildo.laptopshop.service.UserService;

@Controller
public class DashboardController {

    private final UserService userService;
    private final ProductService productService;

    public DashboardController(UserService userService, ProductService productService) {
        this.userService = userService;
        this.productService = productService;
    }

    @GetMapping("/admin/dashboard")
    public String getDashboard(Model model) {
        List<User> allUsers = this.userService.getAllUsers();
        long adminCount = allUsers.stream().filter(u -> "ADMIN".equals(u.getRole())).count();
        long normalUserCount = allUsers.size() - adminCount;

        model.addAttribute("userCount", allUsers.size());
        model.addAttribute("adminCount", adminCount);
        model.addAttribute("normalUserCount", normalUserCount);
        model.addAttribute("productCount", this.productService.getAllProducts().size());
        model.addAttribute("orderCount", 0);

        int size = allUsers.size();
        List<User> recentUsers = allUsers.subList(Math.max(0, size - 5), size);
        model.addAttribute("recentUsers", recentUsers);
        return "admin/dashboard";
    }
}
