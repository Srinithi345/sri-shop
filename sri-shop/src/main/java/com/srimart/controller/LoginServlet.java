package com.srimart.controller;

import com.srimart.model.User;
import com.srimart.service.LoginService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private LoginService loginService;

    @Override
    public void init() throws ServletException {
        loginService = new LoginService();
    }

    // If /login is opened directly
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validation
        if (email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp?error=Please+enter+email+and+password"
            );
            return;
        }

        try {

            User user = loginService.login(
                    email.trim(),
                    password
            );

            // Invalid login
            if (user == null) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/login.jsp?error=Invalid+email+or+password"
                );
                return;
            }

            // Create session
            HttpSession session = request.getSession(true);

            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userRole", user.getRole());

            // Role based dashboard
            if ("SELLER".equalsIgnoreCase(user.getRole())) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/seller-dashboard.jsp"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/buyer-dashboard.jsp"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/login.jsp?error=Login+failed"
            );
        }
    }
}