package com.srimart.controller;

import com.srimart.dao.ProductDAO;
import com.srimart.model.Product;
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
import java.util.List;

@WebServlet("/seller-dashboard")
public class SellerDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Check seller role
        String userRole = String.valueOf(
                session.getAttribute("userRole")
        );

        if (!"SELLER".equalsIgnoreCase(userRole)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Get logged-in seller ID safely
        Object userIdObject = session.getAttribute("userId");

        long sellerId;

        try {
            if (userIdObject instanceof Number) {
                sellerId = ((Number) userIdObject).longValue();
            } else {
                sellerId = Long.parseLong(
                        String.valueOf(userIdObject)
                );
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Debug information
        System.out.println(
                "========================================"
        );
        System.out.println(
                "SELLER DASHBOARD"
        );
        System.out.println(
                "Logged-in Seller ID = " + sellerId
        );
        System.out.println(
                "Logged-in Seller Role = " + userRole
        );
        System.out.println(
                "========================================"
        );

        try {

            // Total products
            int totalProducts =
                    productDAO.getProductCountBySeller(sellerId);

            // Low stock products
            int lowStock =
                    productDAO.getLowStockCountBySeller(sellerId);

            // Total orders
            int totalOrders =
                    getTotalOrders(sellerId);

            // Total sales
            BigDecimal totalSales =
                    getTotalSales(sellerId);

            // Seller products
            List<Product> products =
                    productDAO.getProductsBySeller(sellerId);

            // Send data to JSP
            request.setAttribute(
                    "totalProducts",
                    totalProducts
            );

            request.setAttribute(
                    "totalOrders",
                    totalOrders
            );

            request.setAttribute(
                    "lowStock",
                    lowStock
            );

            request.setAttribute(
                    "totalSales",
                    totalSales
            );

            request.setAttribute(
                    "sellerProducts",
                    products
            );

            // Forward to dashboard
            request.getRequestDispatcher(
                    "/seller-dashboard.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                    "Unable to load seller dashboard.",
                    e
            );
        }
    }

    // ============================================
    // TOTAL ORDERS
    // ============================================

    private int getTotalOrders(long sellerId)
            throws Exception {

        String sql = """
                SELECT COUNT(DISTINCT o.order_id)
                FROM orders o
                JOIN order_items oi
                    ON o.order_id = oi.order_id
                JOIN products p
                    ON oi.product_id = p.product_id
                WHERE p.seller_id = ?
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setLong(1, sellerId);

            try (
                    ResultSet resultSet =
                            statement.executeQuery()
            ) {

                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }

                return 0;
            }
        }
    }

    // ============================================
    // TOTAL SALES
    // ============================================

    private BigDecimal getTotalSales(long sellerId)
            throws Exception {

        String sql = """
                SELECT COALESCE(
                    SUM(oi.quantity * oi.unit_price),
                    0
                )
                FROM order_items oi
                JOIN products p
                    ON oi.product_id = p.product_id
                JOIN orders o
                    ON oi.order_id = o.order_id
                WHERE p.seller_id = ?
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setLong(1, sellerId);

            try (
                    ResultSet resultSet =
                            statement.executeQuery()
            ) {

                if (resultSet.next()) {

                    BigDecimal value =
                            resultSet.getBigDecimal(1);

                    if (value != null) {
                        return value;
                    }
                }

                return BigDecimal.ZERO;
            }
        }
    }
}