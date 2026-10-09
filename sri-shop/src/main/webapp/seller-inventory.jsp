<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedHashSet" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.srimart.model.Product" %>

<%
    String userName =
            (String) session.getAttribute("userName");

    String userRole =
            (String) session.getAttribute("userRole");

    if (userName == null ||
        !"SELLER".equalsIgnoreCase(userRole)) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );

        return;
    }

    List<Product> products =
            (List<Product>) request.getAttribute("inventoryProducts");

    if (products == null) {
        products = new java.util.ArrayList<>();
    }

    int totalProducts = products.size();

    int lowStock = 0;
    int outOfStock = 0;
    int totalStock = 0;

    Set<String> categories = new LinkedHashSet<>();

    for (Product product : products) {

        int stock = product.getStockQuantity();

        totalStock += stock;

        if (stock == 0) {
            outOfStock++;
        } else if (stock <= 5) {
            lowStock++;
        }

        if (product.getCategory() != null &&
            !product.getCategory().trim().isEmpty()) {

            categories.add(product.getCategory().trim());
        }
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Inventory Management - SRI SHOP</title>

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
            padding: 20px 35px;

            display: flex;
            justify-content: space-between;
            align-items: center;

            box-shadow:
                0 5px 20px rgba(0,0,0,0.12);
        }

        .logo {
            font-size: 27px;
            font-weight: bold;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .seller-name {
            font-size: 15px;
        }

        .back-btn {
            background: white;
            color: #0f766e;
            padding: 10px 17px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
        }

        .back-btn:hover {
            background: #ccfbf1;
        }

        .container {
            width: 92%;
            max-width: 1150px;
            margin: 35px auto;
        }

        .title-section {
            margin-bottom: 25px;
        }

        .title-section h1 {
            margin: 0 0 8px;
            color: #134e4a;
        }

        .title-section p {
            margin: 0;
            color: #64748b;
        }

        .summary {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .summary-card {
            background: white;
            padding: 22px;
            border-radius: 16px;

            box-shadow:
                0 8px 25px rgba(0,0,0,0.07);
        }

        .summary-icon {
            font-size: 30px;
        }

        .summary-card h2 {
            margin: 8px 0 0;
            font-size: 28px;
            color: #0f766e;
        }

        .summary-card p {
            margin: 6px 0 0;
            color: #64748b;
        }

        .low-card {
            border-left: 5px solid #f59e0b;
        }

        .low-card h2 {
            color: #d97706;
        }

        .out-card {
            border-left: 5px solid #dc2626;
        }

        .out-card h2 {
            color: #dc2626;
        }

        .inventory-panel {
            background: white;
            padding: 25px;
            border-radius: 18px;

            box-shadow:
                0 8px 25px rgba(0,0,0,0.07);
        }

        .inventory-panel h2 {
            margin-top: 0;
            color: #134e4a;
        }

        .filters {
            display: grid;
            grid-template-columns: 1fr 220px auto;
            gap: 12px;
            margin: 20px 0;
        }

        .search-box,
        .category-select {
            width: 100%;
            padding: 12px 14px;

            border: 1px solid #cbd5e1;
            border-radius: 9px;

            font-size: 14px;
            outline: none;
            background: white;
        }

        .search-box:focus,
        .category-select:focus {
            border-color: #0f766e;
            box-shadow:
                0 0 0 3px rgba(15,118,110,0.10);
        }

        .clear-btn {
            border: none;
            background: #64748b;
            color: white;

            padding: 12px 18px;
            border-radius: 9px;

            font-weight: bold;
            cursor: pointer;
        }

        .clear-btn:hover {
            background: #475569;
        }

        .filter-result {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        .inventory-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .inventory-table th,
        .inventory-table td {
            padding: 14px;
            border-bottom: 1px solid #e2e8f0;
            text-align: left;
        }

        .inventory-table th {
            background: #f0fdfa;
            color: #0f766e;
        }

        .product-name {
            font-weight: bold;
            color: #134e4a;
        }

        .price {
            font-weight: bold;
            color: #0f766e;
        }

        .stock {
            font-weight: bold;
        }

        .stock-good {
            color: #15803d;
        }

        .stock-low {
            color: #d97706;
        }

        .stock-out {
            color: #dc2626;
        }

        .status {
            display: inline-block;
            padding: 6px 11px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .status-good {
            background: #dcfce7;
            color: #15803d;
        }

        .status-low {
            background: #fef3c7;
            color: #b45309;
        }

        .status-out {
            background: #fee2e2;
            color: #b91c1c;
        }

        .edit-btn {
            display: inline-block;
            background: #2563eb;
            color: white;

            padding: 8px 13px;
            border-radius: 7px;

            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
        }

        .edit-btn:hover {
            background: #1d4ed8;
        }

        .no-results {
            display: none;
            text-align: center;
            padding: 40px 20px;
            color: #64748b;
        }

        .empty {
            text-align: center;
            padding: 50px 20px;
            color: #64748b;
        }

        .empty-icon {
            font-size: 55px;
            margin-bottom: 15px;
        }

        .bottom-back {
            display: inline-block;
            margin-top: 25px;

            background: #0f766e;
            color: white;

            padding: 12px 22px;
            border-radius: 8px;

            text-decoration: none;
            font-weight: bold;
        }

        .bottom-back:hover {
            background: #115e59;
        }

        @media (max-width: 850px) {

            .summary {
                grid-template-columns: repeat(2, 1fr);
            }

            .filters {
                grid-template-columns: 1fr 1fr;
            }

            .clear-btn {
                width: 100%;
            }
        }

        @media (max-width: 600px) {

            .header {
                padding: 17px 20px;
            }

            .logo {
                font-size: 22px;
            }

            .seller-name {
                display: none;
            }

            .container {
                width: 90%;
                margin: 25px auto;
            }

            .summary {
                grid-template-columns: 1fr;
            }

            .filters {
                grid-template-columns: 1fr;
            }

            .inventory-panel {
                padding: 18px;
            }

            .inventory-table {
                font-size: 13px;
            }
        }

    </style>

</head>

<body>

<div class="header">

    <div class="logo">
        &#128230; SRI SHOP — Inventory
    </div>

    <div class="header-right">

        <span class="seller-name">
            Seller:
            <strong>
                <%= userName %>
            </strong>
        </span>

        <a class="back-btn"
           href="${pageContext.request.contextPath}/seller-dashboard">

            &#8592; Dashboard

        </a>

    </div>

</div>


<div class="container">


    <div class="title-section">

        <h1>
            Inventory Management
        </h1>

        <p>
            Monitor your product stock and identify
            products that need attention.
        </p>

    </div>


    <div class="summary">


        <div class="summary-card">

            <div class="summary-icon">
                &#128087;
            </div>

            <h2>
                <%= totalProducts %>
            </h2>

            <p>
                Total Products
            </p>

        </div>


        <div class="summary-card">

            <div class="summary-icon">
                &#128230;
            </div>

            <h2>
                <%= totalStock %>
            </h2>

            <p>
                Total Stock Units
            </p>

        </div>


        <div class="summary-card low-card">

            <div class="summary-icon">
                &#9888;
            </div>

            <h2>
                <%= lowStock %>
            </h2>

            <p>
                Low Stock
            </p>

        </div>


        <div class="summary-card out-card">

            <div class="summary-icon">
                &#128683;
            </div>

            <h2>
                <%= outOfStock %>
            </h2>

            <p>
                Out of Stock
            </p>

        </div>


    </div>


    <div class="inventory-panel">

        <h2>
            &#128203; Product Inventory
        </h2>


        <%
            if (products.isEmpty()) {
        %>

            <div class="empty">

                <div class="empty-icon">
                    &#128230;
                </div>

                <h3>
                    No Products Found
                </h3>

                <p>
                    You have not added any products yet.
                </p>

            </div>

        <%
            } else {
        %>


        <!-- SEARCH AND FILTER -->

        <div class="filters">

            <input
                type="text"
                id="productSearch"
                class="search-box"
                placeholder="&#128269; Search product name..."
                onkeyup="filterProducts()"
            >


            <select
                id="categoryFilter"
                class="category-select"
                onchange="filterProducts()"
            >

                <option value="">
                    All Categories
                </option>

                <%
                    for (String category : categories) {
                %>

                    <option value="<%= category.toLowerCase() %>">
                        <%= category %>
                    </option>

                <%
                    }
                %>

            </select>


            <button
                type="button"
                class="clear-btn"
                onclick="clearFilters()">

                Clear

            </button>

        </div>


        <div class="filter-result" id="filterResult">
            Showing <%= products.size() %> products
        </div>


        <div class="table-wrapper">

            <table class="inventory-table">

                <thead>

                    <tr>

                        <th>ID</th>
                        <th>Product</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Size</th>
                        <th>Color</th>
                        <th>Stock</th>
                        <th>Status</th>
                        <th>Action</th>

                    </tr>

                </thead>


                <tbody id="inventoryBody">

                <%
                    for (Product product : products) {

                        int stock =
                                product.getStockQuantity();

                        String stockClass;
                        String statusClass;
                        String statusText;

                        if (stock == 0) {

                            stockClass = "stock-out";
                            statusClass = "status-out";
                            statusText = "Out of Stock";

                        } else if (stock <= 5) {

                            stockClass = "stock-low";
                            statusClass = "status-low";
                            statusText = "Low Stock";

                        } else {

                            stockClass = "stock-good";
                            statusClass = "status-good";
                            statusText = "In Stock";
                        }

                        String productName =
                                product.getName() == null
                                ? ""
                                : product.getName();

                        String category =
                                product.getCategory() == null
                                ? ""
                                : product.getCategory();
                %>


                    <tr
                        class="product-row"
                        data-name="<%= productName.toLowerCase() %>"
                        data-category="<%= category.toLowerCase() %>"
                    >

                        <td>
                            <%= product.getProductId() %>
                        </td>


                        <td>

                            <span class="product-name">
                                <%= productName %>
                            </span>

                        </td>


                        <td>
                            <%= category %>
                        </td>


                        <td>

                            <span class="price">
                                &#8377;<%= product.getPrice() %>
                            </span>

                        </td>


                        <td>
                            <%= product.getSize() %>
                        </td>


                        <td>
                            <%= product.getColor() %>
                        </td>


                        <td>

                            <span class="stock <%= stockClass %>">
                                <%= stock %>
                            </span>

                        </td>


                        <td>

                            <span class="status <%= statusClass %>">
                                <%= statusText %>
                            </span>

                        </td>


                        <td>

                            <a
                                class="edit-btn"
                                href="${pageContext.request.contextPath}/edit-product?id=<%= product.getProductId() %>"
                            >

                                &#9998; Edit

                            </a>

                        </td>

                    </tr>


                <%
                    }
                %>

                </tbody>

            </table>

        </div>


        <div class="no-results" id="noResults">

            <div class="empty-icon">
                &#128269;
            </div>

            <h3>
                No Products Found
            </h3>

            <p>
                Try another product name or category.
            </p>

        </div>


        <%
            }
        %>

    </div>


    <a
        class="bottom-back"
        href="${pageContext.request.contextPath}/seller-dashboard"
    >

        &#8592; Back to Seller Dashboard

    </a>


</div>


<script>

    function filterProducts() {

        const searchInput =
            document.getElementById("productSearch");

        const categorySelect =
            document.getElementById("categoryFilter");

        const search =
            searchInput.value.toLowerCase().trim();

        const category =
            categorySelect.value.toLowerCase();

        const rows =
            document.querySelectorAll(".product-row");

        let visibleCount = 0;

        rows.forEach(function(row) {

            const name =
                row.getAttribute("data-name") || "";

            const rowCategory =
                row.getAttribute("data-category") || "";

            const matchesName =
                name.includes(search);

            const matchesCategory =
                category === "" ||
                rowCategory === category;

            if (matchesName && matchesCategory) {

                row.style.display = "";
                visibleCount++;

            } else {

                row.style.display = "none";
            }

        });


        const noResults =
            document.getElementById("noResults");

        const filterResult =
            document.getElementById("filterResult");


        if (visibleCount === 0) {

            noResults.style.display = "block";

        } else {

            noResults.style.display = "none";
        }


        filterResult.textContent =
            "Showing " +
            visibleCount +
            " product" +
            (visibleCount === 1 ? "" : "s");
    }


    function clearFilters() {

        document.getElementById("productSearch").value = "";

        document.getElementById("categoryFilter").value = "";

        filterProducts();
    }

</script>

</body>

</html>