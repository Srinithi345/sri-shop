<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");

    if (userName == null || !"SELLER".equalsIgnoreCase(userRole)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sri Shop - Seller Dashboard</title>

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
            font-weight: bold;
        }

        .btn:hover {
            background: #115e59;
        }
    </style>
</head>

<body>

<div class="header">

    <h1>SRI SHOP - SELLER</h1>

    <a class="logout"
       href="${pageContext.request.contextPath}/login.jsp">
        Logout
    </a>

</div>

<div class="container">

    <div class="welcome">

        <h2>
            Welcome, <%= userName %>! 👋
        </h2>

        <p>
            Welcome to your Sri Shop Seller Dashboard.
        </p>

    </div>

    <div class="cards">

        <div class="card">

            <h3>➕ Add Dress</h3>

            <p>
                Add a new dress product to Sri Shop.
            </p>

            <a class="btn"
               href="#">
                Add Product
            </a>

        </div>


        <div class="card">

            <h3>👗 My Products</h3>

            <p>
                View and manage your dress products.
            </p>

            <a class="btn"
               href="#">
                View Products
            </a>

        </div>


        <div class="card">

            <h3>📦 Orders</h3>

            <p>
                View orders received from buyers.
            </p>

            <a class="btn"
               href="#">
                View Orders
            </a>

        </div>


        <div class="card">

            <h3>⭐ Reviews</h3>

            <p>
                View reviews given by buyers.
            </p>

            <a class="btn"
               href="#">
                View Reviews
            </a>

        </div>

    </div>

</div>

</body>
</html>