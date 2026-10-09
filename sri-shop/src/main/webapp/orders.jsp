<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Orders - SRI SHOP</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #1f2937;
        }

        .header {
            background: #117c73;
            color: white;
            padding: 18px 30px;
            font-size: 26px;
            font-weight: bold;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 35px auto;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
            margin-bottom: 25px;
        }

        h1 {
            margin: 0;
            color: #222;
        }

        .back-btn {
            display: inline-block;
            padding: 10px 16px;
            background: #e2e8f0;
            color: #334155;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        .back-btn:hover {
            background: #cbd5e1;
        }

        .order {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .order-row {
            margin: 12px 0;
            line-height: 1.5;
        }

        .label {
            font-weight: bold;
        }

        .status {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 6px;
            background: #fff3cd;
            color: #856404;
            font-weight: bold;
        }

        .amount {
            color: #117c73;
            font-weight: bold;
        }

        .details-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 11px 18px;
            background: #117c73;
            color: white;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        .details-btn:hover {
            background: #0f6b63;
        }

        .empty {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
        }

        .empty h3 {
            margin-top: 0;
        }

        .shop-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 11px 20px;
            background: #117c73;
            color: white;
            text-decoration: none;
            border-radius: 7px;
        }

        @media (max-width: 600px) {

            .header {
                padding: 16px 20px;
                font-size: 23px;
            }

            .container {
                width: 94%;
                margin: 25px auto;
            }

            .order {
                padding: 20px;
            }

        }

    </style>

</head>

<body>


<div class="header">

    &#128722; SRI SHOP

</div>


<div class="container">


    <div class="top-bar">

        <h1>
            My Orders
        </h1>

        <a
            class="back-btn"
            href="${pageContext.request.contextPath}/buyer-dashboard.jsp"
        >
            &#8592; Dashboard
        </a>

    </div>


    <%

        List<Map<String, Object>> orders =
                (List<Map<String, Object>>) request.getAttribute("orders");

        if (orders != null && !orders.isEmpty()) {

            for (Map<String, Object> order : orders) {

    %>


    <div class="order">


        <div class="order-row">

            <span class="label">
                Order ID:
            </span>

            #<%= order.get("orderId") %>

        </div>


        <div class="order-row">

            <span class="label">
                Total Amount:
            </span>

            <span class="amount">

                &#8377;<%= order.get("totalAmount") %>

            </span>

        </div>


        <div class="order-row">

            <span class="label">
                Status:
            </span>

            <span class="status">

                <%= order.get("status") %>

            </span>

        </div>


        <div class="order-row">

            <span class="label">
                Shipping Address:
            </span>

            <%= order.get("shippingAddress") %>

        </div>


        <div class="order-row">

            <span class="label">
                Order Date:
            </span>

            <%= order.get("createdAt") %>

        </div>


        <!-- ORDER DETAILS -->

        <a
            class="details-btn"
            href="${pageContext.request.contextPath}/order-details?id=<%= order.get("orderId") %>"
        >

            &#128196; View Order Details

        </a>


    </div>


    <%

            }

        } else {

    %>


    <div class="empty">

        <h3>
            No Orders Found
        </h3>

        <p>
            You have not placed any orders yet.
        </p>

        <a
            class="shop-btn"
            href="${pageContext.request.contextPath}/products"
        >
            &#128087; Start Shopping
        </a>

    </div>


    <%

        }

    %>


</div>


</body>

</html>