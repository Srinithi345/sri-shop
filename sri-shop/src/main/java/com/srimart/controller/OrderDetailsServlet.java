package com.srimart.controller;

import com.srimart.dao.OrderDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/order-details")
public class OrderDetailsServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null
                || !"BUYER".equalsIgnoreCase(
                        String.valueOf(session.getAttribute("userRole")))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String orderIdValue = request.getParameter("id");

        if (orderIdValue == null || orderIdValue.isBlank()) {

            response.sendRedirect(
                    request.getContextPath() + "/orders"
            );
            return;
        }

        try {

            long buyerId = Long.parseLong(
                    String.valueOf(session.getAttribute("userId"))
            );

            long orderId = Long.parseLong(
                    orderIdValue
            );

            List<Map<String, Object>> items =
                    new ArrayList<>();

            try (ResultSet resultSet =
                         orderDAO.getOrderDetails(
                                 buyerId,
                                 orderId)) {

                while (resultSet.next()) {

                    Map<String, Object> item =
                            new HashMap<>();

                    item.put(
                            "orderId",
                            resultSet.getLong("order_id")
                    );

                    item.put(
                            "totalAmount",
                            resultSet.getBigDecimal("total_amount")
                    );

                    item.put(
                            "status",
                            resultSet.getString("status")
                    );

                    item.put(
                            "shippingAddress",
                            resultSet.getString(
                                    "shipping_address"
                            )
                    );

                    item.put(
                            "createdAt",
                            resultSet.getTimestamp("created_at")
                    );

                    item.put(
                            "productId",
                            resultSet.getLong("product_id")
                    );

                    item.put(
                            "productName",
                            resultSet.getString(
                                    "product_name"
                            )
                    );

                    item.put(
                            "imageUrl",
                            resultSet.getString("image_url")
                    );

                    item.put(
                            "quantity",
                            resultSet.getInt("quantity")
                    );

                    item.put(
                            "unitPrice",
                            resultSet.getBigDecimal(
                                    "unit_price"
                            )
                    );

                    item.put(
                            "itemTotal",
                            resultSet.getBigDecimal(
                                    "item_total"
                            )
                    );

                    items.add(item);
                }
            }

            if (items.isEmpty()) {

                response.sendRedirect(
                        request.getContextPath() + "/orders"
                );
                return;
            }

            Map<String, Object> firstItem =
                    items.get(0);

            request.setAttribute(
                    "orderId",
                    firstItem.get("orderId")
            );

            request.setAttribute(
                    "totalAmount",
                    firstItem.get("totalAmount")
            );

            request.setAttribute(
                    "status",
                    firstItem.get("status")
            );

            request.setAttribute(
                    "shippingAddress",
                    firstItem.get("shippingAddress")
            );

            request.setAttribute(
                    "createdAt",
                    firstItem.get("createdAt")
            );

            request.setAttribute(
                    "items",
                    items
            );

            request.getRequestDispatcher(
                    "/order-details.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath() + "/orders"
            );

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "errorMessage",
                    "Unable to load order details."
            );

            request.getRequestDispatcher(
                    "/orders"
            ).forward(request, response);
        }
    }
}