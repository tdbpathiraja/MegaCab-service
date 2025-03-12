$(document).ready(function() {

    // Function to load vehicles via AJAX with optional search
    function loadVehicles(page = 1, search = "") {
        $.ajax({
            url: 'VehicleController',
            type: 'GET',
            data: { action: 'list', search: search, page: page },
            dataType: 'json',
            success: function(response) {
                var container = $("#vehiclesContainer");
                container.empty();
                $.each(response.vehicles, function(index, vehicle) {
                    var statusBadge = vehicle.bookingStatus.toLowerCase() === "available" ?
                        '<span class="badge bg-success">Available</span>' :
                        '<span class="badge bg-danger">Booked</span>';
                    var deleteButton = "";
                    if (vehicle.bookingStatus.toLowerCase() === "booked") {
                        deleteButton = '<button class="btn btn-outline-danger flex-grow-1 deleteVehicleBtn" data-id="' + vehicle.id + '" disabled title="Vehicle is booked"><i class="bi bi-trash"></i> Delete</button>';
                    } else {
                        deleteButton = '<button class="btn btn-outline-danger flex-grow-1 deleteVehicleBtn" data-id="' + vehicle.id + '"><i class="bi bi-trash"></i> Delete</button>';
                    }
                    var card = `<div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                            <div class="card vehicle-card glass-effect">
                                <img src="src/img/Vehicles/${vehicle.vehicleImg}" alt="${vehicle.vehicleName}" class="vehicle-img">
                                <div class="vehicle-details">
                                    <h5 class="vehicle-title">${vehicle.vehicleName}</h5>
                                    <div class="vehicle-info">
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-fuel-pump"></i>
                                            <span>${vehicle.fuelType}</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-car-front"></i>
                                            <span>${vehicle.vehicleType}</span>
                                        </div>
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-gear"></i>
                                            <span>${vehicle.transmission}</span>
                                        </div>
                                    </div>
                                    <div class="vehicle-info mt-2">
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-cash"></i>
                                            <span>Rs.${vehicle.pricePerDay}/day</span>
                                        </div>
                                    </div>
                                    <div class="vehicle-info mt-2">
                                        <div class="vehicle-info-item">
                                            <i class="bi bi-person"></i>
                                            <span>Driver: ${vehicle.driverName} (${vehicle.driverId})</span>
                                        </div>
                                    </div>
                                    <div class="mt-2">
                                        ${statusBadge}
                                    </div>
                                    <div class="d-flex mt-3 gap-2">
                                        <button class="btn btn-outline-primary flex-grow-1 editVehicleBtn" data-id="${vehicle.id}">
                                            <i class="bi bi-pencil"></i> Edit
                                        </button>
                                        ${deleteButton}
                                    </div>
                                </div>
                            </div>
                        </div>`;
                    container.append(card);
                });
                $("#vehiclePagination").html(''); // Update pagination if needed
            },
            error: function(err) {
                console.error("Error loading vehicles", err);
            }
        });
    }

    // Load vehicles on page load
    loadVehicles();

    // Search functionality: filter vehicles by name (partial matching)
    $("#vehicleSearchButton").click(function() {
        var search = $("#vehicleSearchInput").val();
        loadVehicles(1, search);
    });

    // Open modal for adding new vehicle
    $("#addVehicleBtn").click(function() {
        $("#vehicleForm")[0].reset();
        $("#vehicleId").val(0);
        $("#oldVehicleImg").val("");
        $("#currentImgInfo").text("");
        $("#vehicleModalLabel").text("Add Vehicle");
        // Auto-generate driver ID for new vehicle (prefix mcc- with 6-digit random number)
        $("#driverId").val("mcc-" + Math.floor(100000 + Math.random() * 900000));
        $("#driverId").prop("readonly", false);
        $("#vehicleModal").modal("show");
    });

    // Open modal for editing vehicle
    $(document).on("click", ".editVehicleBtn", function() {
        var vehicleId = $(this).data("id");
        $.ajax({
            url: 'VehicleController',
            type: 'GET',
            data: { action: 'list' },
            dataType: 'json',
            success: function(response) {
                var vehicles = response.vehicles;
                var vehicle = vehicles.find(v => v.id == vehicleId);
                if (vehicle) {
                    $("#vehicleId").val(vehicle.id);
                    $("#vehicleName").val(vehicle.vehicleName);
                    $("#vehicleType").val(vehicle.vehicleType);
                    $("#fuelType").val(vehicle.fuelType);
                    $("#transmission").val(vehicle.transmission);
                    $("#pricePerDay").val(vehicle.pricePerDay);
                    $("#driverId").val(vehicle.driverId);
                    $("#driverName").val(vehicle.driverName);
                    $("#oldVehicleImg").val(vehicle.vehicleImg);
                    $("#currentImgInfo").text("Current Image: " + vehicle.vehicleImg);
                    $("#vehicleModalLabel").text("Edit Vehicle");
                    // In edit mode, driverId is read-only
                    $("#driverId").prop("readonly", true);
                    $("#vehicleModal").modal("show");
                }
            },
            error: function(err) {
                console.error("Error fetching vehicle data", err);
            }
        });
    });

    // Handler for delete buttons that are disabled (booked vehicles)
    $(document).on("click", ".deleteVehicleBtn[disabled]", function(e) {
        e.preventDefault();
        alert("This vehicle is booked and cannot be deleted.");
    });

    // Handler for delete buttons that are enabled (non-booked vehicles)
    $(document).on("click", ".deleteVehicleBtn:not([disabled])", function(e) {
        var vehicleId = $(this).data("id");
        if (confirm("Are you sure you want to delete this vehicle?")) {
            $.ajax({
                url: 'VehicleController',
                type: 'POST',
                data: { action: 'delete', vehicleId: vehicleId },
                success: function(response) {
                    loadVehicles();
                },
                error: function(err) {
                    console.error("Error deleting vehicle", err);
                }
            });
        }
    });

    // Handle form submission for add/update (using FormData for file upload)
    $("#vehicleForm").submit(function(e) {
        e.preventDefault();
        var formData = new FormData(this);
        var actionType = ($("#vehicleId").val() == 0) ? "add" : "update";
        formData.append("action", actionType);
        $.ajax({
            url: 'VehicleController',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                $("#vehicleModal").modal("hide");
                loadVehicles();
            },
            error: function(err) {
                console.error("Error saving vehicle", err);
            }
        });
    });
});