<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout - SRI SHOP</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f1f5f9;
            color: #1e293b;
        }

        .header {
            background: #0f766e;
            color: white;
            padding: 18px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            margin: 0;
            font-size: 26px;
        }

        .back-btn {
            background: white;
            color: #0f766e;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 8px;
            font-weight: bold;
        }

        .container {
            max-width: 1100px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .title {
            color: #134e4a;
        }

        .checkout-layout {
            display: grid;
            grid-template-columns: 1fr 360px;
            gap: 25px;
        }

        .card,
        .summary {
            background: white;
            border-radius: 14px;
            padding: 25px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.07);
            margin-bottom: 20px;
        }

        h2 {
            color: #0f766e;
            border-bottom: 1px solid #e2e8f0;
            padding-bottom: 15px;
        }

        label {
            display: block;
            margin-top: 16px;
            margin-bottom: 7px;
            font-weight: bold;
        }

        input,
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        .payment-option {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 15px 0;
            padding: 12px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
        }

        .payment-option input {
            width: auto;
        }

        .payment-option label {
            margin: 0;
        }

        .note {
            background: #f0fdfa;
            color: #115e59;
            padding: 12px;
            border-radius: 8px;
            font-size: 13px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin: 18px 0;
        }

        .free {
            color: #15803d;
            font-weight: bold;
        }

        .total {
            border-top: 1px solid #e2e8f0;
            padding-top: 18px;
            font-size: 21px;
            font-weight: bold;
        }

        .place-order-btn {
            width: 100%;
            padding: 15px;
            margin-top: 15px;
            background: #0f766e;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
        }

        .secure {
            text-align: center;
            color: #64748b;
            font-size: 13px;
            margin-top: 15px;
        }

        @media (max-width: 800px) {
            .checkout-layout {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<div class="header">
    <h1>🛍️ SRI SHOP</h1>

    <a class="back-btn"
       href="${pageContext.request.contextPath}/cart">
        ← Back to Cart
    </a>
</div>

<div class="container">

    <h1 class="title">Checkout</h1>

    <form method="post"
          action="${pageContext.request.contextPath}/place-order">

        <div class="checkout-layout">

            <div>

                <div class="card">

                    <h2>📍 Delivery Address</h2>

                    <label>Full Name</label>
                    <input type="text"
                           name="fullName"
                           placeholder="Enter your full name"
                           required>

                    <label>Phone Number</label>
                    <input type="tel"
                           name="phone"
                           placeholder="Enter 10-digit phone number"
                           pattern="[0-9]{10}"
                           maxlength="10"
                           required>

                    <label>Address</label>
                    <textarea name="address"
                              placeholder="Enter your complete address"
                              required></textarea>

                    <label>City</label>
                    <input type="text"
                           name="city"
                           placeholder="Enter your city"
                           required>

                    <label>State</label>
                    <input type="text"
                           name="state"
                           placeholder="Enter your state"
                           required>

                    <label>PIN Code</label>
                    <input type="text"
                           name="pincode"
                           placeholder="Enter 6-digit PIN code"
                           pattern="[0-9]{6}"
                           maxlength="6"
                           required>

                </div>

                <div class="card">

                    <h2>💳 Payment Method</h2>

                    <div class="payment-option">
                        <input type="radio"
                               id="cod"
                               name="payment"
                               value="COD"
                               checked>

                        <label for="cod">
                            💵 Cash on Delivery
                        </label>
                    </div>

                    <div class="payment-option">
                        <input type="radio"
                               id="online"
                               name="payment"
                               value="ONLINE">

                        <label for="online">
                            💳 Online Payment
                        </label>
                    </div>

                    <div class="note">
                        Online payment integration will be added later.
                        Cash on Delivery is currently available.
                    </div>

                </div>

            </div>

            <div class="summary">

                <h2>🛒 Order Summary</h2>

                <div class="summary-row">
                    <span>Items</span>

                    <a href="${pageContext.request.contextPath}/cart">
                        View Cart
                    </a>
                </div>

                <div class="summary-row">
                    <span>Delivery</span>

                    <span class="free">
                        FREE
                    </span>
                </div>

                <div class="summary-row total">
                    <span>Total Amount</span>
                    <span>₹ Check Cart</span>
                </div>

                <button type="submit"
                        class="place-order-btn">
                    🛍️ Place Order
                </button>

                <div class="secure">
                    🔒 Your order information is secure.
                </div>

            </div>

        </div>

    </form>

</div>

</body>
</html>