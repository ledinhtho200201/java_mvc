package vn.pildo.laptopshop.service;

import org.springframework.stereotype.Service;

@Service
public class UserService {
    public String handleHello() {
        return "Welcome to the Laptop Shop!";
    }
}