<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.megacabproject.models.User" %>
<%@ page import="com.megacabproject.services.UserService" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Check if user is logged in via session
    HttpSession sessionObj = request.getSession(false);
    String loggedInUsername = (sessionObj != null) ? (String) sessionObj.getAttribute("loggedUser") : null;

    if (loggedInUsername == null) {
        // Redirect to auth.jsp if user is not logged in
        response.sendRedirect("auth.jsp");
        return;
    }

    // Fetch user details from database
    UserService userService = new UserService();
    User loggedInUser = userService.getUserByUsername(loggedInUsername);

    // Retrieve URL parameters for selected vehicle
    String vehicleId = request.getParameter("vehicle_id");
    String vehicleName = request.getParameter("vehicle_name");
    String vehiclePrice = request.getParameter("vehicle_price");

    if (vehicleId == null || vehicleName == null || vehiclePrice == null) {
        response.sendRedirect("our-vehicles.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="src/css/styles.css">
</head>
<body>

<%--Navigation Bar--%>
<jsp:include page="navbar.jsp" />

      
    <div class="container booking-container my-5">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="card booking-card shadow-strong">
                    <div class="card-header booking-header">
                        <h2 class="text-center">Booking Form</h2>
                    </div>
                    <div class="card-body booking-body">
                        <form id="bookingForm" action="BookingServlet" method="POST">

                            <input type="hidden" name="vehicleId" value="<%= vehicleId %>">
                            <input type="hidden" name="vehicleName" value="<%= vehicleName %>">
                            <input type="hidden" name="vehiclePrice" value="<%= vehiclePrice %>">

                            <input type="hidden" name="username" value="<%= loggedInUser.getUsername() %>">

                            <!-- Customer Name -->
                            <div class="mb-3 booking-input-group">
                                <label for="bookingCustomerName" class="form-label">Customer Name</label>
                                <input type="text" class="form-control booking-input" id="bookingCustomerName" name="customerName"
                                       value="<%= loggedInUser.getFullName() %>" required readonly>
                            </div>

                            <!-- Address -->
                            <div class="mb-3 booking-input-group">
                                <label for="bookingAddress" class="form-label">Your Address</label>
                                <input type="text" class="form-control booking-input" id="bookingAddress" name="customerAddress"
                                       value="<%= loggedInUser.getAddress() %>" required readonly>
                            </div>

                            <!-- Email Address -->
                            <div class="mb-3 booking-input-group">
                                <label for="emailAddress" class="form-label">Your Email Address</label>
                                <input type="email" class="form-control booking-input" id="emailAddress" name="customerEmail" required>
                            </div>

                            <!-- Telephone Number -->
                            <div class="mb-3 booking-input-group">
                                <label for="bookingTelephone" class="form-label">Telephone Number</label>
                                <input type="tel" class="form-control booking-input" id="bookingTelephone" name="telephoneNumber" required>
                            </div>

                            <!-- Car Details (Read-only) -->
                            <div class="mb-3 booking-input-group">
                                <label for="bookingCarDetails" class="form-label">Booked Car Details</label>
                                <input type="text" class="form-control booking-input" id="bookingCarDetails" readonly>
                            </div>

                            <!-- Rental Days -->
                            <div class="mb-3 booking-input-group">
                                <label for="bookingRentalDays" class="form-label">Number of Rental Days</label>
                                <input type="number" class="form-control booking-input" id="bookingRentalDays" min="1" value="1" name="rentalDays" required>
                            </div>

                            <!-- Trip Details -->
                            <div class="mb-3 booking-input-group">
                                <label class="form-label">Trip Details</label>
                                <div class="row">
                                    <div class="col-md-6">
                                        <select class="form-control booking-input" id="bookingStartDestination" name="startDestination" required>
                                            <option value="">Select Start Destination</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <select class="form-control booking-input" id="bookingEndDestination" name="endDestination" required>
                                            <option value="">Select End Destination</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <!-- Discount Code -->
                            <div class="mb-3 booking-input-group">
                                <label for="bookingDiscountCode" class="form-label">Discount Code</label>
                                <div class="input-group">
                                    <input type="text" class="form-control booking-input" id="bookingDiscountCode" name="discountCode" placeholder="Enter discount code">
                                    <button type="button" class="btn booking-btn-secondary">Apply</button>
                                </div>
                                <!-- Hidden field to store discount percentage -->
                                <input type="hidden" id="discountPercentage" name="discountPercentage" value="0">
                            </div>


                            <!-- Price Breakdown -->
                            <div class="mb-3 booking-price-group">
                                <label class="form-label">Price Breakdown</label>
                                <div class="booking-price-item">
                                    <span>Car Price (per day)</span>
                                    <span>0,000</span>
                                </div>
                                <div class="booking-price-item">
                                    <span>Rental Days</span>
                                    <span id="bookingRentalDaysDisplay">1</span>
                                </div>
                                <div class="booking-price-item">
                                    <span>Subtotal</span>
                                    <span>0,000</span>
                                </div>
                                <div class="booking-price-item">
                                    <span>Tax (10%)</span>
                                    <span>000</span>
                                </div>
                                <div class="booking-price-item">
                                    <span>Discount</span>
                                    <span>0</span>
                                </div>
                                <hr class="booking-price-divider">
                                <div class="booking-price-item booking-total">
                                    <span>Total Value</span>
                                    <span>000</span>
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <button type="submit" class="btn booking-btn-primary w-100">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>


  <script src="src/js/destination_validation.js"></script>
  <script src="src/js/country_code.js"></script>
  <script src="src/js/bookingCalc.js"></script>
  <script src="src/js/discount-validation.js"></script>

</body>
</html>