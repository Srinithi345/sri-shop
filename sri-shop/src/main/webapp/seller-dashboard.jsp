<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String userName =
            (String) session.getAttribute("userName");

    String userRole =
            (String) session.getAttribute("userRole");

    if (userName == null ||
        !"SELLER".equalsIgnoreCase(userRole)) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp");

        return;
    }

    Integer totalProducts =
            (Integer) request.getAttribute("totalProducts");

    Integer totalOrders =
            (Integer) request.getAttribute("totalOrders");

    Integer lowStock =
            (Integer) request.getAttribute("lowStock");

    java.math.BigDecimal totalSales =
            (java.math.BigDecimal)
                    request.getAttribute("totalSales");

    java.util.List<com.srimart.model.Product>
            sellerProducts =
            (java.util.List<com.srimart.model.Product>)
                    request.getAttribute("sellerProducts");

    if (totalProducts == null)
        totalProducts = 0;

    if (totalOrders == null)
        totalOrders = 0;

    if (lowStock == null)
        lowStock = 0;

    if (totalSales == null)
        totalSales = java.math.BigDecimal.ZERO;

    if (sellerProducts == null)
        sellerProducts =
                new java.util.ArrayList<>();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Sri Shop - Seller Dashboard</title>

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

.header {
    background: #0f766e;
    color: white;
    padding: 18px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 5px 20px rgba(0,0,0,0.12);
}

.logo {
    font-size: 25px;
    font-weight: bold;
}

.header-right {
    display: flex;
    align-items: center;
    gap: 20px;
}

.seller-name {
    font-size: 15px;
}

.logout {
    background: white;
    color: #0f766e;
    padding: 10px 18px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: bold;
}

.logout:hover {
    background: #ccfbf1;
}

.container {
    max-width: 1150px;
    margin: 35px auto;
    padding: 20px;
}

.welcome {
    background: linear-gradient(
        135deg,
        #0f766e,
        #115e59
    );

    color: white;
    padding: 32px;
    border-radius: 20px;

    box-shadow:
        0 10px 30px
        rgba(0,0,0,0.10);
}

.welcome h2 {
    margin: 0 0 8px;
    font-size: 29px;
}

.welcome p {
    margin: 0;
    opacity: 0.9;
}

.section-title {
    margin-top: 35px;
    margin-bottom: 18px;
}

.section-title h2 {
    margin: 0;
    color: #134e4a;
}

.stats {
    display: grid;
    grid-template-columns:
        repeat(4, 1fr);

    gap: 20px;
    margin-top: 25px;
}

.stat-card {
    background: white;
    padding: 23px;
    border-radius: 17px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.06);
}

.stat-icon {
    font-size: 30px;
}

.stat-card h3 {
    margin: 8px 0 0;
    font-size: 28px;
    color: #0f766e;
}

.stat-card p {
    margin: 7px 0 0;
    color: #64748b;
}

.cards {
    display: grid;
    grid-template-columns:
        repeat(3, 1fr);

    gap: 22px;
}

.card {
    background: white;
    padding: 28px;
    border-radius: 18px;
    text-align: center;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.07);

    transition:
        transform 0.2s ease;
}

.card:hover {
    transform: translateY(-4px);
}

.icon {
    font-size: 42px;
}

.card h3 {
    color: #0f766e;
    margin: 10px 0;
}

.card p {
    color: #64748b;
    line-height: 1.5;
    min-height: 45px;
}

.btn {
    display: inline-block;
    background: #0f766e;
    color: white;
    padding: 11px 20px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: bold;
    margin-top: 8px;
}

.btn:hover {
    background: #115e59;
}

.products-panel {
    margin-top: 30px;
    background: white;
    padding: 25px;
    border-radius: 18px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.07);
}

.products-panel h2 {
    margin-top: 0;
    color: #134e4a;
}

.product-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 18px;
}

.product-table th,
.product-table td {
    padding: 13px;
    border-bottom:
        1px solid #e2e8f0;

    text-align: left;
}

.product-table th {
    background: #f0fdfa;
    color: #0f766e;
}

.stock-good {
    color: #15803d;
    font-weight: bold;
}

.stock-low {
    color: #dc2626;
    font-weight: bold;
}

/* EDIT BUTTON */

.edit-btn {
    display: inline-block;
    background: #2563eb;
    color: white;
    padding: 8px 14px;
    border-radius: 7px;
    text-decoration: none;
    font-weight: bold;
    font-size: 13px;
}

.edit-btn:hover {
    background: #1d4ed8;
}

.empty {
    text-align: center;
    color: #64748b;
    padding: 30px;
}

.innovation {
    margin-top: 30px;
    background: white;
    padding: 28px;
    border-radius: 18px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.07);

    border-left:
        5px solid #0f766e;
}

.innovation h2 {
    margin-top: 0;
    color: #0f766e;
}

.innovation p {
    color: #64748b;
    line-height: 1.6;
}

@media (max-width: 900px) {

    .stats {
        grid-template-columns:
            repeat(2, 1fr);
    }

    .cards {
        grid-template-columns:
            repeat(2, 1fr);
    }

    .product-table {
        display: block;
        overflow-x: auto;
    }
}

@media (max-width: 600px) {

    .header {
        padding: 15px 20px;
    }

    .seller-name {
        display: none;
    }

    .container {
        margin: 20px auto;
        padding: 12px;
    }

    .stats,
    .cards {
        grid-template-columns: 1fr;
    }

    .welcome h2 {
        font-size: 23px;
    }

    .product-table {
        font-size: 13px;
    }
}

</style>

</head>

<body>

<div class="header">

    <div class="logo">
        🛍️ SRI SHOP
    </div>

    <div class="header-right">

        <span class="seller-name">

            Seller:

            <strong>
                <%= userName %>
            </strong>

        </span>

        <a class="logout"
           href="${pageContext.request.contextPath}/login.jsp">

            Logout

        </a>

    </div>

</div>


<div class="container">

    <div class="welcome">

        <h2>
            Welcome, <%= userName %>! 👋
        </h2>

        <p>
            Manage your dresses, inventory and
            customer orders from your Sri Shop
            Seller Dashboard.
        </p>

    </div>


    <div class="stats">

        <div class="stat-card">

            <div class="stat-icon">
                👗
            </div>

            <h3>
                <%= totalProducts %>
            </h3>

            <p>
                Total Products
            </p>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                📦
            </div>

            <h3>
                <%= totalOrders %>
            </h3>

            <p>
                Total Orders
            </p>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                ⚠️
            </div>

            <h3>
                <%= lowStock %>
            </h3>

            <p>
                Low Stock
            </p>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                💰
            </div>

            <h3>
                ₹<%= totalSales %>
            </h3>

            <p>
                Total Sales
            </p>

        </div>

    </div>


    <div class="section-title">

        <h2>
            Seller Management
        </h2>

    </div>


    <div class="cards">


        <div class="card">

            <div class="icon">
                ➕
            </div>

            <h3>
                Add Dress
            </h3>

            <p>
                Add a new dress product
                to your Sri Shop store.
            </p>

            <a class="btn"
               href="${pageContext.request.contextPath}/add-product.jsp">

                Add Product

            </a>

        </div>


        <div class="card">

            <div class="icon">
                👗
            </div>

            <h3>
                My Products
            </h3>

            <p>
                View and manage all your
                dress products.
            </p>

            <a class="btn"
               href="#products">

                View Products

            </a>

        </div>


        <div class="card">

            <div class="icon">
                📦
            </div>

            <h3>
                Orders
            </h3>

            <p>
                View orders received
                from buyers.
            </p>

            <a class="btn"
               href="#orders">

                View Orders

            </a>

        </div>


        <div class="card">

            <div class="icon">
                📊
            </div>

            <h3>
                Inventory
            </h3>

            <p>
                Monitor stock levels and
                identify low-stock dresses.
            </p>

            <a class="btn"
               href="#products">

                Manage Stock

            </a>

        </div>


        <div class="card">

            <div class="icon">
                ⭐
            </div>

            <h3>
                Reviews
            </h3>

            <p>
                View customer reviews and
                product feedback.
            </p>

            <a class="btn"
               href="#reviews">

                View Reviews

            </a>

        </div>


        <div class="card">

            <div class="icon">
                📈
            </div>

            <h3>
                Smart Analytics
            </h3>

            <p>
                Track products, sales and
                inventory performance.
            </p>

            <a class="btn"
               href="#analytics">

                View Analytics

            </a>

        </div>

    </div>


    <div class="products-panel"
         id="products">

        <h2>
            👗 My Products
        </h2>

        <%
            if (sellerProducts != null &&
                !sellerProducts.isEmpty()) {
        %>

        <table class="product-table">

            <thead>

                <tr>

                    <th>ID</th>

                    <th>Product</th>

                    <th>Category</th>

                    <th>Price</th>

                    <th>Color</th>

                    <th>Stock</th>

                    <th>Action</th>

                </tr>

            </thead>


            <tbody>

            <%

                for (com.srimart.model.Product product
                        : sellerProducts) {

            %>

                <tr>

                    <td>
                        <%= product.getProductId() %>
                    </td>


                    <td>

                        <strong>
                            <%= product.getName() %>
                        </strong>

                    </td>


                    <td>
                        <%= product.getCategory() %>
                    </td>


                    <td>
                        ₹<%= product.getPrice() %>
                    </td>


                    <td>
                        <%= product.getColor() %>
                    </td>


                    <td>

                        <%

                            if (product.getStockQuantity() <= 5) {

                        %>

                            <span class="stock-low">

                                ⚠️
                                <%= product.getStockQuantity() %>

                            </span>

                        <%

                            } else {

                        %>

                            <span class="stock-good">

                                ✓
                                <%= product.getStockQuantity() %>

                            </span>

                        <%

                            }

                        %>

                    </td>


                    <td>

                        <a class="edit-btn"
                           href="${pageContext.request.contextPath}/edit-product?id=<%= product.getProductId() %>">

                            ✏️ Edit

                        </a>

                    </td>

                </tr>

            <%

                }

            %>

            </tbody>

        </table>

        <%

            } else {

        %>

        <div class="empty">

            <div style="font-size:45px;">
                👗
            </div>

            <strong>
                No products added yet.
            </strong>

            <br>
            <br>

            Add your first dress product
            using the Add Product button.

        </div>

        <%

            }

        %>

    </div>


    <div class="innovation">

        <h2>
            👗 SRI SHOP Innovation
        </h2>

        <p>
            Our Virtual Trial Room allows buyers
            to preview selected dresses before
            purchasing. Sellers can upload dress
            images that can be used in the virtual
            trial experience.
        </p>

    </div>

</div>

</body>

</html>