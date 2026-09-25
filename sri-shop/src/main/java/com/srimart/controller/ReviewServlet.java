package com.srimart.controller;

import com.srimart.dao.ReviewDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/reviews")
public class ReviewServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ReviewDAO reviewDAO = new ReviewDAO();

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

            request.setAttribute(
                    "reviews",
                    reviewDAO.getReviewsByBuyer(buyerId)
            );

            request.getRequestDispatcher(
                    "/reviews.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to load reviews.",
                    e
            );
        }
    }

    @Override
    protected void doPost(
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

        String action =
                request.getParameter("action");

        try {

            if ("add".equals(action)) {

                long productId =
                        Long.parseLong(
                                request.getParameter("productId")
                        );

                int rating =
                        Integer.parseInt(
                                request.getParameter("rating")
                        );

                String comment =
                        request.getParameter("comment");

                if (rating < 1 || rating > 5) {
                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Rating must be between 1 and 5."
                    );
                    return;
                }

                if (reviewDAO.hasReviewed(
                        buyerId,
                        productId)) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "You have already reviewed this product."
                    );
                    return;
                }

                reviewDAO.addReview(
                        buyerId,
                        productId,
                        rating,
                        comment
                );
            }

            else if ("delete".equals(action)) {

                long reviewId =
                        Long.parseLong(
                                request.getParameter("reviewId")
                        );

                reviewDAO.deleteReview(
                        buyerId,
                        reviewId
                );
            }

            else {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid review action."
                );
                return;
            }

            response.sendRedirect(
                    request.getContextPath() + "/reviews"
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid review data."
            );

        } catch (Exception e) {

            throw new ServletException(
                    "Review operation failed.",
                    e
            );
        }
    }
}