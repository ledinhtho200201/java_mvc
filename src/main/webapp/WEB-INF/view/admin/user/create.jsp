<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Create User</title>
    <!-- Bootstrap CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link href="/resources/css/demo.css" rel="stylesheet" />
  </head>
  <body>
    <div class="container py-5">
      <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
          <div class="card shadow-sm">
            <div class="card-body">
              <h3 class="card-title mb-4">Create New User</h3>

              <form:form
                method="post"
                action="/admin/user/create"
                modelAttribute="newUser"
              >
                <div class="mb-3">
                  <label for="email" class="form-label">Email</label>
                  <form:input
                    type="email"
                    class="form-control"
                    id="email"
                    path="email"
                    required="required"
                    placeholder="name@example.com"
                  />
                </div>

                <div class="mb-3">
                  <label for="password" class="form-label">Password</label>
                  <form:input
                    type="password"
                    class="form-control"
                    id="password"
                    path="password"
                    required="required"
                    placeholder="Enter a strong password"
                  />
                </div>

                <div class="mb-3">
                  <label for="fullName" class="form-label">Full name</label>
                  <form:input
                    type="text"
                    class="form-control"
                    id="fullName"
                    path="fullName"
                    required="required"
                    placeholder="Nguyen Van A"
                  />
                </div>

                <div class="mb-3">
                  <label for="address" class="form-label">Address</label>
                  <form:textarea
                    class="form-control"
                    id="address"
                    path="address"
                    rows="2"
                    placeholder="Street, City, Country"
                  ></form:textarea>
                </div>

                <div class="mb-3">
                  <label for="phone" class="form-label">Phone</label>
                  <form:input
                    type="tel"
                    class="form-control"
                    id="phone"
                    path="phone"
                    placeholder="0123456789"
                  />
                </div>

                <div class="d-flex justify-content-between">
                  <div>
                    <button type="submit" class="btn btn-primary">
                      Create
                    </button>
                    <a
                      href="${pageContext.request.contextPath}/admin/users"
                      class="btn btn-secondary ms-2"
                      >Cancel</a
                    >
                  </div>
                </div>
              </form:form>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap JS bundle (includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
