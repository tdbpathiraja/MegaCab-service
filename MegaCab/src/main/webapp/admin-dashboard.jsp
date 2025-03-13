<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Prevent browser from caching this page (prevents back-button access after logout)
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    // Retrieve session and check authentication
    HttpSession sessionAdmin = request.getSession(false);
    if (sessionAdmin == null || sessionAdmin.getAttribute("adminUser") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    // Get logged-in admin username
    String adminUser = (String) sessionAdmin.getAttribute("adminUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega Cab - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="src/css/admin.css">

    <script src="src/js/admin-dashboard-countdown.js"></script>
</head>
<body>
    <div id="wrapper">
        <!-- Sidebar -->
        <nav id="sidebar">
            <div class="sidebar-brand">
                <div class="sidebar-brand-icon">
                    <i class="bi bi-car-front-fill"></i>
                </div>
                <div class="sidebar-brand-text">MegaCab Admin</div>
            </div>
            
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link active" href="#" data-section="dashboard-section">
                        <i class="bi bi-speedometer2"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="#" data-section="users-section">
                        <i class="bi bi-people-fill"></i>
                        <span>Manage Users</span>
                    </a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="#" data-section="bookings-section">
                        <i class="bi bi-calendar-check-fill"></i>
                        <span>Manage Bookings</span>
                    </a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="#" data-section="vehicles-section">
                        <i class="bi bi-car-front-fill"></i>
                        <span>Manage Vehicles</span>
                    </a>
                </li>
                
                <li class="nav-item mt-auto">
                    <a class="nav-link" href="AdminLogoutServlet">
                        <i class="bi bi-box-arrow-right"></i>
                        <span>Logout</span>
                    </a>
                </li>
            </ul>
        </nav>
        
        <!-- Page Content -->
        <div id="content">
            <!-- Toggle Button -->
            <button id="sidebarToggle" class="btn btn-link rounded-circle position-fixed d-lg-none" 
                    style="top: 1rem; left: 1rem; z-index: 1050; color: var(--secondary-color); background: var(--primary-color); width: 45px; height: 45px; display: flex; align-items: center; justify-content: center;">
                <i class="bi bi-list"></i>
            </button>

            <!-- Dashboard Section -->
            <div id="dashboard-section" class="content-section active">
                <div class="container-fluid">
                    <h1 class="section-title">MegaCab Car Renting System</h1>

                    <!-- Project Information -->
                    <div class="row">
                        <div class="col-12 mb-4">
                            <div class="card glass-effect">
                                <div class="card-header bg-transparent">
                                    <h5 class="mb-0">Project Information</h5>
                                </div>
                                <div class="card-body">
                                    <div class="d-flex flex-column">
                                        <div class="mb-3">
                                            <h6 class="fw-bold">Module Name:</h6>
                                            <p>Advanced Programming</p>
                                        </div>
                                        <div class="mb-3">
                                            <h6 class="fw-bold">Project:</h6>
                                            <p>MegaCab Car Renting System</p>
                                        </div>
                                        <div>
                                            <h6 class="fw-bold">Developed by:</h6>
                                            <p>Tharindu Darshana Bandara Pathiraja</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Users Section -->
            <div id="users-section" class="content-section">
                <div class="container-fluid">
                    <h1 class="section-title">Manage Users</h1>

                    <div class="card glass-effect mb-4">
                        <div class="card-body">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <input type="text" id="searchInput" class="form-control" placeholder="Search users...">
                                        <button class="btn btn-primary" id="searchButton" type="button">
                                            <i class="bi bi-search"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-6 text-md-end mt-3 mt-md-0">
                                    <button class="btn btn-outline-primary ms-2" id="filterButton">
                                        <i class="bi bi-filter"></i> Filter
                                    </button>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table" id="usersTable">
                                    <thead>
                                    <tr>
                                        <th>Reg Number</th>
                                        <th>Username</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <!-- Rows will be loaded dynamically via AJAX -->
                                    </tbody>
                                </table>
                            </div>

                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <div id="usersCount">Showing 0 of 0 users</div>
                                <nav>
                                    <ul class="pagination" id="pagination">
                                        <!-- Pagination items will be dynamically generated -->
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit User Modal -->
            <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="editUserForm">
                                <input type="hidden" name="userId" id="editUserId">
                                <div class="mb-3">
                                    <label for="editRegNumber" class="form-label">Registration Number</label>
                                    <input type="text" class="form-control" id="editRegNumber" name="editRegNumber" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="editEmail" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="editEmail" name="editEmail">
                                </div>
                                <div class="mb-3">
                                    <label for="editName" class="form-label">Name</label>
                                    <input type="text" class="form-control" id="editName" name="editName">
                                </div>
                                <div class="mb-3">
                                    <label for="editPhone" class="form-label">Phone</label>
                                    <input type="text" class="form-control" id="editPhone" name="editPhone">
                                </div>

                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bookings Section -->
            <div id="bookings-section" class="content-section">
                <div class="container-fluid">
                    <h1 class="section-title">Manage Bookings</h1>

                    <div class="card glass-effect mb-4">
                        <div class="card-body">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <input type="text" id="bookingSearchInput" class="form-control" placeholder="Search bookings...">
                                        <button class="btn btn-primary" id="bookingSearchButton" type="button">
                                            <i class="bi bi-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table" id="bookingsTable">
                                    <thead>
                                    <tr>
                                        <th>Booking ID</th>
                                        <th>Customer Name</th>
                                        <th>Mobile Number</th>
                                        <th>Booked Vehicle</th>
                                        <th>Rental Days</th>
                                        <th>Total Value</th>
                                        <th>Start Location</th>
                                        <th>End Location</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <!-- Rows will be loaded dynamically via AJAX -->
                                    </tbody>
                                </table>
                            </div>

                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <div id="bookingsCount">Showing 0 of 0 bookings</div>
                                <nav>
                                    <ul class="pagination" id="bookingPagination">

                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Vehicles Section -->
            <div id="vehicles-section" class="content-section">
                <div class="container-fluid">
                    <h1 class="section-title">Manage Vehicles</h1>

                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="card glass-effect">
                                <div class="card-body">
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <input type="text" id="vehicleSearchInput" class="form-control" placeholder="Search vehicles...">
                                                <button class="btn btn-primary" id="vehicleSearchButton" type="button">
                                                    <i class="bi bi-search"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="col-md-6 text-md-end mt-3 mt-md-0">
                                            <button class="btn btn-primary" id="addVehicleBtn">
                                                <i class="bi bi-plus-circle"></i> Add Vehicle
                                            </button>
                                            <button class="btn btn-outline-primary ms-2" id="vehicleFilterBtn">
                                                <i class="bi bi-filter"></i> Filter
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row" id="vehiclesContainer">

                    </div>

                    <div class="d-flex justify-content-end mt-3">
                        <nav>
                            <ul class="pagination" id="vehiclePagination">

                            </ul>
                        </nav>
                    </div>
                </div>
            </div>

            <!-- Popup Modal for Add/Edit Vehicle -->
            <div class="modal fade" id="vehicleModal" tabindex="-1" aria-labelledby="vehicleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <!-- Use multipart/form-data for file upload -->
                        <form id="vehicleForm" enctype="multipart/form-data">
                            <div class="modal-header">
                                <h5 class="modal-title" id="vehicleModalLabel">Add / Edit Vehicle</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <!-- Hidden field for vehicle ID (0 for new vehicle) -->
                                <input type="hidden" name="vehicleId" id="vehicleId" value="0">
                                <!-- Hidden field to store current image name -->
                                <input type="hidden" name="oldVehicleImg" id="oldVehicleImg" value="">
                                <div class="mb-3">
                                    <label for="vehicleName" class="form-label">Vehicle Name</label>
                                    <input type="text" class="form-control" id="vehicleName" name="vehicleName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="vehicleType" class="form-label">Vehicle Type</label>
                                    <input type="text" class="form-control" id="vehicleType" name="vehicleType" required>
                                </div>
                                <div class="mb-3">
                                    <label for="fuelType" class="form-label">Fuel Type</label>
                                    <input type="text" class="form-control" id="fuelType" name="fuelType" required>
                                </div>
                                <div class="mb-3">
                                    <label for="transmission" class="form-label">Transmission</label>
                                    <input type="text" class="form-control" id="transmission" name="transmission" required>
                                </div>
                                <div class="mb-3">
                                    <label for="pricePerDay" class="form-label">Price per Day</label>
                                    <input type="number" step="0.01" class="form-control" id="pricePerDay" name="pricePerDay" required>
                                </div>
                                <div class="mb-3">
                                    <label for="driverId" class="form-label">Driver ID</label>
                                    <input type="text" class="form-control" id="driverId" name="driverId" required>
                                </div>
                                <div class="mb-3">
                                    <label for="driverName" class="form-label">Driver Name</label>
                                    <input type="text" class="form-control" id="driverName" name="driverName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="vehicleImg" class="form-label">Vehicle Image</label>
                                    <input type="file" class="form-control" id="vehicleImg" name="vehicleImg">
                                    <small id="currentImgInfo" class="text-muted"></small>
                                </div>
                            </div>
                            <div class="modal-footer">

                                <button type="submit" class="btn btn-primary">Save Vehicle</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <footer class="mt-auto py-4 bg-transparent">
                <div class="container-fluid">
                    <div class="d-flex flex-column flex-md-row justify-content-between">
                        <div class="text-center text-md-start mb-2 mb-md-0">
                            &copy; 2025 MegaCab. All rights reserved.
                        </div>
                        <div class="text-center text-md-end">
                            Design for CIS6003 Advanced Programing Assignment
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="src/js/admin.js"></script>
    <script src="src/js/user-manage.js"></script>
    <script src="src/js/admin-booking-manage.js"></script>
    <script src="src/js/admin-vehicle-manage.js"></script>
</body>
</html>