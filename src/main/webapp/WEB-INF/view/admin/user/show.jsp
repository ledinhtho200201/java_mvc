<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <html>

            <head>
                <title>User Detail</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

                <style>
                    /* Thêm vào file CSS hoặc <style> */
                    .card {
                        border-radius: 10px;
                        overflow: hidden;
                    }

                    .card-header {
                        font-weight: 600;
                    }

                    .info-item {
                        border-left: 3px solid #0d6efd;
                        padding-left: 15px;
                    }

                    .img-thumbnail {
                        border-width: 3px;
                    }

                    .badge {
                        font-size: 0.85em;
                        padding: 5px 10px;
                    }

                    /* Hiệu ứng hover cho card */
                    .card:hover {
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                        transition: box-shadow 0.3s ease;
                    }

                    /* Gradient background */
                    .bg-gradient-primary {
                        background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
                    }
                </style>
            </head>

            <body>
                <div class="container mt-4">
                    <div class="d-flex justify-content-between">
                        <h2>User Detail with ID: ${id}</h2>
                    </div>
                    <div class="card mb-3 shadow-sm">
                        <div class="row g-0">
                            <div class="col-md-4 bg-light d-flex align-items-center justify-content-center">
                                <div class="p-4 text-center">
                                    <img src="https://ui-avatars.com/api/?name=${user.fullName}&size=120"
                                        class="rounded-circle" alt="Avatar">
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="card-body">
                                    <h5 class="card-title">User Information</h5>
                                    <div class="row">
                                        <div class="col-6">
                                            <p class="card-text">
                                                <small class="text-muted">Email:</small><br>
                                                <strong>${user.email}</strong>
                                            </p>
                                            <p class="card-text">
                                                <small class="text-muted">Full Name:</small><br>
                                                <strong>${user.fullName}</strong>
                                            </p>
                                            <p class="card-text">
                                                <small class="text-muted">Phone:</small><br>
                                                <strong>${user.phone}</strong>
                                            </p>
                                        </div>
                                        <div class="col-6">
                                            <p class="card-text">
                                                <small class="text-muted">Status:</small><br>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="mt-3">
                                        <a href="/admin/user/edit/${user.id}" class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <a href="/admin/user" class="btn btn-sm btn-outline-secondary">
                                            <i class="fas fa-list"></i> View All
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

            </body>

            </html>