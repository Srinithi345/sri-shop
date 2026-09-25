package com.srimart.dao;

import com.srimart.model.Wishlist;
import com.srimart.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {

    public boolean addToWishlist(int buyerId, int productId) {

        String sql = """
                INSERT INTO wishlist (buyer_id, product_id)
                VALUES (?, ?)
                ON CONFLICT (buyer_id, product_id) DO NOTHING
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, buyerId);
            statement.setInt(2, productId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean removeFromWishlist(int buyerId, int productId) {

        String sql = """
                DELETE FROM wishlist
                WHERE buyer_id = ? AND product_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, buyerId);
            statement.setInt(2, productId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isInWishlist(int buyerId, int productId) {

        String sql = """
                SELECT 1
                FROM wishlist
                WHERE buyer_id = ? AND product_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, buyerId);
            statement.setInt(2, productId);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Wishlist> getWishlistByBuyer(int buyerId) {

        List<Wishlist> wishlistItems = new ArrayList<>();

        String sql = """
                SELECT wishlist_id, buyer_id, product_id, created_at
                FROM wishlist
                WHERE buyer_id = ?
                ORDER BY created_at DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, buyerId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Wishlist wishlist = new Wishlist();

                    wishlist.setWishlistId(
                            resultSet.getInt("wishlist_id")
                    );

                    wishlist.setBuyerId(
                            resultSet.getInt("buyer_id")
                    );

                    wishlist.setProductId(
                            resultSet.getInt("product_id")
                    );

                    wishlist.setCreatedAt(
                            resultSet.getTimestamp("created_at")
                    );

                    wishlistItems.add(wishlist);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return wishlistItems;
    }

    public int getWishlistCount(int buyerId) {

        String sql = """
                SELECT COUNT(*)
                FROM wishlist
                WHERE buyer_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, buyerId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
}