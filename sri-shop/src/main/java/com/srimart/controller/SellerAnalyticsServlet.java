package com.srimart.controller;

import com.srimart.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/seller-analytics")
public class SellerAnalyticsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

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

        String role = String.valueOf(
                session.getAttribute("userRole")
        );

        if (!"SELLER".equalsIgnoreCase(role)) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        long sellerId;

        try {

            Object userIdObject =
                    session.getAttribute("userId");

            if (userIdObject instanceof Number) {

                sellerId =
                        ((Number) userIdObject).longValue();

            } else {

                sellerId =
                        Long.parseLong(
                                String.valueOf(userIdObject)
                        );
            }

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        Map<String, Object> analytics =
                new HashMap<>();

        String summarySql = """
                SELECT
                    COUNT(DISTINCT p.product_id) AS total_products,
                    COUNT(DISTINCT o.order_id) AS total_orders,
                    COALESCE(
                        SUM(oi.quantity * oi.unit_price),
                        0
                    ) AS total_sales,
                    COALESCE(
                        SUM(oi.quantity),
                        0
                    ) AS total_items_sold
                FROM products p
                LEFT JOIN order_items oi
                    ON p.product_id = oi.product_id
                LEFT JOIN orders o
                    ON oi.order_id = o.order_id
                WHERE p.seller_id = ?
                """;

        String lowStockSql = """
                SELECT COUNT(*)
                FROM products
                WHERE seller_id = ?
                  AND stock_quantity <= 5
                """;

        String bestProductSql = """
                SELECT
                    p.name,
                    COALESCE(SUM(oi.quantity), 0) AS units_sold
                FROM products p
                LEFT JOIN order_items oi
                    ON p.product_id = oi.product_id
                WHERE p.seller_id = ?
                GROUP BY p.product_id, p.name
                ORDER BY units_sold DESC
                LIMIT 1
                """;

        try (Connection connection =
                     DBConnection.getConnection()) {

            try (PreparedStatement statement =
                         connection.prepareStatement(summarySql)) {

                statement.setLong(1, sellerId);

                try (ResultSet resultSet =
                             statement.executeQuery()) {

                    if (resultSet.next()) {

                        analytics.put(
                                "totalProducts",
                                resultSet.getInt(
                                        "total_products"
                                )
                        );

                        analytics.put(
                                "totalOrders",
                                resultSet.getInt(
                                        "total_orders"
                                )
                        );

                        analytics.put(
                                "totalSales",
                                resultSet.getBigDecimal(
                                        "total_sales"
                                )
                        );

                        analytics.put(
                                "totalItemsSold",
                                resultSet.getInt(
                                        "total_items_sold"
                                )
                        );
                    }
                }
            }

            try (PreparedStatement statement =
                         connection.prepareStatement(lowStockSql)) {

                statement.setLong(1, sellerId);

                try (ResultSet resultSet =
                             statement.executeQuery()) {

                    if (resultSet.next()) {

                        analytics.put(
                                "lowStock",
                                resultSet.getInt(1)
                        );
                    }
                }
            }

            try (PreparedStatement statement =
                         connection.prepareStatement(bestProductSql)) {

                statement.setLong(1, sellerId);

                try (ResultSet resultSet =
                             statement.executeQuery()) {

                    if (resultSet.next()) {

                        analytics.put(
                                "bestProduct",
                                resultSet.getString("name")
                        );

                        analytics.put(
                                "bestProductUnits",
                                resultSet.getInt("units_sold")
                        );

                    } else {

                        analytics.put(
                                "bestProduct",
                                "No sales yet"
                        );

                        analytics.put(
                                "bestProductUnits",
                                0
                        );
                    }
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                    "Unable to load seller analytics.",
                    e
            );
        }

        request.setAttribute(
                "analytics",
                analytics
        );

        request.getRequestDispatcher(
                "/seller-analytics.jsp"
        ).forward(request, response);
    }
}