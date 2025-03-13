package com.megacabproject.controllers.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        // Set headers to prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Output a JS alert and redirect to the login page
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><head><script type='text/javascript'>");
        out.println("alert('Successfully Logged Out!');");
        out.println("window.location.href = 'auth.jsp?logout=success';");
        out.println("</script></head><body></body></html>");
    }
}
