<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.srimart.model.Product" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");

    if (userName == null || !"BUYER".equalsIgnoreCase(userRole)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Product product = (Product) request.getAttribute("product");

    if (product == null) {
        response.sendRedirect(request.getContextPath() + "/products");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Virtual Trial Room - SRI SHOP</title>

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

        .back {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 20px;
        }

        .title {
            text-align: center;
            margin-bottom: 30px;
        }

        .title h1 {
            color: #0f766e;
            margin-bottom: 8px;
        }

        .title p {
            color: #64748b;
        }

        .trial-box {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }

        .upload-section {
            text-align: center;
            padding: 25px;
            border: 2px dashed #0f766e;
            border-radius: 15px;
        }

        .upload-section h2 {
            color: #0f766e;
        }

        .upload-section input {
            margin-top: 15px;
            width: 100%;
        }

        .preview {
            margin-top: 20px;
            min-height: 300px;
            background: #f0fdfa;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .preview img {
            max-width: 100%;
            max-height: 400px;
            border-radius: 12px;
        }

        .dress-section {
            text-align: center;
        }

        .dress-section h2 {
            color: #0f766e;
        }

        .dress-image {
            height: 350px;
            background: #ccfbf1;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .dress-image img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .no-image {
            font-size: 80px;
        }

        .product-name {
            font-size: 22px;
            font-weight: bold;
            margin: 18px 0 8px;
        }

        .price {
            color: #0f766e;
            font-size: 24px;
            font-weight: bold;
        }

        .info {
            color: #64748b;
            margin-top: 8px;
        }

        .message {
            margin-top: 20px;
            padding: 12px;
            background: #ccfbf1;
            border-radius: 8px;
            color: #0f766e;
            font-weight: bold;
        }

        @media (max-width: 750px) {

            .trial-box {
                grid-template-columns: 1fr;
            }

            .header {
                padding: 15px 20px;
            }

        }

    </style>

</head>

<body>

<div class="header">

    <div class="logo">
        🛍️ SRI SHOP
    </div>

    <a class="back"
       href="${pageContext.request.contextPath}/products">
        ← Back to Dresses
    </a>

</div>


<div class="container">

    <div class="title">

        <h1>✨ Virtual Trial Room</h1>

        <p>
            Upload your photo and preview the selected dress.
        </p>

    </div>


    <div class="trial-box">


        <!-- USER PHOTO -->

        <div class="upload-section">

            <h2>📸 Your Photo</h2>

            <p>
                Upload a photo to start your virtual trial.
            </p>

            <input
                type="file"
                id="photoInput"
                accept="image/*">

            <div class="preview" id="photoPreview">

                <span>
                    Your photo will appear here
                </span>

            </div>

        </div>


        <!-- SELECTED DRESS -->

        <div class="dress-section">

            <h2>👗 Selected Dress</h2>

            <div class="dress-image">

                <% if (product.getImageUrl() != null
                        && !product.getImageUrl().isBlank()) { %>

                    <img
                        src="<%= product.getImageUrl() %>"
                        alt="<%= product.getName() %>">

                <% } else { %>

                    <div class="no-image">
                        👗
                    </div>

                <% } %>

            </div>


            <div class="product-name">
                <%= product.getName() %>
            </div>

            <div class="price">
                ₹<%= product.getPrice() %>
            </div>

            <div class="info">

                Size:
                <strong><%= product.getSize() %></strong>

                &nbsp; | &nbsp;

                Color:
                <strong><%= product.getColor() %></strong>

            </div>


            <div class="message">
                ✨ Upload your photo to preview the dress.
            </div>

        </div>

    </div>

</div>


<script>

    const photoInput =
        document.getElementById("photoInput");

    const photoPreview =
        document.getElementById("photoPreview");


    photoInput.addEventListener("change", function () {

        const file = this.files[0];

        if (!file) {
            return;
        }

        const reader = new FileReader();

        reader.onload = function (event) {

            photoPreview.innerHTML =
                '<img src="' +
                event.target.result +
                '" alt="Your Photo">';

        };

        reader.readAsDataURL(file);

    });

</script>

</body>

</html>