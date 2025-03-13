package com.megacabproject.dao;

import com.megacabproject.models.User;
import com.megacabproject.utils.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class) // Ensures test order
class UserDAOTest {

    private static Connection conn;
    private static UserDAO userDAO;
    private static int testUserId;
    private static String testUsername = "testuser123";
    private static String testEmail = "testuser123@example.com";
    private static String testPassword = "hashed_password123"; // Assume hashing

    @BeforeAll
    static void setUp() {
        conn = DBConnection.getConnection();
        userDAO = new UserDAO();

        String insertQuery = "INSERT INTO users (reg_number, username, full_name, address, telephone, nic, email, password) " +
                "VALUES ('mcu-999999', ?, 'Test User', 'Test Address', '1234567890', '123456789V', ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(insertQuery, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, testUsername);
            stmt.setString(2, testEmail);
            stmt.setString(3, testPassword);
            stmt.executeUpdate();

            // ✅ Fix: Explicit declaration for ResultSet
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                testUserId = rs.getInt(1); // ✅ Fix: Properly fetch user ID
            }
            rs.close();
            stmt.close();

            System.out.println("✅ Test User Inserted. ID: " + testUserId);
        } catch (SQLException e) {
            fail("❌ ERROR: Failed to insert test user. " + e.getMessage());
        }
    }


    @Test
    @Order(1)
    void testValidateUser() {
        User user = userDAO.validateUser(testUsername, testPassword);
        assertNotNull(user, "❌ ERROR: User validation failed.");
        assertEquals(testUsername, user.getUsername(), "❌ ERROR: Username mismatch.");
        System.out.println("✅ User validation successful.");
    }

    @Test
    @Order(2)
    void testCheckUserExists() {
        int result = userDAO.checkUserExists(testUsername, testEmail);
        assertEquals(1, result, "❌ ERROR: User existence check failed.");
        System.out.println("✅ User existence check successful.");
    }

    @Test
    @Order(3)
    void testGetUserByUsername() {
        User user = userDAO.getUserByUsername(testUsername);
        assertNotNull(user, "❌ ERROR: Failed to fetch user by username.");
        assertEquals(testUsername, user.getUsername(), "❌ ERROR: Username mismatch.");
        System.out.println("✅ User fetched successfully by username.");
    }

    @Test
    @Order(4)
    void testGetUserById() {
        User user = userDAO.getUserById(testUserId);
        assertNotNull(user, "❌ ERROR: Failed to fetch user by ID.");
        assertEquals(testUserId, user.getId(), "❌ ERROR: User ID mismatch.");
        System.out.println("✅ User fetched successfully by ID.");
    }

    @Test
    @Order(5)
    void testGetAllUsers() {
        List<User> users = userDAO.getAllUsers();
        assertFalse(users.isEmpty(), "❌ ERROR: User list is empty.");
        System.out.println("✅ All users fetched successfully.");
    }

    @Test
    @Order(6)
    void testUpdateUser() {
        User updatedUser = new User(testUserId, "mcu-999999", testUsername, "Updated Name", "Updated Address",
                "9876543210", "123456789V", "updated@example.com", testPassword);
        boolean result = userDAO.updateUser(updatedUser);
        assertTrue(result, "❌ ERROR: User update failed.");
        System.out.println("✅ User updated successfully.");
    }

    @Test
    @Order(7)
    void testDeleteUser() {
        boolean result = userDAO.deleteUser(testUserId);
        assertTrue(result, "❌ ERROR: User deletion failed.");
        System.out.println("✅ User deleted successfully.");
    }

    @AfterAll
    static void tearDown() {
        // Ensure test user is removed
        String deleteQuery = "DELETE FROM users WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(deleteQuery)) {
            stmt.setString(1, testUsername);
            stmt.executeUpdate();
            System.out.println("✅ Test user cleanup completed.");
        } catch (SQLException e) {
            System.err.println("❌ ERROR: Failed to remove test user. " + e.getMessage());
        }
    }
}
