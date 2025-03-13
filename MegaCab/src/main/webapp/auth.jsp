<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Mega Cab</title>
  
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
  
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  
  <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
  
  <link rel="stylesheet" href="src/css/styles.css">
</head>
<body>

<%--Navigation Bar--%>
<jsp:include page="navbar.jsp" />

  <div class="auth-background"></div>
  <div class="auth-container d-flex justify-content-center align-items-center vh-100">
    <div class="auth-card auth-glassmorphism animate__animated animate__fadeIn">
      <div class="auth-card-body p-5">
        <!-- Toggle Buttons -->
        <div class="auth-toggle-buttons d-flex justify-content-center mb-4">
          <button id="auth-loginBtn" class="auth-btn auth-btn-toggle auth-active">Login</button>
          <button id="auth-signupBtn" class="auth-btn auth-btn-toggle">Signup</button>
        </div>
        <!-- Login Form -->
        <form id="auth-loginForm" class="auth-form" action="LoginServlet" method="POST">

            <input type="hidden" name="action" value="login">
            
          <div class="auth-form-group mb-3">
            <label for="auth-loginUsername" class="auth-form-label"><i class="fas fa-user"></i> Username</label>
            <input type="text" name="username" class="auth-form-control" id="auth-loginUsername" required>
          </div>
          <div class="auth-form-group mb-3">
            <label for="auth-loginPassword" class="auth-form-label"><i class="fas fa-lock"></i> Password</label>
            <div class="auth-input-group">
              <input type="password" name="password" class="auth-form-control" id="auth-loginPassword" required>
              <button type="button" class="auth-btn auth-btn-outline" id="auth-toggleLoginPassword">
                <i class="fas fa-eye"></i>
              </button>
            </div>
          </div>
          <div class="auth-form-check mb-3">
            <input type="checkbox" class="auth-form-check-input" id="auth-rememberMe">
            <label class="auth-form-check-label" for="auth-rememberMe">Remember Me</label>
          </div>
          <button type="submit" class="auth-btn auth-btn-primary w-100 mb-3">Login</button>
          <a href="#" class="auth-text-center d-block">Forgot Password?</a>
        </form>

        <!-- Signup Form -->
        <form id="auth-signupForm" class="auth-form d-none" action="SignupServlet" method="POST">

            <input type="hidden" name="action" value="signup">

            <div class="auth-form-group mb-3">
              <label for="auth-signupUsername" class="auth-form-label"><i class="fas fa-user"></i> Username</label>
              <input type="text" name="username" class="auth-form-control" id="auth-signupUsername" required>
            </div>
          
            
            <div class="auth-form-group mb-3">
              <label for="auth-signupName" class="auth-form-label"><i class="fas fa-id-card"></i> Full Name</label>
              <input type="text" name="fullName" class="auth-form-control" id="auth-signupName" required>
            </div>
          
            
            <div class="auth-form-group mb-3">
              <label for="auth-signupAddress" class="auth-form-label"><i class="fas fa-map-marker-alt"></i> Address</label>
              <input type="text" name="address" class="auth-form-control" id="auth-signupAddress" required>
            </div>
          
            
            <div class="auth-form-group mb-3">
              <label for="auth-signupTelephone" class="auth-form-label"><i class="fas fa-phone"></i> Telephone Number</label>
              <input type="tel" name="telephone" class="auth-form-control" id="auth-signupTelephone" required>
            </div>
          
           
            <div class="auth-form-group mb-3">
              <label for="auth-signupNIC" class="auth-form-label"><i class="fas fa-id-badge"></i> NIC Number</label>
              <input type="text" name="nic" class="auth-form-control" id="auth-signupNIC" required>
            </div>
          
            
            <div class="auth-form-group mb-3">
              <label for="auth-signupEmail" class="auth-form-label"><i class="fas fa-envelope"></i> Email</label>
              <input type="email" name="email" class="auth-form-control" id="auth-signupEmail" required>
            </div>
          
            
            <div class="auth-form-group mb-3">
              <label for="auth-signupPassword" class="auth-form-label"><i class="fas fa-lock"></i> Password</label>
              <div class="auth-input-group">
                <input type="password" name="password" class="auth-form-control" id="auth-signupPassword" required>
                <button type="button" class="auth-btn auth-btn-outline" id="auth-toggleSignupPassword">
                  <i class="fas fa-eye"></i>
                </button>
              </div>
            </div>
          
            
            <button type="submit" class="auth-btn auth-btn-primary w-100">Signup</button>
          </form>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <script src="src/js/auth.js"></script>
</body>
</html>