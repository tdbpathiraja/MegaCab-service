package com.megacabproject.controllers.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * AdminLogoutServlet handles logging out the admin.
 *
 * Design Patterns & OOP Concepts:
 * - **Encapsulation:** The logout logic is encapsulated within this servlet.
 * - **Layered Architecture:** Acts as the Presentation Layer by handling HTTP requests.
 */
@WebServlet("/AdminLogoutServlet")
public class AdminLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve existing session, if any
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        // Redirect to admin login page after logout
        response.sendRedirect("admin-login.jsp?message=logged_out");
    }
}
