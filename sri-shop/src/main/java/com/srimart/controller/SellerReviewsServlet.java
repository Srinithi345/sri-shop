package com.srimart.controller;

import com.srimart.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/seller-reviews")
public class SellerReviewsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
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

        String role =
                String.valueOf(
                        session.getAttribute("userRole")
                );

        if (!"SELLER".equalsIgnoreCase(role)) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        long sellerId;

        try {

            Object userIdObject =
                    session.getAttribute("userId");

            if (userIdObject instanceof Number) {

                sellerId =
                        ((Number) userIdObject).longValue();

            } else {

                sellerId =
                        Long.parseLong(
                                String.valueOf(userIdObject)
                        );
            }

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        List<Map<String, Object>> reviews =
                new ArrayList<>();

        String sql = """
                SELECT
                    r.review_id,
                    r.rating,
                    r.comment,
                    r.created_at,
                    p.product_id,
                    p.name AS product_name,
                    u.name AS buyer_name,
                    u.email AS buyer_email
                FROM reviews r
                JOIN products p
                    ON r.product_id = p.product_id
                JOIN users u
                    ON r.buyer_id = u.user_id
                WHERE p.seller_id = ?
                ORDER BY r.created_at DESC
                """;

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, sellerId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Map<String, Object> review =
                            new HashMap<>();

                    review.put(
                            "reviewId",
                            resultSet.getLong("review_id")
                    );

                    review.put(
                            "rating",
                            resultSet.getInt("rating")
                    );

                    review.put(
                            "comment",
                            resultSet.getString("comment")
                    );

                    review.put(
                            "createdAt",
                            resultSet.getTimestamp("created_at")
                    );

                    review.put(
                            "productId",
                            resultSet.getLong("product_id")
                    );

                    review.put(
                            "productName",
                            resultSet.getString("product_name")
                    );

                    review.put(
                            "buyerName",
                            resultSet.getString("buyer_name")
                    );

                    review.put(
                            "buyerEmail",
                            resultSet.getString("buyer_email")
                    );

                    reviews.add(review);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                    "Unable to load seller reviews.",
                    e
            );
        }

        request.setAttribute(
                "sellerReviews",
                reviews
        );

        request.getRequestDispatcher(
                "/seller-reviews.jsp"
        ).forward(request, response);
    }
}