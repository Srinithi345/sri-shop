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
import java.sql.Statement;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final OrderDAO orderDAO = new OrderDAO();

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

        List<Map<String, Object>> orders =
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

            while (resultSet.next()) {

                Map<String, Object> order =
                        new HashMap<>();

                order.put(
                        "orderId",
                        resultSet.getLong("order_id")
                );

                order.put(
                        "totalAmount",
                        resultSet.getBigDecimal("total_amount")
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

                orders.add(order);
            }

            request.setAttribute(
                    "orders",
                    orders
            );

            request.getRequestDispatcher(
                    "/orders.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to load orders.",
                    e
            );

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
    }
}