package vn.pildo.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.pildo.laptopshop.domain.User;
import vn.pildo.laptopshop.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    public String handleHello() {
        return "Hello from UserService!";
    }
    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }
    public void updateUserById(User user) {
         // Kiểm tra user có tồn tại không
        User existingUser = getUserById(user.getId());
        if (existingUser != null) {
            // Cập nhật các trường
            existingUser.setFullName(user.getFullName());
            existingUser.setEmail(user.getEmail());
            existingUser.setPhone(user.getPhone());
            existingUser.setAddress(user.getAddress());
            
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

    public boolean checkUserProStatus(Long id) {
        User user = getUserById(id);
        if (user != null) {
            return user.isPro();
        }
        return false;
    }

    public void updateUserProStatus(Long id, boolean isPro) {
        User user = getUserById(id);
        if (user != null) {
            user.setPro(isPro);
            userRepository.save(user);
            System.out.println("User pro status updated: " + id + " -> " + isPro);
        }
    }
}


