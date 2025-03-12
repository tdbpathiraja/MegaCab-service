package com.megacabproject.dao;

import com.megacabproject.models.DiscountCode;
import com.megacabproject.utils.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class DiscountCodeDAOTest {

    private static Connection conn;
    private static DiscountCodeDAO discountCodeDAO;

    @BeforeAll
    static void setUp() {
        conn = DBConnection.getConnection();
        discountCodeDAO = new DiscountCodeDAO();

        // Insert a test discount code
        String insertQuery = "INSERT INTO discount_codes (discount_code, percentage) VALUES ('TESTCODE123', 15.0)";
        try (PreparedStatement stmt = conn.prepareStatement(insertQuery)) {
            stmt.executeUpdate();
            System.out.println("Test discount code inserted.");
        } catch (SQLException e) {
            fail("ERROR: Failed to insert test discount code. " + e.getMessage());
        }
    }

    @Test
    @Order(1)
    void testGetDiscountByValidCode() {
        DiscountCode discount = discountCodeDAO.getDiscountByCode("TESTCODE123");
        assertNotNull(discount, "ERROR: Discount code not found.");
        assertEquals(15.0, discount.getPercentage(), "ERROR: Incorrect discount percentage.");
        System.out.println("Discount code retrieval successful.");
    }

    @Test
    @Order(2)
    void testGetDiscountByInvalidCode() {
        DiscountCode discount = discountCodeDAO.getDiscountByCode("INVALIDCODE");
        assertNull(discount, "ERROR: Found a non-existing discount code.");
        System.out.println("Invalid discount code correctly not found.");
    }

    @AfterAll
    static void tearDown() {
        // Clean up: Delete the test discount code
        String deleteQuery = "DELETE FROM discount_codes WHERE discount_code = 'TESTCODE123'";
        try (PreparedStatement stmt = conn.prepareStatement(deleteQuery)) {
            stmt.executeUpdate();
            System.out.println("Test discount code removed.");
        } catch (SQLException e) {
            System.err.println("ERROR: Failed to remove test discount code. " + e.getMessage());
        }
    }
}
