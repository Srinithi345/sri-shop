package com.srimart.dao;

import com.srimart.model.CartItem;
import com.srimart.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    // Add product to cart with size and color
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
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, cartItem.getBuyerId());
            statement.setLong(2, cartItem.getProductId());
            statement.setInt(3, cartItem.getQuantity());
            statement.setString(4, cartItem.getSize());
            statement.setString(5, cartItem.getColor());

            return statement.executeUpdate() > 0;
        }
    }

    // Get all cart items for a buyer
    public List<CartItem> getCartItems(long buyerId) throws SQLException {

        String sql = """
                SELECT cart_item_id,
                       buyer_id,
                       product_id,
                       quantity,
                       size,
                       color
                FROM cart_items
                WHERE buyer_id = ?
                ORDER BY created_at DESC
                """;

        List<CartItem> cartItems = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    CartItem item = new CartItem();

                    item.setCartItemId(
                            resultSet.getLong("cart_item_id")
                    );

                    item.setBuyerId(
                            resultSet.getLong("buyer_id")
                    );

                    item.setProductId(
                            resultSet.getLong("product_id")
                    );

                    item.setQuantity(
                            resultSet.getInt("quantity")
                    );

                    item.setSize(
                            resultSet.getString("size")
                    );

                    item.setColor(
                            resultSet.getString("color")
                    );

                    cartItems.add(item);
                }
            }
        }

        return cartItems;
    }

    // Update cart item quantity
    public boolean updateQuantity(
            long buyerId,
            long productId,
            int quantity) throws SQLException {

        String sql = """
                UPDATE cart_items
                SET quantity = ?
                WHERE buyer_id = ?
                AND product_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, quantity);
            statement.setLong(2, buyerId);
            statement.setLong(3, productId);

            return statement.executeUpdate() > 0;
        }
    }

    // Remove one product from cart
    public boolean removeFromCart(
            long buyerId,
            long productId) throws SQLException {

        String sql = """
                DELETE FROM cart_items
                WHERE buyer_id = ?
                AND product_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);
            statement.setLong(2, productId);

            return statement.executeUpdate() > 0;
        }
    }

    // Clear complete cart for one buyer
    public boolean clearCart(long buyerId) throws SQLException {

        String sql = """
                DELETE FROM cart_items
                WHERE buyer_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);

            statement.executeUpdate();
            return true;
        }
    }
    // Get total number of cart items
public int getCartItemCount(long buyerId) throws SQLException {

    String sql = """
            SELECT COALESCE(SUM(quantity), 0)
            FROM cart_items
            WHERE buyer_id = ?
            """;

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement = connection.prepareStatement(sql)) {

        statement.setLong(1, buyerId);

        try (ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }

            return 0;
        }
    }
}


// Get cart total amount
public java.math.BigDecimal getCartTotal(long buyerId) throws SQLException {

    String sql = """
            SELECT COALESCE(SUM(c.quantity * p.price), 0)
            FROM cart_items c
            JOIN products p
            ON c.product_id = p.product_id
            WHERE c.buyer_id = ?
            """;

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement = connection.prepareStatement(sql)) {

        statement.setLong(1, buyerId);

        try (ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getBigDecimal(1);
            }

            return java.math.BigDecimal.ZERO;
        }
    }
}
}