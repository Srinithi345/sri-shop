<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String userName = (String) session.getAttribute("userName");

    if (userName == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Integer totalOrders =
            (Integer) request.getAttribute("totalOrders");

    Integer totalItems =
            (Integer) request.getAttribute("totalItems");

    Integer differentVarieties =
            (Integer) request.getAttribute("differentVarieties");

    java.math.BigDecimal totalSpent =
            (java.math.BigDecimal) request.getAttribute("totalSpent");

    Integer cartItemCount =
            (Integer) request.getAttribute("cartItemCount");

    java.math.BigDecimal cartTotal =
            (java.math.BigDecimal) request.getAttribute("cartTotal");

    java.util.List<java.util.Map<String, Object>> recentOrders =
            (java.util.List<java.util.Map<String, Object>>)
                    request.getAttribute("recentOrders");

    java.util.List<java.util.Map<String, Object>> cartPreview =
            (java.util.List<java.util.Map<String, Object>>)
                    request.getAttribute("cartPreview");

    if (totalOrders == null) totalOrders = 0;
    if (totalItems == null) totalItems = 0;
    if (differentVarieties == null) differentVarieties = 0;

    if (totalSpent == null)
        totalSpent = java.math.BigDecimal.ZERO;

    if (cartItemCount == null)
        cartItemCount = 0;

    if (cartTotal == null)
        cartTotal = java.math.BigDecimal.ZERO;
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>SRI SHOP - Buyer Dashboard</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f8fafc;
    color: #134e4a;
}

/* =========================================
   HEADER
========================================= */

.header {
    background: #0f766e;
    color: white;
    padding: 15px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: sticky;
    top: 0;
    z-index: 100;
}

.logo {
    font-size: 25px;
    font-weight: bold;
    white-space: nowrap;
}

.header-right {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 6px;
    flex-wrap: wrap;
}

/* =========================================
   SEARCH FORM
========================================= */

.search-form {
    display: flex;
    align-items: center;
    background: white;
    border-radius: 22px;
    overflow: hidden;
    height: 40px;
    margin: 0 3px;
}

.search-input {
    width: 180px;
    height: 40px;
    border: none;
    outline: none;
    padding: 9px 12px;
    font-size: 14px;
    color: #134e4a;
    background: white;
}

.search-input::placeholder {
    color: #94a3b8;
}

.search-button {
    height: 40px;
    width: 42px;
    border: none;
    background: white;
    color: #0f766e;
    cursor: pointer;
    font-size: 16px;
    transition: background 0.2s ease;
}

.search-button:hover {
    background: #f1f5f9;
}

/* =========================================
   NAVIGATION LINKS
========================================= */

.nav-link {
    color: white;
    text-decoration: none;
    font-weight: bold;
    padding: 9px 11px;
    border-radius: 8px;
    transition: background 0.2s ease;
    white-space: nowrap;
}

.nav-link:hover {
    background: rgba(255,255,255,0.15);
}

/* CART */

.cart-top {
    background: white;
    color: #0f766e;
    padding: 9px 15px;
    border-radius: 20px;
    text-decoration: none;
    font-weight: bold;
    white-space: nowrap;
    transition: transform 0.2s ease;
}

.cart-top:hover {
    transform: translateY(-1px);
}

/* PROFILE */

.profile-link {
    color: white;
    text-decoration: none;
    font-weight: bold;
    padding: 9px 11px;
    border-radius: 8px;
    white-space: nowrap;
}

.profile-link:hover {
    background: rgba(255,255,255,0.15);
}

/* LOGOUT */

.logout {
    color: white;
    text-decoration: none;
    font-weight: bold;
    padding: 9px 11px;
    border-radius: 8px;
    white-space: nowrap;
}

.logout:hover {
    background: rgba(255,255,255,0.15);
}

/* =========================================
   MAIN
========================================= */

.container {
    max-width: 1200px;
    margin: 35px auto;
    padding: 0 20px;
}

/* =========================================
   WELCOME
========================================= */

.welcome {
    background: linear-gradient(135deg, #0f766e, #115e59);
    color: white;
    padding: 35px;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.10);
}

.welcome h1 {
    margin: 0 0 8px;
    font-size: 30px;
}

.welcome p {
    margin: 0;
    opacity: 0.9;
}

/* =========================================
   SECTION
========================================= */

.section-title {
    margin: 32px 0 18px;
    font-size: 22px;
    color: #115e59;
}

/* =========================================
   SUMMARY
========================================= */

.summary-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
}

.summary-card {
    background: white;
    padding: 22px;
    border-radius: 16px;
    box-shadow: 0 7px 22px rgba(0,0,0,0.07);
}

.summary-icon {
    font-size: 28px;
}

.summary-number {
    font-size: 27px;
    font-weight: bold;
    color: #0f766e;
    margin-top: 8px;
}

.summary-label {
    color: #64748b;
    margin-top: 5px;
}

/* =========================================
   ACTIONS
========================================= */

.actions {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
}

.action-card {
    background: white;
    padding: 22px;
    border-radius: 16px;
    text-align: center;
    box-shadow: 0 7px 22px rgba(0,0,0,0.07);
}

.action-icon {
    font-size: 38px;
}

.action-card h3 {
    margin: 10px 0;
}

.btn {
    display: inline-block;
    background: #0f766e;
    color: white;
    padding: 10px 18px;
    border-radius: 9px;
    text-decoration: none;
    font-weight: bold;
    margin-top: 8px;
}

.btn:hover {
    background: #115e59;
}

/* =========================================
   DASHBOARD PANELS
========================================= */

.dashboard-grid {
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 22px;
    margin-top: 25px;
}

.panel {
    background: white;
    padding: 25px;
    border-radius: 18px;
    box-shadow: 0 7px 22px rgba(0,0,0,0.07);
}

.panel h2 {
    margin-top: 0;
    color: #115e59;
}

/* =========================================
   ORDERS
========================================= */

.order {
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

.order-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
}

.status {
    background: #ccfbf1;
    color: #0f766e;
    padding: 5px 10px;
    border-radius: 15px;
    font-size: 12px;
}

.order-details {
    color: #64748b;
    margin-top: 8px;
    font-size: 14px;
    line-height: 1.7;
}

/* =========================================
   CART
========================================= */

.cart-item {
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 14px;
    margin-bottom: 12px;
}

.cart-name {
    font-weight: bold;
    color: #134e4a;
    font-size: 16px;
}

.cart-details {
    color: #64748b;
    font-size: 13px;
    margin-top: 7px;
    line-height: 1.6;
}

.cart-price {
    color: #0f766e;
    font-weight: bold;
    margin-top: 7px;
}

.cart-total {
    border-top: 2px solid #e2e8f0;
    margin-top: 15px;
    padding-top: 15px;
    display: flex;
    justify-content: space-between;
    font-weight: bold;
}

.empty {
    text-align: center;
    color: #64748b;
    padding: 25px 5px;
}

.empty-icon {
    font-size: 45px;
    margin-bottom: 8px;
}

/* =========================================
   SRI BOT BUTTON
========================================= */

.chat-button {
    position: fixed;
    right: 25px;
    bottom: 25px;
    width: 62px;
    height: 62px;
    border-radius: 50%;
    border: none;
    background: #0f766e;
    color: white;
    font-size: 27px;
    cursor: pointer;
    box-shadow: 0 8px 25px rgba(0,0,0,0.20);
    z-index: 1000;
}

/* =========================================
   SRI BOT WINDOW
========================================= */

.bot-window {
    display: none;
    position: fixed;
    right: 25px;
    bottom: 100px;
    width: 360px;
    height: 500px;
    background: white;
    border-radius: 18px;
    box-shadow: 0 15px 45px rgba(0,0,0,0.25);
    overflow: hidden;
    z-index: 999;
}

.bot-header {
    background: #0f766e;
    color: white;
    padding: 16px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.bot-header strong {
    font-size: 18px;
}

.bot-header small {
    display: block;
    margin-top: 3px;
    opacity: 0.8;
}

.bot-close {
    border: none;
    background: transparent;
    color: white;
    font-size: 25px;
    cursor: pointer;
}

.bot-messages {
    height: 390px;
    overflow-y: auto;
    padding: 15px;
    background: #f8fafc;
}

.bot-message {
    background: #ccfbf1;
    color: #134e4a;
    padding: 12px;
    border-radius: 12px;
    margin-bottom: 12px;
    line-height: 1.5;
    font-size: 14px;
}

.user-message {
    background: #0f766e;
    color: white;
    padding: 12px;
    border-radius: 12px;
    margin: 10px 0 10px auto;
    max-width: 85%;
    line-height: 1.5;
    font-size: 14px;
}

.quick-buttons {
    display: flex;
    flex-wrap: wrap;
    gap: 7px;
}

.quick-buttons button {
    border: 1px solid #0f766e;
    background: white;
    color: #0f766e;
    padding: 7px 9px;
    border-radius: 15px;
    cursor: pointer;
    font-size: 12px;
}

.quick-buttons button:hover {
    background: #ccfbf1;
}

.bot-input {
    height: 60px;
    display: flex;
    padding: 10px;
    gap: 8px;
    border-top: 1px solid #e2e8f0;
}

.bot-input input {
    flex: 1;
    border: 1px solid #cbd5e1;
    border-radius: 20px;
    padding: 10px 14px;
    outline: none;
}

.bot-input button {
    width: 42px;
    border: none;
    border-radius: 50%;
    background: #0f766e;
    color: white;
    cursor: pointer;
    font-size: 17px;
}

/* =========================================
   MOBILE
========================================= */

@media (max-width: 1000px) {

    .header {
        padding: 15px 25px;
    }

    .header-right {
        gap: 4px;
    }

    .nav-link,
    .profile-link,
    .logout {
        padding: 8px 7px;
        font-size: 14px;
    }

    .cart-top {
        padding: 8px 12px;
        font-size: 14px;
    }

    .search-input {
        width: 150px;
    }

    .summary-grid,
    .actions {
        grid-template-columns: repeat(2, 1fr);
    }

    .dashboard-grid {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 700px) {

    .header {
        position: relative;
        flex-direction: column;
        align-items: stretch;
        gap: 12px;
        padding: 15px 20px;
    }

    .logo {
        text-align: center;
    }

    .header-right {
        justify-content: center;
    }

    /* MOBILE SEARCH */

    .search-form {
        width: 100%;
        grid-column: 1 / -1;
    }

    .search-input {
        width: 100%;
        flex: 1;
    }

    .nav-link,
    .profile-link,
    .logout {
        font-size: 13px;
        padding: 7px 6px;
    }

    .cart-top {
        font-size: 13px;
        padding: 7px 10px;
    }

    .summary-grid,
    .actions {
        grid-template-columns: 1fr;
    }

    .welcome {
        padding: 25px;
    }

    .welcome h1 {
        font-size: 24px;
    }

    .bot-window {
        right: 10px;
        bottom: 90px;
        width: calc(100% - 20px);
        height: 480px;
    }
}

@media (max-width: 450px) {

    .header-right {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        width: 100%;
    }

    /* SEARCH TAKES FULL ROW */

    .search-form {
        width: 100%;
        grid-column: 1 / -1;
    }

    .search-input {
        width: 100%;
    }

    .nav-link,
    .profile-link,
    .logout,
    .cart-top {
        text-align: center;
        width: 100%;
    }

}

</style>

</head>

<body>

<!-- =========================================
     HEADER / NAVIGATION
========================================= -->

<div class="header">

    <div class="logo">
        🛍️ SRI SHOP
    </div>

    <div class="header-right">

        <!-- SEARCH -->

        <form
            class="search-form"
            action="${pageContext.request.contextPath}/products"
            method="get">

            <input
                type="text"
                name="search"
                class="search-input"
                placeholder="Search dresses..."
                autocomplete="off">

            <button
                type="submit"
                class="search-button">

                🔍

            </button>

        </form>


        <!-- ACCESSORIES -->

        <a
            class="nav-link"
            href="${pageContext.request.contextPath}/products">

            👜 Accessories

        </a>


        <!-- WISHLIST -->

        <a
            class="nav-link"
            href="${pageContext.request.contextPath}/wishlist">

            ❤️ Wishlist

        </a>


        <!-- CART -->

        <a
            class="cart-top"
            href="${pageContext.request.contextPath}/cart">

            🛒 Cart

            <% if (cartItemCount > 0) { %>
                (<%= cartItemCount %>)
            <% } %>

        </a>


        <!-- PROFILE -->

        <a
            class="profile-link"
            href="${pageContext.request.contextPath}/buyer-dashboard">

            👤 Profile

        </a>


        <!-- LOGOUT -->

        <a
            class="logout"
            href="${pageContext.request.contextPath}/logout">

            Logout

        </a>

    </div>

</div>


<!-- =========================================
     MAIN CONTAINER
========================================= -->

<div class="container">


<!-- =========================================
     WELCOME
========================================= -->

<div class="welcome">

    <h1>
        Welcome back, <%= userName %>! 👋
    </h1>

    <p>
        Manage your shopping, orders and favourite dresses from one place.
    </p>

</div>


<!-- =========================================
     SUMMARY
========================================= -->

<h2 class="section-title">
    📊 Your Shopping Summary
</h2>

<div class="summary-grid">

    <div class="summary-card">

        <div class="summary-icon">
            📦
        </div>

        <div class="summary-number">
            <%= totalOrders %>
        </div>

        <div class="summary-label">
            Total Orders
        </div>

    </div>


    <div class="summary-card">

        <div class="summary-icon">
            🛍️
        </div>

        <div class="summary-number">
            <%= totalItems %>
        </div>

        <div class="summary-label">
            Total Items
        </div>

    </div>


    <div class="summary-card">

        <div class="summary-icon">
            🎨
        </div>

        <div class="summary-number">
            <%= differentVarieties %>
        </div>

        <div class="summary-label">
            Different Varieties
        </div>

    </div>


    <div class="summary-card">

        <div class="summary-icon">
            💰
        </div>

        <div class="summary-number">
            ₹<%= totalSpent %>
        </div>

        <div class="summary-label">
            Total Spent
        </div>

    </div>

</div>


<!-- =========================================
     QUICK ACTIONS
========================================= -->

<h2 class="section-title">
    ⚡ Quick Actions
</h2>

<div class="actions">

    <div class="action-card">

        <div class="action-icon">
            👗
        </div>

        <h3>
            Browse Dresses
        </h3>

        <a
            class="btn"
            href="${pageContext.request.contextPath}/products">

            Shop Now

        </a>

    </div>


    <div class="action-card">

        <div class="action-icon">
            🛒
        </div>

        <h3>
            My Cart
        </h3>

        <a
            class="btn"
            href="${pageContext.request.contextPath}/cart">

            View Cart

        </a>

    </div>


    <div class="action-card">

        <div class="action-icon">
            📦
        </div>

        <h3>
            My Orders
        </h3>

        <a
            class="btn"
            href="${pageContext.request.contextPath}/orders">

            View Orders

        </a>

    </div>


    <div class="action-card">

        <div class="action-icon">
            ⭐
        </div>

        <h3>
            My Reviews
        </h3>

        <a
            class="btn"
            href="${pageContext.request.contextPath}/reviews">

            View Reviews

        </a>

    </div>

</div>


<!-- =========================================
     RECENT ORDERS + CART
========================================= -->

<div class="dashboard-grid">


<!-- =========================================
     RECENT ORDERS
========================================= -->

<div class="panel">

    <h2>
        📦 Recent Orders
    </h2>

    <%

    if (recentOrders != null &&
        !recentOrders.isEmpty()) {

        for (java.util.Map<String, Object> order
                : recentOrders) {

            Object orderId =
                    order.get("orderId");

            Object amount =
                    order.get("totalAmount");

            Object status =
                    order.get("status");

            Object createdAt =
                    order.get("createdAt");

    %>

    <div class="order">

        <div class="order-top">

            <span>
                Order #<%= orderId %>
            </span>

            <span class="status">
                <%= status != null ? status : "PENDING" %>
            </span>

        </div>

        <div class="order-details">

            💰 Total:
            ₹<%= amount != null ? amount : "0.00" %>

            <br>

            📅 Date:
            <%= createdAt != null ? createdAt : "-" %>

        </div>

    </div>

    <%

        }

    } else {

    %>

    <div class="empty">

        <div class="empty-icon">
            📦
        </div>

        <strong>
            No recent orders
        </strong>

        <div style="margin-top:8px;">
            Your latest orders will appear here.
        </div>

    </div>

    <%

    }

    %>

    <a
        class="btn"
        href="${pageContext.request.contextPath}/orders">

        View All Orders

    </a>

</div>


<!-- =========================================
     CART PREVIEW
========================================= -->

<div class="panel">

    <h2>
        🛒 Cart Preview
    </h2>

    <%

    if (cartPreview != null &&
        !cartPreview.isEmpty()) {

        for (java.util.Map<String, Object> item
                : cartPreview) {

            Object name =
                    item.get("name");

            Object price =
                    item.get("price");

            Object size =
                    item.get("size");

            Object color =
                    item.get("color");

            Object quantity =
                    item.get("quantity");

            Object itemTotal =
                    item.get("itemTotal");

    %>

    <div class="cart-item">

        <div class="cart-name">

            👗 <%= name != null ? name : "Product" %>

        </div>

        <div class="cart-details">

            📏 Size:
            <%= size != null ? size : "-" %>

            <br>

            🎨 Color:
            <%= color != null ? color : "-" %>

            <br>

            🔢 Quantity:
            <%= quantity != null ? quantity : 0 %>

        </div>

        <div class="cart-price">

            ₹<%= price != null ? price : "0.00" %>

            ×

            <%= quantity != null ? quantity : 0 %>

            =

            ₹<%= itemTotal != null ? itemTotal : "0.00" %>

        </div>

    </div>

    <%

        }

    %>

    <div class="cart-total">

        <span>
            Cart Total
        </span>

        <span>
            ₹<%= cartTotal %>
        </span>

    </div>

    <%

    } else {

    %>

    <div class="empty">

        <div class="empty-icon">
            🛒
        </div>

        <strong>
            Your cart is empty
        </strong>

        <div style="margin-top:8px;">
            Add your favourite dresses to the cart.
        </div>

    </div>

    <%

    }

    %>

    <a
        class="btn"
        href="${pageContext.request.contextPath}/cart">

        Open Cart

    </a>

</div>

</div>

</div>


<!-- =========================================
     SRI BOT BUTTON
========================================= -->

<button
    class="chat-button"
    onclick="openSriBot()"
    title="SriBot AI">

    🤖

</button>


<!-- =========================================
     SRI BOT WINDOW
========================================= -->

<div id="sriBot" class="bot-window">

    <div class="bot-header">

        <div>

            <strong>
                🤖 SriBot
            </strong>

            <small>
                SRI SHOP Assistant
            </small>

        </div>

        <button
            class="bot-close"
            onclick="closeSriBot()">

            ×

        </button>

    </div>


    <div id="botMessages" class="bot-messages">

        <div class="bot-message">

            👋 Hi! I'm SriBot.

            <br><br>

            How can I help you today?

        </div>


        <div class="quick-buttons">

            <button
                onclick="sendQuickMessage('How can I check my orders?')">

                📦 My Orders

            </button>


            <button
                onclick="sendQuickMessage('How do I add a product to cart?')">

                🛒 Cart Help

            </button>


            <button
                onclick="sendQuickMessage('What payment methods are available?')">

                💳 Payment

            </button>


            <button
                onclick="sendQuickMessage('How can I write a review?')">

                ⭐ Reviews

            </button>

        </div>

    </div>


    <div class="bot-input">

        <input
            type="text"
            id="botInput"
            placeholder="Ask SriBot..."
            onkeydown="if(event.key === 'Enter') sendBotMessage();">

        <button onclick="sendBotMessage()">
            ➤
        </button>

    </div>

</div>


<!-- =========================================
     SRI BOT JAVASCRIPT
========================================= -->

<script>

function openSriBot() {

    document.getElementById("sriBot").style.display = "block";

    document.getElementById("botInput").focus();

}


function closeSriBot() {

    document.getElementById("sriBot").style.display = "none";

}


function sendQuickMessage(message) {

    document.getElementById("botInput").value = message;

    sendBotMessage();

}


function sendBotMessage() {

    const input =
        document.getElementById("botInput");

    const message =
        input.value.trim();

    if (message === "") {
        return;
    }

    addUserMessage(message);

    input.value = "";

    setTimeout(function() {

        const reply =
            getSriBotReply(message);

        addBotMessage(reply);

    }, 400);

}


function addUserMessage(message) {

    const messages =
        document.getElementById("botMessages");

    const div =
        document.createElement("div");

    div.className = "user-message";

    div.innerText = message;

    messages.appendChild(div);

    messages.scrollTop =
        messages.scrollHeight;

}


function addBotMessage(message) {

    const messages =
        document.getElementById("botMessages");

    const div =
        document.createElement("div");

    div.className = "bot-message";

    div.innerHTML = message;

    messages.appendChild(div);

    messages.scrollTop =
        messages.scrollHeight;

}


function getSriBotReply(message) {

    const text =
        message.toLowerCase();


    if (
        text.includes("order") ||
        text.includes("orders")
    ) {

        return "📦 You can check your orders from <b>My Orders</b>. Your recent orders are also shown on the dashboard.";

    }


    if (
        text.includes("cart") ||
        text.includes("add")
    ) {

        return "🛒 Browse our dresses, select your size and color, then click <b>Add to Cart</b>. You can view your cart anytime.";

    }


    if (
        text.includes("payment") ||
        text.includes("pay")
    ) {

        return "💳 Currently, <b>Cash on Delivery (COD)</b> is available. Online payment integration can be added later.";

    }


    if (
        text.includes("review") ||
        text.includes("rating")
    ) {

        return "⭐ You can use the <b>My Reviews</b> section to view and manage your product reviews.";

    }


    if (
        text.includes("product") ||
        text.includes("dress")
    ) {

        return "👗 You can browse available dresses using the <b>Browse Dresses</b> option.";

    }


    if (
        text.includes("hello") ||
        text.includes("hi") ||
        text.includes("hey")
    ) {

        return "👋 Hello! Welcome to Sri Shop. How can I help you?";

    }


    if (
        text.includes("thank")
    ) {

        return "😊 You're welcome! Happy shopping with Sri Shop!";

    }


    return "🤖 I can help you with <b>products, cart, orders, payments and reviews</b>. Try asking about one of these.";

}

</script>

</body>

</html>