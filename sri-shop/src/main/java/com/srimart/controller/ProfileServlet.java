package com.srimart.controller;

import com.srimart.dao.UserDAO;
import com.srimart.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null
                || session.getAttribute("userEmail") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String email =
                String.valueOf(session.getAttribute("userEmail"));

        try {

            User user = userDAO.findByEmail(email);

            if (user == null) {

                response.sendRedirect(
                        request.getContextPath() + "/login.jsp"
                );
                return;
            }

            request.setAttribute("user", user);

            request.getRequestDispatcher(
                    "/profile.jsp"
            ).forward(request, response);

        } catch (SQLException e) {

            e.printStackTrace();

            request.setAttribute(
                    "errorMessage",
                    "Unable to load profile."
            );

            request.getRequestDispatcher(
                    "/buyer-dashboard.jsp"
            ).forward(request, response);
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null
                || session.getAttribute("userEmail") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        long userId =
                ((Long) session.getAttribute("userId"));

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");

        if (name == null || name.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/profile?error=Name+is+required"
            );
            return;
        }

        if (phone == null || phone.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/profile?error=Phone+number+is+required"
            );
            return;
        }

        name = name.trim();
        phone = phone.trim();

        try {

            boolean updated =
                    userDAO.updateProfile(
                            userId,
                            name,
                            phone
                    );

            if (updated) {

                session.setAttribute(
                        "userName",
                        name
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/profile?success=Profile+updated+successfully"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/profile?error=Unable+to+update+profile"
                );
            }

        } catch (SQLException e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/profile?error=Unable+to+update+profile"
            );
        }
    }
}