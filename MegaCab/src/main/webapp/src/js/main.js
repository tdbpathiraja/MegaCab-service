// Initialize AOS
AOS.init({
    duration: 1000,
    once: true
});

// Smooth scroll
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'
        });
    });
});

// Navbar scroll effect
window.addEventListener('scroll', function() {
    if (window.scrollY > 50) {
        document.querySelector('.mc-main-nav').style.background = 'rgba(255, 255, 255, 0.98)';
    } else {
        document.querySelector('.mc-main-nav').style.background = 'rgba(255, 255, 255, 1)';
    }
});

// Mobile Navigation Toggle
document.addEventListener('DOMContentLoaded', function() {
const hamburger = document.querySelector('.mc-main-nav__hamburger');
const menu = document.querySelector('.mc-main-nav__menu');

hamburger.addEventListener('click', function() {
hamburger.classList.toggle('active');
menu.classList.toggle('active');
});

// Close menu when a link is clicked
document.querySelectorAll('.mc-main-nav__link').forEach(link => {
link.addEventListener('click', function() {
    hamburger.classList.remove('active');
    menu.classList.remove('active');
});
});
});