$(document).ready(function() {
    // Function to load users via AJAX
    function loadUsers(page = 1, search = "") {
        $.ajax({
            url: 'UserController',  // Servlet mapping to fetch users
            type: 'GET',
            data: { action: 'list', page: page, search: search },
            dataType: 'json',
            success: function(response) {
                var tbody = $("#usersTable tbody");
                tbody.empty();
                // Loop through the user objects returned from the database
                $.each(response.users, function(index, user) {
                    var row = `<tr>
                                <td>${user.regNumber}</td>
                                <td>${user.username}</td>
                                <td>${user.fullName}</td>
                                <td>${user.email}</td>
                                <td>${user.telephone}</td>
                     
                                <td>
                                    <button class="btn btn-sm btn-outline-primary editBtn" data-id="${user.id}"><i class="bi bi-pencil"></i></button>
                                    <button class="btn btn-sm btn-outline-danger deleteBtn" data-id="${user.id}"><i class="bi bi-trash"></i></button>
                                </td>
                            </tr>`;
                    tbody.append(row);
                });
                $("#usersCount").text(`Showing ${response.users.length} of ${response.totalUsers} users`);
                // TODO: update pagination if necessary
            },
            error: function(err) {
                console.error("Error loading users", err);
            }
        });
    }

    // Load users on page load
    loadUsers();

    // Search functionality
    $("#searchButton").click(function() {
        var search = $("#searchInput").val();
        loadUsers(1, search);
    });

    // Delete user functionality
    $(document).on("click", ".deleteBtn", function() {
        var userId = $(this).data("id");
        if (confirm("Are you sure you want to delete this user?")) {
            $.ajax({
                url: 'UserController',
                type: 'POST',
                data: { action: 'delete', userId: userId },
                success: function(response) {
                    loadUsers();
                },
                error: function(err) {
                    console.error("Error deleting user", err);
                }
            });
        }
    });

    // Edit user functionality - open modal with user details
    $(document).on("click", ".editBtn", function() {
        var userId = $(this).data("id");
        $.ajax({
            url: 'UserController',
            type: 'GET',
            data: { action: 'getUser', userId: userId },
            dataType: 'json',
            success: function(user) {
                $("#editUserId").val(user.id);
                $("#editRegNumber").val(user.regNumber);
                $("#editEmail").val(user.email);
                $("#editName").val(user.fullName);
                $("#editPhone").val(user.telephone);
                $("#editUserModal").modal("show");
            },
            error: function(err) {
                console.error("Error fetching user data", err);
            }
        });
    });

    // Submit the edit form to update user details
    $("#editUserForm").submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: 'UserController',
            type: 'POST',
            data: $(this).serialize() + "&action=update",
            success: function(response) {
                $("#editUserModal").modal("hide");
                loadUsers();
            },
            error: function(err) {
                console.error("Error updating user", err);
            }
        });
    });
});