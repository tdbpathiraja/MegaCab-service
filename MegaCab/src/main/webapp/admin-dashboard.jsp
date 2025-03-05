<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.megacabproject.models.User" %>
<%
    if (session == null || session.getAttribute("adminUser") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    String adminUser = (String) session.getAttribute("adminUser");
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
                    <h1 class="section-title">Dashboard Overview</h1>
                    
                    <!-- Status Cards Row -->
                    <div class="row">
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card h-100 status-card status-card-yellow">
                                <div class="status-icon">
                                    <i class="bi bi-people-fill"></i>
                                </div>
                                <div class="status-info">
                                    <h3>1,542</h3>
                                    <p>Registered Users</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card h-100 status-card status-card-green">
                                <div class="status-icon">
                                    <i class="bi bi-calendar-check-fill"></i>
                                </div>
                                <div class="status-info">
                                    <h3>78</h3>
                                    <p>Active Bookings</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card h-100 status-card status-card-blue">
                                <div class="status-icon">
                                    <i class="bi bi-car-front-fill"></i>
                                </div>
                                <div class="status-info">
                                    <h3>164</h3>
                                    <p>Available Vehicles</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card h-100 status-card status-card-orange">
                                <div class="status-icon">
                                    <i class="bi bi-graph-up"></i>
                                </div>
                                <div class="status-info">
                                    <h3>$58.2K</h3>
                                    <p>Monthly Revenue</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Charts and Statistics -->
                    <div class="row">
                        <div class="col-lg-8 mb-4">
                            <div class="card glass-effect">
                                <div class="card-header bg-transparent">
                                    <h5 class="mb-0">Monthly Booking Trends</h5>
                                </div>
                                <div class="card-body">
                                    <img src="/api/placeholder/700/300" alt="Booking Trends Chart" class="img-fluid rounded">
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 mb-4">
                            <div class="card glass-effect h-100">
                                <div class="card-header bg-transparent">
                                    <h5 class="mb-0">Vehicle Types Distribution</h5>
                                </div>
                                <div class="card-body">
                                    <div class="progress-container">
                                        <div class="progress-info">
                                            <span class="fw-medium">Sedan</span>
                                            <span>42%</span>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar bg-warning" style="width: 42%"></div>
                                        </div>
                                    </div>
                                    
                                    <div class="progress-container">
                                        <div class="progress-info">
                                            <span class="fw-medium">SUV</span>
                                            <span>28%</span>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar bg-success" style="width: 28%"></div>
                                        </div>
                                    </div>
                                    
                                    <div class="progress-container">
                                        <div class="progress-info">
                                            <span class="fw-medium">Luxury</span>
                                            <span>15%</span>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar bg-info" style="width: 15%"></div>
                                        </div>
                                    </div>
                                    
                                    <div class="progress-container">
                                        <div class="progress-info">
                                            <span class="fw-medium">Electric</span>
                                            <span>10%</span>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar bg-primary" style="width: 10%"></div>
                                        </div>
                                    </div>
                                    
                                    <div class="progress-container">
                                        <div class="progress-info">
                                            <span class="fw-medium">Van</span>
                                            <span>5%</span>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar bg-danger" style="width: 5%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Recent Activity -->
                    <div class="row">
                        <div class="col-lg-6 mb-4">
                            <div class="card glass-effect">
                                <div class="card-header bg-transparent">
                                    <h5 class="mb-0">Recent Activities</h5>
                                </div>
                                <div class="card-body p-0">
                                    <div class="activity-item new">
                                        <div class="d-flex">
                                            <div class="activity-icon bg-warning text-white">
                                                <i class="bi bi-person-plus"></i>
                                            </div>
                                            <div class="activity-content">
                                                <h6 class="activity-title">New Registration</h6>
                                                <p class="activity-text">Emma Davis created a new account</p>
                                                <small class="activity-time">Just now</small>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="activity-item">
                                        <div class="d-flex">
                                            <div class="activity-icon bg-success text-white">
                                                <i class="bi bi-calendar-check"></i>
                                            </div>
                                            <div class="activity-content">
                                                <h6 class="activity-title">Booking Confirmed</h6>
                                                <p class="activity-text">Michael Brown confirmed booking #78423</p>
                                                <small class="activity-time">2 hours ago</small>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="activity-item">
                                        <div class="d-flex">
                                            <div class="activity-icon bg-info text-white">
                                                <i class="bi bi-car-front"></i>
                                            </div>
                                            <div class="activity-content">
                                                <h6 class="activity-title">Vehicle Returned</h6>
                                                <p class="activity-text">Sophia Miller returned Toyota Camry (XYZ-1234)</p>
                                                <small class="activity-time">Yesterday</small>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="activity-item">
                                        <div class="d-flex">
                                            <div class="activity-icon bg-danger text-white">
                                                <i class="bi bi-exclamation-circle"></i>
                                            </div>
                                            <div class="activity-content">
                                                <h6 class="activity-title">Maintenance Alert</h6>
                                                <p class="activity-text">Honda CR-V scheduled for maintenance</p>
                                                <small class="activity-time">2 days ago</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-lg-6 mb-4">
                            <div class="card glass-effect">
                                <div class="card-header bg-transparent">
                                    <h5 class="mb-0">Top Performing Vehicles</h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table mb-0">
                                            <thead>
                                                <tr>
                                                    <th>Vehicle</th>
                                                    <th>Type</th>
                                                    <th>Bookings</th>
                                                    <th>Revenue</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>Tesla Model 3</td>
                                                    <td>Electric</td>
                                                    <td>145</td>
                                                    <td>$14,500</td>
                                                </tr>
                                                <tr>
                                                    <td>Toyota Camry</td>
                                                    <td>Sedan</td>
                                                    <td>132</td>
                                                    <td>$10,560</td>
                                                </tr>
                                                <tr>
                                                    <td>Honda CR-V</td>
                                                    <td>SUV</td>
                                                    <td>117</td>
                                                    <td>$9,945</td>
                                                </tr>
                                                <tr>
                                                    <td>BMW X5</td>
                                                    <td>Luxury</td>
                                                    <td>98</td>
                                                    <td>$19,600</td>
                                                </tr>
                                            </tbody>
                                        </table>
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
                                        <input type="text" class="form-control" placeholder="Search users...">
                                        <button class="btn btn-primary" type="button">
                                            <i class="bi bi-search"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-6 text-md-end mt-3 mt-md-0">
                                    <button class="btn btn-primary">
                                        <i class="bi bi-person-plus"></i> Add New User
                                    </button>
                                    <button class="btn btn-outline-primary ms-2">
                                        <i class="bi bi-filter"></i> Filter
                                    </button>
                                </div>
                            </div>
                            
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>User</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Registered</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="user-info">
                                                    <img src="/api/placeholder/40/40" class="user-avatar" alt="User">
                                                    <div class="user-text">
                                                        <h6 class="user-name">John Smith</h6>
                                                        <span class="user-role">Premium</span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>john.smith@example.com</td>
                                            <td>(555) 123-4567</td>
                                            <td>12 Jan 2025</td>
                                            <td><span class="badge bg-success">Active</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></button>
                                                <button class="btn btn-sm btn-outline-danger ms-1"><i class="bi bi-trash"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="user-info">
                                                    <img src="/api/placeholder/40/40" class="user-avatar" alt="User">
                                                    <div class="user-text">
                                                        <h6 class="user-name">Emma Davis</h6>
                                                        <span class="user-role">Standard</span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>emma.davis@example.com</td>
                                            <td>(555) 987-6543</td>
                                            <td>22 Feb 2025</td>
                                            <td><span class="badge bg-success">Active</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></button>
                                                <button class="btn btn-sm btn-outline-danger ms-1"><i class="bi bi-trash"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="user-info">
                                                    <img src="/api/placeholder/40/40" class="user-avatar" alt="User">
                                                    <div class="user-text">
                                                        <h6 class="user-name">Michael Brown</h6>
                                                        <span class="user-role">Premium</span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>michael.brown@example.com</td>
                                            <td>(555) 456-7890</td>
                                            <td>3 Jan 2025</td>
                                            <td><span class="badge bg-success">Active</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></button>
                                                <button class="btn btn-sm btn-outline-danger ms-1"><i class="bi bi-trash"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="user-info">
                                                    <img src="/api/placeholder/40/40" class="user-avatar" alt="User">
                                                    <div class="user-text">
                                                        <h6 class="user-name">Sophia Miller</h6>
                                                        <span class="user-role">Standard</span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>sophia.miller@example.com</td>
                                            <td>(555) 234-5678</td>
                                            <td>15 Feb 2025</td>
                                            <td><span class="badge bg-warning">Pending</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></button>
                                                <button class="btn btn-sm btn-outline-danger ms-1"><i class="bi bi-trash"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="user-info">
                                                    <img src="/api/placeholder/40/40" class="user-avatar" alt="User">
                                                    <div class="user-text">
                                                        <h6 class="user-name">James Wilson</h6>
                                                        <span class="user-role">Standard</span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>james.wilson@example.com</td>
                                            <td>(555) 876-5432</td>
                                            <td>18 Jan 2025</td>
                                            <td><span class="badge bg-danger">Inactive</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></button>
                                                <button class="btn btn-sm btn-outline-danger ms-1"><i class="bi bi-trash"></i></button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <div>Showing 5 of 125 users</div>
                                <nav>
                                    <ul class="pagination">
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                                        <li class="page-item">
                                            <a class="page-link" href="#" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Bookings Section -->
            <div id="bookings-section" class="content-section">
                <div class="container-fluid">
                    <h1 class="section-title">Manage Bookings</h1>
                    
                    <div class="row mb-4">
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card glass-effect h-100">
                                <div class="card-body status-card status-card-yellow">
                                    <div class="status-icon">
                                        <i class="bi bi-hourglass-split"></i>
                                    </div>
                                    <div class="status-info">
                                        <h3>32</h3>
                                        <p>Pending</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card glass-effect h-100">
                                <div class="card-body status-card status-card-green">
                                    <div class="status-icon">
                                        <i class="bi bi-check-circle"></i>
                                    </div>
                                    <div class="status-info">
                                        <h3>78</h3>
                                        <p>Active</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card glass-effect h-100">
                                <div class="card-body status-card status-card-blue">
                                    <div class="status-icon">
                                        <i class="bi bi-clock-history"></i>
                                    </div>
                                    <div class="status-info">
                                        <h3>546</h3>
                                        <p>Completed</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card glass-effect h-100">
                                <div class="card-body status-card status-card-orange">
                                    <div class="status-icon">
                                        <i class="bi bi-x-circle"></i>
                                    </div>
                                    <div class="status-info">
                                        <h3>14</h3>
                                        <p>Cancelled</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card glass-effect mb-4">
                        <div class="card-body">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="Search bookings...">
                                        <button class="btn btn-primary" type="button">
                                            <i class="bi bi-search"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-6 text-md-end mt-3 mt-md-0">
                                    <button class="btn btn-primary">
                                        <i class="bi bi-plus-circle"></i> New Booking
                                    </button>
                                    <button class="btn btn-outline-primary ms-2">
                                        <i class="bi bi-filter"></i> Filter
                                    </button>
                                </div>
                            </div>
                            
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Booking ID</th>
                                            <th>Customer</th>
                                            <th>Vehicle</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Status</th>
                                            <th>Total</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>#BK7842</td>
                                            <td>John Smith</td>
                                            <td>Tesla Model 3</td>
                                            <td>01 Mar 2025</td>
                                            <td>05 Mar 2025</td>
                                            <td><span class="badge bg-success">Active</span></td>
                                            <td>$375.00</td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary"><i class="bi bi-eye"></i></button>
                                                <button class="btn btn-sm btn-outline-danger ms-1"><i class="bi bi-x-circle"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>#BK7841</td>
                                            <td>Emma Davis</td>
                                            <td>Toyota Camry</td>
                                            <td>28 Feb 2025</td>
                                            <td>02 Mar 2025</td>
                                            <td><span class="badge bg-success">Active</span></td>
                                            <td>$225.00</td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary"><i class="bi bi-eye"></i></button>
                                                <button class="btn btn-sm btn-outline-danger ms-1"><i class="bi bi-x-circle"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>#BK7840</td>
                                            <td>Michael Brown</td>
                                            <td>BMW X5</td>
                                            <td>05 Mar 2025</td>
                                            <td>10 Mar 2025</td>
                                            <td><span class="badge bg-warning">Pending</span></td>
                                            <td>$750.00</td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary"><i class="bi bi-eye"></i></button>
                                                <button class="btn btn-sm btn-outline-success ms-1"><i class="bi bi-check-circle"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>#BK7839</td>
                                            <td>Sophia Miller</td>
                                            <td>Honda CR-V</td>
                                            <td>27 Feb 2025</td>
                                            <td>28 Feb 2025</td>
                                            <td><span class="badge bg-info">Completed</span></td>
                                            <td>$85.00</td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary"><i class="bi bi-eye"></i></button>
                                                <button class="btn btn-sm btn-outline-secondary ms-1"><i class="bi bi-arrow-repeat"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>#BK7838</td>
                                            <td>James Wilson</td>
                                            <td>Ford Transit</td>
                                            <td>02 Mar 2025</td>
                                            <td>04 Mar 2025</td>
                                            <td><span class="badge bg-danger">Cancelled</span></td>
                                            <td>$180.00</td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary"><i class="bi bi-eye"></i></button>
                                                <button class="btn btn-sm btn-outline-success ms-1"><i class="bi bi-arrow-repeat"></i></button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <div>Showing 5 of 78 active bookings</div>
                                <nav>
                                    <ul class="pagination">
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                                        <li class="page-item">
                                            <a class="page-link" href="#" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
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
                                                <input type="text" class="form-control" placeholder="Search vehicles...">
                                                <button class="btn btn-primary" type="button">
                                                    <i class="bi bi-search"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="col-md-6 text-md-end mt-3 mt-md-0">
                                            <button class="btn btn-primary">
                                                <i class="bi bi-plus-circle"></i> Add Vehicle
                                            </button>
                                            <button class="btn btn-outline-primary ms-2">
                                                <i class="bi bi-filter"></i> Filter
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                            <div class="card vehicle-card glass-effect">
                                <img src="/api/placeholder/300/180" alt="Tesla Model 3" class="vehicle-img">
                                <div class="vehicle-details">
                                    <h5 class="vehicle-title">Tesla Model 3</h5>
                                    <div class="vehicle-info">
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-lightning-charge"></i>
                                            <span>Electric</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-people"></i>
                                            <span>5 Seats</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-gear"></i>
                                            <span>Auto</span>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="badge bg-success">Available</span>
                                        <span class="fw-bold">$75/day</span>
                                    </div>
                                    <div class="d-grid mt-3">
                                        <button class="btn btn-primary">View Details</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                            <div class="card vehicle-card glass-effect">
                                <img src="/api/placeholder/300/180" alt="Toyota Camry" class="vehicle-img">
                                <div class="vehicle-details">
                                    <h5 class="vehicle-title">Toyota Camry</h5>
                                    <div class="vehicle-info">
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-fuel-pump"></i>
                                            <span>Hybrid</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-people"></i>
                                            <span>5 Seats</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-gear"></i>
                                            <span>Auto</span>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="badge bg-success">Available</span>
                                        <span class="fw-bold">$65/day</span>
                                    </div>
                                    <div class="d-grid mt-3">
                                        <button class="btn btn-primary">View Details</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                            <div class="card vehicle-card glass-effect">
                                <img src="/api/placeholder/300/180" alt="BMW X5" class="vehicle-img">
                                <div class="vehicle-details">
                                    <h5 class="vehicle-title">BMW X5</h5>
                                    <div class="vehicle-info">
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-fuel-pump"></i>
                                            <span>Gasoline</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-people"></i>
                                            <span>5 Seats</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-gear"></i>
                                            <span>Auto</span>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="badge bg-danger">Booked</span>
                                        <span class="fw-bold">$120/day</span>
                                    </div>
                                    <div class="d-grid mt-3">
                                        <button class="btn btn-primary">View Details</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                            <div class="card vehicle-card glass-effect">
                                <img src="/api/placeholder/300/180" alt="Honda CR-V" class="vehicle-img">
                                <div class="vehicle-details">
                                    <h5 class="vehicle-title">Honda CR-V</h5>
                                    <div class="vehicle-info">
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-fuel-pump"></i>
                                            <span>Hybrid</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-people"></i>
                                            <span>5 Seats</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-gear"></i>
                                            <span>Auto</span>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="badge bg-success">Available</span>
                                        <span class="fw-bold">$85/day</span>
                                    </div>
                                    <div class="d-grid mt-3">
                                        <button class="btn btn-primary">View Details</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                            <div class="card vehicle-card glass-effect">
                                <img src="/api/placeholder/300/180" alt="Ford Transit" class="vehicle-img">
                                <div class="vehicle-details">
                                    <h5 class="vehicle-title">Ford Transit</h5>
                                    <div class="vehicle-info">
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-fuel-pump"></i>
                                            <span>Diesel</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-people"></i>
                                            <span>9 Seats</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-gear"></i>
                                            <span>Manual</span>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="badge bg-warning">Maintenance</span>
                                        <span class="fw-bold">$95/day</span>
                                    </div>
                                    <div class="d-grid mt-3">
                                        <button class="btn btn-primary">View Details</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                            <div class="card vehicle-card glass-effect">
                                <img src="/api/placeholder/300/180" alt="Audi A4" class="vehicle-img">
                                <div class="vehicle-details">
                                    <h5 class="vehicle-title">Audi A4</h5>
                                    <div class="vehicle-info">
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-fuel-pump"></i>
                                            <span>Gasoline</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-people"></i>
                                            <span>5 Seats</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-gear"></i>
                                            <span>Auto</span>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="badge bg-success">Available</span>
                                        <span class="fw-bold">$95/day</span>
                                    </div>
                                    <div class="d-grid mt-3">
                                        <button class="btn btn-primary">View Details</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                            <div class="card vehicle-card glass-effect">
                                <img src="/api/placeholder/300/180" alt="Jeep Wrangler" class="vehicle-img">
                                <div class="vehicle-details">
                                    <h5 class="vehicle-title">Jeep Wrangler</h5>
                                    <div class="vehicle-info">
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-fuel-pump"></i>
                                            <span>Gasoline</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-people"></i>
                                            <span>5 Seats</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-gear"></i>
                                            <span>Manual</span>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="badge bg-success">Available</span>
                                        <span class="fw-bold">$110/day</span>
                                    </div>
                                    <div class="d-grid mt-3">
                                        <button class="btn btn-primary">View Details</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                            <div class="card vehicle-card glass-effect">
                                <img src="/api/placeholder/300/180" alt="Chevrolet Bolt" class="vehicle-img">
                                <div class="vehicle-details">
                                    <h5 class="vehicle-title">Chevrolet Bolt</h5>
                                    <div class="vehicle-info">
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-lightning-charge"></i>
                                            <span>Electric</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-people"></i>
                                            <span>5 Seats</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-gear"></i>
                                            <span>Auto</span>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="badge bg-danger">Booked</span>
                                        <span class="fw-bold">$70/day</span>
                                    </div>
                                    <div class="d-grid mt-3">
                                        <button class="btn btn-primary">View Details</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-end mt-3">
                        <nav>
                            <ul class="pagination">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
            
            <!-- Footer -->
            <footer class="mt-auto py-4 bg-transparent">
                <div class="container-fluid">
                    <div class="d-flex flex-column flex-md-row justify-content-between">
                        <div class="text-center text-md-start mb-2 mb-md-0">
                            &copy; 2025 VehicleHub. All rights reserved.
                        </div>
                        <div class="text-center text-md-end">
                            Designed with <i class="bi bi-heart-fill text-danger"></i> by Premium Designs
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="src/js/admin.js"></script>
</body>
</html>