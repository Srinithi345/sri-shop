<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    String contextPath = request.getContextPath();

    String userName =
            (String) session.getAttribute("userName");

    if (userName == null) {
        response.sendRedirect(
                contextPath + "/login.jsp"
        );
        return;
    }

    Integer totalOrders =
            (Integer) request.getAttribute("totalOrders");

    Integer totalItems =
            (Integer) request.getAttribute("totalItems");

    Integer differentVarieties =
            (Integer) request.getAttribute("differentVarieties");

    BigDecimal totalSpent =
            (BigDecimal) request.getAttribute("totalSpent");

    Integer cartItemCount =
            (Integer) request.getAttribute("cartItemCount");

    BigDecimal cartTotal =
            (BigDecimal) request.getAttribute("cartTotal");

    List<Map<String, Object>> recentOrders =
            (List<Map<String, Object>>)
                    request.getAttribute("recentOrders");

    List<Map<String, Object>> cartPreview =
            (List<Map<String, Object>>)
                    request.getAttribute("cartPreview");

    if (totalOrders == null) {
        totalOrders = 0;
    }

    if (totalItems == null) {
        totalItems = 0;
    }

    if (differentVarieties == null) {
        differentVarieties = 0;
    }

    if (totalSpent == null) {
        totalSpent = BigDecimal.ZERO;
    }

    if (cartItemCount == null) {
        cartItemCount = 0;
    }

    if (cartTotal == null) {
        cartTotal = BigDecimal.ZERO;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>SRI SHOP - Buyer Dashboard</title>

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

/* =========================
   HEADER
========================= */

.header {
    position: sticky;
    top: 0;
    z-index: 1000;

    background: #0f766e;
    color: white;

    min-height: 72px;

    padding: 12px 30px;

    display: flex;
    align-items: center;
    gap: 25px;

    box-shadow:
        0 4px 15px
        rgba(0, 0, 0, 0.14);
}

.logo {
    font-size: 23px;
    font-weight: bold;

    white-space: nowrap;

    letter-spacing: 0.3px;
}

/* SEARCH */

.search-form {
    flex: 1;

    display: flex;

    max-width: 430px;

    height: 42px;
}

.search-form input {
    flex: 1;

    border: none;
    outline: none;

    padding: 11px 14px;

    border-radius: 8px 0 0 8px;

    font-size: 14px;

    min-width: 100px;
}

.search-form input:focus {
    box-shadow:
        0 0 0 2px
        rgba(255, 255, 255, 0.35);
}

.search-form button {
    width: 48px;

    border: none;

    background: white;

    color: #0f766e;

    border-radius: 0 8px 8px 0;

    cursor: pointer;

    font-size: 18px;

    transition: 0.2s;
}

.search-form button:hover {
    background: #ccfbf1;
}

/* NAVIGATION */

.nav {
    display: flex;
    align-items: center;

    gap: 8px;

    margin-left: auto;
}

.nav a {
    position: relative;

    color: white;

    text-decoration: none;

    font-size: 13px;

    font-weight: bold;

    white-space: nowrap;

    padding: 9px 10px;

    border-radius: 8px;

    display: flex;
    align-items: center;
    gap: 5px;

    transition:
        background 0.2s,
        transform 0.2s;
}

.nav a:hover {
    background: rgba(255, 255, 255, 0.14);

    transform: translateY(-1px);
}

.nav a:last-child {
    background: rgba(255, 255, 255, 0.12);
}

.nav a:last-child:hover {
    background: rgba(255, 255, 255, 0.22);
}

/* CART BADGE */

.cart-badge {
    min-width: 20px;
    height: 20px;

    padding: 2px 6px;

    border-radius: 20px;

    background: #ef4444;

    color: white;

    font-size: 11px;

    display: inline-flex;
    align-items: center;
    justify-content: center;
}

/* =========================
   WELCOME
========================= */

.welcome {
    max-width: 1200px;

    margin: 35px auto 20px;

    padding: 0 20px;
}

.welcome h1 {
    margin: 0 0 8px;

    color: #115e59;
}

.welcome p {
    margin: 0;

    color: #64748b;
}

/* =========================
   MAIN
========================= */

.container {
    max-width: 1200px;

    margin: auto;

    padding: 0 20px 50px;
}

/* =========================
   SUMMARY CARDS
========================= */

.summary-grid {
    display: grid;

    grid-template-columns:
        repeat(4, 1fr);

    gap: 18px;

    margin-top: 25px;
}

.summary-card {
    background: white;

    padding: 22px;

    border-radius: 16px;

    box-shadow:
        0 8px 25px
        rgba(0, 0, 0, 0.06);

    transition:
        transform 0.2s,
        box-shadow 0.2s;
}

.summary-card:hover {
    transform: translateY(-3px);

    box-shadow:
        0 12px 30px
        rgba(0, 0, 0, 0.09);
}

.summary-icon {
    font-size: 28px;

    margin-bottom: 10px;
}

.summary-title {
    color: #64748b;

    font-size: 14px;

    margin-bottom: 8px;
}

.summary-value {
    color: #0f766e;

    font-size: 26px;

    font-weight: bold;
}

/* =========================
   QUICK ACTIONS
========================= */

.section-title {
    margin-top: 35px;

    margin-bottom: 16px;

    color: #115e59;
}

.quick-actions {
    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    gap: 18px;
}

.action-card {
    background: white;

    padding: 22px;

    border-radius: 16px;

    text-decoration: none;

    color: #134e4a;

    box-shadow:
        0 8px 25px
        rgba(0, 0, 0, 0.06);

    transition:
        transform 0.2s,
        box-shadow 0.2s;
}

.action-card:hover {
    transform: translateY(-3px);

    box-shadow:
        0 12px 30px
        rgba(0, 0, 0, 0.10);
}

.action-icon {
    font-size: 30px;

    margin-bottom: 10px;
}

.action-title {
    font-size: 18px;

    font-weight: bold;

    margin-bottom: 5px;
}

.action-description {
    color: #64748b;

    font-size: 13px;
}

/* =========================
   TWO COLUMNS
========================= */

.two-columns {
    display: grid;

    grid-template-columns:
        1fr 1fr;

    gap: 20px;

    margin-top: 25px;
}

.panel {
    background: white;

    border-radius: 16px;

    padding: 22px;

    box-shadow:
        0 8px 25px
        rgba(0, 0, 0, 0.06);
}

.panel h2 {
    margin-top: 0;

    color: #115e59;

    font-size: 19px;
}

/* =========================
   ORDERS
========================= */

.order-item {
    padding: 13px 0;

    border-bottom:
        1px solid #e2e8f0;
}

.order-item:last-child {
    border-bottom: none;
}

.order-number {
    font-weight: bold;

    color: #0f766e;
}

.order-info {
    color: #64748b;

    font-size: 13px;

    margin-top: 4px;
}

/* =========================
   CART
========================= */

.cart-item {
    display: flex;

    justify-content: space-between;

    gap: 15px;

    padding: 13px 0;

    border-bottom:
        1px solid #e2e8f0;
}

.cart-item:last-child {
    border-bottom: none;
}

.cart-name {
    font-weight: bold;
}

.cart-details {
    color: #64748b;

    font-size: 13px;

    margin-top: 4px;
}

.cart-price {
    color: #0f766e;

    font-weight: bold;

    white-space: nowrap;
}

.empty {
    color: #64748b;

    padding: 15px 0;
}

.cart-total {
    margin-top: 15px;

    padding-top: 15px;

    border-top:
        2px solid #e2e8f0;

    display: flex;

    justify-content: space-between;

    font-weight: bold;
}

.cart-total-value {
    color: #0f766e;
}

/* =========================
   VIEW BUTTON
========================= */

.view-btn {
    display: inline-block;

    margin-top: 12px;

    background: #0f766e;

    color: white;

    padding: 9px 15px;

    border-radius: 7px;

    text-decoration: none;

    font-size: 13px;

    font-weight: bold;

    transition: 0.2s;
}

.view-btn:hover {
    background: #115e59;

    transform: translateY(-1px);
}

/* =========================
   CHAT
========================= */

.chat-button {
    position: fixed;

    right: 25px;

    bottom: 25px;

    width: 60px;
    height: 60px;

    border-radius: 50%;

    border: none;

    background: #0f766e;

    color: white;

    font-size: 24px;

    cursor: pointer;

    box-shadow:
        0 8px 25px
        rgba(0, 0, 0, 0.20);

    z-index: 2000;

    transition: 0.2s;
}

.chat-button:hover {
    transform: scale(1.06);

    background: #115e59;
}

.chat-window {
    display: none;

    position: fixed;

    right: 25px;

    bottom: 95px;

    width: 360px;

    height: 500px;

    background: white;

    border-radius: 16px;

    box-shadow:
        0 12px 40px
        rgba(0, 0, 0, 0.20);

    overflow: hidden;

    z-index: 2000;
}

.chat-header {
    background: #0f766e;

    color: white;

    padding: 15px;

    font-weight: bold;
}

.chat-body {
    height: calc(100% - 55px);

    padding: 15px;

    overflow-y: auto;

    color: #475569;

    font-size: 14px;
}

.bot-message {
    background: #f0fdfa;

    padding: 12px;

    border-radius: 10px;

    margin-bottom: 10px;
}

/* =========================
   RESPONSIVE
========================= */

@media (max-width: 1100px) {

    .header {
        flex-wrap: wrap;
    }

    .search-form {
        order: 3;

        max-width: none;

        width: 100%;
    }

    .nav {
        margin-left: 0;

        overflow-x: auto;

        width: 100%;

        padding-bottom: 2px;
    }

    .summary-grid {
        grid-template-columns:
            repeat(2, 1fr);
    }

    .quick-actions {
        grid-template-columns:
            repeat(2, 1fr);
    }
}

@media (max-width: 700px) {

    .header {
        padding: 14px 18px;

        gap: 12px;
    }

    .logo {
        font-size: 19px;
    }

    .nav {
        width: 100%;

        gap: 5px;

        overflow-x: auto;
    }

    .nav a {
        font-size: 12px;

        padding: 8px 7px;
    }

    .nav a span {
        display: inline;
    }

    .summary-grid,
    .quick-actions,
    .two-columns {
        grid-template-columns: 1fr;
    }

    .welcome {
        margin-top: 25px;
    }

    .chat-window {
        right: 12px;

        bottom: 85px;

        width: calc(100% - 24px);
    }

    .chat-button {
        right: 18px;

        bottom: 18px;
    }
}

@media (max-width: 450px) {

    .nav {
        gap: 2px;
    }

    .nav a {
        padding: 7px 5px;

        font-size: 11px;
    }

    .logo {
        width: 100%;
    }

    .search-form {
        width: 100%;
    }
}

</style>

</head>

<body>


<!-- =========================
     HEADER
========================= -->

<header class="header">

    <div class="logo">
        &#128722; SRI SHOP
    </div>


    <form class="search-form"
          action="<%= contextPath %>/products"
          method="get">

        <input
            type="text"
            name="search"
            placeholder="Search dresses..."
            autocomplete="off">

        <button type="submit">
            &#128269;
        </button>

    </form>


    <nav class="nav">

        <a href="<%= contextPath %>/products"
           title="Shop">

            &#128087;

            <span>
                Shop
            </span>

        </a>


        <a href="<%= contextPath %>/products?category=Accessories"
           title="Accessories">

            &#128091;

            <span>
                Accessories
            </span>

        </a>


        <a href="<%= contextPath %>/wishlist"
           title="Wishlist">

            &#10084;&#65039;

            <span>
                Wishlist
            </span>

        </a>


        <a href="<%= contextPath %>/cart"
           title="Cart">

            &#128722;

            <span>
                Cart
            </span>

            <% if (cartItemCount > 0) { %>

                <b class="cart-badge">
                    <%= cartItemCount %>
                </b>

            <% } %>

        </a>


        <a href="<%= contextPath %>/profile"
           title="Profile">

            &#128100;

            <span>
                Profile
            </span>

        </a>


        <a href="<%= contextPath %>/logout"
           title="Logout">

            Logout

        </a>

    </nav>

</header>


<!-- =========================
     WELCOME
========================= -->

<div class="welcome">

    <h1>
        Welcome back, <%= userName %> &#128075;
    </h1>

    <p>
        Manage your shopping, orders and favourite dresses from one place.
    </p>

</div>


<div class="container">


    <!-- =========================
         SUMMARY
    ========================= -->

    <div class="summary-grid">


        <div class="summary-card">

            <div class="summary-icon">
                &#128230;
            </div>

            <div class="summary-title">
                Total Orders
            </div>

            <div class="summary-value">
                <%= totalOrders %>
            </div>

        </div>


        <div class="summary-card">

            <div class="summary-icon">
                &#128087;
            </div>

            <div class="summary-title">
                Total Items
            </div>

            <div class="summary-value">
                <%= totalItems %>
            </div>

        </div>


        <div class="summary-card">

            <div class="summary-icon">
                &#128717;
            </div>

            <div class="summary-title">
                Different Varieties
            </div>

            <div class="summary-value">
                <%= differentVarieties %>
            </div>

        </div>


        <div class="summary-card">

            <div class="summary-icon">
                &#128176;
            </div>

            <div class="summary-title">
                Total Spent
            </div>

            <div class="summary-value">
                &#8377;<%= totalSpent %>
            </div>

        </div>

    </div>


    <!-- =========================
         QUICK ACTIONS
    ========================= -->

    <h2 class="section-title">
        Quick Actions
    </h2>


    <div class="quick-actions">


        <a class="action-card"
           href="<%= contextPath %>/products">

            <div class="action-icon">
                &#128087;
            </div>

            <div class="action-title">
                Browse Dresses
            </div>

            <div class="action-description">
                Explore all available dresses and styles.
            </div>

        </a>


        <a class="action-card"
           href="<%= contextPath %>/cart">

            <div class="action-icon">
                &#128722;
            </div>

            <div class="action-title">
                My Cart
            </div>

            <div class="action-description">
                View and manage items in your cart.
            </div>

        </a>


        <a class="action-card"
           href="<%= contextPath %>/orders">

            <div class="action-icon">
                &#128230;
            </div>

            <div class="action-title">
                My Orders
            </div>

            <div class="action-description">
                Track your previous orders and purchases.
            </div>

        </a>

    </div>


    <!-- =========================
         RECENT ORDERS + CART
    ========================= -->

    <div class="two-columns">


        <div class="panel">

            <h2>
                &#128230; Recent Orders
            </h2>


            <%
                if (recentOrders != null
                        && !recentOrders.isEmpty()) {

                    for (Map<String, Object> order :
                            recentOrders) {
            %>


                <div class="order-item">

                    <div class="order-number">

                        Order #<%= order.get("order_id") %>

                    </div>


                    <div class="order-info">

                        Status:
                        <%= order.get("status") %>

                    </div>


                    <div class="order-info">

                        Total:
                        &#8377;<%= order.get("total_amount") %>

                    </div>

                </div>


            <%
                    }

                } else {
            %>


                <div class="empty">
                    No orders yet.
                </div>


            <%
                }
            %>


            <a class="view-btn"
               href="<%= contextPath %>/orders">

                View All Orders

            </a>

        </div>


        <div class="panel">

            <h2>
                &#128722; Cart Preview
            </h2>


            <%
                if (cartPreview != null
                        && !cartPreview.isEmpty()) {

                    for (Map<String, Object> item :
                            cartPreview) {
            %>


                <div class="cart-item">

                    <div>

                        <div class="cart-name">

                            <%= item.get("product_name") %>

                        </div>


                        <div class="cart-details">

                            Quantity:
                            <%= item.get("quantity") %>

                        </div>

                    </div>


                    <div class="cart-price">

                        &#8377;<%= item.get("subtotal") %>

                    </div>

                </div>


            <%
                    }

                } else {
            %>


                <div class="empty">
                    Your cart is empty.
                </div>


            <%
                }
            %>


            <div class="cart-total">

                <span>
                    Cart Total
                </span>

                <span class="cart-total-value">
                    &#8377;<%= cartTotal %>
                </span>

            </div>


            <a class="view-btn"
               href="<%= contextPath %>/cart">

                View Cart

            </a>

        </div>

    </div>

</div>


<!-- =========================
     CHAT BUTTON
========================= -->

<button
    class="chat-button"
    onclick="toggleChat()">

    &#128172;

</button>


<!-- =========================
     CHAT WINDOW
========================= -->

<div
    id="chatWindow"
    class="chat-window">


    <div class="chat-header">

        &#129302; SRI BOT

    </div>


    <div class="chat-body">


        <div class="bot-message">

            Hello <%= userName %>! &#128075;

            <br><br>

            Welcome to SRI SHOP.

            <br><br>

            How can I help you today?

        </div>


        <div class="bot-message">

            You can browse dresses,
            check your cart,
            view orders,
            or explore Accessories.

        </div>

    </div>

</div>


<script>

function toggleChat() {

    const chat =
        document.getElementById("chatWindow");

    if (chat.style.display === "block") {

        chat.style.display = "none";

    } else {

        chat.style.display = "block";

    }

}

</script>


</body>

</html>