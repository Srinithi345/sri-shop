<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.srimart.model.Product" %>

<%
    String contextPath = request.getContextPath();

    Product product = (Product) request.getAttribute("product");

    if (product == null) {
        response.sendRedirect(contextPath + "/products");
        return;
    }

    String imageUrl = product.getImageUrl();

    if (imageUrl != null) {
        imageUrl = imageUrl.trim();

        if (!imageUrl.startsWith("http://")
                && !imageUrl.startsWith("https://")
                && !imageUrl.startsWith("/")) {
            imageUrl = contextPath + "/" + imageUrl;
        }
    }

    String imageSrc = imageUrl;

    if (imageUrl != null && !imageUrl.isEmpty()) {
        if (imageUrl.contains("?")) {
            imageSrc = imageUrl + "&v=" + product.getProductId();
        } else {
            imageSrc = imageUrl + "?v=" + product.getProductId();
        }
    }

    int stockQuantity = product.getStockQuantity();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        <%= product.getName() %> - SRI SHOP
    </title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f8fafc;
            color: #1f2937;
        }

        header {
            background: #0f766e;
            color: white;
            padding: 16px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
        }

        nav {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        nav a {
            color: white;
            text-decoration: none;
            padding: 9px 12px;
            border-radius: 8px;
            font-size: 14px;
        }

        nav a:hover {
            background: #115e59;
        }

        .container {
            max-width: 1100px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .breadcrumb {
            font-size: 14px;
            color: #64748b;
            margin-bottom: 18px;
        }

        .breadcrumb a {
            color: #0f766e;
            text-decoration: none;
            font-weight: bold;
        }

        .breadcrumb span {
            margin: 0 7px;
            color: #94a3b8;
        }

        .product-card {
            background: white;
            border-radius: 18px;
            padding: 30px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
        }

        .image-box {
            height: 500px;
            background: #f8fafc;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .image-box img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            display: block;
        }

        .no-image {
            color: #64748b;
            font-size: 18px;
        }

        .category {
            display: inline-block;
            background: #ccfbf1;
            color: #0f766e;
            font-weight: bold;
            padding: 7px 12px;
            border-radius: 20px;
            margin-bottom: 12px;
            font-size: 13px;
        }

        h1 {
            margin: 0 0 15px;
            font-size: 34px;
            color: #111827;
        }

        .description {
            color: #64748b;
            line-height: 1.7;
            margin-bottom: 20px;
        }

        .price {
            font-size: 30px;
            font-weight: bold;
            color: #0f766e;
            margin-bottom: 18px;
        }

        .stock {
            font-weight: bold;
            margin-bottom: 20px;
        }

        .available {
            color: #15803d;
        }

        .out {
            color: #dc2626;
        }

        .option-title {
            font-weight: bold;
            margin: 18px 0 8px;
        }

        select,
        input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
            background: white;
        }

        select:focus,
        input[type="number"]:focus {
            outline: none;
            border-color: #0f766e;
            box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.1);
        }

        .quantity {
            max-width: 120px;
        }

        .buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 22px;
        }

        button,
        .buy-button {
            border: none;
            border-radius: 9px;
            padding: 13px 18px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        .cart-button {
            background: #0f766e;
            color: white;
        }

        .cart-button:hover {
            background: #115e59;
        }

        .buy-button {
            background: #f59e0b;
            color: white;
        }

        .buy-button:hover {
            background: #d97706;
        }

        .wishlist-button {
            background: #fee2e2;
            color: #b91c1c;
        }

        .wishlist-button:hover {
            background: #fecaca;
        }

        .share-button {
            background: #e2e8f0;
            color: #334155;
        }

        .share-button:hover {
            background: #cbd5e1;
        }

        .product-info-box {
            margin-top: 25px;
            padding: 16px;
            background: #f8fafc;
            border-radius: 10px;
            font-size: 14px;
            color: #475569;
        }

        .product-info-box div {
            margin: 8px 0;
        }

        .reviews {
            display: inline-block;
            margin-top: 25px;
            color: #0f766e;
            font-weight: bold;
            text-decoration: none;
        }

        .reviews:hover {
            text-decoration: underline;
        }

        @media (max-width: 800px) {

            .product-card {
                grid-template-columns: 1fr;
            }

            .image-box {
                height: 400px;
            }

            h1 {
                font-size: 28px;
            }
        }

        @media (max-width: 500px) {

            header {
                padding: 14px;
            }

            .container {
                padding: 0 12px;
                margin: 20px auto;
            }

            .product-card {
                padding: 20px;
            }

            .buttons {
                flex-direction: column;
            }

            button,
            .buy-button {
                width: 100%;
                text-align: center;
            }
        }

    </style>

</head>

<body>


<header>

    <div class="logo">
        &#128722; SRI SHOP
    </div>

    <nav>

        <a href="<%= contextPath %>/products">
            &#128087; Shop
        </a>

        <a href="<%= contextPath %>/products?category=Accessories">
            &#128091; Accessories
        </a>

        <a href="<%= contextPath %>/wishlist">
            &#10084;&#65039; Wishlist
        </a>

        <a href="<%= contextPath %>/cart">
            &#128722; Cart
        </a>

        <a href="<%= contextPath %>/profile">
            &#128100; Profile
        </a>

    </nav>

</header>


<div class="container">


    <!-- BREADCRUMB -->

    <div class="breadcrumb">

        <a href="<%= contextPath %>/products">
            Shop
        </a>

        <span>&rsaquo;</span>

        <a href="<%= contextPath %>/products?category=<%= product.getCategory() %>">
            <%= product.getCategory() %>
        </a>

        <span>&rsaquo;</span>

        <span>
            <%= product.getName() %>
        </span>

    </div>


    <div class="product-card">


        <!-- PRODUCT IMAGE -->

        <div class="image-box">

            <% if (imageSrc != null && !imageSrc.isEmpty()) { %>

                <img
                    src="<%= imageSrc %>"
                    alt="<%= product.getName() %>"
                    onerror="this.style.display='none'; this.parentElement.innerHTML='<div class=&quot;no-image&quot;>Image unavailable</div>';"
                >

            <% } else { %>

                <div class="no-image">
                    Image unavailable
                </div>

            <% } %>

        </div>


        <!-- PRODUCT DETAILS -->

        <div>

            <div class="category">

                <%= product.getCategory() %>

            </div>


            <h1>

                <%= product.getName() %>

            </h1>


            <div class="description">

                <%= product.getDescription() %>

            </div>


            <div class="price">

                &#8377;<%= product.getPrice() %>

            </div>


            <!-- STOCK -->

            <div class="stock">

                <% if (stockQuantity > 0) { %>

                    <span class="available">

                        &#10003; In Stock:
                        <%= stockQuantity %>

                    </span>

                <% } else { %>

                    <span class="out">

                        Out of Stock

                    </span>

                <% } %>

            </div>


            <% if (stockQuantity > 0) { %>


                <!-- ADD TO CART FORM -->

                <form
                    method="post"
                    action="<%= contextPath %>/cart"
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


                    <!-- SAME SIZE OPTIONS FOR ALL PRODUCTS -->

                    <div class="option-title">

                        Select Size

                    </div>

                    <select
                        name="size"
                        id="size"
                        required
                    >

                        <option value="XS">
                            XS
                        </option>

                        <option value="S">
                            S
                        </option>

                        <option value="M" selected>
                            M
                        </option>

                        <option value="L">
                            L
                        </option>

                        <option value="XL">
                            XL
                        </option>

                        <option value="XXL">
                            XXL
                        </option>

                    </select>


                    <!-- SAME COLOR OPTIONS FOR ALL PRODUCTS -->

                    <div class="option-title">

                        Select Color

                    </div>

                    <select
                        name="color"
                        id="color"
                        required
                    >

                        <option value="Black">
                            Black
                        </option>

                        <option value="White">
                            White
                        </option>

                        <option value="Red">
                            Red
                        </option>

                        <option value="Blue">
                            Blue
                        </option>

                        <option value="Pink">
                            Pink
                        </option>

                        <option value="Green">
                            Green
                        </option>

                        <option value="Yellow">
                            Yellow
                        </option>

                        <option value="Brown">
                            Brown
                        </option>

                    </select>


                    <!-- QUANTITY -->

                    <div class="option-title">

                        Quantity

                    </div>

                    <input
                        class="quantity"
                        type="number"
                        name="quantity"
                        value="1"
                        min="1"
                        max="<%= stockQuantity %>"
                        required
                    >


                    <!-- ADD TO CART / BUY NOW -->

                    <div class="buttons">

                        <button
                            type="submit"
                            class="cart-button"
                        >

                            &#128722; Add to Cart

                        </button>


                        <button
                            type="button"
                            class="buy-button"
                            onclick="buyNow()"
                        >

                            &#9889; Buy Now

                        </button>

                    </div>

                </form>


                <!-- WISHLIST / SHARE -->

                <div class="buttons">

                    <form
                        method="post"
                        action="<%= contextPath %>/wishlist"
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
                            type="submit"
                            class="wishlist-button"
                        >

                            &#10084;&#65039; Add to Wishlist

                        </button>

                    </form>


                    <button
                        type="button"
                        class="share-button"
                        onclick="shareProduct()"
                    >

                        &#128279; Share

                    </button>

                </div>


                <!-- PRODUCT INFORMATION -->

                <div class="product-info-box">

                    <div>

                        <strong>Category:</strong>
                        <%= product.getCategory() %>

                    </div>

                    <div>

                        <strong>Product ID:</strong>
                        <%= product.getProductId() %>

                    </div>

                </div>


                <!-- REVIEWS -->

                <a
                    class="reviews"
                    href="<%= contextPath %>/review-form?productId=<%= product.getProductId() %>"
                >

                    &#11088; View / Add Reviews

                </a>


            <% } %>

        </div>

    </div>

</div>


<script>

function buyNow() {

    const size =
        document.getElementById("size").value;

    const color =
        document.getElementById("color").value;

    const quantity =
        document.querySelector(
            'input[name="quantity"]'
        ).value;

    const productId =
        "<%= product.getProductId() %>";


    const url =
        "<%= contextPath %>/checkout"
        + "?productId="
        + encodeURIComponent(productId)
        + "&size="
        + encodeURIComponent(size)
        + "&color="
        + encodeURIComponent(color)
        + "&quantity="
        + encodeURIComponent(quantity);


    window.location.href = url;
}


function shareProduct() {

    if (navigator.share) {

        navigator.share({

            title:
                "<%= product.getName() %>",

            text:
                "Check out this product on SRI SHOP",

            url:
                window.location.href

        });

    } else {

        navigator.clipboard
            .writeText(window.location.href)
            .then(function () {

                alert("Product link copied!");

            })
            .catch(function () {

                alert("Unable to copy product link.");

            });

    }

}

</script>


</body>

</html>