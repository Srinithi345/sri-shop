<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.srimart.model.Product" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");

    if (userName == null || !"BUYER".equalsIgnoreCase(userRole)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Product> products =
            (List<Product>) request.getAttribute("products");

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Sri Shop - Products</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #222;
        }

        /* NAVBAR */

        .navbar {
            background: #111827;
            color: white;
            padding: 16px 6%;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .nav-right a {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        .logout {
            background: #ef4444;
            padding: 8px 14px;
            border-radius: 7px;
        }

        .logout:hover {
            background: #dc2626;
        }

        /* MAIN */

        .container {
            width: 90%;
            max-width: 1300px;
            margin: 35px auto;
        }

        .heading {
            margin-bottom: 25px;
        }

        .heading h1 {
            font-size: 30px;
            color: #111827;
        }

        .heading p {
            color: #6b7280;
            margin-top: 7px;
        }

        /* PRODUCT GRID */

        .product-grid {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(250px, 1fr));

            gap: 25px;
        }

        /* PRODUCT CARD */

        .product-card {
            background: white;
            border-radius: 14px;
            overflow: hidden;

            box-shadow:
                0 4px 15px rgba(0, 0, 0, 0.08);

            transition: 0.25s;
        }

        .product-card:hover {
            transform: translateY(-5px);

            box-shadow:
                0 8px 25px rgba(0, 0, 0, 0.14);
        }

        /* IMAGE */

        .product-image {
            width: 100%;
            height: 280px;

            background: #ccfbf1;

            overflow: hidden;

            display: flex;
            justify-content: center;
            align-items: center;
        }

        .product-image img {
            width: 100%;
            height: 280px;

            object-fit: cover;

            display: block;
        }

        .no-image {
            color: #64748b;
            font-size: 15px;
        }

        /* PRODUCT INFO */

        .product-info {
            padding: 18px;
        }

        .product-name {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .category {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .description {
            color: #6b7280;
            font-size: 14px;

            line-height: 1.5;

            min-height: 42px;

            margin-bottom: 12px;
        }

        .price {
            font-size: 21px;
            font-weight: bold;

            color: #0f766e;

            margin-bottom: 8px;
        }

        .stock {
            font-size: 14px;
            margin-bottom: 15px;
        }

        .in-stock {
            color: #16a34a;
        }

        .out-stock {
            color: #dc2626;
        }

        /* ACTION BUTTONS */

        .product-actions {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .details-btn,
        .wishlist-btn {
            display: block;

            width: 100%;

            text-align: center;

            text-decoration: none;

            padding: 11px;

            border-radius: 8px;

            font-weight: bold;

            cursor: pointer;

            border: none;

            font-size: 14px;
        }

        .details-btn {
            background: #0f766e;
            color: white;
        }

        .details-btn:hover {
            background: #115e59;
        }

        .wishlist-btn {
            background: #fff1f2;
            color: #be123c;
            border: 1px solid #fecdd3;
        }

        .wishlist-btn:hover {
            background: #ffe4e6;
        }

        /* EMPTY */

        .empty {
            text-align: center;

            background: white;

            padding: 50px;

            border-radius: 12px;

            color: #64748b;
        }

        /* MOBILE */

        @media (max-width: 600px) {

            .navbar {
                padding: 14px 4%;
            }

            .nav-right {
                gap: 8px;
                font-size: 13px;
            }

            .container {
                width: 94%;
            }

            .product-image,
            .product-image img {
                height: 250px;
            }

        }

    </style>

</head>


<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <div class="logo">
        SRI SHOP
    </div>

    <div class="nav-right">

        <span>
            Hi, <%= userName %>
        </span>

        <a href="<%= contextPath %>/cart">
            🛒 Cart
        </a>

        <a href="<%= contextPath %>/orders">
            📦 Orders
        </a>

        <a href="<%= contextPath %>/wishlist">
            ❤️ Wishlist
        </a>

        <a href="<%= contextPath %>/logout"
           class="logout">
            Logout
        </a>

    </div>

</nav>


<!-- ================= MAIN ================= -->

<div class="container">

    <div class="heading">

        <h1>
            Explore Our Products
        </h1>

        <p>
            Choose your favourite dress and add it to your cart.
        </p>

    </div>


    <!-- ================= NO PRODUCTS ================= -->

    <% if (products == null || products.isEmpty()) { %>

        <div class="empty">

            <h2>
                No products available
            </h2>

            <p>
                Please check again later.
            </p>

        </div>


    <!-- ================= PRODUCTS ================= -->

    <% } else { %>

        <div class="product-grid">


            <% for (Product product : products) {

                String imageUrl = product.getImageUrl();

                if (imageUrl == null ||
                    imageUrl.trim().isEmpty()) {

                    imageUrl = "";

                } else if (
                    imageUrl.startsWith("http://") ||
                    imageUrl.startsWith("https://")
                ) {

                    // External URL - keep as it is.

                } else if (
                    imageUrl.startsWith("/sri-shop/")
                ) {

                    // Already has application path.
                    imageUrl = imageUrl;

                } else if (
                    imageUrl.startsWith("/")
                ) {

                    imageUrl = contextPath + imageUrl;

                } else {

                    imageUrl =
                        contextPath + "/" + imageUrl;
                }

            %>


            <!-- ================= PRODUCT CARD ================= -->

            <div class="product-card">


                <!-- IMAGE -->

                <div class="product-image">

                    <% if (!imageUrl.isEmpty()) { %>

                        <img
                            src="<%= imageUrl %>"
                            alt="<%= product.getName() %>"
                            onerror="
                                this.style.display='none';
                                this.nextElementSibling.style.display='block';
                            "
                        >

                        <div
                            class="no-image"
                            style="display:none;"
                        >
                            Image unavailable
                        </div>

                    <% } else { %>

                        <div class="no-image">
                            No Image
                        </div>

                    <% } %>

                </div>


                <!-- PRODUCT INFORMATION -->

                <div class="product-info">


                    <!-- NAME -->

                    <div class="product-name">

                        <%= product.getName() %>

                    </div>


                    <!-- CATEGORY -->

                    <div class="category">

                        <%= product.getCategory() %>

                    </div>


                    <!-- DESCRIPTION -->

                    <div class="description">

                        <%= product.getDescription() == null
                                ? "Premium quality product."
                                : product.getDescription() %>

                    </div>


                    <!-- PRICE -->

                    <div class="price">

                        ₹<%= product.getPrice() %>

                    </div>


                    <!-- STOCK -->

                    <% if (product.getStockQuantity() > 0) { %>

                        <div class="stock in-stock">

                            ✓
                            <%= product.getStockQuantity() %>
                            available

                        </div>

                    <% } else { %>

                        <div class="stock out-stock">

                            ✕ Out of stock

                        </div>

                    <% } %>


                    <!-- ACTION BUTTONS -->

                    <div class="product-actions">

                        <!-- WISHLIST -->

                        <form
                            action="<%= contextPath %>/wishlist"
                            method="post"
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
                                class="wishlist-btn"
                            >
                                ❤️ Add to Wishlist
                            </button>

                        </form>


                        <!-- VIEW PRODUCT -->

                        <a
                            class="details-btn"
                            href="<%= contextPath %>/product-details?id=<%= product.getProductId() %>"
                        >
                            👗 View Product
                        </a>

                    </div>


                </div>

            </div>


            <% } %>

        </div>

    <% } %>

</div>

</body>

</html>