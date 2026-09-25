<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
    boolean loggedIn = userName != null && userRole != null;
%>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SRI SHOP | Fashion Marketplace</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            background: #f7f8fc;
            color: #172033;
        }

        /* ================= NAVBAR ================= */

        .navbar {
            width: 100%;
            padding: 17px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: white;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo {
            font-size: 28px;
            font-weight: bold;
            color: #182b49;
            text-decoration: none;
        }

        .logo span {
            color: #d89b35;
        }

        .nav-links {
            display: flex;
            gap: 26px;
            align-items: center;
        }

        .nav-links a {
            text-decoration: none;
            color: #333;
            font-weight: 600;
            transition: 0.2s;
        }

        .nav-links a:hover {
            color: #d89b35;
        }

        .nav-icon {
            font-size: 18px;
        }

        .nav-btn {
            padding: 10px 20px;
            border-radius: 25px;
            background: #182b49;
            color: white !important;
        }

        .profile-btn {
            padding: 9px 15px;
            border-radius: 20px;
            background: #f1f4f8;
            color: #182b49 !important;
        }

        /* ================= HERO ================= */

        .hero {
            min-height: 570px;
            padding: 70px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 50px;
            background: linear-gradient(135deg, #eef3f9, #ffffff);
        }

        .hero-content {
            max-width: 620px;
        }

        .tag {
            display: inline-block;
            padding: 8px 15px;
            border-radius: 20px;
            background: #fff1d8;
            color: #a56d0b;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .hero h1 {
            font-size: 58px;
            line-height: 1.1;
            margin-bottom: 20px;
            color: #182b49;
        }

        .hero h1 span {
            color: #d89b35;
        }

        .hero p {
            font-size: 18px;
            line-height: 1.7;
            color: #5d6573;
            margin-bottom: 25px;
        }

        /* ================= SEARCH ================= */

        .search-box {
            width: 100%;
            max-width: 570px;
            display: flex;
            background: white;
            border: 1px solid #e1e5eb;
            border-radius: 35px;
            padding: 6px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            margin-bottom: 28px;
        }

        .search-box input {
            flex: 1;
            border: none;
            outline: none;
            padding: 13px 18px;
            font-size: 15px;
            background: transparent;
        }

        .search-box button {
            border: none;
            background: #182b49;
            color: white;
            padding: 12px 23px;
            border-radius: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .search-box button:hover {
            background: #d89b35;
        }

        /* ================= BUTTONS ================= */

        .hero-buttons {
            display: flex;
            gap: 15px;
        }

        .primary-btn,
        .secondary-btn {
            padding: 14px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            display: inline-block;
        }

        .primary-btn {
            background: #182b49;
            color: white;
        }

        .primary-btn:hover {
            background: #d89b35;
        }

        .secondary-btn {
            border: 2px solid #182b49;
            color: #182b49;
            background: white;
        }

        .secondary-btn:hover {
            background: #182b49;
            color: white;
        }

        /* ================= HERO CARD ================= */

        .hero-card {
            width: 400px;
            height: 400px;
            border-radius: 30px;
            background: linear-gradient(145deg, #182b49, #29466e);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            box-shadow: 0 20px 50px rgba(24,43,73,0.25);
        }

        .hero-card-content {
            padding: 30px;
        }

        .hero-card h2 {
            font-size: 45px;
            margin-bottom: 15px;
        }

        .hero-card p {
            color: #e6ebf2;
        }

        /* ================= SECTION ================= */

        .section {
            padding: 75px 7%;
        }

        .section-title {
            text-align: center;
            margin-bottom: 45px;
        }

        .section-title h2 {
            font-size: 36px;
            color: #182b49;
            margin-bottom: 10px;
        }

        .section-title p {
            color: #687080;
        }

        /* ================= CATEGORIES ================= */

        .categories {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .category {
            padding: 35px 20px;
            background: white;
            border-radius: 15px;
            text-align: center;
            border: 1px solid #e6e9ef;
            transition: 0.3s;
            cursor: pointer;
        }

        .category:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.08);
        }

        .category-icon {
            font-size: 45px;
            margin-bottom: 15px;
        }

        .category h3 {
            margin-bottom: 8px;
            color: #182b49;
        }

        .category p {
            color: #777;
        }

        /* ================= FEATURES ================= */

        .features {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        .feature-card {
            background: white;
            padding: 35px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(0,0,0,0.07);
        }

        .feature-icon {
            font-size: 45px;
            margin-bottom: 20px;
        }

        .feature-card h3 {
            color: #182b49;
            margin-bottom: 12px;
        }

        .feature-card p {
            color: #697282;
            line-height: 1.6;
        }

        /* ================= CTA ================= */

        .cta {
            margin: 20px 7% 70px;
            padding: 60px;
            border-radius: 25px;
            background: #182b49;
            color: white;
            text-align: center;
        }

        .cta h2 {
            font-size: 38px;
            margin-bottom: 15px;
        }

        .cta p {
            color: #dfe5ee;
            margin-bottom: 25px;
        }

        .cta a {
            display: inline-block;
            padding: 13px 25px;
            background: #d89b35;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        /* ================= FOOTER ================= */

        footer {
            background: #101b2d;
            color: white;
            text-align: center;
            padding: 25px;
        }

        footer p {
            color: #c5ccd7;
        }

        /* ================= RESPONSIVE ================= */

        @media (max-width: 900px) {

            .navbar {
                padding: 15px 5%;
            }

            .nav-links {
                gap: 12px;
            }

            .hero {
                flex-direction: column;
                text-align: center;
            }

            .hero-content {
                max-width: 700px;
            }

            .search-box {
                margin-left: auto;
                margin-right: auto;
            }

            .hero-buttons {
                justify-content: center;
            }

            .hero-card {
                width: 320px;
                height: 320px;
            }

            .features {
                grid-template-columns: 1fr;
            }

            .categories {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 600px) {

            .navbar {
                padding: 14px 4%;
            }

            .logo {
                font-size: 22px;
            }

            .nav-links a {
                font-size: 13px;
            }

            .nav-links {
                gap: 8px;
            }

            .hero {
                padding: 55px 5%;
            }

            .hero h1 {
                font-size: 40px;
            }

            .hero p {
                font-size: 16px;
            }

            .categories {
                grid-template-columns: 1fr;
            }

            .cta {
                padding: 40px 20px;
            }

            .cta h2 {
                font-size: 28px;
            }
        }

    </style>

</head>

<body>

<!-- ================= NAVBAR ================= -->

<header class="navbar">

    <a href="${pageContext.request.contextPath}/" class="logo">
        SRI <span>SHOP</span>
    </a>

    <nav class="nav-links">

        <% if (loggedIn) { %>

            <a href="${pageContext.request.contextPath}/products">
                👜 Accessories
            </a>

            <a href="${pageContext.request.contextPath}/wishlist">
                ❤️ Wishlist
            </a>

            <a href="${pageContext.request.contextPath}/cart">
                🛒 Cart
            </a>

            <a href="${pageContext.request.contextPath}/buyer-dashboard"
               class="profile-btn">
                👤 <%= userName %>
            </a>

        <% } else { %>

            <a href="#home">Home</a>

            <a href="#categories">
                Categories
            </a>

            <a href="login.jsp" class="nav-btn">
                Login
            </a>

        <% } %>

    </nav>

</header>


<!-- ================= HERO ================= -->

<section class="hero" id="home">

    <div class="hero-content">

        <div class="tag">
            ✨ Premium Fashion Collection
        </div>

        <h1>
            Discover Your
            <span>Perfect Style</span>
        </h1>

        <p>
            Welcome to Sri Shop — your trusted online destination
            for stylish fashion, quality products and a simple
            shopping experience.
        </p>


        <!-- SEARCH -->

        <form class="search-box"
              action="${pageContext.request.contextPath}/products"
              method="get">

            <input
                type="text"
                name="search"
                placeholder="🔍 Search dresses, shirts, shoes..."
                autocomplete="off">

            <button type="submit">
                Search
            </button>

        </form>


        <div class="hero-buttons">

            <% if (loggedIn) { %>

                <a href="${pageContext.request.contextPath}/products"
                   class="primary-btn">
                    🛍️ Start Shopping
                </a>

                <a href="${pageContext.request.contextPath}/buyer-dashboard"
                   class="secondary-btn">
                    👤 My Profile
                </a>

            <% } else { %>

                <a href="login.jsp"
                   class="primary-btn">
                    🛍️ Start Shopping
                </a>

                <a href="register.jsp"
                   class="secondary-btn">
                    Create Account
                </a>

            <% } %>

        </div>

    </div>


    <!-- HERO CARD -->

    <div class="hero-card">

        <div class="hero-card-content">

            <h2>SRI</h2>

            <p>
                Fashion • Quality • Comfort
            </p>

            <br>

            <p>
                Fashion for Women, Men & Kids.
                Find your perfect style at Sri Shop.
            </p>

        </div>

    </div>

</section>


<!-- ================= CATEGORIES ================= -->

<section class="section" id="categories">

    <div class="section-title">

        <h2>Shop By Category</h2>

        <p>
            Explore fashion collections for everyone.
        </p>

    </div>


    <div class="categories">

        <div class="category">

            <div class="category-icon">👗</div>

            <h3>Women</h3>

            <p>
                Dresses, sarees, kurtis & more
            </p>

        </div>


        <div class="category">

            <div class="category-icon">👔</div>

            <h3>Men</h3>

            <p>
                Shirts, T-shirts, jeans & more
            </p>

        </div>


        <div class="category">

            <div class="category-icon">🧒</div>

            <h3>Kids</h3>

            <p>
                Boys & girls fashion collections
            </p>

        </div>


        <div class="category">

            <div class="category-icon">👟</div>

            <h3>Footwear</h3>

            <p>
                Shoes, sneakers & sandals
            </p>

        </div>

    </div>

</section>


<!-- ================= FEATURES ================= -->

<section class="section">

    <div class="section-title">

        <h2>Why Choose Sri Shop?</h2>

        <p>
            Everything you need for a smooth online shopping experience.
        </p>

    </div>


    <div class="features">

        <div class="feature-card">

            <div class="feature-icon">
                🛍️
            </div>

            <h3>Easy Shopping</h3>

            <p>
                Browse products, search products,
                add items to cart and place orders easily.
            </p>

        </div>


        <div class="feature-card">

            <div class="feature-icon">
                ❤️
            </div>

            <h3>Wishlist</h3>

            <p>
                Save your favourite products and
                access them anytime from your wishlist.
            </p>

        </div>


        <div class="feature-card">

            <div class="feature-icon">
                ⭐
            </div>

            <h3>Reviews & Ratings</h3>

            <p>
                View customer ratings and reviews
                for every product.
            </p>

        </div>

    </div>

</section>


<!-- ================= CTA ================= -->

<% if (!loggedIn) { %>

<section class="cta">

    <h2>Ready to Start Shopping?</h2>

    <p>
        Create your account and explore the latest
        fashion collections on Sri Shop.
    </p>

    <a href="register.jsp">
        Create Account
    </a>

</section>

<% } %>


<!-- ================= FOOTER ================= -->

<footer>

    <p>
        © 2026 SRI SHOP. All Rights Reserved.
    </p>

</footer>


</body>
</html>