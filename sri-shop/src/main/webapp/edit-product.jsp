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

    com.srimart.model.Product product =
            (com.srimart.model.Product)
                    request.getAttribute("product");

    String error =
            (String) request.getAttribute("error");

    if (product == null) {
        response.sendRedirect(
                request.getContextPath()
                        + "/seller-dashboard");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Sri Shop - Edit Product</title>

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
}

.logo {
    font-size: 25px;
    font-weight: bold;
}

.seller {
    font-size: 15px;
}

.container {
    max-width: 850px;
    margin: 40px auto;
    padding: 20px;
}

.form-card {
    background: white;
    padding: 35px;
    border-radius: 20px;

    box-shadow:
        0 10px 30px
        rgba(0,0,0,0.08);
}

.form-card h1 {
    margin-top: 0;
    color: #0f766e;
}

.subtitle {
    color: #64748b;
    margin-bottom: 25px;
}

.form-group {
    margin-bottom: 20px;
}

label {
    display: block;
    font-weight: bold;
    margin-bottom: 7px;
    color: #134e4a;
}

input,
textarea,
select {
    width: 100%;
    padding: 12px 14px;
    border: 1px solid #cbd5e1;
    border-radius: 8px;
    font-size: 15px;
    outline: none;
}

input:focus,
textarea:focus,
select:focus {
    border-color: #0f766e;
    box-shadow:
        0 0 0 3px
        rgba(15,118,110,0.10);
}

textarea {
    min-height: 110px;
    resize: vertical;
}

.row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 18px;
}

.btn-row {
    display: flex;
    gap: 12px;
    margin-top: 25px;
}

.update-btn {
    border: none;
    background: #0f766e;
    color: white;
    padding: 13px 25px;
    border-radius: 8px;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
}

.update-btn:hover {
    background: #115e59;
}

.back-btn {
    display: inline-block;
    background: #e2e8f0;
    color: #334155;
    padding: 13px 25px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: bold;
}

.back-btn:hover {
    background: #cbd5e1;
}

.error {
    background: #fee2e2;
    color: #b91c1c;
    padding: 13px;
    border-radius: 8px;
    margin-bottom: 20px;
    font-weight: bold;
}

.product-id {
    background: #f0fdfa;
    padding: 12px;
    border-radius: 8px;
    margin-bottom: 22px;
    color: #0f766e;
    font-weight: bold;
}

@media (max-width: 600px) {

    .header {
        padding: 15px 20px;
    }

    .container {
        margin: 20px auto;
        padding: 12px;
    }

    .form-card {
        padding: 22px;
    }

    .row {
        grid-template-columns: 1fr;
    }

    .btn-row {
        flex-direction: column;
    }

    .update-btn,
    .back-btn {
        text-align: center;
        width: 100%;
    }
}

</style>

</head>

<body>

<div class="header">

    <div class="logo">
        🛍️ SRI SHOP
    </div>

    <div class="seller">
        Seller:
        <strong><%= userName %></strong>
    </div>

</div>


<div class="container">

    <div class="form-card">

        <h1>
            ✏️ Edit Dress Product
        </h1>

        <p class="subtitle">
            Update your product details and inventory.
        </p>


        <div class="product-id">

            Product ID:
            <%= product.getProductId() %>

        </div>


        <%

            if (error != null && !error.isBlank()) {

        %>

            <div class="error">
                <%= error %>
            </div>

        <%

            }

        %>


        <form method="post"
              action="${pageContext.request.contextPath}/edit-product">


            <input type="hidden"
                   name="productId"
                   value="<%= product.getProductId() %>">


            <div class="form-group">

                <label>
                    Dress Name
                </label>

                <input type="text"
                       name="name"
                       value="<%= product.getName() == null ? "" : product.getName() %>"
                       required>

            </div>


            <div class="form-group">

                <label>
                    Description
                </label>

                <textarea
                    name="description"><%= product.getDescription() == null ? "" : product.getDescription() %></textarea>

            </div>


            <div class="row">

                <div class="form-group">

                    <label>
                        Category
                    </label>

                    <select name="category" required>

                        <option value="Saree"
                            <%= "Saree".equalsIgnoreCase(product.getCategory()) ? "selected" : "" %>>
                            Saree
                        </option>

                        <option value="Churidar"
                            <%= "Churidar".equalsIgnoreCase(product.getCategory()) ? "selected" : "" %>>
                            Churidar
                        </option>

                        <option value="Anarkali"
                            <%= "Anarkali".equalsIgnoreCase(product.getCategory()) ? "selected" : "" %>>
                            Anarkali
                        </option>

                        <option value="Kurti"
                            <%= "Kurti".equalsIgnoreCase(product.getCategory()) ? "selected" : "" %>>
                            Kurti
                        </option>

                        <option value="Gown"
                            <%= "Gown".equalsIgnoreCase(product.getCategory()) ? "selected" : "" %>>
                            Gown
                        </option>

                        <option value="Lehenga"
                            <%= "Lehenga".equalsIgnoreCase(product.getCategory()) ? "selected" : "" %>>
                            Lehenga
                        </option>

                    </select>

                </div>


                <div class="form-group">

                    <label>
                        Size
                    </label>

                    <select name="size" required>

                        <option value="XS"
                            <%= "XS".equalsIgnoreCase(product.getSize()) ? "selected" : "" %>>
                            XS
                        </option>

                        <option value="S"
                            <%= "S".equalsIgnoreCase(product.getSize()) ? "selected" : "" %>>
                            S
                        </option>

                        <option value="M"
                            <%= "M".equalsIgnoreCase(product.getSize()) ? "selected" : "" %>>
                            M
                        </option>

                        <option value="L"
                            <%= "L".equalsIgnoreCase(product.getSize()) ? "selected" : "" %>>
                            L
                        </option>

                        <option value="XL"
                            <%= "XL".equalsIgnoreCase(product.getSize()) ? "selected" : "" %>>
                            XL
                        </option>

                        <option value="XXL"
                            <%= "XXL".equalsIgnoreCase(product.getSize()) ? "selected" : "" %>>
                            XXL
                        </option>

                    </select>

                </div>

            </div>


            <div class="row">

                <div class="form-group">

                    <label>
                        Color
                    </label>

                    <input type="text"
                           name="color"
                           value="<%= product.getColor() == null ? "" : product.getColor() %>"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Price (₹)
                    </label>

                    <input type="number"
                           name="price"
                           step="0.01"
                           min="1"
                           value="<%= product.getPrice() %>"
                           required>

                </div>

            </div>


            <div class="form-group">

                <label>
                    Stock Quantity
                </label>

                <input type="number"
                       name="stockQuantity"
                       min="0"
                       value="<%= product.getStockQuantity() %>"
                       required>

            </div>


            <div class="form-group">

                <label>
                    Image URL
                </label>

                <input type="text"
                       name="imageUrl"
                       value="<%= product.getImageUrl() == null ? "" : product.getImageUrl() %>"
                       placeholder="https://example.com/dress.jpg">

            </div>


            <div class="btn-row">

                <button type="submit"
                        class="update-btn">

                    💾 Update Product

                </button>


                <a class="back-btn"
                   href="${pageContext.request.contextPath}/seller-dashboard">

                    ← Back to Dashboard

                </a>

            </div>

        </form>

    </div>

</div>

</body>

</html>