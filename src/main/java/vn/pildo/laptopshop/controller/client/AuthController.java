package vn.pildo.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.validation.Valid;
import vn.pildo.laptopshop.domain.User;
import vn.pildo.laptopshop.domain.dto.RegisterDTO;
import vn.pildo.laptopshop.service.UserService;

@Controller
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String handleRegister(
            Model model,
            @Valid @ModelAttribute("registerUser") RegisterDTO registerDTO,
            BindingResult bindingResult) {

        if (!registerDTO.getPassword().equals(registerDTO.getConfirmPassword())) {
            bindingResult.rejectValue("confirmPassword", "error.confirmPassword",
                    "Mật khẩu xác nhận không khớp");
        }

        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }

        if (this.userService.isEmailExist(registerDTO.getEmail())) {
            model.addAttribute("emailError", "Email đã được sử dụng");
            return "client/auth/register";
        }

        User user = this.userService.registerDTOtoUser(registerDTO);

        this.userService.handleSaveUser(user);
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String getLoginPage() {
        return "client/auth/login";
    }

    @GetMapping("/access-denied")
    public String getAccessDeniedPage() {
        return "client/auth/403";
    }
}
