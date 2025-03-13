package com.megacabproject.dao;

import com.megacabproject.models.Booking;
import com.megacabproject.utils.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class BookingDAOTest {
    private static Connection testConn;
    private static BookingDAO bookingDAO;

    @BeforeAll
    static void setupDatabase() throws SQLException {
        // Initialize in-memory H2 database connection
        testConn = DBConnection.getConnection(); // Ensure DBConnection supports a test connection
        bookingDAO = new BookingDAO();
    }

    @BeforeEach
    void clearDatabase() throws SQLException {
        // Clear the table before each test to maintain isolation
        testConn.prepareStatement("DELETE FROM bookings").executeUpdate();
    }

    @Test
    void testInsertBooking() {
        Booking booking = new Booking(
                "BKG-12345", "testUser", "John Doe", "123 Test Street",
                "555-1234", "Toyota Prius", 100.00, 2, 220.00, 20.00,
                "City A", "City B", "DISC10", 10.00
        );

        boolean result = bookingDAO.insertBooking(booking);
        assertTrue(result, "Booking should be inserted successfully.");
    }

    @Test
    void testGetAllBookings() {
        Booking booking1 = new Booking("BKG-1001", "testUser1", "Alice", "Street 1",
                "555-1111", "Car A", 200.00, 3, 660.00, 60.00, "Start1", "End1", "DISC20", 40.00);
        Booking booking2 = new Booking("BKG-1002", "testUser2", "Bob", "Street 2",
                "555-2222", "Car B", 150.00, 4, 660.00, 60.00, "Start2", "End2", "DISC15", 30.00);

        bookingDAO.insertBooking(booking1);
        bookingDAO.insertBooking(booking2);

        List<Booking> bookings = bookingDAO.getAllBookings();
        assertEquals(2, bookings.size(), "There should be 2 bookings retrieved.");
    }

    @Test
    void testDeleteBooking() {
        Booking booking = new Booking("BKG-3001", "testUser3", "Charlie", "Street 3",
                "555-3333", "Car C", 120.00, 5, 660.00, 60.00, "Start3", "End3", null, 0.00);

        bookingDAO.insertBooking(booking);
        boolean isDeleted = bookingDAO.deleteBooking("BKG-3001");

        assertTrue(isDeleted, "Booking should be deleted successfully.");
        assertNull(bookingDAO.getBookingById("BKG-3001"), "Deleted booking should not exist.");
    }

    @Test
    void testGetBookingsByUsername() {
        Booking booking = new Booking("BKG-4001", "testUser4", "David", "Street 4",
                "555-4444", "Car D", 110.00, 2, 660.00, 60.00, "Start4", "End4", "DISC5", 5.00);

        bookingDAO.insertBooking(booking);
        List<Booking> userBookings = bookingDAO.getBookingsByUsername("testUser4");

        assertEquals(1, userBookings.size(), "There should be one booking for testUser4.");
    }

    @Test
    void testGetBookingById() {
        Booking booking = new Booking("BKG-5001", "testUser5", "Eve", "Street 5",
                "555-5555", "Car E", 90.00, 1, 660.00, 60.00, "Start5", "End5", null, 0.00);

        bookingDAO.insertBooking(booking);
        Booking retrievedBooking = bookingDAO.getBookingById("BKG-5001");

        assertNotNull(retrievedBooking, "Booking should be retrieved successfully.");
        assertEquals("Eve", retrievedBooking.getCustomerName(), "Customer name should match.");
    }

    @AfterAll
    static void tearDown() throws SQLException {
        testConn.close(); // Close the test DB connection
    }
}