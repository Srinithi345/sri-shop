
package com.srimart.controller;

import com.srimart.dao.CartDAO;
import com.srimart.dao.OrderDAO;
import com.srimart.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                !(session.getAttribute("userId") instanceof Long)) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        long buyerId = (Long) session.getAttribute("userId");

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");
        String payment = request.getParameter("payment");

        if (isBlank(fullName) || isBlank(phone) || isBlank(address)
                || isBlank(city) || isBlank(state) || isBlank(pincode)
                || isBlank(payment)) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Please fill all required fields.");
            return;
        }

        if (!phone.matches("\\d{10}")) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid phone number.");
            return;
        }

        if (!pincode.matches("\\d{6}")) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid PIN code.");
            return;
        }

        // Online payment has not been integrated yet.
        if (!"COD".equals(payment)) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Currently, only Cash on Delivery is available.");
            return;
        }

        try {
            List<CartItem> cartItems = cartDAO.getCartItems(buyerId);

            if (cartItems == null || cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            String shippingAddress =
                    fullName.trim() + ", "
                    + phone.trim() + ", "
                    + address.trim() + ", "
                    + city.trim() + ", "
                    + state.trim() + " - "
                    + pincode.trim();

            // OrderDAO calculates the total from current database prices
            // and validates/deducts stock within its transaction.
            long orderId = orderDAO.createOrder(
                    buyerId,
                    BigDecimal.ZERO,
                    shippingAddress,
                    cartItems,
                    Collections.emptyList()
            );

            BigDecimal totalAmount =
                    orderDAO.getOrderTotal(buyerId, orderId);

            cartDAO.clearCart(buyerId);

            request.setAttribute("orderId", orderId);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("payment", "Cash on Delivery");

            request.getRequestDispatcher("/order-success.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(
                    "Unable to place order. Please check stock and try again.",
                    e);
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.isBlank();
    }
}