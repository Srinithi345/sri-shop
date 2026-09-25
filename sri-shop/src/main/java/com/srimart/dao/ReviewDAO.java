package com.srimart.dao;

import com.srimart.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReviewDAO {

    public boolean hasReviewed(long buyerId, long productId)
            throws Exception {

        String sql =
                "SELECT 1 FROM reviews " +
                "WHERE buyer_id = ? AND product_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);
            statement.setLong(2, productId);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        }
    }

    public void addReview(
            long buyerId,
            long productId,
            int rating,
            String comment) throws Exception {

        String sql =
                "INSERT INTO reviews " +
                "(buyer_id, product_id, rating, comment) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);
            statement.setLong(2, productId);
            statement.setInt(3, rating);
            statement.setString(4, comment);

            statement.executeUpdate();
        }
    }

    public ResultSet getReviewsByBuyer(long buyerId)
            throws Exception {

        String sql =
                "SELECT r.review_id, r.product_id, " +
                "p.name AS product_name, r.rating, " +
                "r.comment, r.created_at " +
                "FROM reviews r " +
                "JOIN products p ON r.product_id = p.product_id " +
                "WHERE r.buyer_id = ? " +
                "ORDER BY r.created_at DESC";

        Connection connection = DBConnection.getConnection();

        PreparedStatement statement =
                connection.prepareStatement(sql);

        statement.setLong(1, buyerId);

        return statement.executeQuery();
    }

    public void deleteReview(
            long buyerId,
            long reviewId) throws Exception {

        String sql =
                "DELETE FROM reviews " +
                "WHERE review_id = ? AND buyer_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, reviewId);
            statement.setLong(2, buyerId);

            statement.executeUpdate();
        }
    }
}