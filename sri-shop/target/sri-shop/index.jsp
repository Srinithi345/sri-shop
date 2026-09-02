<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Sri Shop | Online Dress Store</title>

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

        /* NAVBAR */
        .navbar {
            width: 100%;
            padding: 18px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: white;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            font-size: 28px;
            font-weight: bold;
            color: #182b49;
        }

        .logo span {
            color: #d89b35;
        }

        .nav-links {
            display: flex;
            gap: 28px;
            align-items: center;
        }

        .nav-links a {
            text-decoration: none;
            color: #333;
            font-weight: 600;
        }

        .nav-links a:hover {
            color: #d89b35;
        }

        .nav-btn {
            padding: 11px 20px;
            border-radius: 25px;
            background: #182b49;
            color: white !important;
        }

        /* HERO */
        .hero {
            min-height: 600px;
            padding: 80px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 50px;
            background: linear-gradient(135deg, #eef3f9, #ffffff);
        }

        .hero-content {
            max-width: 600px;
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
            margin-bottom: 30px;
        }

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

        .secondary-btn {
            border: 2px solid #182b49;
            color: #182b49;
            background: white;
        }

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

        /* FEATURES */
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

        /* CATEGORY */
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
        }

        .category:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.08);
        }

        .category h3 {
            margin-bottom: 8px;
            color: #182b49;
        }

        .category p {
            color: #777;
        }

        /* CTA */
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

        /* FOOTER */
        footer {
            background: #101b2d;
            color: white;
            text-align: center;
            padding: 25px;
        }

        footer p {
            color: #c5ccd7;
        }

        /* RESPONSIVE */
        @media (max-width: 900px) {

            .hero {
                flex-direction: column;
                text-align: center;
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

            .nav-links {
                display: none;
            }
        }

        @media (max-width: 500px) {

            .hero h1 {
                font-size: 40px;
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

<!-- NAVBAR -->
<header class="navbar">

    <div class="logo">
        SRI <span>SHOP</span>
    </div>

    <nav class="nav-links">
        <a href="#home">Home</a>
        <a href="#categories">Categories</a>
        <a href="#features">Features</a>
        <a href="#seller">Seller</a>
        <a href="login.jsp" class="nav-btn">Login</a>
    </nav>

</header>


<!-- HERO -->
<section class="hero" id="home">

    <div class="hero-content">

        <div class="tag">
            ✨ Premium Dress Collection
        </div>

        <h1>
            Discover Your
            <span>Perfect Style</span>
        </h1>

        <p>
            Welcome to Sri Shop — your trusted online destination
            for stylish dresses, quality products and a simple
            shopping experience.
        </p>

        <div class="hero-buttons">

            <a href="#categories" class="primary-btn">
                Browse Products
            </a>

            <a href="register.jsp" class="secondary-btn">
                Create Account
            </a>

        </div>

    </div>


    <div class="hero-card">

        <div class="hero-card-content">

            <h2>SRi</h2>

            <p>
                Fashion • Quality • Comfort
            </p>

            <br>

            <p>
                Shop your favourite dresses
                from Sri Shop.
            </p>

        </div>

    </div>

</section>


<!-- FEATURES -->
<section class="section" id="features">

    <div class="section-title">

        <h2>Why Choose Sri Shop?</h2>

        <p>
            Everything you need for a smooth online shopping experience.
        </p>

    </div>


    <div class="features">

        <div class="feature-card">

            <div class="feature-icon">🛍️</div>

            <h3>Easy Shopping</h3>

            <p>
                Browse products, search by category,
                add items to cart and place orders easily.
            </p>

        </div>


        <div class="feature-card">

            <div class="feature-icon">🔐</div>

            <h3>Secure Account</h3>

            <p>
                Separate Buyer and Seller accounts
                with secure authentication.
            </p>

        </div>


        <div class="feature-card">

            <div class="feature-icon">🚚</div>

            <h3>Order Management</h3>

            <p>
                Track your orders and manage your
                shopping activities from your dashboard.
            </p>

        </div>

    </div>

</section>


<!-- CATEGORIES -->
<section class="section" id="categories">

    <div class="section-title">

        <h2>Shop By Category</h2>

        <p>
            Explore our dress collections.
        </p>

    </div>


    <div class="categories">

        <div class="category">
            <h3>👗 Dresses</h3>
            <p>Stylish dress collections</p>
        </div>

        <div class="category">
            <h3>🌸 Casual Wear</h3>
            <p>Comfortable everyday styles</p>
        </div>

        <div class="category">
            <h3>✨ Party Wear</h3>
            <p>Special occasion collections</p>
        </div>

        <div class="category">
            <h3>💫 New Arrivals</h3>
            <p>Latest fashion collections</p>
        </div>

    </div>

</section>


<!-- SELLER -->
<section class="cta" id="seller">

    <h2>Are You a Seller?</h2>

    <p>
        Register as a Seller and start managing
        your own product listings on Sri Shop.
    </p>

    <a href="register.jsp">
        Become a Seller
    </a>

</section>


<!-- FOOTER -->
<footer>

    <p>
        © 2026 Sri Shop. All Rights Reserved.
    </p>

</footer>

</body>
</html>