package com.megacabproject.dao;

import com.megacabproject.models.Vehicle;
import com.megacabproject.utils.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class VehicleDAOTest {

    private static Connection conn;
    private static VehicleDAO vehicleDAO;
    private static int testVehicleId;

    @BeforeAll
    static void setUp() {
        conn = DBConnection.getConnection();
        vehicleDAO = new VehicleDAO();

        // Insert test data
        Vehicle testVehicle = new Vehicle(
                0,
                "Test Car",
                "Sedan",
                "Petrol",
                "Automatic",
                100.00,
                "D123",
                "John Doe",
                "test_vehicle.jpg",
                "available"
        );

        boolean added = vehicleDAO.addVehicle(testVehicle);
        assertTrue(added, "Failed to add test vehicle");

        // Fetch the ID of the newly inserted vehicle
        List<Vehicle> vehicles = vehicleDAO.getAllVehicles("Test Car");
        assertFalse(vehicles.isEmpty(), "No test vehicle found after insertion!");
        testVehicleId = vehicles.get(0).getId();
    }

    @Test
    @Order(1)
    void testGetAllVehicles() {
        List<Vehicle> vehicles = vehicleDAO.getAllVehicles(null);
        assertNotNull(vehicles);
        assertFalse(vehicles.isEmpty(), "Vehicle list should not be empty");
    }

    @Test
    @Order(2)
    void testGetAllVehicleCategories() {
        List<String> categories = vehicleDAO.getAllVehicleCategories();
        assertNotNull(categories);
        assertFalse(categories.isEmpty(), "Vehicle categories should not be empty");
    }

    @Test
    @Order(3)
    void testUpdateVehicle() {
        Vehicle updatedVehicle = new Vehicle(
                testVehicleId,
                "Updated Car",
                "SUV",
                "Diesel",
                "Manual",
                120.00,
                "D456",
                "Jane Doe",
                "updated_vehicle.jpg",
                "available"
        );

        boolean updated = vehicleDAO.updateVehicle(updatedVehicle);
        assertTrue(updated, "Failed to update vehicle");

        // Verify the update
        List<Vehicle> vehicles = vehicleDAO.getAllVehicles("Updated Car");
        assertFalse(vehicles.isEmpty(), "Updated vehicle not found!");
        assertEquals("SUV", vehicles.get(0).getVehicleType());
    }

    @Test
    @Order(4)
    void testDeleteVehicle() {
        boolean deleted = vehicleDAO.deleteVehicle(testVehicleId);
        assertTrue(deleted, "Failed to delete vehicle");

        // Ensure vehicle is deleted
        List<Vehicle> vehicles = vehicleDAO.getAllVehicles("Updated Car");
        assertTrue(vehicles.isEmpty(), "Vehicle still exists after deletion!");
    }

    @AfterAll
    static void tearDown() {
        try {
            if (conn != null) conn.close();
            System.out.println("Database connection closed.");
        } catch (Exception e) {
            System.err.println("ERROR: Failed to close DB connection - " + e.getMessage());
        }
    }
}
