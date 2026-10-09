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

        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        long buyerId;

        try {

            buyerId = Long.parseLong(
                    String.valueOf(
                            session.getAttribute("userId")
                    )
            );

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

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

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        long buyerId;

        try {

            buyerId = Long.parseLong(
                    String.valueOf(
                            session.getAttribute("userId")
                    )
            );

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String action =
                request.getParameter("action");

        try {

            if ("add".equals(action)) {

                String productIdValue =
                        request.getParameter("productId");

                String ratingValue =
                        request.getParameter("rating");

                String comment =
                        request.getParameter("comment");

                if (productIdValue == null
                        || productIdValue.trim().isEmpty()) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Product ID is required."
                    );
                    return;
                }

                if (ratingValue == null
                        || ratingValue.trim().isEmpty()) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Rating is required."
                    );
                    return;
                }

                long productId =
                        Long.parseLong(
                                productIdValue.trim()
                        );

                int rating =
                        Integer.parseInt(
                                ratingValue.trim()
                        );

                if (rating < 1 || rating > 5) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Rating must be between 1 and 5."
                    );
                    return;
                }

                if (comment == null
                        || comment.trim().isEmpty()) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Review comment cannot be empty."
                    );
                    return;
                }

                comment = comment.trim();

                if (comment.length() > 1000) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Review comment is too long."
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

                String reviewIdValue =
                        request.getParameter("reviewId");

                if (reviewIdValue == null
                        || reviewIdValue.trim().isEmpty()) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Review ID is required."
                    );
                    return;
                }

                long reviewId =
                        Long.parseLong(
                                reviewIdValue.trim()
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