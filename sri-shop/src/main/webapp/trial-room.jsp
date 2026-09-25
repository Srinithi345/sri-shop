<%@ page contentType="text/html;charset=UTF-8" %>

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
            background: #f5f5f5;
        }

        .header {
            background: #111;
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
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            display: grid;
            grid-template-columns: 1fr 1.2fr;
            gap: 30px;
            padding: 0 20px;
        }

        .panel {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .upload-box {
            border: 2px dashed #aaa;
            border-radius: 12px;
            padding: 30px;
            text-align: center;
            margin-bottom: 25px;
        }

        .upload-box input {
            margin-top: 15px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-top: 18px;
            margin-bottom: 8px;
        }

        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 7px;
            font-size: 15px;
        }

        .colors {
            display: flex;
            gap: 12px;
            margin-top: 10px;
        }

        .color {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            border: 3px solid white;
            outline: 1px solid #aaa;
            cursor: pointer;
        }

        .color.selected {
            outline: 3px solid #111;
        }

        .black {
            background: black;
        }

        .red {
            background: #c62828;
        }

        .blue {
            background: #2457d6;
        }

        .green {
            background: #16843c;
        }

        .pink {
            background: #ed3d91;
        }

        .buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-top: 25px;
        }

        button {
            padding: 13px;
            border: none;
            border-radius: 7px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
        }

        .try-btn {
            background: #111;
            color: white;
        }

        .cart-btn {
            background: #e5e5e5;
            color: #111;
        }

        .try-btn:hover {
            background: #333;
        }

        .cart-btn:hover {
            background: #d2d2d2;
        }

        .preview {
            background: #eee;
            min-height: 550px;
            border-radius: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        #userImage {
            max-width: 100%;
            max-height: 520px;
            display: none;
            object-fit: contain;
        }

        .dress-overlay {
            position: absolute;
            width: 48%;
            height: 48%;
            top: 25%;
            left: 26%;
            border-radius: 45% 45% 25% 25%;
            opacity: 0.65;
            display: none;
            pointer-events: none;
        }

        .message {
            margin-top: 15px;
            text-align: center;
            color: #555;
            font-size: 14px;
        }

        .product-info {
            background: #f8f8f8;
            padding: 12px;
            border-radius: 8px;
            margin-top: 15px;
            font-size: 14px;
        }

        @media(max-width: 800px) {
            .container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<div class="header">

    <div class="logo">
        SRI SHOP
    </div>

    <a class="back"
       href="${pageContext.request.contextPath}/">
        ← Back to Shop
    </a>

</div>


<%
    String productId = request.getParameter("productId");

    if (productId == null || productId.isBlank()) {
        productId = "0";
    }
%>


<div class="container">

    <!-- LEFT PANEL -->

    <div class="panel">

        <h2>Virtual Trial Room</h2>


        <!-- PHOTO UPLOAD -->

        <div class="upload-box">

            <div>
                Upload your photo
            </div>

            <input type="file"
                   id="photoInput"
                   accept="image/*">

            <div id="fileName"></div>

        </div>


        <!-- DRESS -->

        <label for="dress">
            Select Dress
        </label>

        <select id="dress">

            <option value="Kurti">
                Kurti
            </option>

            <option value="Saree">
                Saree
            </option>

            <option value="Gown">
                Gown
            </option>

            <option value="Salwar">
                Salwar
            </option>

        </select>


        <!-- SIZE -->

        <label for="size">
            Select Size
        </label>

        <select id="size">

            <option value="">
                Select Size
            </option>

            <option value="S">
                S
            </option>

            <option value="M">
                M
            </option>

            <option value="L">
                L
            </option>

            <option value="XL">
                XL
            </option>

            <option value="XXL">
                XXL
            </option>

        </select>


        <!-- COLOR -->

        <label>
            Select Color
        </label>

        <div class="colors">

            <div class="color black selected"
                 data-color="Black"
                 onclick="selectColor(this)">
            </div>

            <div class="color red"
                 data-color="Red"
                 onclick="selectColor(this)">
            </div>

            <div class="color blue"
                 data-color="Blue"
                 onclick="selectColor(this)">
            </div>

            <div class="color green"
                 data-color="Green"
                 onclick="selectColor(this)">
            </div>

            <div class="color pink"
                 data-color="Pink"
                 onclick="selectColor(this)">
            </div>

        </div>


        <!-- QUANTITY -->

        <label for="quantity">
            Quantity
        </label>

        <select id="quantity">

            <option value="1">
                1
            </option>

            <option value="2">
                2
            </option>

            <option value="3">
                3
            </option>

            <option value="4">
                4
            </option>

            <option value="5">
                5
            </option>

        </select>


        <!-- PRODUCT ID -->

        <div class="product-info">

            <strong>
                Product ID:
            </strong>

            <%= productId %>

        </div>


        <!-- BUTTONS -->

        <div class="buttons">

            <button type="button"
                    class="try-btn"
                    onclick="tryDress()">

                Try Dress

            </button>


            <button type="submit"
                    form="cartForm"
                    class="cart-btn"
                    onclick="return validateCart()">

                🛒 Add to Cart

            </button>

        </div>


        <div class="message"
             id="message">

            Select your dress, size and color.

        </div>

    </div>


    <!-- PREVIEW PANEL -->

    <div class="panel">

        <h2>
            Preview
        </h2>

        <div class="preview">

            <div id="emptyText">

                Upload your photo to preview

            </div>

            <img id="userImage"
                 alt="Your Photo">

            <div id="dressOverlay"
                 class="dress-overlay">
            </div>

        </div>

    </div>

</div>


<!-- REAL CART FORM -->

<form id="cartForm"
      method="post"
      action="${pageContext.request.contextPath}/cart">

    <input type="hidden"
           name="action"
           value="add">


    <input type="hidden"
           name="productId"
           id="cartProductId"
           value="<%= productId %>">


    <input type="hidden"
           name="quantity"
           id="cartQuantity">


    <input type="hidden"
           name="size"
           id="cartSize">


    <input type="hidden"
           name="color"
           id="cartColor"
           value="Black">

</form>


<script>

    let selectedColor = "Black";


    /* PHOTO UPLOAD */

    document.getElementById("photoInput")
        .addEventListener("change", function(event) {

            const file =
                event.target.files[0];

            if (!file) {
                return;
            }

            document.getElementById("fileName")
                .innerText = file.name;

            const reader =
                new FileReader();

            reader.onload =
                function(e) {

                    const image =
                        document.getElementById(
                            "userImage"
                        );

                    image.src =
                        e.target.result;

                    image.style.display =
                        "block";

                    document.getElementById(
                        "emptyText"
                    ).style.display =
                        "none";

                };

            reader.readAsDataURL(file);

        });


    /* COLOR SELECTION */

    function selectColor(element) {

        document
            .querySelectorAll(".color")
            .forEach(function(color) {

                color.classList.remove(
                    "selected"
                );

            });

        element.classList.add(
            "selected"
        );

        selectedColor =
            element.getAttribute(
                "data-color"
            );

        updateOverlay();

    }


    /* UPDATE COLOR */

    function updateOverlay() {

        const overlay =
            document.getElementById(
                "dressOverlay"
            );


        if (selectedColor === "Black") {

            overlay.style.background =
                "black";

        }

        else if (selectedColor === "Red") {

            overlay.style.background =
                "#c62828";

        }

        else if (selectedColor === "Blue") {

            overlay.style.background =
                "#2457d6";

        }

        else if (selectedColor === "Green") {

            overlay.style.background =
                "#16843c";

        }

        else if (selectedColor === "Pink") {

            overlay.style.background =
                "#ed3d91";

        }

    }


    /* TRY DRESS */

    function tryDress() {

        const image =
            document.getElementById(
                "userImage"
            );


        if (image.style.display === "none") {

            alert(
                "Please upload your photo first."
            );

            return;

        }


        const overlay =
            document.getElementById(
                "dressOverlay"
            );

        overlay.style.display =
            "block";


        updateOverlay();


        const dress =
            document.getElementById(
                "dress"
            ).value;


        document.getElementById(
            "message"
        ).innerText =
            dress +
            " selected in " +
            selectedColor +
            ". Virtual preview updated.";

    }


    /* ADD TO CART VALIDATION */

    function validateCart() {

        const productId =
            document.getElementById(
                "cartProductId"
            ).value;


        const size =
            document.getElementById(
                "size"
            ).value;


        const quantity =
            document.getElementById(
                "quantity"
            ).value;


        if (!productId ||
            productId === "0") {

            alert(
                "Invalid product."
            );

            return false;

        }


        if (!size) {

            alert(
                "Please select a size."
            );

            return false;

        }


        if (!selectedColor) {

            alert(
                "Please select a color."
            );

            return false;

        }


        document.getElementById(
            "cartQuantity"
        ).value =
            quantity;


        document.getElementById(
            "cartSize"
        ).value =
            size;


        document.getElementById(
            "cartColor"
        ).value =
            selectedColor;


        document.getElementById(
            "message"
        ).innerText =
            "Adding product to cart...";


        return true;

    }


    updateOverlay();

</script>

</body>
</html>