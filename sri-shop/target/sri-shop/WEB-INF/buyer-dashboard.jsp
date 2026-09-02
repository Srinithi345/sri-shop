<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sri Shop - Buyer Dashboard</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7f7;
        }

        .navbar {
            background: #134e4a;
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

        .user-info {
            text-align: right;
        }

        .container {
            padding: 40px;
        }

        .welcome {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }

        .welcome h1 {
            color: #134e4a;
            margin-top: 0;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .card h2 {
            color: #0f766e;
        }

        .card p {
            color: #666;
        }

        .card button {
            background: #0f766e;
            color: white;
            border: none;
            padding: 11px 22px;
            border-radius: 8px;
            cursor: pointer;
        }

        .logout {
            color: white;
            text-decoration: none;
            margin-left: 20px;
        }
    </style>
</head>

<body>

<div class="navbar">

    <div class="logo">
        SRI SHOP
    </div>

    <div class="user-info">
        Welcome, <strong><%= userName %></strong>
        <br>
        <small><%= userRole %></small>

        <a class="logout"
           href="<%= request.getContextPath() %>/logout">
            Logout
        </a>
    </div>

</div>

<div class="container">

    <div class="welcome">

        <h1>Welcome to Sri Shop 👋</h1>

        <p>
            Browse dresses, add products to your cart,
            and manage your orders from here.
        </p>

    </div>

    <div class="cards">

        <div class="card">
            <h2>🛍️ Products</h2>
            <p>Browse available dresses.</p>
            <button>View Products</button>
        </div>

        <div class="card">
            <h2>🛒 My Cart</h2>
            <p>View your shopping cart.</p>
            <button>Open Cart</button>
        </div>

        <div class="card">
            <h2>📦 My Orders</h2>
            <p>Track your orders.</p>
            <button>View Orders</button>
        </div>

    </div>

</div>

</body>
</html>