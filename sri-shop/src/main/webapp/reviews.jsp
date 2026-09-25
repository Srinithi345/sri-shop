<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>My Reviews - Sri Shop</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f0fdfa;
            color: #134e4a;
        }

        .header {
            background: #0f766e;
            color: white;
            padding: 20px 40px;
            font-size: 28px;
            font-weight: bold;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
        }

        h1 {
            margin-bottom: 25px;
        }

        .review-card {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        .product {
            font-size: 20px;
            font-weight: bold;
            color: #0f766e;
        }

        .rating {
            margin: 12px 0;
            color: #f59e0b;
            font-size: 20px;
        }

        .comment {
            color: #555;
            margin: 10px 0;
            line-height: 1.5;
        }

        .date {
            color: #888;
            font-size: 14px;
        }

        .delete-btn {
            margin-top: 15px;
            padding: 9px 16px;
            border: none;
            border-radius: 7px;
            background: #dc2626;
            color: white;
            cursor: pointer;
            font-weight: bold;
        }

        .delete-btn:hover {
            background: #b91c1c;
        }

        .empty {
            background: white;
            padding: 40px;
            text-align: center;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 11px 20px;
            background: #0f766e;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

    </style>

</head>

<body>

<div class="header">
    SRI SHOP
</div>

<div class="container">

    <h1>⭐ My Reviews</h1>

    <%
        ResultSet reviews =
                (ResultSet) request.getAttribute("reviews");

        boolean hasReviews = false;

        if (reviews != null) {

            while (reviews.next()) {

                hasReviews = true;
    %>

    <div class="review-card">

        <div class="product">
            <%= reviews.getString("product_name") %>
        </div>

        <div class="rating">

            <%
                int rating = reviews.getInt("rating");

                for (int i = 1; i <= 5; i++) {
                    if (i <= rating) {
            %>
                        ★
            <%
                    } else {
            %>
                        ☆
            <%
                    }
                }
            %>

        </div>

        <div class="comment">
            <%= reviews.getString("comment") != null
                    ? reviews.getString("comment")
                    : "No comment" %>
        </div>

        <div class="date">
            <%= reviews.getTimestamp("created_at") %>
        </div>

        <form method="post"
              action="${pageContext.request.contextPath}/reviews">

            <input type="hidden"
                   name="action"
                   value="delete">

            <input type="hidden"
                   name="reviewId"
                   value="<%= reviews.getLong("review_id") %>">

            <button class="delete-btn"
                    type="submit">
                Delete Review
            </button>

        </form>

    </div>

    <%
            }
        }

        if (!hasReviews) {
    %>

    <div class="empty">

        <h2>No Reviews Yet</h2>

        <p>
            You have not reviewed any products yet.
        </p>

    </div>

    <%
        }
    %>

    <a class="back-btn"
       href="${pageContext.request.contextPath}/buyer-dashboard.jsp">
        Back to Dashboard
    </a>

</div>

</body>
</html>