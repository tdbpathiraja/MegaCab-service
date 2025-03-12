$(document).ready(function() {
    // Function to load bookings via AJAX
    function loadBookings(page = 1, search = "") {
        $.ajax({
            url: 'BookingController',  // Servlet mapping to fetch bookings
            type: 'GET',
            data: { action: 'list', page: page, search: search },
            dataType: 'json',
            success: function(response) {
                var tbody = $("#bookingsTable tbody");
                tbody.empty();
                $.each(response.bookings, function(index, booking) {
                    var row = `<tr>
                            <td>${booking.bookingId}</td>
                            <td>${booking.customerName}</td>
                            <td>${booking.telephoneNumber}</td>
                            <td>${booking.bookedVehicle}</td>
                            <td>${booking.rentalDays}</td>
                            <td>${booking.totalValue}</td>
                            <td>${booking.startDestination}</td>
                            <td>${booking.endDestination}</td>
                            <td>
                                <button class="btn btn-sm btn-outline-danger deleteBookingBtn" data-booking-id="${booking.bookingId}">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                        </tr>`;
                    tbody.append(row);
                });
                $("#bookingsCount").text(`Showing ${response.bookings.length} of ${response.totalBookings} bookings`);
                // TODO: Update pagination if needed
            },
            error: function(err) {
                console.error("Error loading bookings", err);
            }
        });
    }

    // Load bookings on page load
    loadBookings();

    // Search functionality
    $("#bookingSearchButton").click(function() {
        var search = $("#bookingSearchInput").val();
        loadBookings(1, search);
    });

    // Delete booking functionality
    $(document).on("click", ".deleteBookingBtn", function() {
        var bookingId = $(this).data("booking-id");
        if (confirm("Are you sure you want to delete this booking?")) {
            $.ajax({
                url: 'BookingController',
                type: 'POST',
                data: { action: 'delete', bookingId: bookingId },
                success: function(response) {
                    loadBookings();
                },
                error: function(err) {
                    console.error("Error deleting booking", err);
                }
            });
        }
    });
});