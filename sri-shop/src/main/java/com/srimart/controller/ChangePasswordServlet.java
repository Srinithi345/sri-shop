package com.srimart.controller;

import com.srimart.dao.UserDAO;
import com.srimart.model.User;
import com.srimart.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

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
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        request.getRequestDispatcher(
                "/change-password.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        long userId =
                ((Long) session.getAttribute("userId"));

        String currentPassword =
                request.getParameter("currentPassword");

        String newPassword =
                request.getParameter("newPassword");

        String confirmPassword =
                request.getParameter("confirmPassword");

        if (currentPassword == null
                || currentPassword.isEmpty()
                || newPassword == null
                || newPassword.isEmpty()
                || confirmPassword == null
                || confirmPassword.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/change-password?error=All+fields+are+required"
            );
            return;
        }

        if (!newPassword.equals(confirmPassword)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/change-password?error=New+passwords+do+not+match"
            );
            return;
        }

        if (newPassword.length() < 6) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/change-password?error=Password+must+be+at+least+6+characters"
            );
            return;
        }

        if (currentPassword.equals(newPassword)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/change-password?error=New+password+must+be+different"
            );
            return;
        }

        try {

            String email =
                    String.valueOf(
                            session.getAttribute("userEmail")
                    );

            User user = userDAO.findByEmail(email);

            if (user == null
                    || !PasswordUtil.verifyPassword(
                            currentPassword,
                            user.getPasswordHash())) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/change-password?error=Current+password+is+incorrect"
                );
                return;
            }

            String newPasswordHash =
                    PasswordUtil.hashPassword(newPassword);

            boolean updated =
                    userDAO.updatePassword(
                            userId,
                            newPasswordHash
                    );

            if (updated) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/change-password?success=Password+changed+successfully"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/change-password?error=Unable+to+change+password"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                            + "/change-password?error=Unable+to+change+password"
            );
        }
    }
}