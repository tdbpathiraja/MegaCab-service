package com.megacabproject.dao;

import com.megacabproject.models.DiscountCode;
import com.megacabproject.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * DiscountCodeDAO handles all database operations for discount codes.
 * - **Design Pattern:** DAO Pattern (Separation of DB logic)
 * - **OOP Concepts:** Encapsulation (private connection), Abstraction (methods hide SQL details)
 */
public class DiscountCodeDAO {
    private final Connection conn;

    public DiscountCodeDAO() {
        this.conn = DBConnection.getConnection();
        if (this.conn == null) {
            System.err.println("ERROR: Database connection is NULL in DiscountCodeDAO!");
        } else {
            System.out.println("DiscountCodeDAO connected successfully.");
        }
    }

    /**
     * Retrieves the discount percentage for a given discount code.
     *
     * @param discountCode The discount code to validate.
     * @return A DiscountCode object if valid; null otherwise.
     */
    public DiscountCode getDiscountByCode(String discountCode) {
        String query = "SELECT * FROM discount_codes WHERE discount_code = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, discountCode);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new DiscountCode(
                        rs.getInt("id"),
                        rs.getString("discount_code"),
                        rs.getDouble("percentage"),
                        rs.getTimestamp("created_at")
                );
            }
        } catch (SQLException e) {
            System.err.println("ERROR: Failed to fetch discount code: " + e.getMessage());
        }
        return null;
    }
}