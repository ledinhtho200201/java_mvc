package vn.pildo.laptopshop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.pildo.laptopshop.domain.User;
import vn.pildo.laptopshop.service.UserService;

@Controller
public class DashboardController {

    private final UserService userService;

    public DashboardController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/admin/dashboard")
    public String getDashboard(Model model) {
        List<User> allUsers = this.userService.getAllUsers();
        model.addAttribute("userCount", allUsers.size());
        model.addAttribute("productCount", 0);
        model.addAttribute("orderCount", 0);
        // Show last 5 users
        int size = allUsers.size();
        List<User> recentUsers = allUsers.subList(Math.max(0, size - 5), size);
        model.addAttribute("recentUsers", recentUsers);
        return "admin/dashboard";
    }
}
