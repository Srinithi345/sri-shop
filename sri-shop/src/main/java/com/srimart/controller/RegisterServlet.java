package com.srimart.controller;

import com.srimart.service.RegisterService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private RegisterService registerService;

    @Override
    public void init() throws ServletException {
        registerService = new RegisterService();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String phone = request.getParameter("phone");

        // Basic validation
        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || role == null || role.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/register.jsp?error=Please+fill+all+required+fields"
            );
            return;
        }

        try {

            String result = registerService.register(
                    name.trim(),
                    email.trim(),
                    password,
                    role.trim().toUpperCase(),
                    phone != null ? phone.trim() : ""
            );

            if (result != null
                    && result.toLowerCase().contains("success")) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/login.jsp?success=Account+created+successfully"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/register.jsp?error="
                                + java.net.URLEncoder.encode(
                                        result != null ? result : "Registration failed",
                                        "UTF-8"
                                )
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/register.jsp?error=Registration+failed"
            );
        }
    }
}