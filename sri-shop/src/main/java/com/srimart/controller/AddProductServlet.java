package com.srimart.controller;

import com.srimart.model.Product;
import com.srimart.dao.ProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/add-product")
public class AddProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check seller login
        if (session == null
                || session.getAttribute("userId") == null
                || !"SELLER".equalsIgnoreCase(
                        String.valueOf(session.getAttribute("userRole")))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        try {
            Long sellerId = Long.valueOf(
                    session.getAttribute("userId").toString()
            );

            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String size = request.getParameter("size");
            String color = request.getParameter("color");
            String priceValue = request.getParameter("price");
            String stockValue = request.getParameter("stock");
            String imageUrl = request.getParameter("imageUrl");

            // Basic validation
            if (name == null || name.isBlank()
                    || category == null || category.isBlank()
                    || size == null || size.isBlank()
                    || color == null || color.isBlank()
                    || priceValue == null || priceValue.isBlank()
                    || stockValue == null || stockValue.isBlank()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/add-product.jsp?error=required"
                );
                return;
            }

            BigDecimal price = new BigDecimal(priceValue);
            int stock = Integer.parseInt(stockValue);

            if (price.compareTo(BigDecimal.ZERO) < 0 || stock < 0) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/add-product.jsp?error=invalid"
                );
                return;
            }

            Product product = new Product();

            product.setSellerId(sellerId);
            product.setName(name.trim());
            product.setDescription(
                    description == null ? "" : description.trim()
            );
            product.setCategory(category.trim());
            product.setSize(size.trim());
            product.setColor(color.trim());
            product.setPrice(price);
            product.setStockQuantity(stock);
            product.setImageUrl(
                    imageUrl == null || imageUrl.isBlank()
                            ? null
                            : imageUrl.trim()
            );

            boolean success = productDAO.addProduct(product);

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/add-product.jsp?success=true"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/add-product.jsp?error=failed"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/add-product.jsp?error=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/add-product.jsp?error=server"
            );
        }
    }
}