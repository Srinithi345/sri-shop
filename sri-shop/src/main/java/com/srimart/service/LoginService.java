package com.srimart.service;

import com.srimart.dao.UserDAO;
import com.srimart.model.User;
import com.srimart.util.PasswordUtil;
import com.srimart.util.ValidationUtil;

import java.sql.SQLException;

public class LoginService {

    private final UserDAO userDAO;

    public LoginService() {
        this.userDAO = new UserDAO();
    }

    public User login(String email, String password) throws SQLException {

        // Clean input
        email = email == null ? null : email.trim().toLowerCase();

        // Basic validation
        if (!ValidationUtil.isValidEmail(email)) {
            return null;
        }

        if (password == null || password.isEmpty()) {
            return null;
        }

        // Find user
        User user = userDAO.findByEmail(email);

        if (user == null) {
            return null;
        }

        // Verify BCrypt password
        if (!PasswordUtil.verifyPassword(
                password,
                user.getPasswordHash())) {
            return null;
        }

        return user;
    }
}