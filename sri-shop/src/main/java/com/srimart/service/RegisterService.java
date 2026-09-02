package com.srimart.service;

import com.srimart.dao.UserDAO;
import com.srimart.model.User;
import com.srimart.util.PasswordUtil;
import com.srimart.util.ValidationUtil;

import java.sql.SQLException;

public class RegisterService {

    private final UserDAO userDAO;

    public RegisterService() {
        this.userDAO = new UserDAO();
    }

    public String register(
            String name,
            String email,
            String password,
            String role,
            String phone) throws SQLException {

        // Clean input
        name = name == null ? null : name.trim();
        email = email == null ? null : email.trim().toLowerCase();
        role = role == null ? null : role.trim().toUpperCase();
        phone = phone == null ? null : phone.trim();

        // Validate name
        if (!ValidationUtil.isValidName(name)) {
            return "Invalid name";
        }

        // Validate email
        if (!ValidationUtil.isValidEmail(email)) {
            return "Invalid email";
        }

        // Validate password
        if (!ValidationUtil.isValidPassword(password)) {
            return "Password must contain at least 8 characters";
        }

        // Validate role
        if (!"BUYER".equals(role) && !"SELLER".equals(role)) {
            return "Only Buyer or Seller registration is allowed";
        }

        // Validate phone
        if (!ValidationUtil.isValidPhone(phone)) {
            return "Invalid phone number";
        }

        // Check duplicate email
        if (userDAO.emailExists(email)) {
            return "Email already registered";
        }

        // Hash password before storing
        String passwordHash = PasswordUtil.hashPassword(password);

        // Create User
        User user = new User(
                name,
                email,
                passwordHash,
                role,
                phone
        );

        // Save user
        boolean registered = userDAO.registerUser(user);

        if (registered) {
            return "Registration successful";
        }

        return "Registration failed";
    }
}