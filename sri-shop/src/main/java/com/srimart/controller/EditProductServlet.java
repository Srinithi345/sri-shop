package com.srimart.controller;

import com.srimart.dao.ProductDAO;
import com.srimart.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/edit-product")
public class EditProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        // Check seller role
        String userRole =
                String.valueOf(
                        session.getAttribute("userRole"));

        if (!"SELLER".equalsIgnoreCase(userRole)) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        // Get seller ID
        Object userIdObject =
                session.getAttribute("userId");

        long sellerId;

        try {

            if (userIdObject instanceof Number) {

                sellerId =
                        ((Number) userIdObject).longValue();

            } else {

                sellerId =
                        Long.parseLong(
                                String.valueOf(userIdObject));
            }

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        // Get product ID
        String productIdParameter =
                request.getParameter("id");

        if (productIdParameter == null ||
            productIdParameter.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/seller-dashboard");

            return;
        }

        try {

            long productId =
                    Long.parseLong(productIdParameter);

            Product product =
                    productDAO.getProductById(productId);

            // Product not found
            if (product == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found.");

                return;
            }

            // Security check:
            // Seller can edit only their own product
            if (product.getSellerId() != sellerId) {

                response.sendError(
                        HttpServletResponse.SC_FORBIDDEN,
                        "You are not allowed to edit this product.");

                return;
            }

            request.setAttribute(
                    "product",
                    product);

            request.getRequestDispatcher(
                    "/edit-product.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID.");

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                    "Unable to load product.",
                    e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        // Check seller role
        String userRole =
                String.valueOf(
                        session.getAttribute("userRole"));

        if (!"SELLER".equalsIgnoreCase(userRole)) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        // Get seller ID
        Object userIdObject =
                session.getAttribute("userId");

        long sellerId;

        try {

            if (userIdObject instanceof Number) {

                sellerId =
                        ((Number) userIdObject).longValue();

            } else {

                sellerId =
                        Long.parseLong(
                                String.valueOf(userIdObject));
            }

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        try {

            // Product ID
            long productId =
                    Long.parseLong(
                            request.getParameter("productId"));

            // Form values
            String name =
                    request.getParameter("name");

            String description =
                    request.getParameter("description");

            String category =
                    request.getParameter("category");

            String size =
                    request.getParameter("size");

            String color =
                    request.getParameter("color");

            String priceText =
                    request.getParameter("price");

            String stockText =
                    request.getParameter("stockQuantity");

            String imageUrl =
                    request.getParameter("imageUrl");

            // Validation
            if (name == null ||
                name.isBlank()) {

                request.setAttribute(
                        "error",
                        "Dress name is required.");

                reloadProduct(
                        request,
                        response,
                        productId);

                return;
            }

            if (category == null ||
                category.isBlank()) {

                request.setAttribute(
                        "error",
                        "Category is required.");

                reloadProduct(
                        request,
                        response,
                        productId);

                return;
            }

            if (size == null ||
                size.isBlank()) {

                request.setAttribute(
                        "error",
                        "Size is required.");

                reloadProduct(
                        request,
                        response,
                        productId);

                return;
            }

            if (color == null ||
                color.isBlank()) {

                request.setAttribute(
                        "error",
                        "Color is required.");

                reloadProduct(
                        request,
                        response,
                        productId);

                return;
            }

            if (priceText == null ||
                priceText.isBlank()) {

                request.setAttribute(
                        "error",
                        "Price is required.");

                reloadProduct(
                        request,
                        response,
                        productId);

                return;
            }

            if (stockText == null ||
                stockText.isBlank()) {

                request.setAttribute(
                        "error",
                        "Stock quantity is required.");

                reloadProduct(
                        request,
                        response,
                        productId);

                return;
            }

            BigDecimal price =
                    new BigDecimal(priceText);

            int stockQuantity =
                    Integer.parseInt(stockText);

            if (price.compareTo(BigDecimal.ZERO) <= 0) {

                request.setAttribute(
                        "error",
                        "Price must be greater than zero.");

                reloadProduct(
                        request,
                        response,
                        productId);

                return;
            }

            if (stockQuantity < 0) {

                request.setAttribute(
                        "error",
                        "Stock cannot be negative.");

                reloadProduct(
                        request,
                        response,
                        productId);

                return;
            }

            // Create updated product
            Product product =
                    new Product();

            product.setProductId(productId);
            product.setSellerId(sellerId);
            product.setName(name.trim());
            product.setDescription(
                    description == null
                            ? ""
                            : description.trim());
            product.setCategory(category.trim());
            product.setSize(size.trim());
            product.setColor(color.trim());
            product.setPrice(price);
            product.setStockQuantity(stockQuantity);
            product.setImageUrl(
                    imageUrl == null
                            ? ""
                            : imageUrl.trim());

            // Update database
            boolean updated =
                    productDAO.updateProduct(
                            product,
                            sellerId);

            if (updated) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/seller-dashboard");

            } else {

                request.setAttribute(
                        "error",
                        "Product update failed.");

                request.setAttribute(
                        "product",
                        product);

                request.getRequestDispatcher(
                        "/edit-product.jsp")
                        .forward(request, response);
            }

        } catch (NumberFormatException e) {

            request.setAttribute(
                    "error",
                    "Please enter valid price, stock and product ID.");

            try {

                long productId =
                        Long.parseLong(
                                request.getParameter("productId"));

                reloadProduct(
                        request,
                        response,
                        productId);

            } catch (Exception ex) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/seller-dashboard");
            }

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                    "Unable to update product.",
                    e);
        }
    }

    private void reloadProduct(
            HttpServletRequest request,
            HttpServletResponse response,
            long productId)
            throws ServletException, IOException {

        Product product =
                productDAO.getProductById(productId);

        request.setAttribute(
                "product",
                product);

        request.getRequestDispatcher(
                "/edit-product.jsp")
                .forward(request, response);
    }
}