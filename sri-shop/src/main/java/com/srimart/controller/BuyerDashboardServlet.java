package com.srimart.controller;

import com.srimart.dao.CartDAO;
import com.srimart.dao.OrderDAO;
import com.srimart.dao.ProductDAO;
import com.srimart.model.CartItem;
import com.srimart.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/buyer-dashboard")
public class BuyerDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final OrderDAO orderDAO = new OrderDAO();
    private final CartDAO cartDAO = new CartDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        long buyerId =
                (Long) session.getAttribute("userId");

        try {

            // ==============================
            // ORDER SUMMARY
            // ==============================

            int totalOrders =
                    orderDAO.getTotalOrdersByBuyer(buyerId);

            int totalItems =
                    orderDAO.getTotalItemsByBuyer(buyerId);

            int differentVarieties =
                    orderDAO.getDifferentVarietiesByBuyer(buyerId);

            BigDecimal totalSpent =
                    orderDAO.getTotalSpentByBuyer(buyerId);


            // ==============================
            // CART SUMMARY
            // ==============================

            int cartItemCount =
                    cartDAO.getCartItemCount(buyerId);

            BigDecimal cartTotal =
                    cartDAO.getCartTotal(buyerId);


            // ==============================
            // CART PRODUCTS
            // ==============================

            List<CartItem> cartItems =
                    cartDAO.getCartItems(buyerId);

            List<Product> products =
                    productDAO.getAllProducts();

            Map<Long, Product> productMap =
                    new HashMap<>();

            for (Product product : products) {

                productMap.put(
                        product.getProductId(),
                        product
                );
            }


            // Create dashboard cart preview

            List<Map<String, Object>> cartPreview =
                    new ArrayList<>();

            int previewCount = 0;

            for (CartItem item : cartItems) {

                if (previewCount >= 3) {
                    break;
                }

                Product product =
                        productMap.get(
                                item.getProductId()
                        );

                if (product == null) {
                    continue;
                }

                Map<String, Object> cart =
                        new HashMap<>();

                cart.put(
                        "productId",
                        item.getProductId()
                );

                cart.put(
                        "name",
                        product.getName()
                );

                cart.put(
                        "price",
                        product.getPrice()
                );

                cart.put(
                        "imageUrl",
                        product.getImageUrl()
                );

                cart.put(
                        "size",
                        item.getSize()
                );

                cart.put(
                        "color",
                        item.getColor()
                );

                cart.put(
                        "quantity",
                        item.getQuantity()
                );

                BigDecimal itemTotal =
                        product.getPrice()
                                .multiply(
                                        BigDecimal.valueOf(
                                                item.getQuantity()
                                        )
                                );

                cart.put(
                        "itemTotal",
                        itemTotal
                );

                cartPreview.add(cart);

                previewCount++;
            }


            // ==============================
            // RECENT ORDERS
            // ==============================

            List<Map<String, Object>> recentOrders =
                    new ArrayList<>();

            ResultSet resultSet = null;
            Statement statement = null;
            Connection connection = null;

            try {

                resultSet =
                        orderDAO.getOrdersByBuyer(buyerId);

                statement =
                        resultSet.getStatement();

                connection =
                        statement.getConnection();

                int count = 0;

                while (resultSet.next() && count < 3) {

                    Map<String, Object> order =
                            new HashMap<>();

                    order.put(
                            "orderId",
                            resultSet.getLong("order_id")
                    );

                    order.put(
                            "totalAmount",
                            resultSet.getBigDecimal(
                                    "total_amount"
                            )
                    );

                    order.put(
                            "status",
                            resultSet.getString(
                                    "status"
                            )
                    );

                    order.put(
                            "shippingAddress",
                            resultSet.getString(
                                    "shipping_address"
                            )
                    );

                    order.put(
                            "createdAt",
                            resultSet.getTimestamp(
                                    "created_at"
                            )
                    );

                    recentOrders.add(order);

                    count++;
                }

            } finally {

                try {
                    if (resultSet != null) {
                        resultSet.close();
                    }
                } catch (Exception ignored) {
                }

                try {
                    if (statement != null) {
                        statement.close();
                    }
                } catch (Exception ignored) {
                }

                try {
                    if (connection != null) {
                        connection.close();
                    }
                } catch (Exception ignored) {
                }
            }


            // ==============================
            // SEND DATA TO JSP
            // ==============================

            request.setAttribute(
                    "totalOrders",
                    totalOrders
            );

            request.setAttribute(
                    "totalItems",
                    totalItems
            );

            request.setAttribute(
                    "differentVarieties",
                    differentVarieties
            );

            request.setAttribute(
                    "totalSpent",
                    totalSpent
            );

            request.setAttribute(
                    "cartItemCount",
                    cartItemCount
            );

            request.setAttribute(
                    "cartTotal",
                    cartTotal
            );

            request.setAttribute(
                    "cartPreview",
                    cartPreview
            );

            request.setAttribute(
                    "recentOrders",
                    recentOrders
            );


            // ==============================
            // OPEN DASHBOARD
            // ==============================

            request.getRequestDispatcher(
                    "/buyer-dashboard.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to load buyer dashboard.",
                    e
            );
        }
    }
}