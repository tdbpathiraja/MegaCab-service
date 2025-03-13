<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Top Navigation -->
<div class="mc-top-nav">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div class="mc-top-nav__left">
                <a href="auth.jsp" class="mc-top-nav__link mc-top-nav__auth">
                    <i class="fas fa-sign-in-alt"></i> Sign In / Sign Up
                </a>
            </div>
            <div class="mc-top-nav__right">
                <a href="tel:+94322246472" class="mc-top-nav__link">
                    <i class="fas fa-phone"></i> +94 32 22 46 472
                </a>
                <a href="mailto:info@megacitycab.lk" class="mc-top-nav__link">
                    <i class="fas fa-envelope"></i> info@megacitycab.lk
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Main Navigation -->
<nav class="mc-main-nav">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <a href="index.jsp">
                <img src="src/img/Logo.png" alt="Mega City Cab" class="mc-main-nav__logo">
            </a>
            <div class="mc-main-nav__menu-wrapper">
                <div class="mc-main-nav__menu">
                    <a href="index.jsp#home" class="mc-main-nav__link">Home</a>
                    <a href="index.jsp#services" class="mc-main-nav__link">Services</a>
                    <a href="index.jsp#about" class="mc-main-nav__link">About</a>
                    <a href="index.jsp#testimonials" class="mc-main-nav__link">Testimonials</a>
                    <a href="contact.jsp" class="mc-main-nav__link">Contact</a>
                    <a href="our-vehicles.jsp" class="mc-book-btn">Book Now</a>
                </div>
                <button class="mc-main-nav__hamburger" aria-label="Toggle Navigation">
                    <span></span><span></span><span></span>
                </button>
            </div>
        </div>
    </div>
</nav>
