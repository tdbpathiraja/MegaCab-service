document.addEventListener('DOMContentLoaded', () => {
    const loginBtn = document.getElementById('auth-loginBtn');
    const signupBtn = document.getElementById('auth-signupBtn');
    const loginForm = document.getElementById('auth-loginForm');
    const signupForm = document.getElementById('auth-signupForm');
  
    // Toggle between Login and Signup forms
    loginBtn.addEventListener('click', () => {
      loginForm.classList.remove('d-none');
      signupForm.classList.add('d-none');
      loginBtn.classList.add('auth-active');
      signupBtn.classList.remove('auth-active');
    });
  
    signupBtn.addEventListener('click', () => {
      signupForm.classList.remove('d-none');
      loginForm.classList.add('d-none');
      signupBtn.classList.add('auth-active');
      loginBtn.classList.remove('auth-active');
    });
  
    // Password visibility toggle
    const togglePassword = (inputId, toggleBtnId) => {
      const passwordInput = document.getElementById(inputId);
      const toggleBtn = document.getElementById(toggleBtnId);
      toggleBtn.addEventListener('click', () => {
        if (passwordInput.type === 'password') {
          passwordInput.type = 'text';
          toggleBtn.innerHTML = '<i class="fas fa-eye-slash"></i>';
        } else {
          passwordInput.type = 'password';
          toggleBtn.innerHTML = '<i class="fas fa-eye"></i>';
        }
      });
    };
  
    togglePassword('auth-loginPassword', 'auth-toggleLoginPassword');
    togglePassword('auth-signupPassword', 'auth-toggleSignupPassword');
  });