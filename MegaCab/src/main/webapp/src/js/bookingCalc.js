document.addEventListener("DOMContentLoaded", function () {
    // Parse URL parameters for vehicle details
    const params = new URLSearchParams(window.location.search);
    const vehicleName = params.get("vehicle_name");
    const vehiclePrice = params.get("vehicle_price");

    // Update the read-only Car Details field
    const bookingCarDetailsInput = document.getElementById("bookingCarDetails");
    if (vehicleName && vehiclePrice) {
        bookingCarDetailsInput.value = `${vehicleName}`;
    }

    // Update the Car Price (per day) in the Price Breakdown
    const priceItems = document.querySelectorAll(".booking-price-group .booking-price-item");
    if (vehiclePrice) {
        priceItems[0].children[1].textContent = `Rs.${vehiclePrice}`;
    }

    // Grab necessary elements for calculation
    const rentalDaysInput = document.getElementById("bookingRentalDays");
    const rentalDaysDisplay = document.getElementById("bookingRentalDaysDisplay");
    const subtotalDisplay = priceItems[2].children[1]; // Subtotal
    const taxDisplay = priceItems[3].children[1]; // Tax (10%)
    const discountDisplay = priceItems[4].children[1]; // Discount
    const totalDisplay = document.querySelector(".booking-total span:last-child");
    const discountInput = document.getElementById("discountPercentage"); // Hidden field for discount %
    const discountCodeInput = document.getElementById("bookingDiscountCode"); // User-entered discount %
    const applyDiscountBtn = document.querySelector(".btn.booking-btn-secondary"); // Apply button

    // Store discount percentage only when Apply button is clicked
    if (applyDiscountBtn) {
        applyDiscountBtn.addEventListener("click", function () {
            let enteredDiscount = parseFloat(discountCodeInput.value.trim());

            // If the entered value is NaN or negative, set discount to 0
            if (isNaN(enteredDiscount) || enteredDiscount < 0) {
                enteredDiscount = 0;
            }

            // Store the applied discount in the hidden field
            discountInput.value = enteredDiscount;

            // Update the price breakdown after applying the discount
            updateCalculations();
        });
    }

    // Function to update the price breakdown based on the number of rental days
    function updateCalculations() {
        let days = parseInt(rentalDaysInput.value);
        if (isNaN(days) || days < 1) {
            days = 1;
            rentalDaysInput.value = 1;
        }
        rentalDaysDisplay.textContent = days;

        // Parse the per-day price and calculate subtotal
        let perDayPrice = parseFloat(vehiclePrice);
        if (isNaN(perDayPrice)) {
            perDayPrice = 0;
        }
        const subtotal = perDayPrice * days;

        // Get applied discount percentage from the hidden field
        let discountPercentage = parseFloat(discountInput.value);
        if (isNaN(discountPercentage)) {
            discountPercentage = 0;
        }

        // Calculate discount amount
        const discountAmount = (subtotal * discountPercentage) / 100;

        // Calculate tax and total after applying the discount
        const tax = (subtotal - discountAmount) * 0.10; // 10% tax
        const total = subtotal - discountAmount + tax;

        // Update UI
        subtotalDisplay.textContent = `Rs.${subtotal.toFixed(2)}`;
        discountDisplay.textContent = `Rs.${discountAmount.toFixed(2)}`;
        taxDisplay.textContent = `Rs.${tax.toFixed(2)}`;
        totalDisplay.textContent = `Rs.${total.toFixed(2)}`;
    }

    // Prevent entering negative values and invalid characters (like "e")
    rentalDaysInput.addEventListener("keydown", function (e) {
        if (e.key === "-" || e.key === "e") {
            e.preventDefault();
        }
    });

    // Recalculate price when the number of days changes
    rentalDaysInput.addEventListener("input", updateCalculations);

    // Run calculation on page load to initialize the values
    updateCalculations();
});