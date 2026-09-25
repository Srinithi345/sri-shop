package com.srimart.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/review-form")
public class ReviewFormServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String productId = request.getParameter("productId");

        if (productId == null || productId.isBlank()) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Product ID is required"
            );
            return;
        }

        request.setAttribute("productId", productId);

        request.getRequestDispatcher("/review-form.jsp")
                .forward(request, response);
    }
}