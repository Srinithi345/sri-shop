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
import java.util.List;

@WebServlet("/try-on")
public class TryOnServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request,
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

        String productIdValue = request.getParameter("id");

        if (productIdValue == null || productIdValue.isBlank()) {
            response.sendRedirect(
                    request.getContextPath() + "/products"
            );
            return;
        }

        try {

            Long productId = Long.parseLong(productIdValue);

            List<Product> products = productDAO.getAllProducts();

            Product selectedProduct = null;

            for (Product product : products) {

                if (product.getProductId().equals(productId)) {
                    selectedProduct = product;
                    break;
                }
            }

            if (selectedProduct == null) {
                response.sendRedirect(
                        request.getContextPath() + "/products"
                );
                return;
            }

            request.setAttribute("product", selectedProduct);

            request.getRequestDispatcher("/try-on.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath() + "/products"
            );
        }
    }
}