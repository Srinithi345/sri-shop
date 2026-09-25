package com.srimart.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final CartDAO cartDAO = new CartDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
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

            // Get cart items
            List<CartItem> cartItems =
                    cartDAO.getCartItems(buyerId);

            // If cart is empty
            if (cartItems == null ||
                    cartItems.isEmpty()) {

                response.sendRedirect(
                        request.getContextPath() + "/cart"
                );

                return;
            }

            // Get all products
            List<Product> products =
                    productDAO.getAllProducts();

            // Product lookup map
            Map<Long, Product> productMap =
                    new HashMap<>();

            for (Product product : products) {

                productMap.put(
                        product.getProductId(),
                        product
                );
            }

            // Calculate total
            BigDecimal grandTotal =
                    BigDecimal.ZERO;

            // Send product details
            for (CartItem item : cartItems) {

                Product product =
                        productMap.get(
                                item.getProductId()
                        );

                request.setAttribute(
                        "product_" + item.getProductId(),
                        product
                );

                if (product != null &&
                        product.getPrice() != null) {

                    BigDecimal itemTotal =
                            product.getPrice().multiply(
                                    BigDecimal.valueOf(
                                            item.getQuantity()
                                    )
                            );

                    grandTotal =
                            grandTotal.add(itemTotal);
                }
            }

            // Send data to checkout.jsp
            request.setAttribute(
                    "cartItems",
                    cartItems
            );

            request.setAttribute(
                    "grandTotal",
                    grandTotal
            );

            // Open checkout page
            request.getRequestDispatcher(
                    "/checkout.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to load checkout.",
                    e
            );
        }
    }
}