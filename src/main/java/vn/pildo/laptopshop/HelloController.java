package vn.pildo.laptopshop;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/")
    public String index() {
        return "Hello from Laptop Shop update!";
    }

    @GetMapping("/user")
    public String userPage() {
        return "Only users can see this page!";
    }

    @GetMapping("/admin")
    public String adminPage() {
        return "Only admins can see this page!";
    }

}