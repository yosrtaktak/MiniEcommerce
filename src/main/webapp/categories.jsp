<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="fr">

    <head>
      <meta charset="UTF-8">
      <title>Gestion des Catégories</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
      <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>

    <body class="bg-light">

      <%@include file="shared/navbar/navbar.jsp" %>

        <div class="container py-5">
          <h1 class="mb-4">Gestion des Catégories</h1>

          <!-- Display Messages -->
          <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
          </c:if>

          <div class="row">
            <!-- Form Section -->
            <div class="col-md-4">
              <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                  <h5 class="mb-0">
                    <c:choose>
                      <c:when test="${not empty category}">Modifier</c:when>
                      <c:otherwise>Nouvelle Catégorie</c:otherwise>
                    </c:choose>
                  </h5>
                </div>
                <div class="card-body">
                  <form action="categories" method="post">
                    <!-- ID Field for Update -->
                    <c:if test="${not empty category}">
                      <input type="hidden" name="id" value="${category.id}">
                    </c:if>

                    <div class="mb-3">
                      <label for="name" class="form-label">Nom</label>
                      <input type="text" class="form-control" id="name" name="name" value="${category.name}" required>
                    </div>
                    <div class="mb-3">
                      <label for="description" class="form-label">Description</label>
                      <textarea class="form-control" id="description" name="description"
                        rows="3">${category.description}</textarea>
                    </div>
                    <button type="submit" class="btn btn-success w-100">
                      <i class="fas fa-save me-2"></i>Enregistrer
                    </button>
                    <c:if test="${not empty category}">
                      <a href="categories" class="btn btn-secondary w-100 mt-2">Annuler</a>
                    </c:if>
                  </form>
                </div>
              </div>
            </div>

            <!-- List Section -->
            <div class="col-md-8">
              <div class="card shadow-sm">
                <div class="card-header bg-white">
                  <h5 class="mb-0">Liste des Catégories</h5>
                </div>
                <div class="card-body p-0">
                  <table class="table table-hover mb-0">
                    <thead class="table-light">
                      <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Description</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="cat" items="${categories}">
                        <tr>
                          <td>${cat.id}</td>
                          <td><strong>
                              <c:out value="${cat.name}" />
                            </strong></td>
                          <td>
                            <c:out value="${cat.description}" />
                          </td>
                          <td>
                            <a href="categories?action=edit&id=${cat.id}" class="btn btn-sm btn-primary">
                              <i class="fas fa-edit"></i>
                            </a>
                            <a href="categories?action=delete&id=${cat.id}" class="btn btn-sm btn-danger"
                              onclick="return confirm('Êtes-vous sûr ?');">
                              <i class="fas fa-trash"></i>
                            </a>
                          </td>
                        </tr>
                      </c:forEach>
                      <c:if test="${empty categories}">
                        <tr>
                          <td colspan="4" class="text-center text-muted py-4">
                            Aucune catégorie trouvée.
                          </td>
                        </tr>
                      </c:if>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>