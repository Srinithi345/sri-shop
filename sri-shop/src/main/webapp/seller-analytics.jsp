<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.math.BigDecimal" %>

<%
    Map<String, Object> analytics =
            (Map<String, Object>) request.getAttribute("analytics");

    if (analytics == null) {
        response.sendRedirect(
                request.getContextPath() + "/seller-dashboard"
        );
        return;
    }

    int totalProducts =
            analytics.get("totalProducts") != null
                    ? ((Number) analytics.get("totalProducts")).intValue()
                    : 0;

    int totalOrders =
            analytics.get("totalOrders") != null
                    ? ((Number) analytics.get("totalOrders")).intValue()
                    : 0;

    BigDecimal totalSales =
            analytics.get("totalSales") != null
                    ? (BigDecimal) analytics.get("totalSales")
                    : BigDecimal.ZERO;

    int totalItemsSold =
            analytics.get("totalItemsSold") != null
                    ? ((Number) analytics.get("totalItemsSold")).intValue()
                    : 0;

    int lowStock =
            analytics.get("lowStock") != null
                    ? ((Number) analytics.get("lowStock")).intValue()
                    : 0;

    String bestProduct =
            analytics.get("bestProduct") != null
                    ? String.valueOf(analytics.get("bestProduct"))
                    : "No sales yet";

    int bestProductUnits =
            analytics.get("bestProductUnits") != null
                    ? ((Number) analytics.get("bestProductUnits")).intValue()
                    : 0;
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Smart Analytics - SRI SHOP</title>

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
            max-width: 1150px;
            margin: 35px auto;
        }

        .title-section {
            margin-bottom: 30px;
        }

        .title-section h1 {
            margin: 0 0 8px;
            color: #134e4a;
        }

        .title-section p {
            margin: 0;
            color: #64748b;
        }

        .analytics-grid {
            display: grid;
            grid-template-columns:
                repeat(3, 1fr);
            gap: 20px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 16px;
            box-shadow:
                0 8px 25px
                rgba(0,0,0,0.07);
        }

        .card-icon {
            font-size: 32px;
            margin-bottom: 15px;
        }

        .card-title {
            font-size: 14px;
            color: #64748b;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .card-value {
            margin-top: 8px;
            font-size: 30px;
            font-weight: bold;
            color: #0f766e;
        }

        .best-product {
            grid-column: span 2;
        }

        .best-product-name {
            margin-top: 10px;
            font-size: 23px;
            font-weight: bold;
            color: #134e4a;
        }

        .best-product-sales {
            margin-top: 8px;
            color: #64748b;
        }

        .warning {
            border-left: 5px solid #f59e0b;
        }

        .warning .card-value {
            color: #d97706;
        }

        .sales-card {
            border-left: 5px solid #0f766e;
        }

        .summary {
            margin-top: 25px;
            background: white;
            padding: 25px;
            border-radius: 16px;
            box-shadow:
                0 8px 25px
                rgba(0,0,0,0.07);
        }

        .summary h2 {
            margin-top: 0;
            color: #134e4a;
        }

        .summary p {
            color: #64748b;
            line-height: 1.7;
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

        @media (max-width: 800px) {

            .analytics-grid {
                grid-template-columns: 1fr 1fr;
            }

            .best-product {
                grid-column: span 2;
            }
        }

        @media (max-width: 550px) {

            .header {
                padding: 17px 20px;
                font-size: 23px;
            }

            .container {
                width: 90%;
                margin: 25px auto;
            }

            .analytics-grid {
                grid-template-columns: 1fr;
            }

            .best-product {
                grid-column: span 1;
            }

            .card-value {
                font-size: 26px;
            }
        }

    </style>

</head>

<body>

<div class="header">
    📊 SRI SHOP — Smart Analytics
</div>

<div class="container">

    <div class="title-section">

        <h1>
            Smart Analytics
        </h1>

        <p>
            Track your products, sales and business performance.
        </p>

    </div>

    <div class="analytics-grid">

        <div class="card sales-card">

            <div class="card-icon">
                💰
            </div>

            <div class="card-title">
                Total Sales
            </div>

            <div class="card-value">
                ₹<%= totalSales %>
            </div>

        </div>


        <div class="card">

            <div class="card-icon">
                📦
            </div>

            <div class="card-title">
                Total Orders
            </div>

            <div class="card-value">
                <%= totalOrders %>
            </div>

        </div>


        <div class="card">

            <div class="card-icon">
                👗
            </div>

            <div class="card-title">
                Total Products
            </div>

            <div class="card-value">
                <%= totalProducts %>
            </div>

        </div>


        <div class="card">

            <div class="card-icon">
                🛍️
            </div>

            <div class="card-title">
                Items Sold
            </div>

            <div class="card-value">
                <%= totalItemsSold %>
            </div>

        </div>


        <div class="card warning">

            <div class="card-icon">
                ⚠️
            </div>

            <div class="card-title">
                Low Stock Products
            </div>

            <div class="card-value">
                <%= lowStock %>
            </div>

        </div>


        <div class="card best-product">

            <div class="card-icon">
                🏆
            </div>

            <div class="card-title">
                Best Selling Product
            </div>

            <div class="best-product-name">
                <%= bestProduct %>
            </div>

            <div class="best-product-sales">
                <%= bestProductUnits %> items sold
            </div>

        </div>

    </div>


    <div class="summary">

        <h2>
            Business Overview
        </h2>

        <p>
            Your store currently has
            <strong><%= totalProducts %></strong>
            products and
            <strong><%= totalOrders %></strong>
            orders.
            A total of
            <strong><%= totalItemsSold %></strong>
            items have been sold.
        </p>

        <p>
            Your total recorded sales are
            <strong>₹<%= totalSales %></strong>.
            The best-selling product is
            <strong><%= bestProduct %></strong>
            with
            <strong><%= bestProductUnits %></strong>
            items sold.
        </p>

        <p>
            Products requiring stock attention:
            <strong><%= lowStock %></strong>.
        </p>

    </div>


    <a class="back-btn"
       href="${pageContext.request.contextPath}/seller-dashboard">

        ← Back to Seller Dashboard

    </a>

</div>

</body>

</html>