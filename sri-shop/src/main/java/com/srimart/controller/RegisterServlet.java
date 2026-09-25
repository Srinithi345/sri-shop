package com.srimart.controller;

import com.srimart.service.RegisterService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
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

        try {

            String result = registerService.register(
                    name,
                    email,
                    password,
                    role,
                    phone
            );

            if ("Registration successful".equals(result)) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/register.jsp?success="
                                + "Registration successful"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/register.jsp?error="
                                + result.replace(" ", "+")
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/register.jsp?error="
                            + "Registration failed"
            );
        }
    }
}