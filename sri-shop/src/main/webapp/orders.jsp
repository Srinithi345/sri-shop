<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders - Sri Shop</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
        }

        .header {
            background: #117c73;
            color: white;
            padding: 20px 30px;
            font-size: 28px;
            font-weight: bold;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 40px auto;
        }

        h1 {
            color: #222;
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

        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 11px 20px;
            background: #117c73;
            color: white;
            text-decoration: none;
            border-radius: 7px;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .empty {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 12px;
        }
    </style>
</head>

<body>

<div class="header">
    SRI SHOP
</div>

<div class="container">

    <h1>My Orders</h1>

    <%
        List<Map<String, Object>> orders =
                (List<Map<String, Object>>) request.getAttribute("orders");

        if (orders != null && !orders.isEmpty()) {

            for (Map<String, Object> order : orders) {
    %>

    <div class="order">

        <div class="order-row">
            <span class="label">Order ID:</span>
            #<%= order.get("orderId") %>
        </div>

        <div class="order-row">
            <span class="label">Total Amount:</span>
            ₹<%= order.get("totalAmount") %>
        </div>

        <div class="order-row">
            <span class="label">Status:</span>

            <span class="status">
                <%= order.get("status") %>
            </span>
        </div>

        <div class="order-row">
            <span class="label">Shipping Address:</span>
            <%= order.get("shippingAddress") %>
        </div>

        <div class="order-row">
            <span class="label">Order Date:</span>
            <%= order.get("createdAt") %>
        </div>

    </div>

    <%
            }

        } else {
    %>

    <div class="empty">
        <h3>No Orders Found</h3>
        <p>You have not placed any orders yet.</p>
    </div>

    <%
        }
    %>

    <a class="btn"
   href="${pageContext.request.contextPath}/buyer-dashboard">
    Back to Dashboard
</a>

</div>

</body>
</html>