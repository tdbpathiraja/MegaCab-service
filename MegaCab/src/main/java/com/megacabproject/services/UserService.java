package com.megacabproject.services;

import com.megacabproject.dao.UserDAO;
import com.megacabproject.models.User;
import java.util.List;

public class UserService {

    private final UserDAO userDAO = new UserDAO();

    public int checkUserExists(String username, String email) {
        return userDAO.checkUserExists(username, email);
    }

    public boolean registerUser(User user) {
        return userDAO.registerUser(user);
    }

    public User validateUser(String username, String hashedPassword) {
        return userDAO.validateUser(username, hashedPassword);
    }

    public User getUserByUsername(String username) {
        return userDAO.getUserByUsername(username);
    }

    // New method to retrieve all users
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    // New method to retrieve a user by ID
    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }

    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }

    public boolean deleteUser(int userId) {
        return userDAO.deleteUser(userId);
    }
}
