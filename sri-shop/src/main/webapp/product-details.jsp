<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.srimart.model.Product" %>

<%
    Product product = (Product) request.getAttribute("product");

    if (product == null) {
        response.sendRedirect(request.getContextPath() + "/products");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title><%= product.getName() %> - SRI SHOP</title>

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

        /* ================= HEADER ================= */

        .header {
            background: #0f766e;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            margin: 0;
        }

        .back {
            background: white;
            color: #0f766e;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
        }

        .back:hover {
            background: #f0fdfa;
        }

        /* ================= CONTAINER ================= */

        .container {
            max-width: 1100px;
            margin: 50px auto;
            padding: 20px;
        }

        .product-box {
            background: white;
            border-radius: 20px;
            padding: 35px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 45px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }

        /* ================= PRODUCT IMAGE ================= */

        .product-image {
            height: 500px;
            border-radius: 15px;
            background: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* ================= DETAILS ================= */

        .details h2 {
            font-size: 32px;
            margin-top: 0;
            color: #0f766e;
        }

        .description {
            color: #666;
            line-height: 1.7;
        }

        .info {
            margin-top: 20px;
        }

        .info p {
            margin: 12px 0;
            font-size: 16px;
        }

        .price {
            font-size: 30px;
            font-weight: bold;
            color: #0f766e;
            margin: 25px 0;
        }

        .stock {
            font-weight: bold;
        }

        /* ================= SIZE / COLOR ================= */

        .option-group {
            margin-top: 24px;
        }

        .option-title {
            display: block;
            font-weight: bold;
            margin-bottom: 12px;
            font-size: 16px;
        }

        .options {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .option input {
            display: none;
        }

        .option span {
            display: inline-block;
            padding: 10px 20px;
            border: 1px solid #cbd5d1;
            border-radius: 8px;
            cursor: pointer;
            background: white;
            color: #134e4a;
            transition: 0.2s;
        }

        .option span:hover {
            border-color: #0f766e;
        }

        .option input:checked + span {
            background: #0f766e;
            color: white;
            border-color: #0f766e;
        }

        /* ================= QUANTITY ================= */

        .quantity-section {
            margin-top: 24px;
        }

        .quantity-section label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .quantity-input {
            width: 90px;
            padding: 10px;
            border: 1px solid #cbd5d1;
            border-radius: 8px;
            font-size: 16px;
        }

        /* ================= MAIN BUTTONS ================= */

        .actions {
            display: flex;
            gap: 12px;
            margin-top: 25px;
            flex-wrap: wrap;
        }

        .cart-btn,
        .buy-btn,
        .try-btn {
            padding: 14px 24px;
            border-radius: 10px;
            font-weight: bold;
            border: none;
            cursor: pointer;
            font-size: 15px;
            text-decoration: none;
            display: inline-block;
        }

        .cart-btn {
            background: #0f766e;
            color: white;
        }

        .buy-btn {
            background: #134e4a;
            color: white;
        }

        .try-btn {
            background: white;
            color: #0f766e;
            border: 2px solid #0f766e;
        }

        .cart-btn:hover {
            background: #115e59;
        }

        .buy-btn:hover {
            background: #0f766e;
        }

        .try-btn:hover {
            background: #f0fdfa;
        }

        /* ================= WISHLIST / SHARE / REVIEWS ================= */

        .secondary-actions {
            display: flex;
            gap: 12px;
            margin-top: 15px;
            flex-wrap: wrap;
        }

        .wishlist-form {
            margin: 0;
        }

        .wishlist-btn,
        .share-btn,
        .review-btn {
            padding: 11px 18px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        /* WISHLIST */

        .wishlist-btn {
            background: #fff1f2;
            color: #be123c;
            border: 1px solid #fecdd3;
        }

        .wishlist-btn:hover {
            background: #ffe4e6;
        }

        /* SHARE */

        .share-btn {
            background: #eff6ff;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }

        .share-btn:hover {
            background: #dbeafe;
        }

        /* REVIEWS */

        .review-btn {
            background: #fffbeb;
            color: #a16207;
            border: 1px solid #fde68a;
        }

        .review-btn:hover {
            background: #fef3c7;
        }

        /* SHARE MESSAGE */

        .share-message {
            display: none;
            margin-top: 8px;
            color: #0f766e;
            font-size: 14px;
            font-weight: bold;
        }

        /* ================= MOBILE ================= */

        @media (max-width: 700px) {

            .header {
                padding: 18px 20px;
            }

            .product-box {
                grid-template-columns: 1fr;
                padding: 20px;
            }

            .product-image {
                height: 400px;
            }

            .details h2 {
                font-size: 26px;
            }

            .actions,
            .secondary-actions {
                flex-direction: column;
            }

            .cart-btn,
            .buy-btn,
            .try-btn,
            .wishlist-btn,
            .share-btn,
            .review-btn {
                width: 100%;
                text-align: center;
            }

        }

    </style>

</head>


<body>


<!-- ================= HEADER ================= -->

<div class="header">

    <h1>SRI SHOP</h1>

    <a
        class="back"
        href="${pageContext.request.contextPath}/products"
    >
        Back to Dresses
    </a>

</div>



<!-- ================= MAIN CONTAINER ================= -->

<div class="container">

    <div class="product-box">


        <!-- ================= PRODUCT IMAGE ================= -->

        <div class="product-image">

            <% if (product.getImageUrl() != null
                    && !product.getImageUrl().isBlank()) { %>

                <img
                    src="<%= product.getImageUrl() %>"
                    alt="<%= product.getName() %>"
                >

            <% } else { %>

                <span>No Image Available</span>

            <% } %>

        </div>



        <!-- ================= PRODUCT DETAILS ================= -->

        <div class="details">


            <!-- PRODUCT NAME -->

            <h2>

                <%= product.getName() %>

            </h2>



            <!-- DESCRIPTION -->

            <p class="description">

                <%= product.getDescription() %>

            </p>



            <!-- PRODUCT INFORMATION -->

            <div class="info">

                <p>

                    <strong>Category:</strong>

                    <%= product.getCategory() %>

                </p>


                <p class="stock">

                    <strong>Available Stock:</strong>

                    <%= product.getStockQuantity() %>

                </p>

            </div>



            <!-- ================= SIZE ================= -->

            <div class="option-group">

                <span class="option-title">

                    Size

                </span>


                <div class="options">


                    <label class="option">

                        <input
                            type="radio"
                            name="size"
                            value="S"
                            checked
                        >

                        <span>S</span>

                    </label>


                    <label class="option">

                        <input
                            type="radio"
                            name="size"
                            value="M"
                        >

                        <span>M</span>

                    </label>


                    <label class="option">

                        <input
                            type="radio"
                            name="size"
                            value="L"
                        >

                        <span>L</span>

                    </label>


                    <label class="option">

                        <input
                            type="radio"
                            name="size"
                            value="XL"
                        >

                        <span>XL</span>

                    </label>


                    <label class="option">

                        <input
                            type="radio"
                            name="size"
                            value="XXL"
                        >

                        <span>XXL</span>

                    </label>


                </div>

            </div>



            <!-- ================= COLOR ================= -->

            <div class="option-group">

                <span class="option-title">

                    Color

                </span>


                <div class="options">


                    <label class="option">

                        <input
                            type="radio"
                            name="color"
                            value="Black"
                            checked
                        >

                        <span>Black</span>

                    </label>


                    <label class="option">

                        <input
                            type="radio"
                            name="color"
                            value="Blue"
                        >

                        <span>Blue</span>

                    </label>


                    <label class="option">

                        <input
                            type="radio"
                            name="color"
                            value="Pink"
                        >

                        <span>Pink</span>

                    </label>


                    <label class="option">

                        <input
                            type="radio"
                            name="color"
                            value="Green"
                        >

                        <span>Green</span>

                    </label>


                    <label class="option">

                        <input
                            type="radio"
                            name="color"
                            value="Red"
                        >

                        <span>Red</span>

                    </label>


                </div>

            </div>



            <!-- ================= QUANTITY ================= -->

            <div class="quantity-section">

                <label for="quantity">

                    Quantity

                </label>


                <input
                    class="quantity-input"
                    type="number"
                    id="quantity"
                    name="quantity"
                    value="1"
                    min="1"
                    max="<%= product.getStockQuantity() %>"
                >

            </div>



            <!-- ================= PRICE ================= -->

            <div class="price">

                ₹<%= product.getPrice() %>

            </div>



            <!-- ================= MAIN ACTIONS ================= -->

            <div class="actions">


                <!-- ADD TO CART -->

                <form
                    method="post"
                    action="${pageContext.request.contextPath}/cart"
                    onsubmit="return prepareCartData();"
                >

                    <input
                        type="hidden"
                        name="action"
                        value="add"
                    >

                    <input
                        type="hidden"
                        name="productId"
                        value="<%= product.getProductId() %>"
                    >

                    <input
                        type="hidden"
                        name="size"
                        id="selectedSize"
                    >

                    <input
                        type="hidden"
                        name="color"
                        id="selectedColor"
                    >

                    <input
                        type="hidden"
                        name="quantity"
                        id="selectedQuantity"
                    >

                    <button
                        class="cart-btn"
                        type="submit"
                    >
                        Add to Cart
                    </button>

                </form>



                <!-- BUY NOW -->

                <button
                    class="buy-btn"
                    type="button"
                    onclick="buyNow();"
                >
                    Buy Now
                </button>



                <!-- TRY THIS DRESS -->

                <a
                    class="try-btn"
                    href="${pageContext.request.contextPath}/trial-room.jsp?productId=<%= product.getProductId() %>"
                >
                    👗 Try This Dress
                </a>


            </div>



            <!-- ==================================================
                 WISHLIST / SHARE / REVIEWS
                 ================================================== -->

            <div class="secondary-actions">


                <!-- ADD TO WISHLIST -->

                <form
                    class="wishlist-form"
                    method="post"
                    action="${pageContext.request.contextPath}/wishlist"
                >

                    <input
                        type="hidden"
                        name="action"
                        value="add"
                    >

                    <input
                        type="hidden"
                        name="productId"
                        value="<%= product.getProductId() %>"
                    >

                    <button
                        class="wishlist-btn"
                        type="submit"
                    >
                        ❤️ Add to Wishlist
                    </button>

                </form>



                <!-- SHARE -->

                <button
                    class="share-btn"
                    type="button"
                    onclick="shareProduct();"
                >
                    🔗 Share
                </button>



                <!-- REVIEWS -->

                <a
                    class="review-btn"
                    href="${pageContext.request.contextPath}/review-form?productId=<%= product.getProductId() %>"
                >
                    ⭐ Reviews & Ratings
                </a>


            </div>



            <!-- SHARE SUCCESS MESSAGE -->

            <div
                id="shareMessage"
                class="share-message"
            >
                Product link copied successfully!
            </div>


        </div>

    </div>

</div>



<!-- ================= JAVASCRIPT ================= -->

<script>


/* ==================================================
   ADD TO CART
   ================================================== */

function prepareCartData() {

    const selectedSize =
        document.querySelector(
            'input[name="size"]:checked'
        );


    const selectedColor =
        document.querySelector(
            'input[name="color"]:checked'
        );


    const quantityInput =
        document.getElementById("quantity");


    const quantity =
        parseInt(quantityInput.value);


    if (!selectedSize) {

        alert("Please select a size.");

        return false;

    }


    if (!selectedColor) {

        alert("Please select a color.");

        return false;

    }


    if (isNaN(quantity) || quantity < 1) {

        alert("Please enter a valid quantity.");

        return false;

    }


    const maxStock =
        parseInt(quantityInput.max);


    if (quantity > maxStock) {

        alert(
            "Only " +
            maxStock +
            " item(s) available in stock."
        );

        return false;

    }


    document.getElementById("selectedSize").value =
        selectedSize.value;


    document.getElementById("selectedColor").value =
        selectedColor.value;


    document.getElementById("selectedQuantity").value =
        quantity;


    return true;

}



/* ==================================================
   BUY NOW
   ================================================== */

function buyNow() {

    const selectedSize =
        document.querySelector(
            'input[name="size"]:checked'
        );


    const selectedColor =
        document.querySelector(
            'input[name="color"]:checked'
        );


    const quantityInput =
        document.getElementById("quantity");


    const quantity =
        parseInt(quantityInput.value);


    if (!selectedSize) {

        alert("Please select a size.");

        return;

    }


    if (!selectedColor) {

        alert("Please select a color.");

        return;

    }


    if (isNaN(quantity) || quantity < 1) {

        alert("Please enter a valid quantity.");

        return;

    }


    const maxStock =
        parseInt(quantityInput.max);


    if (quantity > maxStock) {

        alert(
            "Only " +
            maxStock +
            " item(s) available in stock."
        );

        return;

    }


    const productId =
        "<%= product.getProductId() %>";


    const contextPath =
        "${pageContext.request.contextPath}";


    window.location.href =
        contextPath +
        "/checkout?productId=" +
        encodeURIComponent(productId) +
        "&size=" +
        encodeURIComponent(selectedSize.value) +
        "&color=" +
        encodeURIComponent(selectedColor.value) +
        "&quantity=" +
        encodeURIComponent(quantity);

}



/* ==================================================
   SHARE PRODUCT
   ================================================== */

function shareProduct() {

    const productUrl =
        window.location.href;


    const productName =
        "<%= product.getName() %>";


    /* Browser native Share */

    if (navigator.share) {

        navigator.share({

            title:
                productName + " - SRI SHOP",

            text:
                "Check out this product on SRI SHOP.",

            url:
                productUrl

        }).catch(function(error) {

            /*
             * User cancelled the share window.
             * Do nothing.
             */

            if (error.name === "AbortError") {

                return;

            }

        });

        return;

    }


    /* Clipboard fallback */

    if (navigator.clipboard) {

        navigator.clipboard.writeText(productUrl)
            .then(function() {

                showShareMessage();

            })
            .catch(function() {

                window.prompt(
                    "Copy this product link:",
                    productUrl
                );

            });

    } else {

        window.prompt(
            "Copy this product link:",
            productUrl
        );

    }

}



/* ==================================================
   SHARE MESSAGE
   ================================================== */

function showShareMessage() {

    const message =
        document.getElementById("shareMessage");


    message.style.display = "block";


    setTimeout(function() {

        message.style.display = "none";

    }, 2500);

}


</script>


</body>

</html>