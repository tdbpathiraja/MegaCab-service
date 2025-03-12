<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sessionObj = request.getSession(false);
    String loggedUser = (sessionObj != null) ? (String) sessionObj.getAttribute("loggedUser") : null;
    if (loggedUser == null) {
        response.sendRedirect("auth.jsp?error=SessionExpired");
    }
    // Prevent back navigation after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Account | Premium Car Rental</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- AOS Animation Library -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <style>
        :root {
            --primary-yellow: #FFD700;
            --secondary-yellow: #FFC107;
            --light-yellow: #FFEB3B;
            --dark-yellow: #F9A825;
            --primary-black: #191919;
            --secondary-black: #303030;
            --accent-color: #E0A800;
        }

        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap');

        body {
            background-color: #f9f9f9;
            font-family: 'Montserrat', sans-serif;
            color: #333;
            overflow-x: hidden;
        }

        .container {
            max-width: 1200px;
            padding: 0 15px;
        }

        /* Premium Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        ::-webkit-scrollbar-thumb {
            background: var(--primary-yellow);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--dark-yellow);
        }

        .page-wrapper {
            position: relative;
            min-height: 100vh;
        }

        .user-welcome {
            background: linear-gradient(135deg, var(--primary-black), var(--secondary-black));
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
            position: relative;
            margin-top: 20px;
        }

        .user-welcome::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://images.unsplash.com/photo-1580273916550-e323be2ae537?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80') no-repeat;
            background-size: cover;
            opacity: 0.15;
            z-index: 0;
        }

        .user-welcome-content {
            position: relative;
            z-index: 1;
            padding: 2.5rem;
        }

        .user-welcome h2 {
            color: var(--primary-yellow);
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
            font-size: 2.5rem;
        }

        .user-welcome p {
            color: #ffffff;
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 0;
        }

        .section-title {
            position: relative;
            color: var(--primary-black);
            font-weight: 700;
            margin-bottom: 2rem;
            display: inline-block;
        }

        .section-title::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -10px;
            width: 70px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-yellow), var(--dark-yellow));
            border-radius: 2px;
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            overflow: hidden;
            background-color: #ffffff;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary-black), var(--secondary-black));
            color: white;
            border-radius: 15px 15px 0 0 !important;
            border: none;
            padding: 1.5rem;
        }

        .card-header h5 {
            margin-bottom: 0;
            color: var(--primary-yellow);
            font-weight: 600;
            font-size: 1.25rem;
        }

        .card-body {
            padding: 1.5rem;
        }

        .btn-premium {
            background: linear-gradient(135deg, var(--primary-yellow), var(--dark-yellow));
            color: var(--primary-black);
            border: none;
            font-weight: 600;
            padding: 0.75rem 2rem;
            border-radius: 50px;
            box-shadow: 0 4px 15px rgba(255, 215, 0, 0.3);
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
        }

        .btn-premium:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 20px rgba(255, 215, 0, 0.4);
            color: var(--primary-black);
        }

        .btn-premium:active {
            transform: translateY(1px);
        }

        .btn-premium i {
            margin-right: 8px;
        }

        .table-premium {
            border-collapse: separate;
            border-spacing: 0 10px;
            margin-top: -10px;
        }

        .table-premium thead th {
            background-color: var(--primary-black);
            color: var(--primary-yellow);
            border: none;
            padding: 15px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
        }

        .table-premium thead th:first-child {
            border-radius: 10px 0 0 10px;
        }

        .table-premium thead th:last-child {
            border-radius: 0 10px 10px 0;
        }

        .table-premium tbody tr {
            box-shadow: 0 3px 10px rgba(0,0,0,0.03);
            border-radius: 10px;
            background-color: white;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .table-premium tbody tr:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.07);
            background-color: rgba(255, 215, 0, 0.03);
        }

        .table-premium tbody td {
            border: none;
            padding: 20px 15px;
            vertical-align: middle;
        }

        .table-premium tbody td:first-child {
            border-radius: 10px 0 0 10px;
        }

        .table-premium tbody td:last-child {
            border-radius: 0 10px 10px 0;
        }

        .booking-id {
            font-weight: 700;
            color: var(--primary-black);
            letter-spacing: 1px;
        }

        .btn-action {
            background-color: transparent;
            border: 2px solid var(--primary-black);
            color: var(--primary-black);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-right: 5px;
            transition: all 0.3s ease;
        }

        .btn-action:hover {
            background-color: var(--primary-yellow);
            border-color: var(--primary-yellow);
            color: var(--primary-black);
            transform: scale(1.1);
        }

        .booking-banner {
            height: 250px;
            border-radius: 15px;
            position: relative;
            overflow: hidden;
            margin-bottom: 40px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        .booking-banner-img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 10s ease;
        }

        .booking-banner:hover .booking-banner-img {
            transform: scale(1.1);
        }

        .booking-banner-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(25,25,25,0.9) 0%, rgba(25,25,25,0.7) 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 3rem;
            transition: background 0.3s ease;
        }

        .booking-banner:hover .booking-banner-overlay {
            background: linear-gradient(135deg, rgba(25,25,25,0.8) 0%, rgba(25,25,25,0.6) 100%);
        }

        .booking-banner h3 {
            color: var(--primary-yellow);
            font-weight: 700;
            margin-bottom: 1rem;
            font-size: 2rem;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .booking-banner p {
            color: white;
            margin-bottom: 2rem;
            font-size: 1.1rem;
            max-width: 80%;
            text-shadow: 0 1px 2px rgba(0,0,0,0.2);
        }

        .logout-btn {
            display: inline-flex;
            align-items: center;
            background: linear-gradient(135deg, var(--primary-yellow), var(--dark-yellow));
            color: var(--primary-black);
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            letter-spacing: 1px;
            box-shadow: 0 4px 15px rgba(255, 215, 0, 0.3);
            transition: all 0.3s ease;
            text-decoration: none;
            text-transform: uppercase;
            font-size: 0.9rem;
        }

        .logout-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 20px rgba(255, 215, 0, 0.4);
            color: var(--primary-black);
        }

        .logout-btn:active {
            transform: translateY(1px);
        }

        .logout-btn i {
            margin-right: 8px;
        }

        .footer {
            background: linear-gradient(135deg, var(--primary-black), var(--secondary-black));
            color: white;
            padding: 2rem 0;
            margin-top: 5rem;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .footer a {
            color: var(--primary-yellow);
            text-decoration: none;
            margin-left: 1.5rem;
            transition: color 0.3s ease;
        }

        .footer a:hover {
            color: var(--dark-yellow);
            text-decoration: none;
        }

        .vehicle-model {
            font-weight: 600;
            color: var(--secondary-black);
        }

        .amount-paid {
            font-weight: 700;
            color: #28a745;
        }

        .premium-divider {
            height: 4px;
            background: linear-gradient(90deg, var(--primary-yellow), transparent);
            margin: 3rem 0;
            border-radius: 2px;
        }

        /* Animation Classes */
        .fade-up {
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 0.8s ease, transform 0.8s ease;
        }

        .fade-up.active {
            opacity: 1;
            transform: translateY(0);
        }

        /* Responsive styles */
        @media (max-width: 991.98px) {
            .booking-banner h3 {
                font-size: 1.75rem;
            }

            .booking-banner p {
                font-size: 1rem;
                max-width: 90%;
            }

            .user-welcome h2 {
                font-size: 2rem;
            }
        }

        @media (max-width: 767.98px) {
            .user-welcome-content {
                flex-direction: column;
                align-items: flex-start !important;
            }

            .logout-btn {
                margin-top: 1.5rem;
            }

            .booking-banner {
                height: 300px;
            }

            .booking-banner-overlay {
                padding: 2rem;
            }

            .booking-banner h3 {
                font-size: 1.5rem;
            }

            .booking-banner p {
                max-width: 100%;
            }

            .table-responsive {
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            }

            .table-premium tbody td {
                padding: 15px 10px;
            }

            .footer-content {
                flex-direction: column;
                text-align: center;
            }

            .footer-links {
                margin-top: 1rem;
            }

            .footer a {
                margin: 0 0.75rem;
            }
        }

        @media (max-width: 575.98px) {
            .user-welcome h2 {
                font-size: 1.75rem;
            }

            .section-title {
                font-size: 1.5rem;
            }

            .booking-banner {
                height: 350px;
            }

            .booking-banner h3 {
                font-size: 1.35rem;
            }

            .booking-banner p {
                font-size: 0.9rem;
            }

            .btn-premium, .logout-btn {
                width: 100%;
                display: flex;
                justify-content: center;
                margin-top: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="page-wrapper">
    <!-- Main Content -->
    <div class="container">
        <!-- Welcome Section with Logout Button -->
        <div class="row mb-5" data-aos="fade-up" data-aos-duration="800">
            <div class="col-12">
                <div class="user-welcome">
                    <div class="user-welcome-content d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center">
                            <div class="me-4">
                                <i class="fas fa-user-circle" style="font-size: 4rem; color: var(--primary-yellow);"></i>
                            </div>
                            <div>
                                <h2>Welcome, <%= loggedUser %>!</h2>
                                <p>Explore your premium car rental experience</p>
                            </div>
                        </div>
                        <!-- Updated logout link to use LogoutServlet -->
                        <a href="logout" class="logout-btn">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Create a Booking Section -->
        <div class="row mb-5" data-aos="fade-up" data-aos-duration="800" data-aos-delay="100">
            <div class="col-12">
                <div class="booking-banner">
                    <img src="https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80" class="booking-banner-img" alt="Luxury Car">
                    <div class="booking-banner-overlay">
                        <h3><i class="fas fa-car me-2"></i>Elevate Your Journey</h3>
                        <p>Discover our premium fleet of luxury vehicles. From sleek sedans to powerful SUVs, find your perfect ride for any adventure.</p>
                        <a href="our-vehicles.jsp" class="btn-premium">
                            <i class="fas fa-plus"></i>Create a Booking
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bookings Section -->
        <div class="row" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
            <div class="col-12">
                <h3 class="section-title">Your Bookings</h3>

                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-list me-2"></i>Booking History</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-premium">
                                <thead>
                                <tr>
                                    <th>Booking ID</th>
                                    <th>Vehicle</th>
                                    <th>Rental Days</th>
                                    <th>Amount Paid</th>
                                    <th>From</th>
                                    <th>To</th>
                                    <th>Action</th>
                                </tr>
                                </thead>

                                <tbody id="bookingTableBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer" data-aos="fade" data-aos-duration="800">
        <div class="container">
            <div class="footer-content">
                <div class="copyright">
                    <p class="mb-0">&copy; 2025 MegaCab. All rights reserved.</p>
                </div>
                <div class="footer-links">
                    <a href="#">Privacy Policy</a>
                    <a href="#">Terms of Service</a>
                    <a href="#">Contact Us</a>
                </div>
            </div>
        </div>
    </footer>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- AOS Animation Library JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>

<!-- Include jQuery for AJAX calls -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Custom JavaScript -->
<script>
    // Initialize AOS animation
    AOS.init();

    // Add active class to elements with fade-up class after page load
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(function() {
            const fadeElements = document.querySelectorAll('.fade-up');
            fadeElements.forEach(function(element, index) {
                setTimeout(function() {
                    element.classList.add('active');
                }, index * 100);
            });
        }, 300);
    });

    // Use jQuery to fetch the logged-in user's booking data via AJAX
    $(document).ready(function(){
        $.ajax({
            url: 'fetchUserBookings',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                var tbody = $('#bookingTableBody');
                tbody.empty();
                $.each(data, function(index, booking) {
                    var row = '<tr class="fade-up">' +
                        '<td><span class="booking-id">' + booking.bookingId + '</span></td>' +
                        '<td><span class="vehicle-model">' + booking.bookedVehicle + '</span></td>' +
                        '<td>' + booking.rentalDays + '</td>' +
                        '<td><span class="amount-paid">$' + booking.totalValue + '</span></td>' +
                        '<td>' + booking.startDestination + '</td>' +
                        '<td>' + booking.endDestination + '</td>' +
                        '<td>' +
                        '<button class="btn-action download-btn" data-booking-id="' + booking.bookingId + '">' +
                        '<i class="fas fa-download"></i>' +
                        '</button>' +
                        '</td>' +
                        '</tr>';
                    tbody.append(row);
                });
            },
            error: function(err) {
                console.error('Error fetching bookings:', err);
            }
        });

        // When a download button is clicked, redirect to the download servlet with the booking ID
        $(document).on('click', '.download-btn', function(){
            var bookingId = $(this).data('booking-id');
            window.location.href = 'downloadBooking?bookingId=' + bookingId;
        });
    });
</script>
</body>
</html>
