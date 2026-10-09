<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String userName = (String) session.getAttribute("userName");

    if (userName == null) {
        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
        return;
    }

    String success = request.getParameter("success");
    String error = request.getParameter("error");

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SRI SHOP - Change Password</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f0fdfa;
            color: #134e4a;
            min-height: 100vh;
        }

        header {
            background: #0f766e;
            color: white;
            padding: 16px 6%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            flex-wrap: wrap;
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
        }

        nav {
            display: flex;
            align-items: center;
            gap: 18px;
            flex-wrap: wrap;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }

        nav a:hover {
            text-decoration: underline;
        }

        .page {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .title-section {
            margin-bottom: 25px;
        }

        .title-section h1 {
            font-size: 30px;
            color: #115e59;
            margin-bottom: 8px;
        }

        .title-section p {
            color: #64748b;
            font-size: 15px;
        }

        .card {
            background: white;
            border-radius: 18px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(15, 118, 110, 0.10);
            border: 1px solid #ccfbf1;
            max-width: 650px;
        }

        .alert {
            padding: 13px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .success {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 700;
            color: #334155;
        }

        .form-group input {
            width: 100%;
            padding: 13px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            font-size: 15px;
            outline: none;
            transition: 0.2s;
        }

        .form-group input:focus {
            border-color: #0f766e;
            box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.10);
        }

        .hint {
            margin-top: 7px;
            color: #64748b;
            font-size: 12px;
        }

        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 25px;
            flex-wrap: wrap;
        }

        .btn {
            border: none;
            border-radius: 10px;
            padding: 13px 20px;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
            display: inline-block;
        }

        .btn-primary {
            background: #0f766e;
            color: white;
        }

        .btn-primary:hover {
            background: #115e59;
        }

        .btn-secondary {
            background: #e2e8f0;
            color: #334155;
        }

        .btn-secondary:hover {
            background: #cbd5e1;
        }

        .security-box {
            margin-top: 25px;
            padding: 18px;
            background: #f0fdfa;
            border: 1px solid #ccfbf1;
            border-radius: 12px;
        }

        .security-box h3 {
            font-size: 15px;
            color: #115e59;
            margin-bottom: 8px;
        }

        .security-box ul {
            padding-left: 20px;
            color: #64748b;
            font-size: 13px;
            line-height: 1.8;
        }

        @media (max-width: 600px) {

            header {
                padding: 14px 5%;
            }

            nav {
                gap: 12px;
            }

            .page {
                margin: 25px auto;
                padding: 0 15px;
            }

            .card {
                padding: 22px;
            }

            .title-section h1 {
                font-size: 25px;
            }

            .buttons {
                flex-direction: column;
            }

            .btn {
                text-align: center;
                width: 100%;
            }
        }

    </style>
</head>

<body>

<header>

    <div class="logo">
        🛍️ SRI SHOP
    </div>

    <nav>
        <a href="<%= contextPath %>/buyer-dashboard.jsp">Dashboard</a>
        <a href="<%= contextPath %>/products">Shop</a>
        <a href="<%= contextPath %>/wishlist">Wishlist</a>
        <a href="<%= contextPath %>/cart">Cart</a>
        <a href="<%= contextPath %>/profile">Profile</a>
        <a href="<%= contextPath %>/logout">Logout</a>
    </nav>

</header>

<main class="page">

    <section class="title-section">

        <h1>Change Password</h1>

        <p>
            Keep your SRI SHOP account secure by updating your password.
        </p>

    </section>

    <div class="card">

        <% if (success != null && !success.isBlank()) { %>

            <div class="alert success">
                ✅ <%= success %>
            </div>

        <% } %>

        <% if (error != null && !error.isBlank()) { %>

            <div class="alert error">
                ❌ <%= error %>
            </div>

        <% } %>

        <form
                method="post"
                action="<%= contextPath %>/change-password">

            <div class="form-group">

                <label for="currentPassword">
                    Current Password
                </label>

                <input
                        type="password"
                        id="currentPassword"
                        name="currentPassword"
                        placeholder="Enter current password"
                        required>

            </div>

            <div class="form-group">

                <label for="newPassword">
                    New Password
                </label>

                <input
                        type="password"
                        id="newPassword"
                        name="newPassword"
                        placeholder="Enter new password"
                        minlength="6"
                        required>

                <div class="hint">
                    Password must contain at least 6 characters.
                </div>

            </div>

            <div class="form-group">

                <label for="confirmPassword">
                    Confirm New Password
                </label>

                <input
                        type="password"
                        id="confirmPassword"
                        name="confirmPassword"
                        placeholder="Re-enter new password"
                        minlength="6"
                        required>

            </div>

            <div class="buttons">

                <button
                        type="submit"
                        class="btn btn-primary">
                    🔐 Change Password
                </button>

                <a
                        href="<%= contextPath %>/profile"
                        class="btn btn-secondary">
                    Cancel
                </a>

            </div>

        </form>

        <div class="security-box">

            <h3>🔒 Password Security</h3>

            <ul>
                <li>Use a password that you do not use elsewhere.</li>
                <li>Choose at least 6 characters.</li>
                <li>Never share your password with anyone.</li>
            </ul>

        </div>

    </div>

</main>

</body>
</html>