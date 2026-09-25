<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.srimart.model.Wishlist" %>
<%@ page import="com.srimart.model.Product" %>

<%
    List<Wishlist> wishlistItems =
            (List<Wishlist>) request.getAttribute("wishlistItems");

    if (wishlistItems == null) {
        wishlistItems = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Wishlist - SRI SHOP</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f8f8f8;
            color: #222;
        }

        .navbar {
            background: #ffffff;
            border-bottom: 1px solid #e5e5e5;
            padding: 18px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .brand {
            font-size: 24px;
            font-weight: 700;
            color: #222;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 24px;
        }

        .nav-links a {
            text-decoration: none;
            color: #333;
            font-size: 15px;
            font-weight: 500;
        }

        .nav-links a:hover {
            color: #9b4d73;
        }

        .page-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 45px 25px;
        }

        .page-title {
            font-size: 32px;
            margin-bottom: 8px;
        }

        .page-subtitle {
            color: #777;
            margin-bottom: 30px;
        }

        .wishlist-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 24px;
        }

        .wishlist-card {
            background: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid #e7e7e7;
            padding: 20px;
        }

        .product-image {
            width: 100%;
            height: 280px;
            object-fit: cover;
            border-radius: 8px;
            background: #f1f1f1;
        }

        .product-title {
            font-size: 18px;
            font-weight: 600;
            margin: 16px 0;
        }

        .product-link {
            display: inline-block;
            text-decoration: none;
            color: #333;
            margin-bottom: 15px;
        }

        .remove-button {
            width: 100%;
            border: none;
            background: #222;
            color: white;
            padding: 11px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }

        .remove-button:hover {
            background: #444;
        }

        .empty-wishlist {
            background: white;
            border: 1px solid #e5e5e5;
            border-radius: 12px;
            padding: 60px 25px;
            text-align: center;
        }

        .empty-wishlist h2 {
            margin-bottom: 12px;
        }

        .empty-wishlist p {
            color: #777;
            margin-bottom: 25px;
        }

        .shop-button {
            display: inline-block;
            background: #222;
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 6px;
        }

        @media (max-width: 700px) {

            .navbar {
                padding: 15px 20px;
                flex-direction: column;
                gap: 15px;
            }

            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
                gap: 15px;
            }

            .page-container {
                padding: 30px 15px;
            }

            .page-title {
                font-size: 26px;
            }
        }
    </style>
</head>

<body>

<nav class="navbar">

    <a class="brand"
       href="<%= request.getContextPath() %>/">
        SRI SHOP
    </a>

    <div class="nav-links">

        <a href="<%= request.getContextPath() %>/products">
            Shop
        </a>

        <a href="<%= request.getContextPath() %>/wishlist">
            Wishlist
        </a>

        <a href="<%= request.getContextPath() %>/cart">
            Cart
        </a>

        <a href="<%= request.getContextPath() %>/buyer-dashboard.jsp">
            Profile
        </a>

        <a href="<%= request.getContextPath() %>/logout">
            Logout
        </a>

    </div>

</nav>

<main class="page-container">

    <h1 class="page-title">My Wishlist</h1>

    <p class="page-subtitle">
        Your saved products
    </p>

    <% if (wishlistItems.isEmpty()) { %>

        <div class="empty-wishlist">

            <h2>Your wishlist is empty</h2>

            <p>
                You haven't added any products to your wishlist yet.
            </p>

            <a class="shop-button"
               href="<%= request.getContextPath() %>/products">
                Continue Shopping
            </a>

        </div>

    <% } else { %>

        <div class="wishlist-grid">

            <% for (Wishlist item : wishlistItems) { %>

                <div class="wishlist-card">

                    <div class="product-title">
                        Product #<%= item.getProductId() %>
                    </div>

                    <a class="product-link"
                       href="<%= request.getContextPath() %>/product-details?id=<%= item.getProductId() %>">
                        View Product
                    </a>

                    <form method="post"
                          action="<%= request.getContextPath() %>/wishlist">

                        <input type="hidden"
                               name="action"
                               value="remove">

                        <input type="hidden"
                               name="productId"
                               value="<%= item.getProductId() %>">

                        <button type="submit"
                                class="remove-button">
                            Remove from Wishlist
                        </button>

                    </form>

                </div>

            <% } %>

        </div>

    <% } %>

</main>

</body>
</html>