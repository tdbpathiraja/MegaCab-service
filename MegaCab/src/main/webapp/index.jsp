<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mega City Cab</title>
    <link rel="icon" type="image/x-icon" href="favicon.ico" />

    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />

    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    />

    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet" />

    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />

    <link rel="stylesheet" href="src/css/styles.css" />
  </head>
  <body>

  <%--Navigation Bar--%>
  <jsp:include page="navbar.jsp" />

    <!-- Hero Section -->
    <section class="mc-hero" id="home">
      <div class="container">
        <div class="mc-hero__content" data-aos="fade-up">
          <h1 class="mc-hero__title">Premium Taxi Service in Your City</h1>
          <p class="mc-hero__subtitle">
            Experience comfort and luxury with our professional taxi service
          </p>
          <div class="mc-hero__cta">
            <a href="our-vehicles.jsp" class="mc-hero__btn mc-hero__btn--primary"
              >Book Now</a
            >
            <a href="services.jsp" class="mc-hero__btn mc-hero__btn--secondary"
              >Our Services</a
            >
          </div>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section class="mc-features">
      <div class="mc-features__shape mc-features__shape--1"></div>
      <div class="mc-features__shape mc-features__shape--2"></div>
      <div class="container">
        <div class="text-center mb-5">
          <h2 class="section-title" data-aos="fade-up">Why Choose Us</h2>
        </div>
        <div class="row">
          <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
            <div class="mc-feature-card">
              <i class="fas fa-clock mc-feature-card__icon"></i>
              <h3 class="mc-feature-card__title">24/7 Service</h3>
              <p>Available round the clock for your convenience</p>
            </div>
          </div>
          <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
            <div class="mc-feature-card">
              <i class="fas fa-shield-alt mc-feature-card__icon"></i>
              <h3 class="mc-feature-card__title">Safe & Secure</h3>
              <p>Top-notch safety measures for our valued customers</p>
            </div>
          </div>
          <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
            <div class="mc-feature-card">
              <i class="fas fa-star mc-feature-card__icon"></i>
              <h3 class="mc-feature-card__title">Premium Quality</h3>
              <p>Unmatched service with highest standards of excellence</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="mc-services" id="services">
      <div class="container">
        <div class="text-center mb-5">
          <h2 class="section-title" data-aos="fade-up">Our Services</h2>
        </div>
        <div class="row">
          <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
            <div class="mc-service-card">
              <div class="mc-service-card__image">
                <img src="luxury-ride.jpg" alt="Luxury Ride" />
              </div>
              <div class="mc-service-card__content">
                <h3 class="mc-service-card__title">Luxury Ride</h3>
                <span class="mc-service-card__price"
                  >Starting at Rs. 8,500</span
                >
              </div>
            </div>
          </div>
          <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
            <div class="mc-service-card">
              <div class="mc-service-card__image">
                <img src="corporate-service.jpg" alt="Corporate Service" />
              </div>
              <div class="mc-service-card__content">
                <h3 class="mc-service-card__title">Corporate Package</h3>
                <span class="mc-service-card__price">Starting at Rs.6,000</span>
              </div>
            </div>
          </div>
          <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
            <div class="mc-service-card">
              <div class="mc-service-card__image">
                <img src="airport-transfer.jpg" alt="Airport Transfer" />
              </div>
              <div class="mc-service-card__content">
                <h3 class="mc-service-card__title">Airport Transfer</h3>
                <span class="mc-service-card__price"
                  >Starting at Rs. 7,500</span
                >
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="mc-company" id="about">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-md-6" data-aos="fade-right">
            <div class="mc-company__image-wrapper">
              <img
                src="src/img/Home_page_about.png"
                alt="Mega City Cab"
                class="mc-company__image"
              />
            </div>
          </div>
          <div class="col-md-6" data-aos="fade-left">
            <div class="mc-company__content">
              <h2 class="section-title">About Mega City Cab</h2>
              <p>
                Providing premium taxi services with a commitment to comfort and
                reliability.
              </p>
              <div class="mc-company__stats">
                <div class="mc-company__stat">
                  <div class="mc-company__stat-number">5000+</div>
                  <div class="mc-company__stat-label">Happy Customers</div>
                </div>
                <div class="mc-company__stat">
                  <div class="mc-company__stat-number">100+</div>
                  <div class="mc-company__stat-label">Vehicles</div>
                </div>
                <div class="mc-company__stat">
                  <div class="mc-company__stat-number">10+</div>
                  <div class="mc-company__stat-label">Years of Service</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="mc-testimonials" id="testimonials">
      <div class="container">
        <div class="text-center mb-5">
          <h2 class="section-title" data-aos="fade-up">
            What Our Customers Say
          </h2>
        </div>
        <div class="row">
          <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
            <div class="mc-testimonial-card">
              <div class="mc-testimonial-card__header">
                <img
                  src="avatar1.jpg"
                  alt="Customer"
                  class="mc-testimonial-card__avatar"
                />
                <div>
                  <div class="mc-testimonial-card__name">Rajith Perera</div>
                  <div class="mc-testimonial-card__rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                  </div>
                </div>
              </div>
              <p class="mc-testimonial-card__quote">
                "Incredible service from Colombo to Kandy. Punctual and
                comfortable!"
              </p>
            </div>
          </div>
          <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
            <div class="mc-testimonial-card">
              <div class="mc-testimonial-card__header">
                <img
                  src="avatar2.jpg"
                  alt="Customer"
                  class="mc-testimonial-card__avatar"
                />
                <div>
                  <div class="mc-testimonial-card__name">Chamari Silva</div>
                  <div class="mc-testimonial-card__rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                  </div>
                </div>
              </div>
              <p class="mc-testimonial-card__quote">
                "Perfect airport transfer service. Very professional drivers!"
              </p>
            </div>
          </div>
          <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
            <div class="mc-testimonial-card">
              <div class="mc-testimonial-card__header">
                <img
                  src="avatar3.jpg"
                  alt="Customer"
                  class="mc-testimonial-card__avatar"
                />
                <div>
                  <div class="mc-testimonial-card__name">Sunil Fernando</div>
                  <div class="mc-testimonial-card__rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                  </div>
                </div>
              </div>
              <p class="mc-testimonial-card__quote">
                "Exceptional corporate transport service. Always reliable!"
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="mc-cta-banner" id="book">
      <div class="container">
        <div class="mc-cta-banner__content">
          <h2 class="mc-cta-banner__title" data-aos="fade-up">
            Ready to Ride in Comfort?
          </h2>
          <p
            class="mc-cta-banner__text"
            data-aos="fade-up"
            data-aos-delay="100"
          >
            Book your premium taxi service now
          </p>
          <a
            href="our-vehicles.jsp"
            class="mc-cta-banner__btn"
            data-aos="fade-up"
            data-aos-delay="200"
            >Book Now</a
          >
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="mc-footer">
      <div class="container">
        <div class="row">
          <div class="col-lg-4">
            <img
              src="src/img/Footer_logo.png"
              alt="Mega City Cab"
              class="mc-footer__logo"
            />
            <p class="mc-footer__about">
              Premium taxi service providing comfortable and reliable
              transportation solutions.
            </p>
            <div class="mc-footer__social">
              <a href="#" class="mc-footer__social-link"
                ><i class="fab fa-facebook-f"></i
              ></a>
              <a href="#" class="mc-footer__social-link"
                ><i class="fab fa-twitter"></i
              ></a>
              <a href="#" class="mc-footer__social-link"
                ><i class="fab fa-instagram"></i
              ></a>
              <a href="#" class="mc-footer__social-link"
                ><i class="fab fa-linkedin-in"></i
              ></a>
            </div>
          </div>
          <div class="col-lg-2">
            <h4 class="mc-footer__title">Quick Links</h4>
            <ul class="mc-footer__links">
              <li class="mc-footer__link">
                <a href="#home"><i class="fas fa-chevron-right"></i> Home</a>
              </li>
              <li class="mc-footer__link">
                <a href="#services"
                  ><i class="fas fa-chevron-right"></i> Services</a
                >
              </li>
              <li class="mc-footer__link">
                <a href="#about"
                  ><i class="fas fa-chevron-right"></i> About Us</a
                >
              </li>
              <li class="mc-footer__link">
                <a href="#testimonials"
                  ><i class="fas fa-chevron-right"></i> Testimonials</a
                >
              </li>
            </ul>
          </div>
          <div class="col-lg-3">
            <h4 class="mc-footer__title">Contact Info</h4>
            <ul class="mc-footer__links">
              <li class="mc-footer__link">
                <a href="tel:+1234567890"
                  ><i class="fas fa-phone"></i> +94 32 22 46 472</a
                >
              </li>
              <li class="mc-footer__link">
                <a href="mailto:info@megacitycab.com"
                  ><i class="fas fa-envelope"></i> info@megacitycab.lk</a
                >
              </li>
              <li class="mc-footer__link">
                <a href="#"><i class="fas fa-map-marker-alt"></i> Colombo</a>
              </li>
            </ul>
          </div>
          <div class="col-lg-3">
            <h4 class="mc-footer__title">Our Services</h4>
            <ul class="mc-footer__links">
              <li class="mc-footer__link">
                <a href="#"
                  ><i class="fas fa-chevron-right"></i> Luxury Rides</a
                >
              </li>
              <li class="mc-footer__link">
                <a href="#"
                  ><i class="fas fa-chevron-right"></i> Airport Transfers</a
                >
              </li>
              <li class="mc-footer__link">
                <a href="#"
                  ><i class="fas fa-chevron-right"></i> Corporate Services</a
                >
              </li>
              <li class="mc-footer__link">
                <a href="#"
                  ><i class="fas fa-chevron-right"></i> Event Transportation</a
                >
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div class="mc-footer__bottom">
        <div class="container">
          <p>&copy; 2025 Mega City Cab. All rights reserved.</p>
        </div>
      </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="src/js/main.js"></script>
  </body>
</html>
