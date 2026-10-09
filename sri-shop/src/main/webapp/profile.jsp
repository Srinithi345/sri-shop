<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.srimart.model.User" %>

<%
    User user = (User) request.getAttribute("user");

    if (user == null) {
        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
        return;
    }

    String contextPath = request.getContextPath();

    String successMessage = request.getParameter("success");
    String errorMessage = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SRI SHOP - My Profile</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family:
                Arial,
                Helvetica,
                sans-serif;
            background: #f0fdfa;
            color: #134e4a;
            min-height: 100vh;
        }

        .header {
            background: #0f766e;
            color: white;
            padding: 16px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.12);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            font-size: 25px;
            font-weight: 800;
            white-space: nowrap;
        }

        .nav {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .nav a {
            color: white;
            text-decoration: none;
            padding: 9px 13px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            transition: 0.2s;
        }

        .nav a:hover {
            background: rgba(255,255,255,0.16);
        }

        .page {
            max-width: 900px;
            margin: 45px auto;
            padding: 0 20px;
        }

        .page-title {
            text-align: center;
            margin-bottom: 30px;
        }

        .page-title h1 {
            font-size: 32px;
            color: #115e59;
            margin-bottom: 8px;
        }

        .page-title p {
            color: #64748b;
            font-size: 15px;
        }

        .profile-card {
            background: white;
            border-radius: 18px;
            box-shadow: 0 8px 30px rgba(15,118,110,0.10);
            overflow: hidden;
            border: 1px solid #ccfbf1;
        }

        .profile-top {
            background: linear-gradient(
                135deg,
                #0f766e,
                #115e59
            );
            color: white;
            padding: 35px;
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .avatar {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            background: white;
            color: #0f766e;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 42px;
            flex-shrink: 0;
        }

        .profile-top h2 {
            font-size: 25px;
            margin-bottom: 7px;
        }

        .profile-top p {
            opacity: 0.9;
            font-size: 14px;
        }

        .profile-body {
            padding: 35px;
        }

        .message {
            padding: 13px 16px;
            border-radius: 10px;
            margin-bottom: 22px;
            font-size: 14px;
            font-weight: 600;
        }

        .success-message {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .error-message {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .info-box {
            border: 1px solid #dbeafe;
            border-radius: 12px;
            padding: 18px;
            background: #f8fafc;
        }

        .info-label {
            color: #64748b;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            margin-bottom: 7px;
        }

        .info-value {
            color: #134e4a;
            font-size: 16px;
            font-weight: 600;
            word-break: break-word;
        }

        .role-badge {
            display: inline-block;
            background: #ccfbf1;
            color: #0f766e;
            padding: 6px 13px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 700;
        }

        .edit-section {
            margin-top: 32px;
            padding-top: 28px;
            border-top: 1px solid #e2e8f0;
        }

        .edit-section h3 {
            color: #115e59;
            font-size: 21px;
            margin-bottom: 6px;
        }

        .edit-section p {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            color: #334155;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 7px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 13px;
            border: 1px solid #cbd5e1;
            border-radius: 9px;
            font-size: 14px;
            color: #134e4a;
            background: white;
            outline: none;
            transition: 0.2s;
        }

        .form-group input:focus {
            border-color: #0f766e;
            box-shadow: 0 0 0 3px rgba(15,118,110,0.10);
        }

        .form-group input[readonly] {
            background: #f1f5f9;
            color: #64748b;
            cursor: not-allowed;
        }

        .edit-actions {
            margin-top: 20px;
            display: flex;
            justify-content: flex-end;
        }

        .actions {
            margin-top: 30px;
            display: flex;
            justify-content: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            text-decoration: none;
            border: none;
            cursor: pointer;
            padding: 12px 22px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 700;
            transition: 0.2s;
        }

        .btn-primary {
            background: #0f766e;
            color: white;
        }

        .btn-primary:hover {
            background: #115e59;
            transform: translateY(-1px);
        }

        .btn-secondary {
            background: #e2e8f0;
            color: #334155;
        }

        .btn-secondary:hover {
            background: #cbd5e1;
        }

        .footer {
            text-align: center;
            color: #64748b;
            font-size: 13px;
            padding: 30px 20px;
        }

        @media (max-width: 700px) {

            .header {
                padding: 14px 20px;
                flex-direction: column;
                align-items: stretch;
            }

            .logo {
                text-align: center;
            }

            .nav {
                justify-content: center;
            }

            .page {
                margin: 30px auto;
            }

            .profile-top {
                padding: 28px 20px;
                flex-direction: column;
                text-align: center;
            }

            .profile-body {
                padding: 25px 20px;
            }

            .info-grid,
            .form-grid {
                grid-template-columns: 1fr;
            }

            .edit-actions {
                justify-content: stretch;
            }

            .edit-actions .btn {
                width: 100%;
            }
        }

        @media (max-width: 450px) {

            .nav a {
                font-size: 12px;
                padding: 8px 9px;
            }

            .page-title h1 {
                font-size: 27px;
            }

            .profile-top h2 {
                font-size: 22px;
            }

        }

    </style>

</head>

<body>

<header class="header">

    <div class="logo">
        🛍️ SRI SHOP
    </div>

    <nav class="nav">

        <a href="<%= contextPath %>/profile">
            👤 Profile
        </a>

        <a href="<%= contextPath %>/products">
            🛍️ Shop
        </a>

        <a href="<%= contextPath %>/wishlist">
            ❤️ Wishlist
        </a>

        <a href="<%= contextPath %>/cart">
            🛒 Cart
        </a>

        <a href="<%= contextPath %>/logout">
            Logout
        </a>

    </nav>

</header>


<main class="page">

    <div class="page-title">

        <h1>My Profile</h1>

        <p>
            View and manage your SRI SHOP account information
        </p>

    </div>


    <section class="profile-card">

        <div class="profile-top">

            <div class="avatar">
                👤
            </div>

            <div>

                <h2>
                    <%= user.getName() %>
                </h2>

                <p>
                    Welcome to your SRI SHOP profile
                </p>

            </div>

        </div>


        <div class="profile-body">

            <% if (successMessage != null && !successMessage.trim().isEmpty()) { %>

                <div class="message success-message">
                    ✅ <%= successMessage %>
                </div>

            <% } %>


            <% if (errorMessage != null && !errorMessage.trim().isEmpty()) { %>

                <div class="message error-message">
                    ❌ <%= errorMessage %>
                </div>

            <% } %>


            <div class="info-grid">

                <div class="info-box">

                    <div class="info-label">
                        User ID
                    </div>

                    <div class="info-value">
                        #<%= user.getUserId() %>
                    </div>

                </div>


                <div class="info-box">

                    <div class="info-label">
                        Full Name
                    </div>

                    <div class="info-value">
                        <%= user.getName() %>
                    </div>

                </div>


                <div class="info-box">

                    <div class="info-label">
                        Email Address
                    </div>

                    <div class="info-value">
                        <%= user.getEmail() %>
                    </div>

                </div>


                <div class="info-box">

                    <div class="info-label">
                        Phone Number
                    </div>

                    <div class="info-value">

                        <%
                            String phone = user.getPhone();

                            if (phone == null ||
                                phone.trim().isEmpty()) {
                        %>

                            Not provided

                        <%
                            } else {
                        %>

                            <%= phone %>

                        <%
                            }
                        %>

                    </div>

                </div>


                <div class="info-box">

                    <div class="info-label">
                        Account Role
                    </div>

                    <div class="info-value">

                        <span class="role-badge">
                            <%= user.getRole() %>
                        </span>

                    </div>

                </div>


                <div class="info-box">

                    <div class="info-label">
                        Account Status
                    </div>

                    <div class="info-value">

                        <span class="role-badge">
                            Active
                        </span>

                    </div>

                </div>

            </div>


            <div class="edit-section">

                <h3>
                    ✏️ Edit Profile
                </h3>

                <p>
                    Update your name and phone number.
                </p>


                <form
                    method="post"
                    action="<%= contextPath %>/profile">

                    <div class="form-grid">

                        <div class="form-group">

                            <label for="name">
                                Full Name
                            </label>

                            <input
                                type="text"
                                id="name"
                                name="name"
                                value="<%= user.getName() %>"
                                maxlength="100"
                                required>

                        </div>


                        <div class="form-group">

                            <label for="phone">
                                Phone Number
                            </label>

                            <input
                                type="tel"
                                id="phone"
                                name="phone"
                                value="<%= user.getPhone() == null ? "" : user.getPhone() %>"
                                maxlength="20"
                                required>

                        </div>


                        <div class="form-group">

                            <label for="email">
                                Email Address
                            </label>

                            <input
                                type="email"
                                id="email"
                                value="<%= user.getEmail() %>"
                                readonly>

                        </div>

                    </div>


                    <div class="edit-actions">

                        <button
                            type="submit"
                            class="btn btn-primary">
                            💾 Save Changes
                        </button>

                    </div>

                </form>

            </div>


            <div class="actions">

                <a
                    href="<%= contextPath %>/buyer-dashboard.jsp"
                    class="btn btn-primary">
                    ← Back to Dashboard
                </a>

                <a
                    href="<%= contextPath %>/change-password"
                    class="btn btn-secondary">
                    🔐 Change Password
                </a>

                <a
                    href="<%= contextPath %>/products"
                    class="btn btn-secondary">
                    🛍️ Continue Shopping
                </a>

            </div>

        </div>

    </section>

</main>


<footer class="footer">

    © 2026 SRI SHOP. All rights reserved.

</footer>

</body>

</html>