package vn.pildo.laptopshop.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import vn.pildo.laptopshop.domain.User;
import vn.pildo.laptopshop.repository.UserRepository;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;
import java.nio.file.StandardCopyOption;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }
    public String handleHello() {
        return "Hello from UserService!";
    }
    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }
    public void updateUserById(User user) {
        User existingUser = getUserById(user.getId());
        if (existingUser != null) {
            existingUser.setFullName(user.getFullName());
            existingUser.setPhone(user.getPhone());
            existingUser.setAddress(user.getAddress());
            existingUser.setRole(user.getRole());
            if (user.getAvatar() != null && !user.getAvatar().isEmpty()) {
                existingUser.setAvatar(user.getAvatar());
            }
            userRepository.save(existingUser);
        }
    }
    public List<User> getAllUserByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }
    public User getUserById(Long id) {
        return this.userRepository.findById(id).orElse(null);
    }
    public User handleSaveUser(User user) {
        User pildo = this.userRepository.save(user);
        System.out.println("Saving user..." + pildo);
        return pildo;
    }

    public String handleUploadFile(MultipartFile file, String uploadDir) throws IOException {
        if (file == null || file.isEmpty()) {
            return null;
        }
        String originalFilename = file.getOriginalFilename();
        String extension = originalFilename != null && originalFilename.contains(".")
                ? originalFilename.substring(originalFilename.lastIndexOf("."))
                : "";
        String newFilename = UUID.randomUUID().toString() + extension;

        Path uploadPath = Paths.get(uploadDir);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        Files.copy(file.getInputStream(), uploadPath.resolve(newFilename), StandardCopyOption.REPLACE_EXISTING);
        return newFilename;
    }

    public String hashPassword(String plainPassword) {
        return passwordEncoder.encode(plainPassword);
    }

    public void deleteUser(Long id) {
        // Cách 1: Delete trực tiếp
        // userRepository.deleteById(id);
        
        // Cách 2: Kiểm tra tồn tại trước khi delete
        if (userRepository.existsById(id)) {
            userRepository.deleteById(id);
            System.out.println("User deleted: " + id);
        } else {
            System.out.println("User not found: " + id);
        }
    }
}


