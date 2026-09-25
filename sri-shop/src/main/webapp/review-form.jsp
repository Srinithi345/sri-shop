<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Write a Review - SRI SHOP</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 40px;
        }

        .review-box {
            max-width: 500px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 6px;
            font-weight: bold;
        }

        select,
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        textarea {
            height: 120px;
            resize: vertical;
        }

        button {
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            border: none;
            border-radius: 6px;
            background: #111;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #333;
        }
    </style>
</head>

<body>

<div class="review-box">

    <h2>Write a Review</h2>

    <form action="${pageContext.request.contextPath}/reviews"
          method="post">

        <input type="hidden"
               name="action"
               value="add">

        <input type="hidden"
               name="productId"
               value="<%= request.getAttribute("productId") %>">

        <label for="rating">Rating</label>

        <select id="rating"
                name="rating"
                required>

            <option value="">Select Rating</option>
            <option value="5">5 - Excellent</option>
            <option value="4">4 - Very Good</option>
            <option value="3">3 - Good</option>
            <option value="2">2 - Fair</option>
            <option value="1">1 - Poor</option>

        </select>

        <label for="comment">Your Review</label>

        <textarea id="comment"
                  name="comment"
                  placeholder="Write your review..."
                  maxlength="1000"
                  required></textarea>

        <button type="submit">
            Submit Review
        </button>

    </form>

</div>

</body>
</html>