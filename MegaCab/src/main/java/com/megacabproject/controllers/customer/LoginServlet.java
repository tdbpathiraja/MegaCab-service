package com.megacabproject.controllers.customer;

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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Retrieving login credentials
        String username = request.getParameter("username");
        String password = PasswordHash.hashPassword(request.getParameter("password"));

        // Validate user
        User user = userService.validateUser(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user.getUsername());
            out.println("<script>alert('Login Successful! Welcome " + user.getUsername() + "'); window.location.href='user-account.jsp';</script>");
        } else {
            out.println("<script>alert('Invalid Username or Password!'); window.location.href='auth.jsp';</script>");
        }
    }
}
