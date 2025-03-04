package com.megacabproject.dao;

import com.megacabproject.models.User;
import com.megacabproject.utils.DBConnection;

import java.sql.*;
import java.util.Random;

/**
 * 🔹 **UserDAO Class**
 * - **Data Layer:** Handles database operations for User Management.
 * - **Design Pattern Used:** Singleton Pattern for DB connection.
 * - **Used in:** Authentication, Booking System (Fetching User Details).
 */
public class UserDAO {
    private final Connection conn;

    /**
     * 🔹 Constructor - Initializes Database Connection
     */
    public UserDAO() {
        this.conn = DBConnection.getConnection();
        if (this.conn == null) {
            System.err.println("ERROR: Database connection is NULL!");
        } else {
            System.out.println("✅ UserDAO connected successfully.");
        }
    }

    /**
     * 🔹 Generate Unique Registration Number (e.g., "mcu-123456")
     * @return Unique registration number.
     */
    private String generateRegNumber() {
        Random random = new Random();
        int number = 100000 + random.nextInt(900000);
        return "mcu-" + number;
    }

    /**
     * 🔹 Register User with Hashed Password
     * @param user User object containing registration details
     * @return true if registration is successful, false otherwise
     */
    public boolean registerUser(User user) {
        if (conn == null) {
            System.err.println("❌ ERROR: Cannot register user, DB connection NULL!");
            return false;
        }

        String query = "INSERT INTO users (reg_number, username, full_name, address, telephone, nic, email, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            String regNumber = generateRegNumber();  // Generate unique registration number
            stmt.setString(1, regNumber);
            stmt.setString(2, user.getUsername());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getTelephone());
            stmt.setString(6, user.getNic());
            stmt.setString(7, user.getEmail());
            stmt.setString(8, user.getPassword());

            int rowsInserted = stmt.executeUpdate();
            System.out.println("✅ User Registered: " + user.getUsername() + " (Reg: " + regNumber + ")");
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.err.println("❌ ERROR: User Registration Failed! SQL Error: " + e.getMessage());
            return false;
        }
    }

    /**
     * 🔹 Validate login credentials
     * @param username User's username
     * @param hashedPassword Hashed password for verification
     * @return User object if credentials match, null otherwise
     */
    public User validateUser(String username, String hashedPassword) {
        if (conn == null) {
            System.err.println("❌ ERROR: Cannot validate user, DB connection NULL!");
            return null;
        }

        String query = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, hashedPassword);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                System.out.println("✅ User Found: " + rs.getString("username"));
                return new User(
                        rs.getInt("id"), rs.getString("reg_number"), rs.getString("username"),
                        rs.getString("full_name"), rs.getString("address"), rs.getString("telephone"),
                        rs.getString("nic"), rs.getString("email"), rs.getString("password")
                );
            }
        } catch (SQLException e) {
            System.err.println("❌ ERROR: User Login Validation Failed: " + e.getMessage());
        }
        return null;
    }

    /**
     * 🔹 Check if Username or Email Exists
     * @param username The username to check
     * @param email The email to check
     * @return 1 if username exists, 2 if email exists, 0 if no match
     */
    public int checkUserExists(String username, String email) {
        String query = "SELECT username, email FROM users WHERE username = ? OR email = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, email);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                if (rs.getString("username").equals(username)) {
                    return 1; // Username exists
                }
                if (rs.getString("email").equals(email)) {
                    return 2; // Email exists
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ ERROR: Failed to check existing user: " + e.getMessage());
        }
        return 0; // No match found
    }

    /**
     * 🔍 Fetch User Details by Username (Used in Booking System)
     * @param username The username of the user
     * @return User object if found, null otherwise
     */
    public User getUserByUsername(String username) {
        if (conn == null) {
            System.err.println("❌ ERROR: Cannot fetch user, DB connection NULL!");
            return null;
        }

        String query = "SELECT full_name, address FROM users WHERE username = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                System.out.println("✅ User Data Fetched for: " + username);
                return new User(
                        0, // ID not needed
                        "", // Registration Number not needed
                        username,
                        rs.getString("full_name"),
                        rs.getString("address"),
                        "",
                        "",
                        "",
                        ""
                );
            } else {
                System.out.println("❌ No User Found for username: " + username);
            }
        } catch (SQLException e) {
            System.err.println("❌ ERROR: Failed to fetch user details: " + e.getMessage());
        }
        return null;
    }
}