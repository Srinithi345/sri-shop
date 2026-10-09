package com.srimart.controller;

import com.srimart.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/seller-orders")
public class SellerOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String[] ALLOWED_STATUSES = {
            "PENDING",
            "CONFIRMED",
            "SHIPPED",
            "DELIVERED",
            "CANCELLED"
    };

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String role =
                String.valueOf(session.getAttribute("userRole"));

        if (!"SELLER".equalsIgnoreCase(role)) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        long sellerId = getSellerId(session, response, request);

        if (sellerId == -1) {
            return;
        }

        List<Map<String, Object>> orders;

        try {
            orders = loadSellerOrders(sellerId);
        } catch (SQLException e) {
            e.printStackTrace();

            throw new ServletException(
                    "Unable to load seller orders.",
                    e
            );
        }

        request.setAttribute(
                "sellerOrders",
                orders
        );

        request.getRequestDispatcher(
                "/seller-orders.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null
                || !"SELLER".equalsIgnoreCase(
                        String.valueOf(
                                session.getAttribute("userRole")
                        ))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        long sellerId = getSellerId(session, response, request);

        if (sellerId == -1) {
            return;
        }

        String action = request.getParameter("action");

        if (!"updateStatus".equals(action)) {

            response.sendRedirect(
                    request.getContextPath() + "/seller-orders"
            );

            return;
        }

        String orderIdValue =
                request.getParameter("orderId");

        String newStatus =
                request.getParameter("status");

        if (orderIdValue == null
                || orderIdValue.isBlank()
                || newStatus == null
                || newStatus.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/seller-orders?error=Invalid+order+status"
            );

            return;
        }

        long orderId;

        try {

            orderId = Long.parseLong(orderIdValue);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/seller-orders?error=Invalid+order"
            );

            return;
        }

        newStatus = newStatus.trim().toUpperCase();

        if (!isAllowedStatus(newStatus)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/seller-orders?error=Invalid+status"
            );

            return;
        }

        String sql = """
                UPDATE orders
                SET status = ?
                WHERE order_id = ?
                  AND EXISTS (
                      SELECT 1
                      FROM order_items oi
                      JOIN products p
                          ON oi.product_id = p.product_id
                      WHERE oi.order_id = orders.order_id
                        AND p.seller_id = ?
                  )
                """;

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, newStatus);
            statement.setLong(2, orderId);
            statement.setLong(3, sellerId);

            int updatedRows =
                    statement.executeUpdate();

            if (updatedRows > 0) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/seller-orders?success=Status+updated"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/seller-orders?error=Unable+to+update+order"
                );
            }

        } catch (SQLException e) {

            e.printStackTrace();

            throw new ServletException(
                    "Unable to update order status.",
                    e
            );
        }
    }

    private long getSellerId(
            HttpSession session,
            HttpServletResponse response,
            HttpServletRequest request)
            throws IOException {

        try {

            Object userIdObject =
                    session.getAttribute("userId");

            if (userIdObject instanceof Number) {

                return ((Number) userIdObject).longValue();

            } else {

                return Long.parseLong(
                        String.valueOf(userIdObject)
                );
            }

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return -1;
        }
    }

    private boolean isAllowedStatus(String status) {

        for (String allowedStatus : ALLOWED_STATUSES) {

            if (allowedStatus.equals(status)) {
                return true;
            }
        }

        return false;
    }

    private List<Map<String, Object>> loadSellerOrders(
            long sellerId)
            throws SQLException {

        List<Map<String, Object>> orders =
                new ArrayList<>();

        String sql = """
                SELECT
                    o.order_id,
                    u.name AS buyer_name,
                    u.email AS buyer_email,
                    o.status,
                    o.shipping_address,
                    o.created_at,
                    STRING_AGG(
                        p.name || ' x ' || oi.quantity,
                        ', '
                        ORDER BY p.name
                    ) AS product_summary,
                    COALESCE(
                        SUM(oi.quantity * oi.unit_price),
                        0
                    ) AS seller_amount
                FROM orders o
                JOIN users u
                    ON o.buyer_id = u.user_id
                JOIN order_items oi
                    ON o.order_id = oi.order_id
                JOIN products p
                    ON oi.product_id = p.product_id
                WHERE p.seller_id = ?
                GROUP BY
                    o.order_id,
                    u.name,
                    u.email,
                    o.status,
                    o.shipping_address,
                    o.created_at
                ORDER BY o.created_at DESC
                """;

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, sellerId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Map<String, Object> order =
                            new HashMap<>();

                    order.put(
                            "orderId",
                            resultSet.getLong("order_id")
                    );

                    order.put(
                            "buyerName",
                            resultSet.getString("buyer_name")
                    );

                    order.put(
                            "buyerEmail",
                            resultSet.getString("buyer_email")
                    );

                    order.put(
                            "status",
                            resultSet.getString("status")
                    );

                    order.put(
                            "shippingAddress",
                            resultSet.getString("shipping_address")
                    );

                    order.put(
                            "createdAt",
                            resultSet.getTimestamp("created_at")
                    );

                    order.put(
                            "productSummary",
                            resultSet.getString("product_summary")
                    );

                    BigDecimal sellerAmount =
                            resultSet.getBigDecimal(
                                    "seller_amount"
                            );

                    order.put(
                            "sellerAmount",
                            sellerAmount
                    );

                    orders.add(order);
                }
            }
        }

        return orders;
    }
}