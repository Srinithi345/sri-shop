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
import java.util.List;

@WebServlet("/seller-inventory")
public class SellerInventoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO =
            new ProductDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp"
            );

            return;
        }

        String role =
                String.valueOf(
                        session.getAttribute("userRole")
                );

        if (!"SELLER".equalsIgnoreCase(role)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp"
            );

            return;
        }

        long sellerId;

        try {

            Object userIdObject =
                    session.getAttribute("userId");

            if (userIdObject instanceof Number) {

                sellerId =
                        ((Number) userIdObject)
                                .longValue();

            } else {

                sellerId =
                        Long.parseLong(
                                String.valueOf(
                                        userIdObject
                                )
                        );
            }

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp"
            );

            return;
        }

        try {

            List<Product> products =
                    productDAO.getProductsBySeller(
                            sellerId
                    );

            request.setAttribute(
                    "inventoryProducts",
                    products
            );

            request.getRequestDispatcher(
                    "/seller-inventory.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                    "Unable to load seller inventory.",
                    e
            );
        }
    }
}