package com.megacabproject.controllers;

import com.megacabproject.models.User;
import com.megacabproject.services.UserService;
import com.megacabproject.utils.PasswordHash;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * LoginServlet is responsible for handling user authentication.
 * It follows the **Layered Architecture Pattern**, separating concerns between Presentation, Business, and Data Layers.
 */
@WebServlet("/LoginServlet") // Web service endpoint
public class LoginServlet extends HttpServlet {

    // **Encapsulation (OOP Concept)**
    // UserService instance is encapsulated within the servlet, restricting direct access to business logic.
    private final UserService userService = new UserService();

    /**
     * Handles POST requests for user login authentication.
     * Uses **Encapsulation**, **Abstraction**, and **Open-Closed Principle**.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // **Encapsulation:** Username & Password are retrieved as private variables.
        String username = request.getParameter("username");
        String password = PasswordHash.hashPassword(request.getParameter("password")); // **Abstraction:** Hiding hashing details

        // **Polymorphism (Method Overloading in Service Layer)**
        // The validateUser method is overloaded in UserService for different use cases.
        User user = userService.validateUser(username, password);

        if (user != null) {
            // **Encapsulation & Session Management**
            // HttpSession is used to store the logged-in user, ensuring persistence during the session.
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user.getUsername()); // **Logged username stored in session**

            // Redirecting with a success message
            out.println("<script>alert('Login Successful! Welcome " + user.getUsername() + "'); window.location.href='user-account.jsp';</script>");
        } else {
            // Redirecting with an error message
            out.println("<script>alert('Invalid Username or Password!'); window.location.href='auth.jsp';</script>");
        }
    }
}
