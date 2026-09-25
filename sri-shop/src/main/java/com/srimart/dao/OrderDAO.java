package com.srimart.dao;

import com.srimart.model.CartItem;
import com.srimart.model.Product;
import com.srimart.util.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

public class OrderDAO {

    public long createOrder(
            long buyerId,
            BigDecimal totalAmount,
            String shippingAddress,
            List<CartItem> cartItems,
            List<Product> products) throws Exception {

        String orderSql =
                "INSERT INTO orders " +
                "(buyer_id, total_amount, status, shipping_address) " +
                "VALUES (?, ?, 'PENDING', ?)";

        String itemSql =
                "INSERT INTO order_items " +
                "(order_id, product_id, quantity, unit_price) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection()) {

            connection.setAutoCommit(false);

            try {

                long orderId;

                try (PreparedStatement orderStatement =
                             connection.prepareStatement(
                                     orderSql,
                                     Statement.RETURN_GENERATED_KEYS)) {

                    orderStatement.setLong(1, buyerId);
                    orderStatement.setBigDecimal(2, totalAmount);
                    orderStatement.setString(3, shippingAddress);

                    orderStatement.executeUpdate();

                    try (ResultSet keys =
                                 orderStatement.getGeneratedKeys()) {

                        if (!keys.next()) {
                            throw new Exception(
                                    "Unable to create order."
                            );
                        }

                        orderId = keys.getLong(1);
                    }
                }

                try (PreparedStatement itemStatement =
                             connection.prepareStatement(itemSql)) {

                    for (CartItem item : cartItems) {

                        Product product = null;

                        for (Product p : products) {

                            if (p.getProductId() ==
                                    item.getProductId()) {

                                product = p;
                                break;
                            }
                        }

                        if (product == null) {
                            throw new Exception(
                                    "Product not found: "
                                    + item.getProductId()
                            );
                        }

                        itemStatement.setLong(
                                1,
                                orderId
                        );

                        itemStatement.setLong(
                                2,
                                item.getProductId()
                        );

                        itemStatement.setInt(
                                3,
                                item.getQuantity()
                        );

                        itemStatement.setBigDecimal(
                                4,
                                product.getPrice()
                        );

                        itemStatement.addBatch();
                    }

                    itemStatement.executeBatch();
                }

                connection.commit();

                return orderId;

            } catch (Exception e) {

                connection.rollback();

                throw e;
            }

        }
    }
    public ResultSet getOrdersByBuyer(long buyerId) throws Exception {

    String sql =
            "SELECT order_id, total_amount, status, " +
            "shipping_address, created_at " +
            "FROM orders " +
            "WHERE buyer_id = ? " +
            "ORDER BY created_at DESC";

    Connection connection = DBConnection.getConnection();

    PreparedStatement statement =
            connection.prepareStatement(sql);

    statement.setLong(1, buyerId);

    return statement.executeQuery();
}
public int getTotalOrdersByBuyer(long buyerId) throws Exception {

    String sql =
            "SELECT COUNT(*) " +
            "FROM orders " +
            "WHERE buyer_id = ?";

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


public int getTotalItemsByBuyer(long buyerId) throws Exception {

    String sql =
            "SELECT COALESCE(SUM(oi.quantity), 0) " +
            "FROM order_items oi " +
            "JOIN orders o ON oi.order_id = o.order_id " +
            "WHERE o.buyer_id = ?";

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


public int getDifferentVarietiesByBuyer(long buyerId) throws Exception {

    String sql =
            "SELECT COUNT(DISTINCT oi.product_id) " +
            "FROM order_items oi " +
            "JOIN orders o ON oi.order_id = o.order_id " +
            "WHERE o.buyer_id = ?";

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


public BigDecimal getTotalSpentByBuyer(long buyerId) throws Exception {

    String sql =
            "SELECT COALESCE(SUM(total_amount), 0) " +
            "FROM orders " +
            "WHERE buyer_id = ?";

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement = connection.prepareStatement(sql)) {

        statement.setLong(1, buyerId);

        try (ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getBigDecimal(1);
            }

            return BigDecimal.ZERO;
        }
    }
}
}