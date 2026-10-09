package com.srimart.dao;

import com.srimart.model.CartItem;
import com.srimart.model.Product;
import com.srimart.util.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderDAO {

    public long createOrder(
            long buyerId,
            BigDecimal totalAmount,
            String shippingAddress,
            List<CartItem> cartItems,
            List<Product> products) throws Exception {

        if (cartItems == null || cartItems.isEmpty()) {
            throw new Exception("Your cart is empty.");
        }

        List<CartItem> sortedItems = new ArrayList<>(cartItems);
        sortedItems.sort(Comparator.comparingLong(CartItem::getProductId));

        String productSql =
                "SELECT price, stock_quantity " +
                "FROM products WHERE product_id = ? FOR UPDATE";

        String orderSql =
                "INSERT INTO orders " +
                "(buyer_id, total_amount, status, shipping_address) " +
                "VALUES (?, ?, 'PENDING', ?)";

        String stockSql =
                "UPDATE products " +
                "SET stock_quantity = stock_quantity - ? " +
                "WHERE product_id = ? AND stock_quantity >= ?";

        String itemSql =
                "INSERT INTO order_items " +
                "(order_id, product_id, quantity, unit_price) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection()) {
            connection.setAutoCommit(false);

            try {
                Map<Long, BigDecimal> priceMap = new HashMap<>();
                BigDecimal actualTotal = BigDecimal.ZERO;

                // Lock products and validate stock using current database values.
                try (PreparedStatement productStatement =
                             connection.prepareStatement(productSql)) {

                    for (CartItem item : sortedItems) {
                        if (item.getQuantity() < 1) {
                            throw new Exception("Invalid item quantity.");
                        }

                        productStatement.setLong(1, item.getProductId());

                        try (ResultSet rs = productStatement.executeQuery()) {
                            if (!rs.next()) {
                                throw new Exception(
                                        "Product not found: " + item.getProductId());
                            }

                            BigDecimal price = rs.getBigDecimal("price");
                            int stock = rs.getInt("stock_quantity");

                            if (price == null || price.signum() < 0) {
                                throw new Exception(
                                        "Invalid price for product ID: "
                                                + item.getProductId());
                            }

                            if (stock < item.getQuantity()) {
                                throw new Exception(
                                        "Insufficient stock for product ID: "
                                                + item.getProductId());
                            }

                            priceMap.put(item.getProductId(), price);

                            actualTotal = actualTotal.add(
                                    price.multiply(
                                            BigDecimal.valueOf(item.getQuantity())));
                        }
                    }
                }

                long orderId;

                try (PreparedStatement orderStatement =
                             connection.prepareStatement(
                                     orderSql, Statement.RETURN_GENERATED_KEYS)) {

                    orderStatement.setLong(1, buyerId);
                    orderStatement.setBigDecimal(2, actualTotal);
                    orderStatement.setString(3, shippingAddress);
                    orderStatement.executeUpdate();

                    try (ResultSet keys = orderStatement.getGeneratedKeys()) {
                        if (!keys.next()) {
                            throw new Exception("Unable to create order.");
                        }
                        orderId = keys.getLong(1);
                    }
                }

                try (PreparedStatement stockStatement =
                             connection.prepareStatement(stockSql);
                     PreparedStatement itemStatement =
                             connection.prepareStatement(itemSql)) {

                    for (CartItem item : sortedItems) {
                        stockStatement.setInt(1, item.getQuantity());
                        stockStatement.setLong(2, item.getProductId());
                        stockStatement.setInt(3, item.getQuantity());

                        if (stockStatement.executeUpdate() != 1) {
                            throw new Exception(
                                    "Stock changed. Please review your cart and try again.");
                        }

                        itemStatement.setLong(1, orderId);
                        itemStatement.setLong(2, item.getProductId());
                        itemStatement.setInt(3, item.getQuantity());
                        itemStatement.setBigDecimal(
                                4, priceMap.get(item.getProductId()));
                        itemStatement.addBatch();
                    }

                    itemStatement.executeBatch();
                }

                connection.commit();
                return orderId;

            } catch (Exception e) {
                try {
                    connection.rollback();
                } catch (Exception rollbackException) {
                    e.addSuppressed(rollbackException);
                }
                throw e;
            }
        }
    }

    public BigDecimal getOrderTotal(long buyerId, long orderId)
            throws Exception {

        String sql =
                "SELECT total_amount FROM orders " +
                "WHERE buyer_id = ? AND order_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);
            statement.setLong(2, orderId);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getBigDecimal("total_amount");
                }
            }
        }

        throw new Exception("Order total not found.");
    }

    public ResultSet getOrdersByBuyer(long buyerId) throws Exception {
        String sql =
                "SELECT order_id, total_amount, status, " +
                "shipping_address, created_at " +
                "FROM orders WHERE buyer_id = ? " +
                "ORDER BY created_at DESC";

        Connection connection = DBConnection.getConnection();
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setLong(1, buyerId);
        return statement.executeQuery();
    }

    public int getTotalOrdersByBuyer(long buyerId) throws Exception {
        String sql =
                "SELECT COUNT(*) FROM orders WHERE buyer_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);

            try (ResultSet rs = statement.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    public int getTotalItemsByBuyer(long buyerId) throws Exception {
        String sql =
                "SELECT COALESCE(SUM(oi.quantity), 0) " +
                "FROM order_items oi " +
                "JOIN orders o ON oi.order_id = o.order_id " +
                "WHERE o.buyer_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);

            try (ResultSet rs = statement.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    public int getDifferentVarietiesByBuyer(long buyerId) throws Exception {
        String sql =
                "SELECT COUNT(DISTINCT oi.product_id) " +
                "FROM order_items oi " +
                "JOIN orders o ON oi.order_id = o.order_id " +
                "WHERE o.buyer_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);

            try (ResultSet rs = statement.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    public BigDecimal getTotalSpentByBuyer(long buyerId) throws Exception {
        String sql =
                "SELECT COALESCE(SUM(total_amount), 0) " +
                "FROM orders WHERE buyer_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, buyerId);

            try (ResultSet rs = statement.executeQuery()) {
                return rs.next() ? rs.getBigDecimal(1) : BigDecimal.ZERO;
            }
        }
    }

    public ResultSet getOrderDetails(long buyerId, long orderId)
            throws Exception {

        String sql =
                "SELECT o.order_id, o.total_amount, o.status, " +
                "o.shipping_address, o.created_at, oi.product_id, " +
                "p.name AS product_name, p.image_url, oi.quantity, " +
                "oi.unit_price, (oi.quantity * oi.unit_price) AS item_total " +
                "FROM orders o " +
                "JOIN order_items oi ON o.order_id = oi.order_id " +
                "JOIN products p ON oi.product_id = p.product_id " +
                "WHERE o.buyer_id = ? AND o.order_id = ? " +
                "ORDER BY oi.order_item_id";

        Connection connection = DBConnection.getConnection();
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setLong(1, buyerId);
        statement.setLong(2, orderId);
        return statement.executeQuery();
    }
}