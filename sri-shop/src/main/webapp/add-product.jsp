<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");

    if (userName == null || !"SELLER".equalsIgnoreCase(userRole)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sri Shop - Add Product</title>

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
            padding: 20px 40px;
        }

        .header h1 {
            margin: 0;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
        }

        .form-card {
            background: white;
            padding: 35px;
            border-radius: 18px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }

        .form-card h2 {
            margin-top: 0;
            color: #0f766e;
        }

        .seller-info {
            background: #f0fdfa;
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 25px;
        }

        .message {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .success {
            background: #dcfce7;
            color: #166534;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
        }

        input,
        textarea,
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
        }

        input:focus,
        textarea:focus,
        select:focus {
            border-color: #0f766e;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        .row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .btn {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 8px;
            background: #0f766e;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn:hover {
            background: #115e59;
        }

        .back {
            display: inline-block;
            margin-top: 15px;
            color: #0f766e;
            text-decoration: none;
            font-weight: bold;
        }

        @media (max-width: 600px) {
            .row {
                grid-template-columns: 1fr;
            }

            .container {
                margin: 20px auto;
                padding: 10px;
            }

            .form-card {
                padding: 25px;
            }
        }
    </style>
</head>

<body>

<div class="header">
    <h1>SRI SHOP - Add Product</h1>
</div>

<div class="container">

    <div class="form-card">

        <h2>➕ Add New Dress</h2>

        <div class="seller-info">
            Seller:
            <strong><%= userName %></strong>
        </div>

        <% if ("true".equals(success)) { %>
            <div class="message success">
                ✅ Dress product added successfully!
            </div>
        <% } %>

        <% if ("required".equals(error)) { %>
            <div class="message error">
                ❌ Please fill all required fields.
            </div>
        <% } else if ("invalid".equals(error)) { %>
            <div class="message error">
                ❌ Please enter valid price and stock values.
            </div>
        <% } else if ("failed".equals(error)) { %>
            <div class="message error">
                ❌ Product could not be added. Please try again.
            </div>
        <% } else if ("server".equals(error)) { %>
            <div class="message error">
                ❌ Server error occurred. Please try again.
            </div>
        <% } %>

        <!-- IMPORTANT: Connected to AddProductServlet -->
        <form action="${pageContext.request.contextPath}/add-product" method="post">

            <!-- Dress Name -->
            <div class="form-group">
                <label for="name">Dress Name</label>

                <input
                    type="text"
                    id="name"
                    name="name"
                    placeholder="Enter dress name"
                    maxlength="150"
                    required>
            </div>

            <!-- Description -->
            <div class="form-group">
                <label for="description">Description</label>

                <textarea
                    id="description"
                    name="description"
                    placeholder="Enter dress description"></textarea>
            </div>

            <!-- Category + Size -->
            <div class="row">

                <div class="form-group">
                    <label for="category">Category</label>

                    <select
                        id="category"
                        name="category"
                        required>

                        <option value="">Select Category</option>
                        <option value="Saree">Saree</option>
                        <option value="Churidar">Churidar</option>
                        <option value="Anarkali">Anarkali</option>
                        <option value="Kurti">Kurti</option>
                        <option value="Gown">Gown</option>
                        <option value="Lehenga">Lehenga</option>

                    </select>
                </div>

                <div class="form-group">
                    <label for="size">Size</label>

                    <select
                        id="size"
                        name="size"
                        required>

                        <option value="">Select Size</option>
                        <option value="XS">XS</option>
                        <option value="S">S</option>
                        <option value="M">M</option>
                        <option value="L">L</option>
                        <option value="XL">XL</option>
                        <option value="XXL">XXL</option>

                    </select>
                </div>

            </div>

            <!-- Color + Price -->
            <div class="row">

                <div class="form-group">
                    <label for="color">Color</label>

                    <input
                        type="text"
                        id="color"
                        name="color"
                        placeholder="Example: Blue"
                        maxlength="50"
                        required>
                </div>

                <div class="form-group">
                    <label for="price">Price (₹)</label>

                    <input
                        type="number"
                        id="price"
                        name="price"
                        min="0"
                        step="0.01"
                        placeholder="Example: 1499"
                        required>
                </div>

            </div>

            <!-- Stock + Image -->
            <div class="row">

                <div class="form-group">
                    <label for="stock">Stock Quantity</label>

                    <input
                        type="number"
                        id="stock"
                        name="stock"
                        min="0"
                        placeholder="Example: 20"
                        required>
                </div>

                <div class="form-group">
                    <label for="imageUrl">Image URL</label>

                    <input
                        type="url"
                        id="imageUrl"
                        name="imageUrl"
                        maxlength="500"
                        placeholder="https://example.com/dress.jpg">
                </div>

            </div>

            <!-- Submit -->
            <button type="submit" class="btn">
                Add Dress Product
            </button>

        </form>

        <a
            class="back"
            href="${pageContext.request.contextPath}/seller-dashboard.jsp">
            ← Back to Seller Dashboard
        </a>

    </div>

</div>

</body>
</html>