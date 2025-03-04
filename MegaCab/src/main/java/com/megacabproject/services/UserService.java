package com.megacabproject.services;

import com.megacabproject.dao.UserDAO;
import com.megacabproject.models.User;

/**
 * 🔹 **UserService Class**
 * - **Business Layer:** Handles business logic for User operations.
 * - **Design Pattern Used:** Singleton Pattern for DAO instance.
 * - **Used in:** Authentication, Booking System (Auto-fill details)
 */
public class UserService {

    private final UserDAO userDAO = new UserDAO(); // DAO Layer (Singleton Pattern)

    /**
     * 🔍 Check if User Exists by Username or Email
     * @param username The username to check
     * @param email The email to check
     * @return User ID if exists, else -1
     */
    public int checkUserExists(String username, String email) {
        return userDAO.checkUserExists(username, email);
    }

    /**
     * 🔐 Register a new user
     * @param user User object containing registration details
     * @return true if registration successful, false otherwise
     */
    public boolean registerUser(User user) {
        return userDAO.registerUser(user);
    }

    /**
     * 🔑 Validate User Login
     * @param username User's username
     * @param hashedPassword Hashed password for verification
     * @return User object if credentials match, null otherwise
     */
    public User validateUser(String username, String hashedPassword) {
        return userDAO.validateUser(username, hashedPassword);
    }

    /**
     * 🆔 Fetch User Details by Username (Used in Booking System)
     * @param username Username of the user
     * @return User object if found, otherwise null
     */
    public User getUserByUsername(String username) {
        return userDAO.getUserByUsername(username);
    }
}