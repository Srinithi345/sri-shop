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

@WebServlet("/products")
public class ProductListServlet extends HttpServlet {

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

        try {

            String searchTerm = request.getParameter("search");

            List<Product> products;

            if (searchTerm != null
                    && !searchTerm.trim().isEmpty()) {

                products = productDAO.searchProducts(searchTerm);

                request.setAttribute(
                        "searchTerm",
                        searchTerm.trim()
                );

            } else {

                products = productDAO.getAllProducts();

                request.setAttribute(
                        "searchTerm",
                        ""
                );
            }

            request.setAttribute(
                    "products",
                    products
            );

            request.getRequestDispatcher(
                    "/Listing.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "errorMessage",
                    "Unable to load products. Please try again."
            );

            request.setAttribute(
                    "searchTerm",
                    ""
            );

            request.getRequestDispatcher(
                    "/Listing.jsp"
            ).forward(request, response);
        }
    }
}