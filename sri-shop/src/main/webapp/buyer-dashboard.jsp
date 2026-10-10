
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    String contextPath = request.getContextPath();
    String userName = (String) session.getAttribute("userName");

    if (userName == null) {
        response.sendRedirect(contextPath + "/login.jsp");
        return;
    }

    Integer totalOrders = (Integer) request.getAttribute("totalOrders");
    Integer totalItems = (Integer) request.getAttribute("totalItems");
    Integer differentVarieties = (Integer) request.getAttribute("differentVarieties");
    BigDecimal totalSpent = (BigDecimal) request.getAttribute("totalSpent");
    Integer cartItemCount = (Integer) request.getAttribute("cartItemCount");
    BigDecimal cartTotal = (BigDecimal) request.getAttribute("cartTotal");

    List<Map<String, Object>> recentOrders =
        (List<Map<String, Object>>) request.getAttribute("recentOrders");
    List<Map<String, Object>> cartPreview =
        (List<Map<String, Object>>) request.getAttribute("cartPreview");

    if (totalOrders == null) totalOrders = 0;
    if (totalItems == null) totalItems = 0;
    if (differentVarieties == null) differentVarieties = 0;
    if (totalSpent == null) totalSpent = BigDecimal.ZERO;
    if (cartItemCount == null) cartItemCount = 0;
    if (cartTotal == null) cartTotal = BigDecimal.ZERO;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SRI SHOP - Buyer Dashboard</title>

<style>
* { box-sizing: border-box; }

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f0fdfa;
    color: #134e4a;
}

.header {
    position: sticky;
    top: 0;
    z-index: 1000;
    background: #0f766e;
    color: white;
    min-height: 72px;
    padding: 12px 25px;
    display: flex;
    align-items: center;
    gap: 20px;
    box-shadow: 0 4px 15px rgba(0,0,0,.14);
}

.logo {
    font-size: 23px;
    font-weight: bold;
    white-space: nowrap;
}

.search-form {
    flex: 1;
    display: flex;
    max-width: 430px;
    height: 42px;
}

.search-form input {
    flex: 1;
    min-width: 80px;
    border: none;
    outline: none;
    padding: 11px 14px;
    border-radius: 8px 0 0 8px;
    font-size: 14px;
}

.search-form button {
    width: 48px;
    border: none;
    background: white;
    color: #0f766e;
    border-radius: 0 8px 8px 0;
    cursor: pointer;
    font-size: 18px;
}

.nav {
    display: flex;
    align-items: center;
    gap: 5px;
    margin-left: auto;
}

.nav a {
    color: white;
    text-decoration: none;
    font-size: 13px;
    font-weight: bold;
    white-space: nowrap;
    padding: 9px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    gap: 5px;
}

.nav a:hover { background: rgba(255,255,255,.16); }

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

.welcome {
    max-width: 1200px;
    margin: 35px auto 20px;
    padding: 0 20px;
}

.welcome h1 { margin: 0 0 8px; color: #115e59; }
.welcome p { margin: 0; color: #64748b; }

.container {
    max-width: 1200px;
    margin: auto;
    padding: 0 20px 50px;
}

.summary-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
    margin-top: 25px;
}

.summary-card, .panel, .action-card {
    background: white;
    padding: 22px;
    border-radius: 16px;
    box-shadow: 0 8px 25px rgba(0,0,0,.06);
}

.summary-card { transition: transform .2s; }
.summary-card:hover, .action-card:hover { transform: translateY(-3px); }

.summary-icon, .action-icon { font-size: 28px; margin-bottom: 10px; }
.summary-title { color: #64748b; font-size: 14px; margin-bottom: 8px; }
.summary-value { color: #0f766e; font-size: 26px; font-weight: bold; }

.section-title { margin: 35px 0 16px; color: #115e59; }

.quick-actions {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 18px;
}

.action-card {
    text-decoration: none;
    color: #134e4a;
    transition: transform .2s;
}

.action-title { font-size: 18px; font-weight: bold; margin-bottom: 5px; }
.action-description { color: #64748b; font-size: 13px; }

.two-columns {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-top: 25px;
}

.panel h2 { margin-top: 0; color: #115e59; font-size: 19px; }

.order-item, .cart-item {
    padding: 13px 0;
    border-bottom: 1px solid #e2e8f0;
}

.order-number, .cart-name { font-weight: bold; color: #0f766e; }
.order-info, .cart-details { color: #64748b; font-size: 13px; margin-top: 4px; }

.cart-item { display: flex; justify-content: space-between; gap: 15px; }
.cart-price { color: #0f766e; font-weight: bold; white-space: nowrap; }
.empty { color: #64748b; padding: 15px 0; }

.cart-total {
    margin-top: 15px;
    padding-top: 15px;
    border-top: 2px solid #e2e8f0;
    display: flex;
    justify-content: space-between;
    font-weight: bold;
}

.cart-total-value { color: #0f766e; }

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
}

.view-btn:hover { background: #115e59; }

/* SRI BOT */
.chat-button {
    position: fixed;
    right: 25px;
    bottom: 25px;
    width: 55px;
    height: 55px;
    border-radius: 50%;
    border: none;
    background: #0f766e;
    color: white;
    font-size: 24px;
    cursor: pointer;
    box-shadow: 0 8px 25px rgba(0,0,0,.20);
    z-index: 2000;
}

.chat-button:hover { background: #115e59; }

.chat-window {
    display: none;
    position: fixed;
    right: 25px;
    bottom: 90px;
    width: 360px;
    height: 500px;
    max-height: calc(100vh - 120px);
    background: white;
    border-radius: 16px;
    box-shadow: 0 12px 40px rgba(0,0,0,.20);
    overflow: hidden;
    z-index: 2000;
}

.chat-header {
    height: 48px;
    background: #0f766e;
    color: white;
    padding: 14px;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.chat-close {
    background: transparent;
    border: none;
    color: white;
    font-size: 20px;
    cursor: pointer;
}

.chat-body {
    height: calc(100% - 108px);
    padding: 14px;
    overflow-y: auto;
    color: #334155;
    font-size: 13px;
}

.bot-message {
    background: #f0fdfa;
    padding: 12px;
    border-radius: 10px;
    margin-bottom: 10px;
    line-height: 1.5;
    overflow-wrap: anywhere;
}

.user-message {
    background: #0f766e;
    color: white;
    padding: 11px 12px;
    border-radius: 10px;
    margin: 10px 0 10px 28px;
    line-height: 1.5;
    overflow-wrap: anywhere;
}

.chat-form {
    height: 60px;
    display: flex;
    gap: 7px;
    padding: 9px;
    border-top: 1px solid #e2e8f0;
}

.chat-form input {
    flex: 1;
    min-width: 0;
    border: 1px solid #cbd5e1;
    border-radius: 8px;
    padding: 9px;
    outline: none;
}

.chat-form input:focus { border-color: #0f766e; }

.chat-form button {
    border: none;
    border-radius: 8px;
    padding: 0 12px;
    background: #0f766e;
    color: white;
    font-weight: bold;
    cursor: pointer;
}

.chat-form button:disabled { opacity: .6; cursor: not-allowed; }

@media (max-width: 1100px) {
    .header { flex-wrap: wrap; }
    .search-form { order: 3; max-width: none; width: 100%; }
    .nav { margin-left: 0; overflow-x: auto; width: 100%; }
    .summary-grid { grid-template-columns: repeat(2, 1fr); }
}

@media (max-width: 700px) {
    .header { padding: 14px 18px; gap: 12px; }
    .logo { font-size: 19px; }
    .nav { gap: 3px; }
    .nav a { font-size: 12px; padding: 8px 6px; }
    .quick-actions, .two-columns { grid-template-columns: 1fr; }
    .welcome { margin-top: 25px; }
    .chat-window {
        right: 12px;
        bottom: 80px;
        width: calc(100% - 24px);
    }
    .chat-button { right: 18px; bottom: 18px; }
}

@media (max-width: 450px) {
    .summary-grid { grid-template-columns: 1fr; }
    .nav a { padding: 7px 5px; font-size: 11px; }
}
</style>
</head>

<body>

<header class="header">
    <div class="logo">🛍️ SRI SHOP</div>

    <form class="search-form" action="<%= contextPath %>/products" method="get">
        <input type="text" name="search" placeholder="Search dresses..." autocomplete="off">
        <button type="submit" aria-label="Search">🔍</button>
    </form>

    <nav class="nav">
        <a href="<%= contextPath %>/products">👗 <span>Shop</span></a>
        <a href="<%= contextPath %>/products?category=Accessories">👜 <span>Accessories</span></a>
        <a href="<%= contextPath %>/wishlist">❤️ <span>Wishlist</span></a>
        <a href="<%= contextPath %>/cart">🛒 <span>Cart</span>
            <% if (cartItemCount > 0) { %>
                <b class="cart-badge"><%= cartItemCount %></b>
            <% } %>
        </a>
        <a href="<%= contextPath %>/profile">👤 <span>Profile</span></a>
        <a href="<%= contextPath %>/logout">Logout</a>
    </nav>
</header>

<div class="welcome">
    <h1>Welcome back, <%= userName %> 👋</h1>
    <p>Manage your shopping, orders and favourite dresses from one place.</p>
</div>

<div class="container">

    <div class="summary-grid">
        <div class="summary-card">
            <div class="summary-icon">📦</div>
            <div class="summary-title">Total Orders</div>
            <div class="summary-value"><%= totalOrders %></div>
        </div>

        <div class="summary-card">
            <div class="summary-icon">👗</div>
            <div class="summary-title">Total Items</div>
            <div class="summary-value"><%= totalItems %></div>
        </div>

        <div class="summary-card">
            <div class="summary-icon">🛍️</div>
            <div class="summary-title">Different Varieties</div>
            <div class="summary-value"><%= differentVarieties %></div>
        </div>

        <div class="summary-card">
            <div class="summary-icon">💰</div>
            <div class="summary-title">Total Spent</div>
            <div class="summary-value">₹<%= totalSpent %></div>
        </div>
    </div>

    <h2 class="section-title">Quick Actions</h2>

    <div class="quick-actions">
        <a class="action-card" href="<%= contextPath %>/products">
            <div class="action-icon">👗</div>
            <div class="action-title">Browse Dresses</div>
            <div class="action-description">Explore available dresses and styles.</div>
        </a>

        <a class="action-card" href="<%= contextPath %>/cart">
            <div class="action-icon">🛒</div>
            <div class="action-title">My Cart</div>
            <div class="action-description">View and manage items in your cart.</div>
        </a>

        <a class="action-card" href="<%= contextPath %>/orders">
            <div class="action-icon">📦</div>
            <div class="action-title">My Orders</div>
            <div class="action-description">Track previous orders and purchases.</div>
        </a>
    </div>

    <div class="two-columns">
        <div class="panel">
            <h2>📦 Recent Orders</h2>

            <% if (recentOrders != null && !recentOrders.isEmpty()) {
                for (Map<String, Object> order : recentOrders) { %>
                    <div class="order-item">
                        <div class="order-number">Order #<%= order.get("order_id") %></div>
                        <div class="order-info">Status: <%= order.get("status") %></div>
                        <div class="order-info">Total: ₹<%= order.get("total_amount") %></div>
                    </div>
            <%  }
               } else { %>
                <div class="empty">No orders yet.</div>
            <% } %>

            <a class="view-btn" href="<%= contextPath %>/orders">View All Orders</a>
        </div>

        <div class="panel">
            <h2>🛒 Cart Preview</h2>

            <% if (cartPreview != null && !cartPreview.isEmpty()) {
                for (Map<String, Object> item : cartPreview) { %>
                    <div class="cart-item">
                        <div>
                            <div class="cart-name"><%= item.get("product_name") %></div>
                            <div class="cart-details">Quantity: <%= item.get("quantity") %></div>
                        </div>
                        <div class="cart-price">₹<%= item.get("subtotal") %></div>
                    </div>
            <%  }
               } else { %>
                <div class="empty">Your cart is empty.</div>
            <% } %>

            <div class="cart-total">
                <span>Cart Total</span>
                <span class="cart-total-value">₹<%= cartTotal %></span>
            </div>

            <a class="view-btn" href="<%= contextPath %>/cart">View Cart</a>
        </div>
    </div>
</div>

<button class="chat-button" id="chatToggle" type="button"
        aria-label="Open SRI BOT" aria-expanded="false">💬</button>

<div id="chatWindow" class="chat-window" role="dialog" aria-label="SRI BOT chat">
    <div class="chat-header">
        <span>🤖 SRI BOT</span>
        <button class="chat-close" id="chatClose" type="button" aria-label="Close chat">×</button>
    </div>

    <div id="chatMessages" class="chat-body" aria-live="polite">
        <div class="bot-message">
            Hello! Welcome to SRI SHOP. 👋<br><br>
            I can help you find dresses, accessories, cart, orders, wishlist and profile.
        </div>
    </div>

    <form id="chatForm" class="chat-form">
        <input id="chatInput" type="text" maxlength="500"
               placeholder="Type your message..." autocomplete="off" required>
        <button id="chatSend" type="submit">Send</button>
    </form>
</div>

<script>
(function () {
    "use strict";

    const chatWindow = document.getElementById("chatWindow");
    const chatToggle = document.getElementById("chatToggle");
    const chatClose = document.getElementById("chatClose");
    const chatForm = document.getElementById("chatForm");
    const chatInput = document.getElementById("chatInput");
    const chatMessages = document.getElementById("chatMessages");

    function openChat() {
        chatWindow.style.display = "block";
        chatToggle.setAttribute("aria-expanded", "true");
        chatInput.focus();
    }

    function closeChat() {
        chatWindow.style.display = "none";
        chatToggle.setAttribute("aria-expanded", "false");
        chatToggle.focus();
    }

    chatToggle.addEventListener("click", function () {
        if (chatWindow.style.display === "block") {
            closeChat();
        } else {
            openChat();
        }
    });

    chatClose.addEventListener("click", closeChat);

    function addMessage(text, className) {
        const message = document.createElement("div");
        message.className = className;
        message.textContent = text;
        chatMessages.appendChild(message);
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    function getBotReply(input) {
        const msg = input.toLowerCase().trim();

        if (/^(hi|hello|hey|vanakkam)\b/.test(msg)) {
            return "Hello! 😊 Welcome to SRI SHOP. What would you like help with?";
        }

        if (msg.includes("dress") || msg.includes("product") ||
            msg.includes("shop") || msg.includes("buy")) {
            return "You can browse dresses and products using the Shop menu at the top of the page.";
        }

        if (msg.includes("accessor")) {
            return "You can explore Accessories from the Accessories menu.";
        }

        if (msg.includes("cart")) {
            return "Click Cart in the top menu to view or manage your cart.";
        }

        if (msg.includes("order") || msg.includes("track") ||
            msg.includes("delivery") || msg.includes("status")) {
            return "Open My Orders to check your order history and available order status.";
        }

        if (msg.includes("wish") || msg.includes("favourite") ||
            msg.includes("favorite")) {
            return "Click Wishlist to view your saved favourite products.";
        }

        if (msg.includes("profile") || msg.includes("account") ||
            msg.includes("password")) {
            return "Open Profile to view or manage your account settings.";
        }

        if (msg.includes("search")) {
            return "Use the search bar in the header to search for products.";
        }

        if (msg.includes("thank")) {
            return "You're welcome! 💚 Happy shopping at SRI SHOP.";
        }

        if (msg.includes("bye")) {
            return "Goodbye! 👋 Thanks for visiting SRI SHOP.";
        }

        if (msg.includes("help")) {
            return "I can help with dresses, accessories, searching products, cart, orders, wishlist and profile.";
        }

        return "I can help with dresses, accessories, cart, orders, wishlist and profile. Try asking about one of these!";
    }

    chatForm.addEventListener("submit", function (event) {
        event.preventDefault();

        const text = chatInput.value.trim();
        if (!text) return;

        addMessage(text, "user-message");
        chatInput.value = "";

        const reply = getBotReply(text);

        window.setTimeout(function () {
            addMessage(reply, "bot-message");
        }, 250);
    });
})();
</script>

</body>
</html>
