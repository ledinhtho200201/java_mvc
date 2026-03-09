package vn.pildo.laptopshop.controller.admin;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.pildo.laptopshop.domain.User;
import vn.pildo.laptopshop.service.UserService;
import org.springframework.validation.FieldError;

@Controller
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/")
    public String getHomePage(Model model) {
        // List<User> arrUsers = this.userService.getAllUsers();
        // List<User> arrUsersByEmail = this.userService.getAllUserByEmail("a@gmail.com");

        // String test = this.userService.handleHello();
        // model.addAttribute("message", test);
        // model.addAttribute("desc", "This is a description");
        return "client/show";
    }

    @RequestMapping("/admin/user")
    public String getListUser(Model model) {
        List<User> users = this.userService.getAllUsers();
        model.addAttribute("listUser", users);
        return "admin/user/user-table";
    }

    @RequestMapping("/admin/user/{id}")
    public String getUserDetailPage(Model model, @PathVariable Long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("id", id);
        model.addAttribute("user", user);
        System.out.println("User ID: " + id);
        return "admin/user/show";
    }

    @PostMapping("/admin/user/update")
    public String updateUser(
            @ModelAttribute User user,
            @RequestParam(value = "avatarFile", required = false) MultipartFile avatarFile) {
        try {
            if (avatarFile != null && !avatarFile.isEmpty()) {
                String uploadDir = "src/main/resources/static/images/avatar";
                String avatarName = this.userService.handleUploadFile(avatarFile, uploadDir);
                if (avatarName != null) {
                    user.setAvatar(avatarName);
                }
            }
        } catch (Exception ignored) {}
        userService.updateUserById(user);
        return "redirect:/admin/user";
    }

    @RequestMapping("/admin/user/update/{id}")
    public String updateUserPage(Model model, @PathVariable Long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("id", id);
        model.addAttribute("user", user);
        return "admin/user/update";
    }

    @RequestMapping("/admin/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @RequestMapping(value = "/admin/user/create", method = RequestMethod.POST)
    public String createUser(
            Model model,
            @Valid @ModelAttribute("newUser") User newUser,
            BindingResult bindingResult,
            @RequestParam("avatarFile") MultipartFile avatarFile) {

        if (bindingResult.hasErrors()) {
            return "admin/user/create";
        }

        // Validate email trùng
        if (this.userService.isEmailExist(newUser.getEmail())) {
            bindingResult.addError(new FieldError("newUser", "email", "Email đã tồn tại trong hệ thống"));
            return "admin/user/create";
        }

        try {
            String uploadDir = "src/main/resources/static/images/avatar";
            String avatarName = this.userService.handleUploadFile(avatarFile, uploadDir);
            if (avatarName != null) {
                newUser.setAvatar(avatarName);
            }
        } catch (Exception e) {
            model.addAttribute("uploadError", "Upload ảnh thất bại: " + e.getMessage());
            return "admin/user/create";
        }

        String hashedPassword = this.userService.hashPassword(newUser.getPassword());
        newUser.setPassword(hashedPassword);

        this.userService.handleSaveUser(newUser);
        return "redirect:/admin/user";
    }

    @DeleteMapping("/admin/user/delete/{id}")
    @ResponseBody
    public ResponseEntity<String> deleteUserAjax(@PathVariable Long id) {
        try {
            this.userService.deleteUser(id);
            return ResponseEntity.ok("User deleted successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error deleting user: " + e.getMessage());
        }
    }
}
