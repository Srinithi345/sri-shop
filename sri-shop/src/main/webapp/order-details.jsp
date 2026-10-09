<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Order Details - SRI SHOP</title>

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
            width: 92%;
            max-width: 1050px;
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

        .order-summary {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 25px;
        }

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        .summary-item {
            padding: 15px;
            background: #f8fafc;
            border-radius: 8px;
        }

        .label {
            display: block;
            font-size: 13px;
            color: #64748b;
            margin-bottom: 6px;
            font-weight: bold;
        }

        .value {
            font-size: 16px;
            font-weight: bold;
            color: #1e293b;
        }

        .amount {
            color: #117c73;
            font-size: 20px;
        }

        .status {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 6px;
            background: #fff3cd;
            color: #856404;
            font-weight: bold;
        }

        .section-title {
            margin: 0 0 15px;
            font-size: 22px;
        }

        .items-section {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .item {
            display: flex;
            gap: 20px;
            padding: 20px 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .item:last-child {
            border-bottom: none;
        }

        .product-image {
            width: 110px;
            height: 130px;
            object-fit: contain;
            border-radius: 8px;
            background: #f8fafc;
        }

        .item-info {
            flex: 1;
        }

        .product-name {
            margin: 0 0 10px;
            font-size: 18px;
            color: #111827;
        }

        .item-row {
            margin: 6px 0;
            color: #475569;
        }

        .item-total {
            font-weight: bold;
            color: #117c73;
            font-size: 17px;
        }

        .empty {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 12px;
        }

        .bottom-actions {
            margin-top: 25px;
        }

        .btn {
            display: inline-block;
            padding: 11px 20px;
            background: #117c73;
            color: white;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        .btn:hover {
            background: #0f6b63;
        }

        @media (max-width: 650px) {

            .header {
                padding: 16px 20px;
                font-size: 23px;
            }

            .container {
                width: 94%;
                margin: 25px auto;
            }

            .summary-grid {
                grid-template-columns: 1fr;
            }

            .item {
                gap: 12px;
            }

            .product-image {
                width: 85px;
                height: 105px;
            }

            .product-name {
                font-size: 16px;
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
            Order Details
        </h1>

        <a
            class="back-btn"
            href="${pageContext.request.contextPath}/orders"
        >
            &#8592; My Orders
        </a>

    </div>


    <div class="order-summary">

        <h2 class="section-title">
            Order #<%= request.getAttribute("orderId") %>
        </h2>

        <div class="summary-grid">


            <div class="summary-item">

                <span class="label">
                    Order Date
                </span>

                <span class="value">
                    <%= request.getAttribute("createdAt") %>
                </span>

            </div>


            <div class="summary-item">

                <span class="label">
                    Status
                </span>

                <span class="status">
                    <%= request.getAttribute("status") %>
                </span>

            </div>


            <div class="summary-item">

                <span class="label">
                    Total Amount
                </span>

                <span class="value amount">
                    &#8377;<%= request.getAttribute("totalAmount") %>
                </span>

            </div>


            <div class="summary-item">

                <span class="label">
                    Shipping Address
                </span>

                <span class="value">
                    <%= request.getAttribute("shippingAddress") %>
                </span>

            </div>


        </div>

    </div>


    <div class="items-section">

        <h2 class="section-title">
            Ordered Products
        </h2>


        <%

            List<Map<String, Object>> items =
                    (List<Map<String, Object>>)
                            request.getAttribute("items");

            if (items != null && !items.isEmpty()) {

                for (Map<String, Object> item : items) {

                    String imageUrl =
                            String.valueOf(item.get("imageUrl"));

                    String productName =
                            String.valueOf(item.get("productName"));

        %>


        <div class="item">


            <img
                class="product-image"
                src="<%= imageUrl %>?v=<%= item.get("productId") %>"
                alt="<%= productName %>"
                onerror="this.src='${pageContext.request.contextPath}/images/no-image.png';"
            >


            <div class="item-info">


                <h3 class="product-name">
                    <%= productName %>
                </h3>


                <div class="item-row">

                    <strong>Quantity:</strong>
                    <%= item.get("quantity") %>

                </div>


                <div class="item-row">

                    <strong>Unit Price:</strong>
                    &#8377;<%= item.get("unitPrice") %>

                </div>


                <div class="item-row item-total">

                    Item Total:
                    &#8377;<%= item.get("itemTotal") %>

                </div>


            </div>


        </div>


        <%

                }

            } else {

        %>


        <div class="empty">

            <h3>
                No Products Found
            </h3>

        </div>


        <%

            }

        %>


    </div>


    <div class="bottom-actions">

        <a
            class="btn"
            href="${pageContext.request.contextPath}/products"
        >
            &#128087; Continue Shopping
        </a>

    </div>


</div>


</body>

</html>