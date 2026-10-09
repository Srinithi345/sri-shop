<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Seller Reviews - SRI SHOP</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f0fdfa;
            color: #134e4a;
        }

        .header {
            background: #0f766e;
            color: white;
            padding: 20px 35px;
            font-size: 27px;
            font-weight: bold;
            box-shadow: 0 5px 20px rgba(0,0,0,0.12);
        }

        .container {
            width: 92%;
            max-width: 1100px;
            margin: 35px auto;
        }

        .title-section {
            margin-bottom: 25px;
        }

        .title-section h1 {
            margin: 0 0 8px;
            color: #134e4a;
        }

        .title-section p {
            margin: 0;
            color: #64748b;
        }

        .review-card {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 16px;

            box-shadow:
                0 8px 25px
                rgba(0,0,0,0.07);
        }

        .review-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
            flex-wrap: wrap;
        }

        .product-name {
            font-size: 20px;
            font-weight: bold;
            color: #0f766e;
        }

        .rating {
            margin-top: 8px;
            font-size: 20px;
            letter-spacing: 2px;
        }

        .buyer {
            margin-top: 18px;
            padding: 14px;
            background: #f0fdfa;
            border-radius: 10px;
        }

        .buyer-name {
            font-weight: bold;
            color: #134e4a;
        }

        .buyer-email {
            margin-top: 5px;
            color: #64748b;
            font-size: 14px;
        }

        .comment {
            margin-top: 18px;
            padding: 18px;
            background: #f8fafc;
            border-left: 4px solid #0f766e;
            border-radius: 8px;

            color: #334155;
            line-height: 1.6;
        }

        .date {
            margin-top: 15px;
            color: #64748b;
            font-size: 13px;
        }

        .empty {
            background: white;
            padding: 55px 25px;
            text-align: center;
            border-radius: 16px;

            box-shadow:
                0 8px 25px
                rgba(0,0,0,0.06);
        }

        .empty-icon {
            font-size: 55px;
            margin-bottom: 15px;
        }

        .empty h3 {
            margin: 0 0 8px;
            color: #134e4a;
        }

        .empty p {
            color: #64748b;
        }

        .back-btn {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 22px;
            background: #0f766e;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        .back-btn:hover {
            background: #115e59;
        }

        @media (max-width: 600px) {

            .header {
                padding: 17px 20px;
                font-size: 23px;
            }

            .container {
                width: 90%;
                margin: 25px auto;
            }

            .review-card {
                padding: 18px;
            }

            .product-name {
                font-size: 18px;
            }

        }

    </style>

</head>

<body>

<div class="header">
    ⭐ SRI SHOP — Customer Reviews
</div>

<div class="container">

    <div class="title-section">

        <h1>
            Customer Reviews
        </h1>

        <p>
            See what customers think about your products.
        </p>

    </div>

    <%
        List<Map<String, Object>> reviews =
                (List<Map<String, Object>>)
                        request.getAttribute("sellerReviews");

        if (reviews != null && !reviews.isEmpty()) {

            for (Map<String, Object> review : reviews) {

                int rating =
                        ((Number) review.get("rating")).intValue();
    %>

    <div class="review-card">

        <div class="review-top">

            <div>

                <div class="product-name">
                    👗 <%= review.get("productName") %>
                </div>

                <div class="rating">

                    <%
                        for (int i = 1; i <= 5; i++) {

                            if (i <= rating) {
                    %>

                                ⭐

                    <%
                            } else {
                    %>

                                ☆

                    <%
                            }
                        }
                    %>

                </div>

            </div>

        </div>


        <div class="buyer">

            <div class="buyer-name">

                👤
                <%= review.get("buyerName") %>

            </div>

            <div class="buyer-email">

                📧
                <%= review.get("buyerEmail") %>

            </div>

        </div>


        <div class="comment">

            <strong>
                Customer Feedback:
            </strong>

            <br><br>

            <%
                Object comment =
                        review.get("comment");

                if (comment != null &&
                    !comment.toString().trim().isEmpty()) {
            %>

                <%= comment %>

            <%
                } else {
            %>

                No written comment provided.

            <%
                }
            %>

        </div>


        <div class="date">

            📅
            <%= review.get("createdAt") %>

        </div>

    </div>

    <%
            }

        } else {
    %>

    <div class="empty">

        <div class="empty-icon">
            ⭐
        </div>

        <h3>
            No Reviews Yet
        </h3>

        <p>
            Customers have not reviewed your products yet.
        </p>

    </div>

    <%
        }
    %>


    <a class="back-btn"
       href="${pageContext.request.contextPath}/seller-dashboard">

        ← Back to Seller Dashboard

    </a>

</div>

</body>

</html>