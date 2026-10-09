<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Write a Review - SRI SHOP</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #222;
            min-height: 100vh;
        }

        .header {
            background: #117c73;
            color: white;
            padding: 18px 30px;
            font-size: 26px;
            font-weight: bold;
        }

        .container {
            width: 92%;
            max-width: 550px;
            margin: 45px auto;
        }

        .review-box {
            background: white;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        h1 {
            margin: 0 0 8px;
            text-align: center;
            color: #222;
        }

        .subtitle {
            text-align: center;
            color: #64748b;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 18px;
            margin-bottom: 7px;
            font-weight: bold;
            color: #374151;
        }

        select,
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
            font-family: Arial, sans-serif;
            background: white;
        }

        select:focus,
        textarea:focus {
            outline: none;
            border-color: #117c73;
            box-shadow: 0 0 0 2px rgba(17, 124, 115, 0.12);
        }

        textarea {
            min-height: 130px;
            resize: vertical;
        }

        .submit-btn {
            width: 100%;
            margin-top: 24px;
            padding: 13px;
            border: none;
            border-radius: 8px;
            background: #117c73;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .submit-btn:hover {
            background: #0f665f;
        }

        .back-btn {
            display: block;
            text-align: center;
            margin-top: 15px;
            padding: 11px;
            color: #117c73;
            text-decoration: none;
            font-weight: bold;
        }

        .back-btn:hover {
            text-decoration: underline;
        }

        @media (max-width: 600px) {

            .header {
                padding: 16px 20px;
                font-size: 23px;
            }

            .container {
                width: 94%;
                margin: 25px auto;
            }

            .review-box {
                padding: 22px;
            }

        }

    </style>

</head>

<body>


<div class="header">

    &#128722; SRI SHOP

</div>


<div class="container">

    <div class="review-box">

        <h1>
            Write a Review
        </h1>

        <div class="subtitle">
            Share your experience with this product
        </div>


        <form
            action="${pageContext.request.contextPath}/reviews"
            method="post"
        >

            <input
                type="hidden"
                name="action"
                value="add"
            >

            <input
                type="hidden"
                name="productId"
                value="<%= request.getAttribute("productId") %>"
            >


            <label for="rating">
                Rating
            </label>

            <select
                id="rating"
                name="rating"
                required
            >

                <option value="">
                    Select Rating
                </option>

                <option value="5">
                    5 - Excellent
                </option>

                <option value="4">
                    4 - Very Good
                </option>

                <option value="3">
                    3 - Good
                </option>

                <option value="2">
                    2 - Fair
                </option>

                <option value="1">
                    1 - Poor
                </option>

            </select>


            <label for="comment">
                Your Review
            </label>

            <textarea
                id="comment"
                name="comment"
                placeholder="Write your review..."
                maxlength="1000"
                required
            ></textarea>


            <button
                type="submit"
                class="submit-btn"
            >
                Submit Review
            </button>

        </form>


        <a
            class="back-btn"
            href="${pageContext.request.contextPath}/products"
        >
            &#8592; Continue Shopping
        </a>

    </div>

</div>


</body>

</html>