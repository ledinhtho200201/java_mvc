<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .delete-btn {
            cursor: pointer;
        }


        .btn-group>.btn-group:not(:last-child)>.btn, .btn-group>.btn.dropdown-toggle-split:first-child, .btn-group>.btn:not(:last-child):not(.dropdown-toggle) {
            border-radius: inherit;
        }

        .btn-group>.btn-group:not(:first-child)>.btn, .btn-group>.btn:nth-child(n+3), .btn-group>:not(.btn-check)+.btn {
            border-top-left-radius: inherit; 
            border-bottom-left-radius: inherit;
        }
    </style>
</head>

<body>
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-users"></i> User List</h2>
            <a class="btn btn-primary" href="/admin/user/create">
                <i class="fas fa-plus"></i> Add User
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${listUser}">
                        <tr id="user-row-${user.id}">
                            <td>${user.id}</td>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>${user.phone}</td>
                            <td>${user.address}</td>
                            <td>
                                <div class="btn-group d-flex gap-2" role="group">
                                    <a href="/admin/user/${user.id}" class="btn btn-sm btn-success rounded-[20%]">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                    <a href="/admin/user/update/${user.id}" class="btn btn-sm btn-warning rounded-[20%]">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <button type="button" class="btn btn-sm btn-danger delete-btn rounded-[20%]" 
                                            data-user-id="${user.id}" 
                                            data-user-name="${user.fullName}">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle me-2"></i>Confirm Delete
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete user <strong id="deleteUserName"></strong>?</p>
                    <p class="text-danger"><small>This action cannot be undone!</small></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Font Awesome for icons -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <!-- jQuery (optional, for easier DOM manipulation) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        $(document).ready(function() {
            let userIdToDelete = null;
            let userNameToDelete = null;
            
            // When delete button is clicked
            $('.delete-btn').click(function() {
                userIdToDelete = $(this).data('user-id');
                userNameToDelete = $(this).data('user-name');
                
                // Show user name in modal
                $('#deleteUserName').text(userNameToDelete);
                
                // Show the modal
                const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
                deleteModal.show();
            });
            
            // When confirm delete button is clicked
            $('#confirmDeleteBtn').click(function() {
                if (userIdToDelete) {
                    // Send delete request
                    deleteUser(userIdToDelete);
                }
            });
            
            function deleteUser(userId) {
                // Send AJAX request to delete
                $.ajax({
                    url: '/admin/user/delete/' + userId,
                    type: 'DELETE',
                    success: function(response) {
                        // Remove the row from table
                        $('#user-row-' + userId).fadeOut(300, function() {
                            $(this).remove();
                        });
                        
                        // Show success message (optional)
                        showToast('User deleted successfully!');
                        
                        // Hide modal
                        $('#deleteModal').modal('hide');
                    },
                    error: function(xhr, status, error) {
                        console.error('Delete error:', error);
                        alert('Error deleting user: ' + error);
                    }
                });
            }
            
            // Function to show toast notification (optional)
            function showToast(message) {
                // Create toast element
                const toast = document.createElement('div');
                toast.className = 'toast align-items-center text-bg-success border-0 position-fixed bottom-0 end-0 m-3';
                toast.setAttribute('role', 'alert');
                toast.setAttribute('aria-live', 'assertive');
                toast.setAttribute('aria-atomic', 'true');
                console.log(message);
                toast.innerHTML = `
                    <div class="d-flex">
                        <div class="toast-body">
                            <i class="fas fa-check-circle me-2"></i>Delete successful: ${message}
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                    </div>
                `;
                
                document.body.appendChild(toast);
                
                // Show toast
                const bsToast = new bootstrap.Toast(toast);
                bsToast.show();
                
                // Remove toast after it's hidden
                toast.addEventListener('hidden.bs.toast', function() {
                    toast.remove();
                });
            }
        });
    </script>
</body>
</html>