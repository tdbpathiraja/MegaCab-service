package com.megacabproject.controllers.customer;

import com.megacabproject.models.User;
import com.megacabproject.services.UserService;
import com.megacabproject.utils.PasswordHash;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * SignupServlet handles user registration.
 * It follows the **Layered Architecture Pattern**, ensuring separation of concerns.
 *
 * **OOP Concepts Used:**
 * - **Encapsulation:** Private variables are used within controlled methods.
 * - **Abstraction:** The `PasswordHash.hashPassword()` method hides hashing logic.
 * - **Open-Closed Principle:** The servlet remains open for extension without modification by using the service layer.
 */
@WebServlet("/SignupServlet") // Web service endpoint
public class SignupServlet extends HttpServlet {

    private final UserService userService = new UserService(); // Encapsulation: Service Layer instance

    /**
     * Handles POST requests for user signup.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 🔹 Retrieving form data
        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String nic = request.getParameter("nic");
        String email = request.getParameter("email");
        String password = PasswordHash.hashPassword(request.getParameter("password")); // Abstraction: Password hashing

        // 🔹 Creating a User object
        User newUser = new User(0, "", username, fullName, address, telephone, nic, email, password);

        // 🔹 Check if the user already exists
        int userExistsStatus = userService.checkUserExists(username, email);

        if (userExistsStatus == 1) {
            // Username already exists
            System.out.println("ERROR: Username '" + username + "' is already taken.");
            out.println("<script>alert('Signup Failed! Username is already taken.'); window.location.href='auth.jsp';</script>");
        } else if (userExistsStatus == 2) {
            // Email already exists
            System.out.println("ERROR: Email '" + email + "' is already registered.");
            out.println("<script>alert('Signup Failed! Email is already registered.'); window.location.href='auth.jsp';</script>");
        } else {
            // 🔹 Register the user
            boolean registered = userService.registerUser(newUser);

            if (registered) {
                System.out.println("User Registered Successfully: " + username);
                out.println("<script>alert('Signup Successful! Please login.'); window.location.href='auth.jsp';</script>");
            } else {
                System.err.println("ERROR: User registration failed due to an internal issue.");
                out.println("<script>alert('Signup Failed! Please try again.'); window.location.href='auth.jsp';</script>");
            }
        }
    }
}