document.addEventListener("DOMContentLoaded", function () {
    const phoneInput = document.getElementById("bookingTelephone");

    phoneInput.addEventListener("input", function () {
        let inputValue = phoneInput.value.replace(/\s+/g, ""); // Remove spaces

        // Ensure "+94 " is only added once at the beginning
        if (!inputValue.startsWith("+94 ")) {
            inputValue = "+94 " + inputValue.replace("+94", "").trim(); // Remove duplicate "+94" if present
        }

        // Extract numbers after "+94 "
        let numberPart = inputValue.replace("+94 ", "");

        // Block "0" at the beginning of the number (after "+94")
        if (numberPart.startsWith("0")) {
            numberPart = numberPart.substring(1); // Remove leading zero
        }

        // Set formatted value back to input field
        phoneInput.value = "+94 " + numberPart;
    });

    // Prevent typing "0" at the start
    phoneInput.addEventListener("keydown", function (event) {
        if (phoneInput.value === "+94 " && event.key === "0") {
            event.preventDefault(); // Block typing "0" at the start
        }
    });
});