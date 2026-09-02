<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String userName = (String) session.getAttribute("userName");

    if (userName == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
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
            background: #f0fdfa;
            color: #134e4a;
        }

        .header {
            background: #0f766e;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            margin: 0;
        }

        .logout {
            background: white;
            color: #0f766e;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
        }

        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 20px;
        }

        .welcome {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }

        .welcome h2 {
            margin-top: 0;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-top: 25px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }

        .card h3 {
            color: #0f766e;
        }

        .card p {
            color: #666;
        }

        .btn {
            display: inline-block;
            background: #0f766e;
            color: white;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="header">
    <h1>SRI SHOP</h1>

    <a class="logout"
       href="${pageContext.request.contextPath}/login.jsp">
        Logout
    </a>
</div>

<div class="container">

    <div class="welcome">
        <h2>Welcome, <%= userName %>! 👋</h2>
        <p>Welcome to your Sri Shop Buyer Dashboard.</p>
    </div>

    <div class="cards">

        <div class="card">
            <h3>👗 Browse Dresses</h3>
            <p>Explore available dress products.</p>
            <a class="btn" href="#">Browse</a>
        </div>

        <div class="card">
            <h3>🛒 My Cart</h3>
            <p>View products added to your cart.</p>
            <a class="btn" href="#">View Cart</a>
        </div>

        <div class="card">
            <h3>📦 My Orders</h3>
            <p>View your previous and current orders.</p>
            <a class="btn" href="#">Orders</a>
        </div>

        <div class="card">
            <h3>⭐ My Reviews</h3>
            <p>View and manage your product reviews.</p>
            <a class="btn" href="#">Reviews</a>
        </div>

    </div>

</div>

</body>
</html>