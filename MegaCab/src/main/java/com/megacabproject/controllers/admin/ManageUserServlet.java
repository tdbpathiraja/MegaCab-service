package com.megacabproject.controllers.admin;

import com.google.gson.Gson;
import com.megacabproject.models.User;
import com.megacabproject.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/UserController")
public class ManageUserServlet extends HttpServlet {

    private final UserService userService = new UserService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        if (action == null) {
            out.print(gson.toJson("No action specified"));
            return;
        }

        switch (action.toLowerCase()) {
            case "list":
                // Fetch users from the database (implement getAllUsers() in your service layer)
                List<User> users = userService.getAllUsers();
                int totalUsers = users.size();  // Adjust for pagination if needed.
                Map<String, Object> listResult = new HashMap<>();
                listResult.put("users", users);
                listResult.put("totalUsers", totalUsers);
                out.print(gson.toJson(listResult));
                break;

            case "getuser":
                try {
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    // Fetch single user (implement getUserById(int userId) in your service layer)
                    User user = userService.getUserById(userId);
                    out.print(gson.toJson(user));
                } catch (NumberFormatException e) {
                    out.print(gson.toJson("Invalid user id"));
                }
                break;

            default:
                out.print(gson.toJson("Invalid action"));
        }
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        Map<String, Object> result = new HashMap<>();

        if (action == null) {
            result.put("success", false);
            result.put("message", "No action specified");
            out.print(gson.toJson(result));
            out.flush();
            return;
        }

        switch (action.toLowerCase()) {
            case "delete":
                try {
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    boolean deleted = userService.deleteUser(userId);
                    result.put("success", deleted);
                    result.put("message", deleted ? "User deleted successfully" : "Failed to delete user");
                } catch (NumberFormatException e) {
                    result.put("success", false);
                    result.put("message", "Invalid user id");
                }
                break;

            case "update":
                try {
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    String email = request.getParameter("editEmail");
                    String fullName = request.getParameter("editName");
                    String telephone = request.getParameter("editPhone");
                    // Create a new User object with updated fields. Other fields are set to null or can be fetched as needed.
                    User user = new User(userId, null, null, fullName, null, telephone, null, email, null);
                    boolean updated = userService.updateUser(user);
                    result.put("success", updated);
                    result.put("message", updated ? "User updated successfully" : "Failed to update user");
                } catch (NumberFormatException e) {
                    result.put("success", false);
                    result.put("message", "Invalid user id");
                }
                break;

            default:
                result.put("success", false);
                result.put("message", "Invalid action");
        }

        out.print(gson.toJson(result));
        out.flush();
    }
}
