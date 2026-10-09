<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    String contextPath = request.getContextPath();

    List<Map<String, Object>> orders =
            (List<Map<String, Object>>) request.getAttribute("sellerOrders");

    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Seller Orders - SRI SHOP</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f5f7fb;
            color: #222;
        }

        .header {
            background: #117c73;
            color: white;
            padding: 20px 30px;
            font-size: 28px;
            font-weight: bold;
        }

        .container {
            width: 92%;
            max-width: 1200px;
            margin: 35px auto;
        }

        h1 {
            margin-bottom: 25px;
        }

        .message {
            padding: 13px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .success {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .order {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-bottom: 18px;
            flex-wrap: wrap;
        }

        .order-id {
            font-size: 20px;
            font-weight: bold;
            color: #117c73;
        }

        .status {
            display: inline-block;
            padding: 7px 13px;
            border-radius: 20px;
            background: #fff3cd;
            color: #856404;
            font-weight: bold;
        }

        .order-row {
            margin: 12px 0;
            line-height: 1.5;
        }

        .label {
            font-weight: bold;
            display: inline-block;
            min-width: 150px;
        }

        .amount {
            font-size: 19px;
            font-weight: bold;
            color: #117c73;
        }

        .products {
            background: #f7faf9;
            padding: 12px 15px;
            border-radius: 8px;
            margin-top: 8px;
        }

        .status-section {
            margin-top: 22px;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
        }

        .status-form {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .status-form label {
            font-weight: bold;
            color: #374151;
        }

        .status-select {
            padding: 10px 12px;
            border: 1px solid #d1d5db;
            border-radius: 7px;
            background: white;
            font-size: 14px;
            min-width: 160px;
        }

        .update-btn {
            border: none;
            padding: 10px 18px;
            background: #117c73;
            color: white;
            border-radius: 7px;
            font-weight: bold;
            cursor: pointer;
        }

        .update-btn:hover {
            background: #0f665f;
        }

        .btn {
            display: inline-block;
            margin-top: 15px;
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
            padding: 50px;
            background: white;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
        }

        .empty h3 {
            margin-bottom: 8px;
        }

        @media (max-width: 600px) {

            .container {
                width: 90%;
            }

            .header {
                padding: 18px 20px;
                font-size: 24px;
            }

            .order {
                padding: 18px;
            }

            .label {
                display: block;
                margin-bottom: 4px;
            }

            .status-form {
                align-items: stretch;
                flex-direction: column;
            }

            .status-select,
            .update-btn {
                width: 100%;
            }
        }

    </style>

</head>

<body>

<div class="header">
    SRI SHOP — Seller Orders
</div>

<div class="container">

    <h1>Customer Orders</h1>

    <%
        if ("Status updated".equals(success)) {
    %>

        <div class="message success">
            Order status updated successfully.
        </div>

    <%
        }

        if (error != null && !error.isBlank()) {
    %>

        <div class="message error">
            Unable to update order status.
        </div>

    <%
        }

        if (orders != null && !orders.isEmpty()) {

            for (Map<String, Object> order : orders) {

                String currentStatus =
                        String.valueOf(order.get("status"));
    %>

    <div class="order">

        <div class="order-header">

            <div class="order-id">
                Order #<%= order.get("orderId") %>
            </div>

            <span class="status">
                <%= currentStatus %>
            </span>

        </div>

        <div class="order-row">

            <span class="label">
                Customer:
            </span>

            <%= order.get("buyerName") %>

        </div>

        <div class="order-row">

            <span class="label">
                Customer Email:
            </span>

            <%= order.get("buyerEmail") %>

        </div>

        <div class="order-row">

            <span class="label">
                Products:
            </span>

            <div class="products">
                <%= order.get("productSummary") %>
            </div>

        </div>

        <div class="order-row">

            <span class="label">
                Order Amount:
            </span>

            <span class="amount">
                &#8377;<%= order.get("sellerAmount") %>
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

        <div class="status-section">

            <form
                class="status-form"
                action="<%= contextPath %>/seller-orders"
                method="post"
            >

                <input
                    type="hidden"
                    name="action"
                    value="updateStatus"
                >

                <input
                    type="hidden"
                    name="orderId"
                    value="<%= order.get("orderId") %>"
                >

                <label for="status-<%= order.get("orderId") %>">
                    Update Status:
                </label>

                <select
                    id="status-<%= order.get("orderId") %>"
                    name="status"
                    class="status-select"
                    required
                >

                    <option
                        value="PENDING"
                        <%= "PENDING".equalsIgnoreCase(currentStatus) ? "selected" : "" %>
                    >
                        PENDING
                    </option>

                    <option
                        value="CONFIRMED"
                        <%= "CONFIRMED".equalsIgnoreCase(currentStatus) ? "selected" : "" %>
                    >
                        CONFIRMED
                    </option>

                    <option
                        value="SHIPPED"
                        <%= "SHIPPED".equalsIgnoreCase(currentStatus) ? "selected" : "" %>
                    >
                        SHIPPED
                    </option>

                    <option
                        value="DELIVERED"
                        <%= "DELIVERED".equalsIgnoreCase(currentStatus) ? "selected" : "" %>
                    >
                        DELIVERED
                    </option>

                    <option
                        value="CANCELLED"
                        <%= "CANCELLED".equalsIgnoreCase(currentStatus) ? "selected" : "" %>
                    >
                        CANCELLED
                    </option>

                </select>

                <button
                    type="submit"
                    class="update-btn"
                >
                    Update Status
                </button>

            </form>

        </div>

    </div>

    <%
            }

        } else {
    %>

    <div class="empty">

        <h3>No Customer Orders Found</h3>

        <p>
            No orders have been placed for your products yet.
        </p>

    </div>

    <%
        }
    %>

    <a
        class="btn"
        href="<%= contextPath %>/seller-dashboard"
    >
        &#8592; Back to Seller Dashboard
    </a>

</div>

</body>

</html>