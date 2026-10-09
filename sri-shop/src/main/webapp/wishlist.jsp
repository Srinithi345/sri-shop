<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page import="com.srimart.model.Wishlist" %>

<%
    List<Wishlist> wishlistItems =
        (List<Wishlist>) request.getAttribute("wishlistItems");

    if (wishlistItems == null) {
        wishlistItems = new ArrayList<Wishlist>();
    }

    String contextPath = request.getContextPath();
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
            background: #f8fafc;
            color: #222;
        }

        .navbar {
            background: #fff;
            border-bottom: 1px solid #e5e7eb;
            padding: 18px 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .brand {
            font-size: 24px;
            font-weight: bold;
            color: #115e59;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 22px;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: #333;
            text-decoration: none;
            font-size: 14px;
        }

        .nav-links a:hover {
            color: #0f766e;
        }

        .page-container {
            max-width: 1200px;
            margin: auto;
            padding: 40px 24px;
        }

        .page-title {
            font-size: 30px;
            margin-bottom: 8px;
        }

        .page-subtitle {
            color: #6b7280;
            margin-bottom: 28px;
        }

        .wishlist-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 24px;
        }

        .wishlist-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            overflow: hidden;
            transition: box-shadow 0.2s ease, transform 0.2s ease;
        }

        .wishlist-card:hover {
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            transform: translateY(-3px);
        }

        .image-container {
            position: relative;
            height: 280px;
            background: #f1f5f9;
            overflow: hidden;
        }

        .product-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .image-placeholder {
            height: 100%;
            width: 100%;
            align-items: center;
            justify-content: center;
            padding: 12px;
            color: #6b7280;
            text-align: center;
            background: #f1f5f9;
        }

        .placeholder-visible {
            display: flex;
        }

        .placeholder-hidden {
            display: none;
        }

        .heart-icon {
            position: absolute;
            top: 12px;
            right: 12px;
            background: #fff;
            color: #e11d48;
            border-radius: 50%;
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.12);
        }

        .product-info {
            padding: 16px;
        }

        .product-title {
            font-size: 17px;
            line-height: 1.4;
            margin-bottom: 10px;
            overflow-wrap: anywhere;
        }

        .product-price {
            font-size: 20px;
            font-weight: bold;
            color: #0f766e;
            margin-bottom: 16px;
        }

        .card-actions {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .view-button,
        .remove-button {
            width: 100%;
            padding: 11px;
            border-radius: 7px;
            font-size: 14px;
            text-align: center;
            cursor: pointer;
            font-weight: 600;
        }

        .view-button {
            display: block;
            text-decoration: none;
            color: #fff;
            background: #0f766e;
            border: 1px solid #0f766e;
        }

        .view-button:hover {
            background: #115e59;
        }

        .remove-form {
            width: 100%;
        }

        .remove-button {
            background: #fff;
            color: #be123c;
            border: 1px solid #fecdd3;
        }

        .remove-button:hover {
            background: #fff1f2;
        }

        .empty-wishlist {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 55px 25px;
            text-align: center;
        }

        .empty-wishlist h2 {
            margin-bottom: 12px;
        }

        .empty-wishlist p {
            color: #6b7280;
            margin-bottom: 24px;
        }

        .shop-button {
            display: inline-block;
            padding: 12px 24px;
            background: #0f766e;
            color: #fff;
            text-decoration: none;
            border-radius: 7px;
        }

        .shop-button:hover {
            background: #115e59;
        }

        @media (max-width: 650px) {
            .navbar {
                padding: 16px;
                flex-direction: column;
                gap: 15px;
            }

            .nav-links {
                justify-content: center;
                gap: 15px;
            }

            .page-container {
                padding: 28px 16px;
            }

            .page-title {
                font-size: 26px;
            }

            .wishlist-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 14px;
            }

            .image-container {
                height: 200px;
            }

            .product-info {
                padding: 12px;
            }

            .product-title {
                font-size: 15px;
            }

            .product-price {
                font-size: 18px;
            }

            .view-button,
            .remove-button {
                padding: 9px 5px;
                font-size: 12px;
            }
        }
    </style>
</head>

<body>

<nav class="navbar">
    <a class="brand" href="<%= contextPath %>/">SRI SHOP</a>

    <div class="nav-links">
        <a href="<%= contextPath %>/products">Shop</a>
        <a href="<%= contextPath %>/wishlist">Wishlist</a>
        <a href="<%= contextPath %>/cart">Cart</a>
        <a href="<%= contextPath %>/buyer-dashboard.jsp">Profile</a>
        <a href="<%= contextPath %>/logout">Logout</a>
    </div>
</nav>

<main class="page-container">

    <h1 class="page-title">My Wishlist &#9829;</h1>
    <p class="page-subtitle">
        Your favourite dresses, saved in one place.
    </p>

    <% if (wishlistItems.isEmpty()) { %>

        <div class="empty-wishlist">
            <h2>Your wishlist is empty</h2>
            <p>You haven't added any products to your wishlist yet.</p>

            <a class="shop-button"
               href="<%= contextPath %>/products">
                Continue Shopping
            </a>
        </div>

    <% } else { %>

        <div class="wishlist-grid">

            <% for (Wishlist item : wishlistItems) {

                String productName = item.getProductName();
                String imageUrl = item.getProductImage();

                if (productName == null || productName.trim().isEmpty()) {
                    productName = "Dress #" + item.getProductId();
                }

                boolean hasImage =
                    imageUrl != null && !imageUrl.trim().isEmpty();
            %>

                <article class="wishlist-card">

                    <div class="image-container">

                        <% if (hasImage) { %>

                            <img
                                class="product-image"
                                src="<%= imageUrl %>"
                                alt="<%= productName %>"
                                loading="lazy"
                                onerror="this.style.display='none'; this.nextElementSibling.classList.remove('placeholder-hidden'); this.nextElementSibling.classList.add('placeholder-visible');">

                        <% } %>

                        <div class="image-placeholder <%= hasImage ? "placeholder-hidden" : "placeholder-visible" %>">
                            Dress image unavailable
                        </div>

                        <span class="heart-icon">&#9829;</span>

                    </div>

                    <div class="product-info">

                        <h2 class="product-title">
                            <%= productName %>
                        </h2>

                        <div class="product-price">
                            <% if (item.getProductPrice() != null) { %>

                                &#8377;<%= item.getProductPrice()
                                    .setScale(2, RoundingMode.HALF_UP)
                                    .toPlainString() %>

                            <% } else { %>

                                Price unavailable

                            <% } %>
                        </div>

                        <div class="card-actions">

                            <a class="view-button"
                               href="<%= contextPath %>/product-details?id=<%= item.getProductId() %>">
                                View Dress
                            </a>

                            <form class="remove-form"
                                  method="post"
                                  action="<%= contextPath %>/wishlist"
                                  onsubmit="return confirm('Remove this dress from your wishlist?');">

                                <input type="hidden"
                                       name="action"
                                       value="remove">

                                <input type="hidden"
                                       name="productId"
                                       value="<%= item.getProductId() %>">

                                <button type="submit" class="remove-button">
                                    Remove from Wishlist
                                </button>

                            </form>

                        </div>

                    </div>

                </article>

            <% } %>

        </div>

    <% } %>

</main>

</body>
</html>