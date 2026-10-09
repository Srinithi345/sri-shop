package com.srimart.dao;

import com.srimart.model.User;
import com.srimart.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // Register a new user
    public boolean registerUser(User user) throws SQLException {

        String sql = """
                INSERT INTO users
                (name, email, password_hash, role, phone)
                VALUES (?, ?, ?, ?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPasswordHash());
            statement.setString(4, user.getRole());
            statement.setString(5, user.getPhone());

            return statement.executeUpdate() > 0;
        }
    }

    // Find user by email
    public User findByEmail(String email) throws SQLException {

        String sql = """
                SELECT user_id, name, email, password_hash, role, phone
                FROM users
                WHERE email = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    User user = new User();

                    user.setUserId(resultSet.getLong("user_id"));
                    user.setName(resultSet.getString("name"));
                    user.setEmail(resultSet.getString("email"));
                    user.setPasswordHash(resultSet.getString("password_hash"));
                    user.setRole(resultSet.getString("role"));
                    user.setPhone(resultSet.getString("phone"));

                    return user;
                }
            }
        }

        return null;
    }

    // Check whether email already exists
    public boolean emailExists(String email) throws SQLException {

        String sql = """
                SELECT 1
                FROM users
                WHERE email = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        }
    }

    // Update buyer profile
    public boolean updateProfile(
            long userId,
            String name,
            String phone) throws SQLException {

        String sql = """
                UPDATE users
                SET name = ?, phone = ?
                WHERE user_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, name);
            statement.setString(2, phone);
            statement.setLong(3, userId);

            return statement.executeUpdate() > 0;
        }
    }
    // Update user password
public boolean updatePassword(
        long userId,
        String passwordHash) throws SQLException {

    String sql = """
            UPDATE users
            SET password_hash = ?
            WHERE user_id = ?
            """;

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement = connection.prepareStatement(sql)) {

        statement.setString(1, passwordHash);
        statement.setLong(2, userId);

        return statement.executeUpdate() > 0;
    }
}
}