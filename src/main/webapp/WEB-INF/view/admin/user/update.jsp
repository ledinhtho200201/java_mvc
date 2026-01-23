<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
    <title>Update User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 20px;
        }
        .container {
            max-width: 600px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #0d6efd;
            margin-bottom: 20px;
        }
        .form-label {
            font-weight: 500;
        }
        .btn-back {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><i class="fas fa-edit"></i> Update User</h2>
        
        <form:form method="POST" action="/admin/user/update" modelAttribute="user">
            <!-- Hidden field for ID -->
            <form:hidden path="id"/>
            
            <div class="mb-3">
                <label for="fullName" class="form-label">Full Name</label>
                <form:input type="text" class="form-control" id="fullName" 
                           path="fullName" required="true" />
            </div>
            
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <form:input type="email" class="form-control" id="email"  disabled="true"
                           path="email" required="true" />
            </div>
            
            <div class="mb-3">
                <label for="phone" class="form-label">Phone Number</label>
                <form:input type="text" class="form-control" id="phone" 
                           path="phone" />
            </div>
            
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <form:textarea class="form-control" id="address" 
                              path="address" rows="3" />
            </div>
            
            <div class="d-flex justify-content-between mt-4">
                <a href="/admin/user" class="btn btn-secondary btn-back">
                    <i class="fas fa-arrow-left"></i> Cancel
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Update User
                </button>
            </div>
        </form:form>
    </div>

    <!-- Font Awesome for icons -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>