package com.srimart.dao;

import com.srimart.model.CartItem;
import com.srimart.util.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public boolean addToCart(CartItem cartItem) throws SQLException {

        String sql = """
                INSERT INTO cart_items
                    (buyer_id, product_id, quantity, size, color)
                VALUES (?, ?, ?, ?, ?)
                ON CONFLICT (buyer_id, product_id)
                DO UPDATE SET
                    quantity = cart_items.quantity + EXCLUDED.quantity,
                    size = EXCLUDED.size,
                    color = EXCLUDED.color
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, cartItem.getBuyerId());
            statement.setLong(2, cartItem.getProductId());
            statement.setInt(3, cartItem.getQuantity());
            statement.setString(4, cartItem.getSize());
            statement.setString(5, cartItem.getColor());

            int rows = statement.executeUpdate();

            System.out.println(
                    "CART DAO: buyerId=" + cartItem.getBuyerId()
                    + ", productId=" + cartItem.getProductId()
                    + ", rowsAffected=" + rows
            );

            return rows > 0;

        } catch (SQLException e) {
            System.err.println("CART DAO INSERT FAILED");
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    public List<CartItem> getCartItems(long buyerId)
            throws SQLException {

        String sql = """
                SELECT cart_item_id, buyer_id, product_id,
                       quantity, size, color
                FROM cart_items
                WHERE buyer_id = ?
                ORDER BY cart_item_id DESC
                """;

        List<CartItem> cartItems = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();

                    item.setCartItemId(rs.getLong("cart_item_id"));
                    item.setBuyerId(rs.getLong("buyer_id"));
                    item.setProductId(rs.getLong("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setSize(rs.getString("size"));
                    item.setColor(rs.getString("color"));

                    cartItems.add(item);
                }
            }
        }

        return cartItems;
    }

    public boolean updateQuantity(
            long buyerId, long productId, int quantity)
            throws SQLException {

        String sql = """
                UPDATE cart_items
                SET quantity = ?
                WHERE buyer_id = ? AND product_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, quantity);
            statement.setLong(2, buyerId);
            statement.setLong(3, productId);

            return statement.executeUpdate() > 0;
        }
    }

    public boolean removeFromCart(long buyerId, long productId)
            throws SQLException {

        String sql = """
                DELETE FROM cart_items
                WHERE buyer_id = ? AND product_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);
            statement.setLong(2, productId);

            return statement.executeUpdate() > 0;
        }
    }

    public boolean clearCart(long buyerId) throws SQLException {

        String sql = "DELETE FROM cart_items WHERE buyer_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);
            statement.executeUpdate();
            return true;
        }
    }

    public int getCartItemCount(long buyerId) throws SQLException {

        String sql = """
                SELECT COALESCE(SUM(quantity), 0)
                FROM cart_items
                WHERE buyer_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);

            try (ResultSet rs = statement.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    public BigDecimal getCartTotal(long buyerId) throws SQLException {

        String sql = """
                SELECT COALESCE(SUM(c.quantity * p.price), 0)
                FROM cart_items c
                JOIN products p ON c.product_id = p.product_id
                WHERE c.buyer_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);

            try (ResultSet rs = statement.executeQuery()) {
                return rs.next() ? rs.getBigDecimal(1) : BigDecimal.ZERO;
            }
        }
    }
}