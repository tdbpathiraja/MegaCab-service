<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="src/css/styles.css">
</head>
<body>

<%--Navigation Bar--%>
<jsp:include page="navbar.jsp" />

<!-- Filter Dropdown -->
<div class="container my-5">
    <div class="d-flex justify-content-end mb-4">
        <div class="dropdown">
            <button class="btn btn-filter dropdown-toggle" type="button" id="filterDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                Filter by Category
            </button>
            <ul class="dropdown-menu" id="categoryDropdown" aria-labelledby="filterDropdown">
                <li><a class="dropdown-item" href="#" data-category="all">All</a></li>
            </ul>
        </div>
    </div>

    <!-- Vehicle Grid -->
    <div class="row" id="vehicle-grid">

    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        fetch("VehicleServlet")
            .then(response => response.json())
            .then(data => {
                let vehicleGrid = document.getElementById("vehicle-grid");
                vehicleGrid.innerHTML = ""; // Clear existing elements

                data.forEach(vehicle => {
                    let vehicleCard = '<div class="col-md-3 vehicle-card" data-category="' + vehicle.vehicleType + '">'
                        + '<div class="card">'
                        + '<div class="card-img">'
                        + '<img src="src/img/Vehicles/' + vehicle.vehicleImg + '" alt="' + vehicle.vehicleName + '">'
                        + (vehicle.bookingStatus === "booked" ? '<div class="not-available">Not Available</div>' : '')
                        + '</div>'
                        + '<div class="card-body">'
                        + '<h5 class="card-title">' + vehicle.vehicleName + '</h5>'
                        + '<p><i class="fas fa-gas-pump"></i> ' + vehicle.fuelType + '</p>'
                        + '<p><i class="fas fa-cog"></i> ' + vehicle.transmission + '</p>'
                        + '<p><i class="fas fa-tag"></i> Rs.' + vehicle.pricePerDay + '/day</p>'
                        + (vehicle.bookingStatus === "available"
                            ? '<a href="booking-cab.jsp?vehicle_id=' + vehicle.id
                            + '&vehicle_name=' + encodeURIComponent(vehicle.vehicleName)
                            + '&vehicle_price=' + vehicle.pricePerDay
                            + '" class="book-now-btn">Book Now</a>'
                            : '')
                        + '</div>'
                        + '</div>'
                        + '</div>';

                    vehicleGrid.innerHTML += vehicleCard;
                });

            })
            .catch(error => console.error("❌ Error fetching vehicles:", error));

        // Fetch Vehicle Categories
        fetch("VehicleServlet?categories=true")
            .then(response => response.json())
            .then(categories => {
                let categoryDropdown = document.getElementById("categoryDropdown");
                categories.forEach(category => {
                    let categoryItem = '<li><a class="dropdown-item" href="#" data-category="' + category + '">' + category + '</a></li>';
                    categoryDropdown.innerHTML += categoryItem;
                });
            })
            .catch(error => console.error("Error fetching categories:", error));

        // Filter Vehicles by Category
        document.getElementById("categoryDropdown").addEventListener("click", function (event) {
            let selectedCategory = event.target.getAttribute("data-category");
            document.querySelectorAll(".vehicle-card").forEach(card => {
                card.style.display = (selectedCategory === "all" || card.getAttribute("data-category") === selectedCategory) ? "block" : "none";
            });
        });
    });
</script>



<!-- JavaScript Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

</body>
</html>