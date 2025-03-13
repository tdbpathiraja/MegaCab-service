document.addEventListener("DOMContentLoaded", function () {
    const startDestination = document.getElementById("bookingStartDestination");
    const endDestination = document.getElementById("bookingEndDestination");

    // List of 30+ Sri Lankan Cities
    const cities = [
        "Colombo", "Kandy", "Galle", "Jaffna", "Anuradhapura", "Polonnaruwa", "Negombo", "Ratnapura", "Batticaloa", "Trincomalee",
        "Matara", "Kurunegala", "Badulla", "Nuwara Eliya", "Kilinochchi", "Mannar", "Vavuniya", "Puttalam", "Hambantota", "Monaragala",
        "Matale", "Kalutara", "Ampara", "Gampaha", "Mullaitivu", "Kegalle", "Hatton", "Weligama", "Panadura", "Chilaw"
    ];

    // Function to populate dropdowns
    function populateDropdown(selectElement, citiesList) {
        selectElement.innerHTML = '<option value="">Select City</option>'; // Default option
        citiesList.forEach(city => {
            const option = document.createElement("option");
            option.value = city;
            option.textContent = city;
            selectElement.appendChild(option);
        });
    }

    // Initialize Start Destination dropdown
    populateDropdown(startDestination, cities);

    // Disable End Destination dropdown initially
    endDestination.disabled = true;

    // Event Listener for Start Destination selection
    startDestination.addEventListener("change", function () {
        const selectedCity = startDestination.value;

        // Enable End Destination dropdown only if a Start Destination is selected
        endDestination.disabled = !selectedCity;

        // Repopulate End Destination dropdown, excluding the selected Start Destination
        const filteredCities = cities.filter(city => city !== selectedCity);
        populateDropdown(endDestination, filteredCities);
    });

    // Form Validation before submission
    document.getElementById("bookingForm").addEventListener("submit", function (event) {
        if (!startDestination.value || !endDestination.value) {
            alert("Please select both Start and End Destinations.");
            event.preventDefault(); // Prevent form submission
        }
    });
});