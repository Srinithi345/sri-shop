<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.srimart.model.Product" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");

    if (userName == null || !"BUYER".equalsIgnoreCase(userRole)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Product> products =
            (List<Product>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>SRI SHOP - Browse Dresses</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f8fafc;
            color: #134e4a;
        }

        /* HEADER */
        .header {
            background: #0f766e;
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

        .welcome {
            font-size: 15px;
        }

        .back {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-weight: bold;
        }

        /* MAIN */
        .container {
            max-width: 1200px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .page-title {
            text-align: center;
            margin-bottom: 35px;
        }

        .page-title h1 {
            margin-bottom: 8px;
            color: #115e59;
        }

        .page-title p {
            color: #64748b;
        }

        /* PRODUCT GRID */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        /* PRODUCT CARD */
        .product-card {
            background: white;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            transition: transform 0.25s, box-shadow 0.25s;
        }

        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 14px 35px rgba(0,0,0,0.12);
        }

        /* PRODUCT IMAGE */
        .product-image {
            width: 100%;
            height: 280px;
            background: #ccfbf1;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .product-image img {
            width: 100%;
            height: 280px;
            object-fit: cover;
            display: block;
        }

        .no-image {
            font-size: 55px;
        }

        /* PRODUCT INFORMATION */
        .product-info {
            padding: 20px;
        }

        .category {
            display: inline-block;
            background: #ccfbf1;
            color: #0f766e;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .product-name {
            margin: 5px 0;
            font-size: 20px;
            color: #134e4a;
        }

        .description {
            color: #64748b;
            font-size: 14px;
            min-height: 42px;
            margin: 10px 0;
        }

        .details {
            display: flex;
            justify-content: space-between;
            margin: 12px 0;
            font-size: 14px;
        }

        .price {
            font-size: 22px;
            font-weight: bold;
            color: #0f766e;
        }

        .stock {
            color: #475569;
        }

       