package com.megacabproject.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static Connection connection;

    private DBConnection() {}

    public static Connection getConnection() {
        if (connection == null) {
            try {
                System.out.println("Attempting to connect to database...");
                Class.forName("com.mysql.cj.jdbc.Driver");

                connection = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/megacitycab", "root", ""
                );

                if (connection != null) {
                    System.out.println("Database Connected Successfully!");
                } else {
                    System.err.println("ERROR: Connection returned NULL!");
                }

            } catch (ClassNotFoundException e) {
                System.err.println("JDBC Driver not found: " + e.getMessage()); //I added this for testing purposes to driver errors
            } catch (SQLException e) {
                System.err.println("Database Connection Failed: " + e.getMessage());
            }
        }
        return connection;
    }
}
