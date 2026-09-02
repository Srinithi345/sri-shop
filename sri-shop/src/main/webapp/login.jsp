<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Sri Shop - Login</title>

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

        .login-card {
            width: 420px;
            background: white;
            padding: 35px;
            border-radius: 18px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.25);
        }

        .logo {
            text-align: center;
            font-size: 32px;
            font-weight: bold;
            color: #0f766e;
            margin-bottom: 5px;
        }

        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 28px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            color: #333;
        }

        input {
            width: 100%;
            padding: 13px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }

        input:focus {
            outline: none;
            border-color: #0f766e;
        }

        button {
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

        button:hover {
            background: #115e59;
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }

        .register-link a {
            color: #0f766e;
            text-decoration: none;
            font-weight: bold;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .error {
            color: #dc2626;
            text-align: center;
            margin-bottom: 15px;
            font-weight: bold;
        }

        /* SUCCESS MESSAGE */
        .success {
            color: #15803d;
            text-align: center;
            margin-bottom: 15px;
            font-weight: bold;
            background: #f0fdf4;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #bbf7d0;
        }

    </style>

</head>

<body>

<div class="login-card">

    <div class="logo">
        SRI SHOP
    </div>

    <div class="subtitle">
        Welcome back! Please login to continue.
    </div>


    <!-- SUCCESS MESSAGE -->

    <%
        String success = request.getParameter("success");

        if (success != null && !success.isEmpty()) {
    %>

        <div class="success">
            <%= success %>
        </div>

    <%
        }
    %>


    <!-- ERROR MESSAGE -->

    <%
        String error = request.getParameter("error");

        if (error != null && !error.isEmpty()) {
    %>

        <div class="error">
            <%= error %>
        </div>

    <%
        }
    %>


    <!-- LOGIN FORM -->

    <form action="${pageContext.request.contextPath}/login"
          method="post">

        <label for="email">
            Email
        </label>

        <input
            type="email"
            id="email"
            name="email"
            placeholder="Enter your email"
            required>


        <label for="password">
            Password
        </label>

        <input
            type="password"
            id="password"
            name="password"
            placeholder="Enter your password"
            required>


        <button type="submit">
            Login
        </button>

    </form>


    <!-- REGISTER -->

    <div class="register-link">

        Don't have an account?

        <a href="register.jsp">
            Create Account
        </a>

    </div>

</div>

</body>

</html>