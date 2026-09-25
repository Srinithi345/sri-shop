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

            // Get buyer cart
            List<CartItem> cartItems =
                    cartDAO.getCartItems(buyerId);

            // Get all products
            List<Product> products =
                    productDAO.getAllProducts();

            // Create product lookup map
            Map<Long, Product> productMap =
                    new HashMap<>();

            for (Product product : products) {

                productMap.put(
                        product.getProductId(),
                        product
                );
            }

            // Send product details to cart.jsp
            for (CartItem item : cartItems) {

                Product product =
                        productMap.get(
                                item.getProductId()
                        );

                request.setAttribute(
                        "product_" + item.getProductId(),
                        product
                );
            }

            request.setAttribute(
                    "cartItems",
                    cartItems
            );

            request.getRequestDispatcher(
                    "/cart.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to load cart.",
                    e
            );
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        long buyerId =
                (Long) session.getAttribute("userId");

        String action =
                request.getParameter("action");

        try {

            // ==========================
            // ADD TO CART
            // ==========================

            if ("add".equals(action)) {

                long productId =
                        Long.parseLong(
                                request.getParameter(
                                        "productId"
                                )
                        );

                int quantity =
                        Integer.parseInt(
                                request.getParameter(
                                        "quantity"
                                )
                        );

                String size =
                        request.getParameter("size");

                String color =
                        request.getParameter("color");

                if (quantity < 1) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid quantity."
                    );

                    return;
                }

                if (size == null ||
                        size.isBlank()) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Please select a size."
                    );

                    return;
                }

                if (color == null ||
                        color.isBlank()) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Please select a color."
                    );

                    return;
                }

                CartItem cartItem =
                        new CartItem(
                                buyerId,
                                productId,
                                quantity,
                                size,
                                color
                        );

                cartDAO.addToCart(cartItem);

                response.sendRedirect(
                        request.getContextPath()
                                + "/cart"
                );

                return;
            }

            // ==========================
            // UPDATE QUANTITY
            // ==========================

            if ("update".equals(action)) {

                long productId =
                        Long.parseLong(
                                request.getParameter(
                                        "productId"
                                )
                        );

                int quantity =
                        Integer.parseInt(
                                request.getParameter(
                                        "quantity"
                                )
                        );

                if (quantity < 1) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid quantity."
                    );

                    return;
                }

                cartDAO.updateQuantity(
                        buyerId,
                        productId,
                        quantity
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/cart"
                );

                return;
            }

            // ==========================
            // REMOVE ITEM
            // ==========================

            if ("remove".equals(action)) {

                long productId =
                        Long.parseLong(
                                request.getParameter(
                                        "productId"
                                )
                        );

                cartDAO.removeFromCart(
                        buyerId,
                        productId
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/cart"
                );

                return;
            }

            // ==========================
            // CLEAR CART
            // ==========================

            if ("clear".equals(action)) {

                cartDAO.clearCart(buyerId);

                response.sendRedirect(
                        request.getContextPath()
                                + "/cart"
                );

                return;
            }

            // ==========================
            // INVALID ACTION
            // ==========================

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid cart action."
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product or quantity."
            );

        } catch (Exception e) {

            throw new ServletException(
                    "Cart operation failed.",
                    e
            );
        }
    }
}