<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ page import="com.example.model.Category" %>
    <%@ page import="java.util.List" %>

      <% String role=(String) session.getAttribute("role"); if (role==null || !role.equalsIgnoreCase("admin")) {
        response.sendRedirect("/error.jsp"); return; } List<Category> categories = (List<Category>)
          request.getAttribute("categories");
          String message = (String) request.getAttribute("message");
          String error = (String) request.getAttribute("error");
          %>

          <!DOCTYPE html>
          <html lang="fr">

          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Administration - Catégories</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <link rel="stylesheet" href="../css/style.css">
          </head>

          <body class="bg-light">

            <jsp:include page="/shared/navbar/adminNavbar.jsp" />

            <div class="container py-5 animate-fade-in">
              <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="fw-bold text-primary"><i class="fas fa-tags me-2"></i>Gestion des Catégories</h1>
              </div>

              <!-- Messages -->
              <% if (message !=null) { %>
                <div class="alert alert-success alert-dismissible fade show shadow-sm border-0" role="alert">
                  <i class="fas fa-check-circle me-2"></i>
                  <%= message %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% } %>

                  <% if (error !=null) { %>
                    <div class="alert alert-danger alert-dismissible fade show shadow-sm border-0" role="alert">
                      <i class="fas fa-exclamation-triangle me-2"></i>
                      <%= error %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>

                      <div class="row g-4">

                        <!-- FORMULAIRE AJOUT -->
                        <div class="col-lg-4">
                          <div class="card border-0 shadow-sm rounded-4 h-100">
                            <div class="card-header bg-white border-0 pt-4 px-4 pb-0">
                              <h5 class="fw-bold mb-0 text-primary">Ajouter une catégorie</h5>
                            </div>
                            <div class="card-body p-4">
                              <form action="/admin/categories" method="post">
                                <input type="hidden" name="action" value="add">
                                <div class="mb-3">
                                  <label class="form-label fw-semibold">Nom</label>
                                  <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i
                                        class="fas fa-tag text-muted"></i></span>
                                    <input type="text" class="form-control border-start-0 ps-0 bg-light" name="name"
                                      placeholder="Ex: Informatique" required>
                                  </div>
                                </div>
                                <div class="mb-4">
                                  <label class="form-label fw-semibold">Description</label>
                                  <textarea class="form-control bg-light" name="description" rows="3"
                                    placeholder="Brève description..." required></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary-custom w-100 text-white py-2 shadow-sm">
                                  <i class="fas fa-plus-circle me-2"></i>Créer la catégorie
                                </button>
                              </form>
                            </div>
                          </div>
                        </div>

                        <!-- LISTE DES CATEGORIES -->
                        <div class="col-lg-8">
                          <div class="card border-0 shadow-sm rounded-4 h-100">
                            <div
                              class="card-header bg-white border-0 pt-4 px-4 pb-0 d-flex justify-content-between align-items-center">
                              <h5 class="fw-bold mb-0">Liste des catégories existantes</h5>
                              <span class="badge bg-light text-primary border rounded-pill px-3">
                                <%= (categories !=null) ? categories.size() : 0 %> total
                              </span>
                            </div>
                            <div class="card-body p-4">
                              <% if (categories !=null && !categories.isEmpty()) { %>
                                <div class="table-responsive">
                                  <table class="table table-hover align-middle">
                                    <thead class="bg-light text-muted small text-uppercase">
                                      <tr>
                                        <th class="ps-3 border-0 rounded-start">Nom</th>
                                        <th class="border-0">Description</th>
                                        <th class="border-0 text-end rounded-end pe-3">Actions</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <% for (Category cat : categories) { %>
                                        <tr>
                                          <td class="ps-3 fw-bold text-primary">
                                            <%= cat.getName() %>
                                          </td>
                                          <td class="text-muted text-truncate" style="max-width: 250px;">
                                            <%= cat.getDescription() %>
                                          </td>
                                          <td class="text-end pe-3">
                                            <div class="d-flex justify-content-end gap-2">
                                              <button class="btn btn-sm btn-outline-warning rounded-pill px-3"
                                                onclick="openEditModal('<%= cat.getId() %>', '<%= cat.getName() != null ? cat.getName().replace("'", "\\'").replace("\n", " " ).replace("\r", "" ) : "" %>', '<%= cat.getDescription() !=null
                                                  ? cat.getDescription().replace("'", "\\'" ).replace("\n", "\\n"
                                                  ).replace("\r", "" ) : "" %>')">
                                                  <i class="fas fa-edit me-1"></i>Edit
                                              </button>

                                              <a href="/admin/products?category=<%= cat.getId() %>"
                                                class="btn btn-sm btn-outline-info rounded-pill px-3"
                                                title="Voir Produits">
                                                <i class="fas fa-box-open"></i>
                                              </a>
                                              <form action="/admin/categories" method="post" class="d-inline">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="<%= cat.getId() %>">
                                                <button type="submit"
                                                  class="btn btn-sm btn-outline-danger rounded-circle p-2"
                                                  title="Supprimer"
                                                  onclick="return confirm('Attention : Supprimer cette catégorie supprimera tous les produits associés ! Continuer ?')">
                                                  <i class="fas fa-trash-alt"></i>
                                                </button>
                                              </form>
                                            </div>
                                          </td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                  </table>
                                </div>
                                <% } else { %>
                                  <div class="text-center py-5">
                                    <i class="fas fa-folder-open fa-3x text-muted opacity-50 mb-3"></i>
                                    <p class="text-muted">Aucune catégorie n'a été créée pour le moment.</p>
                                  </div>
                                  <% } %>
                            </div>
                          </div>
                        </div>
                      </div>
            </div>

            <!-- MODAL MODIFICATION -->
            <div class="modal fade" id="editModal" tabindex="-1">
              <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow rounded-4">
                  <div class="modal-header bg-primary text-white border-0 rounded-top-4">
                    <h5 class="modal-title fw-bold"><i class="fas fa-edit me-2"></i>Modifier la catégorie</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                  </div>
                  <form action="/admin/categories" method="post">
                    <div class="modal-body p-4">
                      <input type="hidden" name="action" value="update">
                      <input type="hidden" name="id" id="editId">

                      <div class="mb-3">
                        <label class="form-label fw-semibold">Nom</label>
                        <input type="text" class="form-control" name="name" id="editName" required>
                      </div>
                      <div class="mb-3">
                        <label class="form-label fw-semibold">Description</label>
                        <textarea class="form-control" name="description" id="editDescription" rows="3"
                          required></textarea>
                      </div>
                    </div>
                    <div class="modal-footer border-0 p-4 pt-0">
                      <button type="button" class="btn btn-light rounded-pill px-4"
                        data-bs-dismiss="modal">Annuler</button>
                      <button type="submit"
                        class="btn btn-primary-custom text-white rounded-pill px-4 shadow-sm">Enregistrer</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script>
              function openEditModal(id, name, description) {
                document.getElementById("editId").value = id;
                document.getElementById("editName").value = name;
                document.getElementById("editDescription").value = description;
                var editModal = new bootstrap.Modal(document.getElementById("editModal"));
                editModal.show();
              }
            </script>
          </body>

          </html>
