<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Login - Mega City Cab</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
  <style>
    :root {
      --primary-yellow: #FFD700;
      --secondary-yellow: #F7CA18;
      --dark-yellow: #d4af37;
      --light-gray: #f5f5f5;
      --charcoal: #333333;
    }

    body {
      background-color: var(--light-gray);
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .mega-cab-container {
      max-width: 500px;
      margin: 0 auto;
      padding: 0 20px;
    }

    .admin-login-card {
      background-color: white;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      padding: 30px;
      margin-top: 50px;
      border-top: 5px solid var(--secondary-yellow);
    }

    .login-header {
      text-align: center;
      margin-bottom: 30px;
    }

    .cab-logo-wrapper {
      width: 80px;
      height: 80px;
      background-color: var(--primary-yellow);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 20px;
      color: var(--charcoal);
      font-size: 2rem;
    }

    .admin-title {
      color: var(--charcoal);
      font-weight: 700;
      margin-bottom: 5px;
    }

    .admin-subtitle {
      color: #666;
      font-size: 14px;
    }

    .login-form-wrapper .form-group {
      margin-bottom: 20px;
    }

    .login-form-wrapper .form-label {
      font-weight: 600;
      color: var(--charcoal);
      margin-bottom: 8px;
    }

    .login-form-wrapper .form-control {
      padding: 12px 15px;
      border-radius: 8px;
      border: 1px solid #e0e0e0;
      background-color: #f9f9f9;
      transition: all 0.3s ease;
    }

    .login-form-wrapper .form-control:focus {
      border-color: var(--secondary-yellow);
      box-shadow: 0 0 0 0.25rem rgba(255, 215, 0, 0.25);
    }

    .input-group-text {
      background-color: var(--light-gray);
      border: 1px solid #e0e0e0;
      border-right: none;
    }

    .login-btn {
      background-color: var(--secondary-yellow);
      border: none;
      padding: 12px;
      font-weight: 600;
      border-radius: 8px;
      transition: all 0.3s ease;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      color: var(--charcoal);
    }

    .login-btn:hover, .login-btn:focus {
      background-color: var(--dark-yellow);
      box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
      transform: translateY(-2px);
    }

    .error-alert {
      border-radius: 8px;
      border-left: 5px solid #dc3545;
      background-color: rgba(220, 53, 69, 0.1);
    }

    .login-footer {
      text-align: center;
      margin-top: 25px;
      color: #666;
      font-size: 14px;
    }

    @media (max-width: 576px) {
      .admin-login-card {
        padding: 20px;
        margin-top: 30px;
      }

      .cab-logo-wrapper {
        width: 60px;
        height: 60px;
        font-size: 1.5rem;
      }
    }
  </style>
</head>
<body>
<div class="container mega-cab-container">
  <div class="admin-login-card">
    <div class="login-header">
      <div class="cab-logo-wrapper">
        <i class="bi bi-taxi-front"></i>
      </div>
      <h2 class="admin-title">Admin Login</h2>
      <p class="admin-subtitle">Mega City Cab Management System</p>
    </div>

    <% if(request.getParameter("error") != null){ %>
    <div class="alert error-alert mb-4">
      <i class="bi bi-exclamation-triangle-fill me-2"></i>
      Invalid credentials. Please try again.
    </div>
    <% } %>

    <div class="login-form-wrapper">
      <form action="AdminLoginServlet" method="POST">
        <div class="form-group mb-3">
          <label for="username" class="form-label">Username</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
            <input type="text" name="username" id="username" class="form-control" placeholder="Enter your username" required>
          </div>
        </div>
        <div class="form-group mb-4">
          <label for="password" class="form-label">Password</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
            <input type="password" name="password" id="password" class="form-control" placeholder="Enter your password" required>
          </div>
        </div>
        <button type="submit" class="btn login-btn w-100">
          <i class="bi bi-box-arrow-in-right me-2"></i>Login
        </button>
      </form>
    </div>

    <div class="login-footer">
      <p>© 2025 Mega City Cab Services. All rights reserved.</p>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>