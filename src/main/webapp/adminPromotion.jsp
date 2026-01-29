<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ page import="com.example.model.Promotion" %>
    <%@ page import="java.util.List" %>
      <%@ page import="com.example.model.Product" %>
        <%@ page import="com.example.model.Category" %>

          <% String role=(String) session.getAttribute("role"); if (role==null || !role.equalsIgnoreCase("admin")) {
            response.sendRedirect("/error.jsp"); return; } List<Promotion> promotions = (List<Promotion>)
              request.getAttribute("promotions");
              List<Category> categories = (List<Category>) request.getAttribute("categories");
                  List<Product> products = (List<Product>) request.getAttribute("products");

                      String message = (String) request.getAttribute("message");
                      String error = (String) request.getAttribute("error");
                      %>

                      <!DOCTYPE html>
                      <html lang="fr">

                      <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Administration - Promotions</title>
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                          rel="stylesheet">
                        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap"
                          rel="stylesheet">
                        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                          rel="stylesheet">
                        <link rel="stylesheet" href="../css/style.css">
                      </head>

                      <body class="bg-light">

                        <!-- NAVBAR -->
                        <jsp:include page="/shared/navbar/adminNavbar.jsp" />

                        <div class="container py-5 animate-fade-in">
                          <div class="d-flex justify-content-between align-items-center mb-4">
                            <h1 class="fw-bold text-primary"><i class="fas fa-percent me-2"></i>Gestion des Promotions
                            </h1>
                          </div>

                          <!-- Messages -->
                          <% if (message !=null) { %>
                            <div class="alert alert-success alert-dismissible fade show shadow-sm border-0"
                              role="alert">
                              <i class="fas fa-check-circle me-2"></i>
                              <%= message %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% } %>
                              <% if (error !=null) { %>
                                <div class="alert alert-danger alert-dismissible fade show shadow-sm border-0"
                                  role="alert">
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
                                          <h5 class="fw-bold mb-0 text-primary">Créer une promotion</h5>
                                        </div>
                                        <div class="card-body p-4">
                                          <form action="/admin/promotions" method="post" class="row g-3">
                                            <input type="hidden" name="action" value="add">

                                            <div class="col-12">
                                              <label class="form-label fw-semibold">Titre de la promo</label>
                                              <input type="text" class="form-control bg-light" name="title"
                                                placeholder="Ex: Soldes d'été" required>
                                            </div>

                                            <div class="col-md-6">
                                              <label class="form-label fw-semibold">Type</label>
                                              <select name="type" class="form-select bg-light" required>
                                                <option value="">Choisir...</option>
                                                <option value="Pourcentage">Pourcentage %</option>
                                                <option value="Montant fixe">Montant Fixe €</option>
                                              </select>
                                            </div>

                                            <div class="col-md-6">
                                              <label class="form-label fw-semibold">Valeur</label>
                                              <input type="number" step="0.01" class="form-control bg-light"
                                                name="value" placeholder="10" required>
                                            </div>

                                            <div class="col-6">
                                              <label class="form-label fw-semibold">Début</label>
                                              <input type="date" class="form-control bg-light" name="startDate"
                                                required>
                                            </div>

                                            <div class="col-6">
                                              <label class="form-label fw-semibold">Fin</label>
                                              <input type="date" class="form-control bg-light" name="endDate" required>
                                            </div>

                                            <div class="col-12">
                                              <label
                                                class="form-label fw-semibold text-muted small text-uppercase">Appliquer
                                                à (Un seul choix)</label>
                                              <div class="bg-light p-3 rounded-3 border">
                                                <div class="mb-3" id="categoryDiv">
                                                  <label class="form-label small">Catégorie</label>
                                                  <select name="categoryId" class="form-select form-select-sm"
                                                    id="categorySelect">
                                                    <option value="">-- Aucune --</option>
                                                    <% if(categories !=null) { for(Category cat : categories) { %>
                                                      <option value="<%= cat.getId() %>">
                                                        <%= cat.getName() %>
                                                      </option>
                                                      <% }} %>
                                                  </select>
                                                </div>
                                                <div id="productDiv">
                                                  <label class="form-label small">Ou Produit Spécifique</label>
                                                  <select name="productId" class="form-select form-select-sm"
                                                    id="productSelect">
                                                    <option value="">-- Aucun --</option>
                                                    <% if(products !=null) { for(Product p : products) { %>
                                                      <option value="<%= p.getId() %>">
                                                        <%= p.getName() %>
                                                      </option>
                                                      <% }} %>
                                                  </select>
                                                </div>
                                              </div>
                                            </div>

                                            <div class="col-12">
                                              <label class="form-label fw-semibold">Description</label>
                                              <textarea class="form-control bg-light" name="description" rows="2"
                                                required></textarea>
                                            </div>

                                            <div class="col-12 pt-2">
                                              <button type="submit"
                                                class="btn btn-primary-custom w-100 text-white rounded-pill shadow-sm">
                                                <i class="fas fa-plus me-2"></i>Ajouter Promotion
                                              </button>
                                            </div>
                                          </form>
                                        </div>
                                      </div>
                                    </div>

                                    <!-- LISTE PROMOTIONS -->
                                    <div class="col-lg-8">
                                      <div class="card border-0 shadow-sm rounded-4 h-100">
                                        <div
                                          class="card-header bg-white border-0 pt-4 px-4 pb-0 d-flex justify-content-between align-items-center">
                                          <h5 class="fw-bold mb-0">Promotions Actives</h5>
                                          <span class="badge bg-light text-primary border rounded-pill px-3">
                                            <%= promotions !=null ? promotions.size() : 0 %>
                                          </span>
                                        </div>
                                        <div class="card-body p-4">
                                          <% if (promotions !=null && !promotions.isEmpty()) { %>
                                            <div class="row row-cols-1 row-cols-md-2 g-3">
                                              <% for (Promotion promo : promotions) { String safeTitle=promo.getTitle()
                                                !=null ? promo.getTitle().replace("\"", "&quot;" ) : "" ; String
                                                safeDesc=promo.getDescription() !=null ?
                                                promo.getDescription().replace("\"", "&quot;" ) : "" ; String
                                                safeType=promo.getType() !=null ? promo.getType() : "" ; String
                                                safeCat=promo.getCategoryName() !=null ? promo.getCategoryName() : "" ;
                                                String safeProd=promo.getProductName() !=null ? promo.getProductName()
                                                : "" ; String safeStartDate=promo.getStartDate() !=null ?
                                                promo.getStartDate().toString() : "" ; String
                                                safeEndDate=promo.getEndDate() !=null ? promo.getEndDate().toString()
                                                : "" ; %>
                                                <div class="col">
                                                  <div
                                                    class="card h-100 border bg-light position-relative overflow-hidden promotion-card">
                                                    <div class="card-body">
                                                      <div
                                                        class="d-flex justify-content-between align-items-start mb-2">
                                                        <h6 class="fw-bold text-primary mb-0">
                                                          <%= promo.getTitle() %>
                                                        </h6>
                                                        <span class="badge bg-success rounded-pill">
                                                          <%= promo.getValue() %>
                                                            <%= "Pourcentage" .equals(promo.getType()) ? "%" : "€" %>
                                                        </span>
                                                      </div>
                                                      <p class="small text-muted mb-2">
                                                        <%= promo.getDescription() %>
                                                      </p>

                                                      <div class="small mb-2">
                                                        <i class="far fa-calendar-alt me-1 text-muted"></i>
                                                        <span class="fw-semibold">
                                                          <%= promo.getStartDate() %>
                                                        </span> au <span class="fw-semibold">
                                                          <%= promo.getEndDate() %>
                                                        </span>
                                                      </div>

                                                      <div class="mb-3">
                                                        <% if(promo.getCategoryName() !=null &&
                                                          !promo.getCategoryName().isEmpty()) { %>
                                                          <span class="badge bg-secondary text-white small">Cat: <%=
                                                              promo.getCategoryName() %></span>
                                                          <% } else if(promo.getProductName() !=null &&
                                                            !promo.getProductName().isEmpty()) { %>
                                                            <span class="badge bg-secondary text-white small">Prod: <%=
                                                                promo.getProductName() %></span>
                                                            <% } else { %>
                                                              <span
                                                                class="badge bg-warning text-dark small">Global</span>
                                                              <% } %>
                                                      </div>

                                                      <hr class="my-2">

                                                      <div class="d-flex justify-content-end gap-2">
                                                        <button
                                                          class="btn btn-sm btn-outline-dark rounded-pill edit-btn"
                                                          type="button" data-id="<%= promo.getId() %>"
                                                          data-title="<%= safeTitle %>" data-type="<%= safeType %>"
                                                          data-value="<%= promo.getValue() %>"
                                                          data-start-date="<%= safeStartDate %>"
                                                          data-end-date="<%= safeEndDate %>"
                                                          data-category="<%= safeCat %>" data-product="<%= safeProd %>"
                                                          data-description="<%= safeDesc %>">
                                                          <i class="fas fa-edit"></i>
                                                        </button>

                                                        <a href="/admin/promotions?action=delete&id=<%= promo.getId() %>"
                                                          class="btn btn-sm btn-outline-danger rounded-pill"
                                                          onclick="return confirm('Supprimer cette promotion ?')">
                                                          <i class="fas fa-trash"></i>
                                                        </a>
                                                      </div>
                                                    </div>
                                                  </div>
                                                </div>
                                                <% } %>
                                            </div>
                                            <% } else { %>
                                              <div class="text-center py-5">
                                                <i class="fas fa-percentage fa-3x text-muted opacity-50 mb-3"></i>
                                                <p class="text-muted">Aucune promotion en cours.</p>
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
                                <h5 class="modal-title fw-bold">Modifier Promotion</h5>
                                <button type="button" class="btn-close btn-close-white"
                                  data-bs-dismiss="modal"></button>
                              </div>
                              <form action="/admin/promotions" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" id="editId">

                                <div class="modal-body p-4">
                                  <div class="mb-3">
                                    <label class="form-label fw-semibold">Titre</label>
                                    <input type="text" class="form-control" name="title" id="editTitle" required>
                                  </div>

                                  <div class="row g-3 mb-3">
                                    <div class="col-6">
                                      <label class="form-label fw-semibold">Type</label>
                                      <select class="form-select" name="type" id="editType" required>
                                        <option value="Pourcentage">Pourcentage</option>
                                        <option value="Montant fixe">Montant fixe</option>
                                      </select>
                                    </div>
                                    <div class="col-6">
                                      <label class="form-label fw-semibold">Valeur</label>
                                      <input type="number" step="0.01" class="form-control" name="value" id="editValue"
                                        required>
                                    </div>
                                  </div>

                                  <div class="row g-3 mb-3">
                                    <div class="col-6">
                                      <label class="form-label fw-semibold">Début</label>
                                      <input type="date" class="form-control" name="startDate" id="editStartDate"
                                        required>
                                    </div>
                                    <div class="col-6">
                                      <label class="form-label fw-semibold">Fin</label>
                                      <input type="date" class="form-control" name="endDate" id="editEndDate" required>
                                    </div>
                                  </div>

                                  <div class="mb-3">
                                    <label class="form-label fw-semibold small text-muted">Cible (L'un ou
                                      l'autre)</label>
                                    <div class="row g-2">
                                      <div class="col-6">
                                        <select class="form-select form-select-sm" name="categoryId" id="editCategory">
                                          <option value="">-- Catégorie --</option>
                                          <% if(categories !=null) { for(Category cat : categories) { %>
                                            <option value="<%= cat.getId() %>">
                                              <%= cat.getName() %>
                                            </option>
                                            <% }} %>
                                        </select>
                                      </div>
                                      <div class="col-6">
                                        <select class="form-select form-select-sm" name="productId" id="editProduct">
                                          <option value="">-- Produit --</option>
                                          <% if(products !=null) { for(Product p : products) { %>
                                            <option value="<%= p.getId() %>">
                                              <%= p.getName() %>
                                            </option>
                                            <% }} %>
                                        </select>
                                      </div>
                                    </div>
                                  </div>

                                  <div class="mb-3">
                                    <label class="form-label fw-semibold">Description</label>
                                    <textarea class="form-control" name="description" id="editDescription" rows="2"
                                      required></textarea>
                                  </div>
                                </div>

                                <div class="modal-footer border-0 p-4 pt-0">
                                  <button type="button" class="btn btn-light rounded-pill px-4"
                                    data-bs-dismiss="modal">Annuler</button>
                                  <button type="submit"
                                    class="btn btn-primary-custom text-white rounded-pill px-4 shadow-sm">Mettre à
                                    jour</button>
                                </div>
                              </form>
                            </div>
                          </div>
                        </div>

                        <script
                          src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                        <script>
                          document.addEventListener('DOMContentLoaded', function () {
                            // --- Logic for exclusive selects ---
                            const categorySelect = document.getElementById('categorySelect');
                            const productSelect = document.getElementById('productSelect');

                            if (categorySelect && productSelect) {
                              categorySelect.addEventListener('change', () => {
                                if (categorySelect.value) productSelect.value = '';
                              });
                              productSelect.addEventListener('change', () => {
                                if (productSelect.value) categorySelect.value = '';
                              });
                            }

                            const editCategory = document.getElementById('editCategory');
                            const editProduct = document.getElementById('editProduct');

                            if (editCategory && editProduct) {
                              editCategory.addEventListener('change', () => {
                                if (editCategory.value) editProduct.value = '';
                              });
                              editProduct.addEventListener('change', () => {
                                if (editProduct.value) editCategory.value = '';
                              });
                            }

                            // --- Logic for Edit Buttons using data-attributes ---
                            const editButtons = document.querySelectorAll('.edit-btn');
                            editButtons.forEach(btn => {
                              btn.addEventListener('click', function () {
                                const data = this.dataset;
                                openEditModal(
                                  data.id,
                                  data.title,
                                  data.type,
                                  data.value,
                                  data.startDate,
                                  data.endDate,
                                  data.categoryId,
                                  data.productId,
                                  data.description
                                );
                              });
                            });
                          });

                          function openEditModal(id, title, type, value, startDate, endDate, categoryId, productId, description) {
                            const clean = (val) => (val === 'null' || val === undefined) ? '' : val;

                            document.getElementById('editId').value = id;
                            document.getElementById('editTitle').value = clean(title);
                            document.getElementById('editType').value = clean(type);
                            document.getElementById('editValue').value = clean(value);
                            document.getElementById('editStartDate').value = clean(startDate);
                            document.getElementById('editEndDate').value = clean(endDate);
                            document.getElementById('editDescription').value = clean(description);
                            document.getElementById('editCategory').value = clean(categoryId);
                            document.getElementById('editProduct').value = clean(productId);

                            var modal = new bootstrap.Modal(document.getElementById('editModal'));
                            modal.show();
                          }
                        </script>

                      </body>

                      </html>