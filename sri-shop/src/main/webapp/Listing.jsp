<%@ page contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.srimart.model.Product" %>

<%
    String contextPath = request.getContextPath();

    List<Product> products =
            (List<Product>) request.getAttribute("products");

    if (products == null) {
        products = java.util.Collections.emptyList();
    }

    String selectedCategory =
            request.getAttribute("category") == null
                    ? ""
                    : String.valueOf(
                            request.getAttribute("category")
                      );

    String searchTerm =
            request.getAttribute("searchTerm") == null
                    ? ""
                    : String.valueOf(
                            request.getAttribute("searchTerm")
                      );

    String errorMessage =
            request.getAttribute("errorMessage") == null
                    ? ""
                    : String.valueOf(
                            request.getAttribute("errorMessage")
                      );
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <title>SRI SHOP - Shop Dresses</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f8fafc;
            color: #1f2937;
        }

        .header {
            background: #0f766e;
            color: white;
            padding: 16px 30px;
            display: flex;
            align-items: center;
            gap: 25px;
            flex-wrap: wrap;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            white-space: nowrap;
        }

        .search-form {
            flex: 1;
            min-width: 240px;
            max-width: 600px;
            display: flex;
        }

        .search-form input {
            flex: 1;
            padding: 12px 15px;
            border: none;
            outline: none;
            border-radius: 8px 0 0 8px;
            font-size: 15px;
        }

        .search-form button {
            width: 50px;
            border: none;
            background: #115e59;
            color: white;
            font-size: 18px;
            cursor: pointer;
            border-radius: 0 8px 8px 0;
        }

        .nav {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .nav a {
            color: white;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }

        .nav a:hover {
            text-decoration: underline;
        }

        .container {
            width: 92%;
            max-width: 1400px;
            margin: 30px auto;
        }

        .page-title {
            text-align: center;
            margin-bottom: 25px;
        }

        .page-title h1 {
            margin: 0 0 8px;
            color: #115e59;
            font-size: 32px;
        }

        .page-title p {
            margin: 0;
            color: #64748b;
        }

        .category-filter {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 30px;
        }

        .category-btn {
            display: inline-block;
            padding: 10px 18px;
            border-radius: 25px;
            border: 1px solid #0f766e;
            background: white;
            color: #0f766e;
            text-decoration: none;
            font-weight: 600;
            transition: 0.2s;
        }

        .category-btn:hover,
        .category-btn.active {
            background: #0f766e;
            color: white;
        }

        .search-result {
            text-align: center;
            margin-bottom: 20px;
            color: #475569;
        }

        .error-message {
            background: #fee2e2;
            color: #991b1b;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }

        .empty-message {
            background: white;
            border-radius: 12px;
            padding: 50px 20px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
        }

        .empty-message h2 {
            margin-bottom: 10px;
            color: #334155;
        }

        .empty-message p {
            color: #64748b;
        }

        .products-grid {
            display: grid;
            grid-template-columns:
                repeat(auto-fill, minmax(230px, 1fr));
            gap: 25px;
        }

        .product-card {
            background: white;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 5px 18px rgba(0, 0, 0, 0.08);
            transition:
                transform 0.2s,
                box-shadow 0.2s;
        }

        .product-card:hover {
            transform: translateY(-4px);
            box-shadow:
                0 10px 25px rgba(0, 0, 0, 0.12);
        }

        .product-image-container {
            width: 100%;
            height: 280px;
            background: #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .product-image {
            width: 100%;
            height: 100%;
            object-fit: contain;
            padding: 8px;
            display: block;
        }

        .no-image {
            color: #94a3b8;
            font-size: 15px;
        }

        .product-info {
            padding: 18px;
        }

        .product-name {
            font-size: 18px;
            font-weight: bold;
            color: #1e293b;
            margin-bottom: 8px;
        }

        .product-category {
            font-size: 13px;
            color: #64748b;
            margin-bottom: 8px;
        }

        .product-price {
            font-size: 20px;
            font-weight: bold;
            color: #0f766e;
            margin-bottom: 10px;
        }

        .product-stock {
            font-size: 13px;
            color: #475569;
            margin-bottom: 15px;
        }

        .product-actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn {
            flex: 1;
            min-width: 100px;
            padding: 10px 12px;
            border: none;
            border-radius: 7px;
            text-align: center;
            text-decoration: none;
            font-weight: 600;
            cursor: pointer;
            font-size: 13px;
        }

        .btn-view {
            background: #0f766e;
            color: white;
        }

        .btn-view:hover {
            background: #115e59;
        }

        .btn-wishlist {
            background: #fce7f3;
            color: #be185d;
        }

        .btn-wishlist:hover {
            background: #fbcfe8;
        }

        .wishlist-form {
            flex: 1;
            display: flex;
        }

        .wishlist-form button {
            width: 100%;
        }

        @media (max-width: 900px) {

            .header {
                padding: 15px;
            }

            .search-form {
                order: 3;
                width: 100%;
                max-width: none;
            }

            .nav {
                gap: 10px;
            }

            .products-grid {
                grid-template-columns:
                    repeat(auto-fill, minmax(200px, 1fr));
            }
        }

        @media (max-width: 600px) {

            .container {
                width: 94%;
                margin: 20px auto;
            }

            .logo {
                font-size: 20px;
            }

            .nav {
                width: 100%;
                justify-content: center;
            }

            .page-title h1 {
                font-size: 26px;
            }

            .products-grid {
                grid-template-columns: 1fr 1fr;
                gap: 12px;
            }

            .product-image-container {
                height: 220px;
            }

            .product-info {
                padding: 12px;
            }

            .product-name {
                font-size: 15px;
            }

            .product-price {
                font-size: 17px;
            }

            .btn {
                min-width: 100%;
            }
        }

    </style>

</head>

<body>

<header class="header">

    <div class="logo">
        &#128717;&#65039; SRI SHOP
    </div>

    <form
        class="search-form"
        action="<%= contextPath %>/products"
        method="get"
    >

        <input
            type="text"
            name="search"
            value="<%= searchTerm %>"
            placeholder="Search dresses..."
            autocomplete="off"
        >

        <button type="submit">
            &#128269;
        </button>

    </form>

    <nav class="nav">

        <a href="<%= contextPath %>/products">
            &#128717;&#65039; Shop
        </a>

        <a href="<%= contextPath %>/products?category=Accessories">
            &#128090; Accessories
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

        <a href="<%= contextPath %>/logout">
            Logout
        </a>

    </nav>

</header>


<div class="container">

    <div class="page-title">

        <h1>
            Shop Dresses
        </h1>

        <p>
            Find your perfect style at SRI SHOP
        </p>

    </div>


    <div class="category-filter">

        <a
            href="<%= contextPath %>/products"
            class="category-btn
                <%= selectedCategory.isEmpty()
                    && searchTerm.isEmpty()
                    ? "active"
                    : "" %>"
        >
            All
        </a>


        <a
            href="<%= contextPath %>/products?category=Anarkali"
            class="category-btn
                <%= "Anarkali".equalsIgnoreCase(
                        selectedCategory
                   )
                    ? "active"
                    : "" %>"
        >
            Anarkali
        </a>


        <a
            href="<%= contextPath %>/products?category=Kurti"
            class="category-btn
                <%= "Kurti".equalsIgnoreCase(
                        selectedCategory
                   )
                    ? "active"
                    : "" %>"
        >
            Kurti
        </a>


        <a
            href="<%= contextPath %>/products?category=Boys%20Wear"
            class="category-btn
                <%= "Boys Wear".equalsIgnoreCase(
                        selectedCategory
                   )
                    ? "active"
                    : "" %>"
        >
            Boys Wear
        </a>


        <a
            href="<%= contextPath %>/products?category=Accessories"
            class="category-btn
                <%= "Accessories".equalsIgnoreCase(
                        selectedCategory
                   )
                    ? "active"
                    : "" %>"
        >
            Accessories
        </a>

    </div>


    <% if (!searchTerm.isEmpty()) { %>

        <div class="search-result">

            Search results for:
            <strong><%= searchTerm %></strong>

        </div>

    <% } %>


    <% if (!errorMessage.isEmpty()) { %>

        <div class="error-message">
            <%= errorMessage %>
        </div>

    <% } %>


    <% if (products.isEmpty()) { %>

        <div class="empty-message">

            <h2>
                No products found
            </h2>

            <p>
                Try another category or search term.
            </p>

        </div>

    <% } else { %>


        <div class="products-grid">

            <% for (Product product : products) { %>

                <%
                    String imageUrl = product.getImageUrl();

                    if (imageUrl != null) {

                        imageUrl = imageUrl.trim();

                        if (!(imageUrl.startsWith("http://")
                                || imageUrl.startsWith("https://")
                                || imageUrl.startsWith("/"))) {

                            imageUrl =
                                    contextPath
                                    + "/"
                                    + imageUrl;
                        }
                    }

                    String imageSrc = imageUrl;

                    if (imageUrl != null
                            && !imageUrl.isEmpty()) {

                        if (imageUrl.contains("?")) {

                            imageSrc =
                                    imageUrl
                                    + "&v="
                                    + product.getProductId();

                        } else {

                            imageSrc =
                                    imageUrl
                                    + "?v="
                                    + product.getProductId();
                        }
                    }
                %>


                <div class="product-card">

                    <div class="product-image-container">

                        <% if (imageSrc != null
                                && !imageSrc.isEmpty()) { %>

                            <img
                                src="<%= imageSrc %>"
                                alt="<%= product.getName() %>"
                                class="product-image"
                                onerror="this.style.display='none'; this.nextElementSibling.style.display='block';"
                            >

                            <div
                                class="no-image"
                                style="display:none;"
                            >
                                No Image Available
                            </div>

                        <% } else { %>

                            <div class="no-image">
                                No Image Available
                            </div>

                        <% } %>

                    </div>


                    <div class="product-info">

                        <div class="product-name">
                            <%= product.getName() %>
                        </div>


                        <div class="product-category">
                            Category:
                            <%= product.getCategory() %>
                        </div>


                        <div class="product-price">
                            &#8377;<%= product.getPrice() %>
                        </div>


                        <div class="product-stock">

                            <% if (product.getStockQuantity() > 0) { %>

                                In Stock:
                                <%= product.getStockQuantity() %>

                            <% } else { %>

                                <span style="color:#dc2626;">
                                    Out of Stock
                                </span>

                            <% } %>

                        </div>


                        <div class="product-actions">

                            <a
                                href="<%= contextPath %>/product-details?id=<%= product.getProductId() %>"
                                class="btn btn-view"
                            >
                                View Product
                            </a>


                            <% if (product.getStockQuantity() > 0) { %>

                                <form
                                    action="<%= contextPath %>/wishlist"
                                    method="post"
                                    class="wishlist-form"
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
                                        class="btn btn-wishlist"
                                    >
                                        &#10084;&#65039; Wishlist
                                    </button>

                                </form>

                            <% } %>

                        </div>

                    </div>

                </div>

            <% } %>

        </div>

    <% } %>

</div>

</body>

</html>