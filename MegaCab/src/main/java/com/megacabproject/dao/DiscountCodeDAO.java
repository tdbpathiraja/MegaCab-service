package com.megacabproject.dao;

import com.megacabproject.models.DiscountCode;
import com.megacabproject.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


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