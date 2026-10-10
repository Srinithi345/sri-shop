package com.srimart.controller;

import com.srimart.dao.CartDAO;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        long buyerId = ((Number) session.getAttribute("userId")).longValue();

        try {
            List<CartItem> cartItems = cartDAO.getCartItems(buyerId);
            List<Product> products = productDAO.getAllProducts();

            Map<Long, Product> productMap = new HashMap<>();

            for (Product product : products) {
                productMap.put(product.getProductId(), product);
            }

            for (CartItem item : cartItems) {
                request.setAttribute(
                    "product_" + item.getProductId(),
                    productMap.get(item.getProductId())
                );
            }

            request.setAttribute("cartItems", cartItems);

            System.out.println(
                "CART GET: buyerId=" + buyerId
                + ", itemCount=" + cartItems.size()
            );

            request.getRequestDispatcher("/cart.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Unable to load cart.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        long buyerId = ((Number) session.getAttribute("userId")).longValue();
        String action = request.getParameter("action");

        System.out.println(
            "CART POST: buyerId=" + buyerId + ", action=" + action
        );

        try {
            if ("add".equals(action)) {

                String productIdValue = request.getParameter("productId");
                String quantityValue = request.getParameter("quantity");
                String size = request.getParameter("size");
                String color = request.getParameter("color");

                if (productIdValue == null || productIdValue.isBlank()
                        || quantityValue == null || quantityValue.isBlank()
                        || size == null || size.isBlank()
                        || color == null || color.isBlank()) {

                    response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Product ID, quantity, size and color are required."
                    );
                    return;
                }

                long productId = Long.parseLong(productIdValue);
                int quantity = Integer.parseInt(quantityValue);

                System.out.println(
                    "CART ADD: productId=" + productId
                    + ", quantity=" + quantity
                    + ", size=" + size
                    + ", color=" + color
                );

                if (productId <= 0 || quantity < 1) {
                    response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid product ID or quantity."
                    );
                    return;
                }

                Product product = productDAO.getProductById(productId);

                if (product == null) {
                    response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found."
                    );
                    return;
                }

                CartItem cartItem = new CartItem(
                    buyerId,
                    productId,
                    quantity,
                    size.trim(),
                    color.trim()
                );

                boolean added = cartDAO.addToCart(cartItem);

                System.out.println("CART ADD RESULT: " + added);

                if (!added) {
                    response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Product could not be added to cart."
                    );
                    return;
                }

                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            if ("update".equals(action)) {

                long productId = Long.parseLong(
                    request.getParameter("productId")
                );
                int quantity = Integer.parseInt(
                    request.getParameter("quantity")
                );

                if (productId <= 0 || quantity < 1) {
                    response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid product ID or quantity."
                    );
                    return;
                }

                boolean updated = cartDAO.updateQuantity(
                    buyerId, productId, quantity
                );

                if (!updated) {
                    response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Cart item was not found."
                    );
                    return;
                }

                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            if ("remove".equals(action)) {

                long productId = Long.parseLong(
                    request.getParameter("productId")
                );

                if (productId <= 0) {
                    response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid product ID."
                    );
                    return;
                }

                boolean removed = cartDAO.removeFromCart(buyerId, productId);

                if (!removed) {
                    response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Cart item was not found."
                    );
                    return;
                }

                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            if ("clear".equals(action)) {
                cartDAO.clearCart(buyerId);
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid cart action."
            );

        } catch (NumberFormatException e) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid product ID or quantity."
            );

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Cart operation failed.", e);
        }
    }
}