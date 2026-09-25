package com.srimart.controller;

import com.srimart.dao.WishlistDAO;
import com.srimart.model.Wishlist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private WishlistDAO wishlistDAO;

    @Override
    public void init() throws ServletException {
        wishlistDAO = new WishlistDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        Object roleObject = session.getAttribute("userRole");

        if (roleObject == null ||
                !"BUYER".equalsIgnoreCase(roleObject.toString())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only buyers can access the wishlist."
            );
            return;
        }

        int buyerId = ((Long) session.getAttribute("userId")).intValue();

        List<Wishlist> wishlistItems =
                wishlistDAO.getWishlistByBuyer(buyerId);

        request.setAttribute("wishlistItems", wishlistItems);

        request.getRequestDispatcher("/wishlist.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        Object roleObject = session.getAttribute("userRole");

        if (roleObject == null ||
                !"BUYER".equalsIgnoreCase(roleObject.toString())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only buyers can modify the wishlist."
            );
            return;
        }

        int buyerId = ((Long) session.getAttribute("userId")).intValue();

        String action = request.getParameter("action");
        String productIdParameter = request.getParameter("productId");

        if (action == null || productIdParameter == null) {
            response.sendRedirect(
                    request.getContextPath() + "/wishlist"
            );
            return;
        }

        try {

            int productId = Integer.parseInt(productIdParameter);

            if ("add".equalsIgnoreCase(action)) {

                wishlistDAO.addToWishlist(buyerId, productId);

            } else if ("remove".equalsIgnoreCase(action)) {

                wishlistDAO.removeFromWishlist(buyerId, productId);
            }

            response.sendRedirect(
                    request.getContextPath() + "/wishlist"
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID."
            );
        }
    }
}