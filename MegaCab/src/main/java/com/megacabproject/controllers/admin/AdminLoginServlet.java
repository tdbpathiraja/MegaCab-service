package com.megacabproject.controllers.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;


@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    private final String ADMIN_USERNAME = "admin";
    private final String ADMIN_PASSWORD = "admin123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve admin credentials from form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate against hard-coded credentials
        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            // Create a session and store admin info
            HttpSession session = request.getSession();
            session.setAttribute("adminUser", username);
            // Set session timeout to 60 seconds
            session.setMaxInactiveInterval(60);
            // Redirect to admin dashboard on success
            response.sendRedirect("admin-dashboard.jsp");
        } else {
            // Redirect back to login page with an error parameter on failure
            response.sendRedirect("admin-login.jsp?error=invalid_credentials");
        }
    }
}
