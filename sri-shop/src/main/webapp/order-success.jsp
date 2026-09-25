<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Successful - Sri Shop</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
        }

        .container {
            width: 90%;
            max-width: 600px;
            margin: 80px auto;
            background: white;
            padding: 40px;
            text-align: center;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
        }

        .success {
            font-size: 60px;
        }

        h1 {
            color: #198754;
            margin-bottom: 10px;
        }

        .order-id {
            font-size: 18px;
            margin: 20px 0;
        }

        .amount {
            font-size: 24px;
            font-weight: bold;
            margin: 15px 0;
        }

        .payment {
            color: #555;
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            margin: 5px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            background: #0d6efd;
            color: white;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .home {
            background: #212529;
        }
    </style>
</head>

<body>

<div class="container">

    <div class="success">✓</div>

    <h1>Order Placed Successfully!</h1>

    <p>Thank you for shopping with <strong>Sri Shop</strong>.</p>

    <div class="order-id">
        Order ID:
        <strong>#${orderId}</strong>
    </div>

    <div class="amount">
        ₹${totalAmount}
    </div>

    <div class="payment">
        Payment Method:
        <strong>${payment}</strong>
    </div>

    <a class="btn"
       href="${pageContext.request.contextPath}/orders">
        View My Orders
    </a>

    <a class="btn home"
       href="${pageContext.request.contextPath}/products">
        Continue Shopping
    </a>

</div>

</body>
</html>