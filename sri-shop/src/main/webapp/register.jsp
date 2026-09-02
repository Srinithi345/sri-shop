<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Sri Shop - Create Account</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #0f766e, #134e4a);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-card {
            width: 420px;
            background: white;
            padding: 35px;
            border-radius: 18px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.25);
        }

        h1 {
            text-align: center;
            margin-bottom: 8px;
            color: #134e4a;
        }

        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 6px;
            font-weight: bold;
            color: #333;
        }

        input,
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }

        input:focus,
        select:focus {
            outline: none;
            border-color: #0f766e;
        }

        button {
            width: 100%;
            margin-top: 25px;
            padding: 13px;
            border: none;
            border-radius: 8px;
            background: #0f766e;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #115e59;
        }

        .login-link {
            text-align: center;
            margin-top: 18px;
            color: #666;
        }

        .login-link a {
            color: #0f766e;
            text-decoration: none;
            font-weight: bold;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .error {
            color: #dc2626;
            text-align: center;
            margin-bottom: 15px;
            font-weight: bold;
        }

        .success {
            color: #15803d;
            text-align: center;
            margin-bottom: 15px;
            font-weight: bold;
        }
    </style>
</head>

<body>

<div class="register-card">

    <h1>Create Account</h1>

    <p class="subtitle">
        Join Sri Shop
    </p>

    <%
        String error = request.getParameter("error");
        String success = request.getParameter("success");

        if (error != null && !error.isEmpty()) {
    %>

        <div class="error">
            <%= error %>
        </div>

    <%
        }

        if (success != null && !success.isEmpty()) {
    %>

        <div class="success">
            <%= success %>
        </div>

    <%
        }
    %>

    <form action="${pageContext.request.contextPath}/register"
          method="post">

        <label for="name">Full Name</label>

        <input type="text"
               id="name"
               name="name"
               placeholder="Enter your name"
               required>

        <label for="email">Email</label>

        <input type="email"
               id="email"
               name="email"
               placeholder="Enter your email"
               required>

        <label for="phone">Phone</label>

        <input type="tel"
               id="phone"
               name="phone"
               placeholder="Enter your phone number">

        <label for="password">Password</label>

        <input type="password"
               id="password"
               name="password"
               placeholder="Enter password"
               minlength="8"
               required>

        <label for="role">Account Type</label>

        <select id="role"
                name="role"
                required>

            <option value="">Select account type</option>
            <option value="BUYER">Buyer</option>
            <option value="SELLER">Seller</option>

        </select>

        <button type="submit">
            Create Account
        </button>

    </form>

    <div class="login-link">

        Already have an account?

        <a href="login.jsp">
            Login
        </a>

    </div>

</div>

</body>

</html>