document.addEventListener("DOMContentLoaded", function () {
    // Listen for discount code "Apply" button click
    document.querySelector(".booking-btn-secondary").addEventListener("click", function () {
        var discountCode = document.getElementById("bookingDiscountCode").value.trim();
        if (discountCode === "") {
            alert("Please enter a discount code.");
            return;
        }
        fetch("DiscountCodeServlet?discountCode=" + encodeURIComponent(discountCode))
            .then(response => response.json())
            .then(data => {
                if (data.valid) {
                    // Show discount percentage in an input or display element
                    alert("Discount Code is valid! Discount Percentage: " + data.percentage + "%");
                    // set the discount percentage into a hidden input for later use:
                    document.getElementById("discountPercentage").value = data.percentage;
                } else {
                    alert("Discount Code Invalid: " + data.error);
                }
            })
            .catch(error => {
                console.error("❌ Error validating discount code:", error);
                alert("Error validating discount code.");
            });
    });
});