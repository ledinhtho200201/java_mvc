package vn.pildo.laptopshop.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import vn.pildo.laptopshop.domain.User;
import vn.pildo.laptopshop.service.UserService;

@Controller
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/")
    public String getHomePage(Model model) {
        List<User> arrUsers = this.userService.getAllUsers();
        List<User> arrUsersByEmail = this.userService.getAllUserByEmail("a@gmail.com");

        String test = this.userService.handleHello();
        model.addAttribute("message", test);
        model.addAttribute("desc", "This is a description");
        return "hello";
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
    public String updateUser(@ModelAttribute User user) {
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
    public String createUser(Model model, @ModelAttribute("newUser") User newusercreated) {
        System.out.println("Creating user..." + newusercreated);
        this.userService.handleSaveUser(newusercreated);
        // Handle user creation logic here
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

    @GetMapping("/api/user/{id}/pro-status")
    @ResponseBody
    public ResponseEntity<ProStatusResponse> checkProStatus(@PathVariable Long id) {
        User user = this.userService.getUserById(id);
        if (user == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ProStatusResponse(false, "User not found"));
        }
        boolean isPro = user.isPro();
        String message = isPro ? "User has pro subscription" : "User does not have pro subscription";
        return ResponseEntity.ok(new ProStatusResponse(isPro, message));
    }

    @PostMapping("/api/user/{id}/pro-status")
    @ResponseBody
    public ResponseEntity<String> updateProStatus(@PathVariable Long id, @RequestParam("isPro") boolean isPro) {
        try {
            User user = this.userService.getUserById(id);
            if (user == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("User not found");
            }
            user.setPro(isPro);
            this.userService.handleSaveUser(user);
            String message = isPro ? "Pro subscription activated" : "Pro subscription deactivated";
            return ResponseEntity.ok(message);
        } catch (Exception e) {
            // Log the exception for debugging but don't expose details to client
            System.err.println("Error updating pro status for user " + id + ": " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error updating pro status");
        }
    }

    // Inner class for response
    public static class ProStatusResponse {
        private boolean isPro;
        private String message;

        public ProStatusResponse(boolean isPro, String message) {
            this.isPro = isPro;
            this.message = message;
        }

        public boolean isPro() {
            return isPro;
        }

        public void setIsPro(boolean isPro) {
            this.isPro = isPro;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }
}
