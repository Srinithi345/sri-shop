<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.srimart.model.CartItem" %>
<%@ page import="com.srimart.model.Product" %>

<%
    List<CartItem> cartItems =
            (List<CartItem>) request.getAttribute("cartItems");
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>My Cart - SRI SHOP</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f1f3f6;
            color: #212121;
        }

        .header {
            background: #0f766e;
            color: white;
            padding: 18px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            margin: 0;
        }

        .back-btn {
            background: white;
            color: #0f766e;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 8px;
            font-weight: bold;
        }

        .container {
            max-width: 1150px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .cart-title {
            font-size: 28px;
            margin-bottom: 20px;
        }

        .cart-layout {
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 20px;
        }

        .cart-items {
            background: white;
            border-radius: 8px;
            overflow: hidden;
        }

        .cart-item {
            padding: 25px;
            border-bottom: 1px solid #eeeeee;
        }

        .item-content {
            display: grid;
            grid-template-columns: 150px 1fr;
            gap: 25px;
        }

        .product-image {
            width: 150px;
            height: 180px;
            background: #f5f5f5;
            border-radius: 8px;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-name {
            font-size: 21px;
            font-weight: bold;
            margin-bottom: 12px;
            color: #0f766e;
        }

        .item-info {
            color: #555;
            line-height: 1.8;
        }

        .quantity-form {
            margin-top: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .quantity-input {
            width: 65px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            text-align: center;
        }

        .update-btn {
            padding: 8px 15px;
            border: none;
            background: #0f766e;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }

        .remove-form {
            margin-top: 12px;
        }

        .remove-btn {
            border: none;
            background: none;
            color: #d32f2f;
            cursor: pointer;
            font-weight: bold;
            padding: 0;
        }

        .summary {
            background: white;
            border-radius: 8px;
            padding: 25px;
            height: fit-content;
        }

        .summary h2 {
            margin-top: 0;
            border-bottom: 1px solid #ddd;
            padding-bottom: 18px;
            color: #555;
            font-size: 20px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin: 18px 0;
        }

        .total {
            border-top: 1px solid #ddd;
            padding-top: 18px;
            font-size: 21px;
            font-weight: bold;
        }

        .buy-btn {
            width: 100%;
            padding: 15px;
            background: #ff9f00;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 15px;
        }

        .clear-btn {
            width: 100%;
            padding: 12px;
            background: white;
            border: 1px solid #d32f2f;
            color: #d32f2f;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            margin-top: 10px;
        }

        .empty-cart {
            background: white;
            padding: 70px 20px;
            text-align: center;
            border-radius: 8px;
        }

        .empty-cart h2 {
            color: #555;
        }

        .shop-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 12px 25px;
            background: #0f766e;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        @media (max-width: 800px) {
            .cart-layout {
                grid-template-columns: 1fr;
            }

            .item-content {
                grid-template-columns: 100px 1fr;
            }

            .product-image {
                width: 100px;
                height: 130px;
            }
        }
    </style>

</head>

<body>

<div class="header">

    <h1>SRI SHOP</h1>

    <a class="back-btn"
       href="${pageContext.request.contextPath}/products">
        Continue Shopping
    </a>

</div>


<div class="container">

    <h1 class="cart-title">
        My Cart
    </h1>


<%
    if (cartItems == null || cartItems.isEmpty()) {
%>

    <div class="empty-cart">

        <h2>Your cart is empty</h2>

        <p>
            Add some beautiful dresses to your cart.
        </p>

        <a class="shop-btn"
           href="${pageContext.request.contextPath}/products">
            Shop Dresses
        </a>

    </div>

<%
    } else {
%>

    <div class="cart-layout">


        <!-- CART ITEMS -->

        <div class="cart-items">

<%
        BigDecimal grandTotal = BigDecimal.ZERO;

        for (CartItem item : cartItems) {

            Product product =
                    (Product) request.getAttribute(
                            "product_" + item.getProductId()
                    );

            BigDecimal price = BigDecimal.ZERO;

            String productName = "Product";
            String imageUrl = null;

            if (product != null) {

                price = product.getPrice();

                if (price == null) {
                    price = BigDecimal.ZERO;
                }

                productName = product.getName();
                imageUrl = product.getImageUrl();
            }

            BigDecimal itemTotal =
                    price.multiply(
                            BigDecimal.valueOf(item.getQuantity())
                    );

            grandTotal = grandTotal.add(itemTotal);
%>

            <div class="cart-item">

                <div class="item-content">


                    <!-- IMAGE -->

                    <div class="product-image">

<%
                    if (imageUrl != null &&
                        !imageUrl.isBlank()) {
%>

                        <img src="<%= imageUrl %>"
                             alt="<%= productName %>">

<%
                    } else {
%>

                        <span>No Image</span>

<%
                    }
%>

                    </div>


                    <!-- DETAILS -->

                    <div>

                        <div class="product-name">
                            <%= productName %>
                        </div>

                        <div class="item-info">

                            <div>
                                <strong>Size:</strong>
                                <%= item.getSize() != null
                                        ? item.getSize()
                                        : "Not selected" %>
                            </div>

                            <div>
                                <strong>Color:</strong>
                                <%= item.getColor() != null
                                        ? item.getColor()
                                        : "Not selected" %>
                            </div>

                            <div>
                                <strong>Price:</strong>
                                ₹<%= price %>
                            </div>

                            <div>
                                <strong>Total:</strong>
                                ₹<%= itemTotal %>
                            </div>

                        </div>


                        <!-- UPDATE QUANTITY -->

                        <form class="quantity-form"
                              method="post"
                              action="${pageContext.request.contextPath}/cart">

                            <input type="hidden"
                                   name="action"
                                   value="update">

                            <input type="hidden"
                                   name="productId"
                                   value="<%= item.getProductId() %>">

                            <label>
                                Quantity:
                            </label>

                            <input class="quantity-input"
                                   type="number"
                                   name="quantity"
                                   value="<%= item.getQuantity() %>"
                                   min="1">

                            <button class="update-btn"
                                    type="submit">
                                Update
                            </button>

                        </form>


                        <!-- REMOVE -->

                        <form class="remove-form"
                              method="post"
                              action="${pageContext.request.contextPath}/cart">

                            <input type="hidden"
                                   name="action"
                                   value="remove">

                            <input type="hidden"
                                   name="productId"
                                   value="<%= item.getProductId() %>">

                            <button class="remove-btn"
                                    type="submit">
                                Remove
                            </button>

                        </form>

                    </div>

                </div>

            </div>

<%
        }
%>

        </div>


        <!-- ORDER SUMMARY -->

        <div class="summary">

            <h2>
                PRICE DETAILS
            </h2>

            <div class="summary-row">

                <span>
                    Items
                </span>

                <span>
                    <%= cartItems.size() %>
                </span>

            </div>

            <div class="summary-row">

                <span>
                    Delivery
                </span>

                <span>
                    FREE
                </span>

            </div>

            <div class="summary-row total">

                <span>
                    Total Amount
                </span>

                <span>
                    ₹<%= grandTotal %>
                </span>

            </div>


            <!-- BUY -->

            <form method="get"
                  action="${pageContext.request.contextPath}/checkout">

                <button class="buy-btn"
                        type="submit">

                    Proceed to Buy

                </button>

            </form>


            <!-- CLEAR CART -->

            <form method="post"
                  action="${pageContext.request.contextPath}/cart">

                <input type="hidden"
                       name="action"
                       value="clear">

                <button class="clear-btn"
                        type="submit">

                    Clear Cart

                </button>

            </form>

        </div>

    </div>

<%
    }
%>

</div>

</body>
</html>