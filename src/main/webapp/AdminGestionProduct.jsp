<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ page import="com.example.model.Product" %>
    <%@ page import="com.example.model.Category" %>
      <%@ page import="com.example.model.Promotion" %>
        <%@ page import="java.util.List" %>
          <%@ page import="java.util.Map" %>
            <%@ page import="java.text.SimpleDateFormat" %>

              <% String role=(String) session.getAttribute("role"); if (role==null || !role.equalsIgnoreCase("admin")) {
                response.sendRedirect("/error.jsp"); return; } List<Product> products = (List<Product>)
                  request.getAttribute("products");
                  List<Category> categories = (List<Category>) request.getAttribute("categories");
                      Map<Long, Promotion> productPromotionMap = (Map<Long, Promotion>)
                          request.getAttribute("productPromotionMap");
                          String message = (String) request.getAttribute("message");
                          String error = (String) request.getAttribute("error");
                          SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                          %>

                          <!DOCTYPE html>
                          <html lang="fr">

                          <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Administration - Produits</title>
                            <!-- Bootstrap CSS -->
                            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                              rel="stylesheet">
                            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap"
                              rel="stylesheet">
                            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                              rel="stylesheet">
                            <link rel="stylesheet" href="../css/style.css">
                            <style>
                              .product-card {
                                transition: all 0.3s ease;
                                cursor: default;
                              }

                              .product-card:hover {
                                transform: translateY(-5px);
                                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
                              }

                              .product-img-container {
                                height: 200px;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                background: #f8f9fa;
                                position: relative;
                                overflow: hidden;
                              }

                              .product-img-container img {
                                max-height: 180px;
                                object-fit: contain;
                                transition: transform 0.3s;
                              }

                              .product-card:hover .product-img-container img {
                                transform: scale(1.05);
                              }

                              .action-overlay {
                                position: absolute;
                                top: 10px;
                                right: 10px;
                                opacity: 0;
                                transition: opacity 0.3s;
                              }

                              .product-card:hover .action-overlay {
                                opacity: 1;
                              }
                            </style>
                          </head>

                          <body class="bg-light">

                            <!-- NAVBAR -->
                            <jsp:include page="/shared/navbar/adminNavbar.jsp" />

                            <div class="container py-5 animate-fade-in">
                              <div class="d-flex justify-content-between align-items-center mb-4">
                                <h1 class="fw-bold text-primary"><i class="fas fa-boxes me-2"></i>Gestion des Produits
                                </h1>
                                <button class="btn btn-primary-custom text-white rounded-pill px-4 shadow-sm"
                                  type="button" data-bs-toggle="collapse" data-bs-target="#addProductForm">
                                  <i class="fas fa-plus me-2"></i>Nouveau Produit
                                </button>
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

                                      <!-- FORMULAIRE AJOUT (Collapse) -->
                                      <div class="collapse mb-4" id="addProductForm">
                                        <div class="card border-0 shadow-sm rounded-4">
                                          <div class="card-header bg-white border-0 pt-4 px-4 pb-0">
                                            <h5 class="fw-bold mb-0 text-primary">Ajouter un produit</h5>
                                          </div>
                                          <div class="card-body p-4">
                                            <form action="/admin/products" method="post" class="row g-3">
                                              <input type="hidden" name="action" value="add">

                                              <div class="col-md-6">
                                                <label class="form-label fw-semibold">Nom du produit</label>
                                                <input type="text" class="form-control bg-light" name="name"
                                                  placeholder="Ex: Smartphone XYZ" required>
                                              </div>

                                              <div class="col-md-3">
                                                <label class="form-label fw-semibold">Prix (€)</label>
                                                <div class="input-group">
                                                  <input type="number" step="0.01" class="form-control bg-light"
                                                    name="price" placeholder="0.00" required>
                                                  <span class="input-group-text bg-light border-start-0">€</span>
                                                </div>
                                              </div>

                                              <div class="col-md-3">
                                                <label class="form-label fw-semibold">Catégorie</label>
                                                <select name="categoryId" class="form-select bg-light" required>
                                                  <option value="">-- Choisir --</option>
                                                  <% if (categories !=null) { for (Category c : categories) { %>
                                                    <option value="<%= c.getId() %>">
                                                      <%= c.getName() %>
                                                    </option>
                                                    <% }} %>
                                                </select>
                                              </div>

                                              <div class="col-md-12">
                                                <label class="form-label fw-semibold">Description</label>
                                                <textarea name="description" class="form-control bg-light" rows="2"
                                                  placeholder="Détails du produit..." required></textarea>
                                              </div>

                                              <div class="col-md-12">
                                                <label class="form-label fw-semibold">URL de l'image</label>
                                                <div class="input-group">
                                                  <span class="input-group-text bg-light"><i
                                                      class="fas fa-link"></i></span>
                                                  <input type="url" class="form-control bg-light" name="imagePath"
                                                    placeholder="http://exemple.com/image.jpg">
                                                </div>
                                                <div class="form-text small"><i
                                                    class="fas fa-info-circle me-1"></i>L'image sera
                                                  téléchargée sur le serveur.</div>
                                              </div>

                                              <div class="col-12 text-end">
                                                <button type="button" class="btn btn-light rounded-pill px-4 me-2"
                                                  data-bs-toggle="collapse"
                                                  data-bs-target="#addProductForm">Annuler</button>
                                                <button type="submit"
                                                  class="btn btn-primary-custom text-white rounded-pill px-4 shadow-sm">Enregistrer
                                                  le produit</button>
                                              </div>
                                            </form>
                                          </div>
                                        </div>
                                      </div>

                                      <!-- BARRE DE FILTRES -->
                                      <div class="card border-0 shadow-sm rounded-4 mb-4">
                                        <div class="card-body p-3">
                                          <div class="row g-2 align-items-center">
                                            <div class="col-md-4">
                                              <div class="input-group">
                                                <span class="input-group-text bg-white border-end-0"><i
                                                    class="fas fa-search text-muted"></i></span>
                                                <input type="text" id="searchName"
                                                  class="form-control border-start-0 ps-0" placeholder="Rechercher...">
                                              </div>
                                            </div>
                                            <div class="col-md-3">
                                              <select id="filterCategory" class="form-select border-0 bg-light">
                                                <option value="">Toutes les catégories</option>
                                                <% if (categories !=null) { for (Category c : categories) { %>
                                                  <option value="<%= c.getName() %>">
                                                    <%= c.getName() %>
                                                  </option>
                                                  <% }} %>
                                              </select>
                                            </div>
                                            <div class="col-md-3">
                                              <input type="number" id="filterMaxPrice"
                                                class="form-control border-0 bg-light" placeholder="Prix max (€)">
                                            </div>
                                            <div class="col-md-2">
                                              <button class="btn btn-secondary w-100 rounded-pill"
                                                onclick="resetFilters()">
                                                <i class="fas fa-undo me-2"></i>Reset
                                              </button>
                                            </div>
                                          </div>
                                        </div>
                                      </div>

                                      <!-- LISTE DES PRODUITS GRID -->
                                      <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="text-muted" id="productCount">
                                          <%= products !=null ? products.size() : 0 %> produit(s) trouvés
                                        </span>
                                      </div>

                                      <% if (products !=null && !products.isEmpty()) { %>
                                        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-4"
                                          id="productsContainer">
                                          <% for (Product p : products) { String safeName=(p.getName() !=null) ?
                                            p.getName().replace("\"", "&quot;" ) : "" ; String
                                            safeDesc=(p.getDescription() !=null) ?
                                            p.getDescription().replace("\"", "&quot;" ) : "" ; String
                                            safePrice=String.format("%.2f", p.getPrice()).replace(",", "." ); String
                                            safeImage=(p.getImagePath() !=null) ? p.getImagePath().replace("\\", "/" )
                                            : "" ; %>
                                            <div class="col product-item animate-fade-in"
                                              data-name="<%= p.getName().toLowerCase() %>"
                                              data-category="<%= p.getCategory() %>" data-price="<%= p.getPrice() %>">
                                              <div
                                                class="card h-100 product-card border-0 shadow-sm rounded-4 overflow-hidden">
                                                <div class="product-img-container">
                                                  <% if (p.getImagePath() !=null && !p.getImagePath().isEmpty()) { %>
                                                    <img src="<%= p.getImagePath() %>" alt="<%= p.getName() %>">
                                                    <% } else { %>
                                                      <div class="text-center text-muted opacity-50">
                                                        <i class="fas fa-image fa-3x mb-2"></i><br>No Image
                                                      </div>
                                                      <% } %>

                                                        <!-- Promotion Badge -->
                                                        <% Promotion activePromo=null; if (productPromotionMap !=null) {
                                                          activePromo=productPromotionMap.get(p.getId()); } if
                                                          (activePromo !=null) { String
                                                          promoTitle=activePromo.getTitle() !=null ?
                                                          activePromo.getTitle() : "" ; String
                                                          promoEndDate=activePromo.getEndDate() !=null ?
                                                          dateFormat.format(activePromo.getEndDate()) : "indefini" ;
                                                          String promoBadgeTitle=promoTitle + " - Jusqu'au " +
                                                          promoEndDate; String promoSymbol="Pourcentage"
                                                          .equalsIgnoreCase(activePromo.getType()) ? "%" : "EUR" ; int
                                                          promoValue=(int) activePromo.getValue(); %>
                                                          <div class="position-absolute top-0 start-0 m-2">
                                                            <span
                                                              class="badge bg-danger rounded-pill px-2 py-1 shadow-sm"
                                                              title="<%= promoBadgeTitle %>">
                                                              <i class="fas fa-tag me-1"></i>-<%= promoValue %>
                                                                <%= promoSymbol %>
                                                            </span>
                                                          </div>
                                                          <% } %>

                                                            <!-- Quick Actions Overlay -->
                                                            <div class="action-overlay">
                                                              <form action="/admin/products" method="post"
                                                                class="d-inline">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                                                <button type="submit"
                                                                  class="btn btn-danger btn-sm rounded-circle shadow"
                                                                  title="Supprimer"
                                                                  onclick="return confirm('Êtes-vous sûr ?')">
                                                                  <i class="fas fa-trash-alt"></i>
                                                                </button>
                                                              </form>
                                                            </div>
                                                </div>

                                                <div class="card-body p-3 d-flex flex-column">
                                                  <div class="mb-2">
                                                    <span
                                                      class="badge bg-light text-primary border rounded-pill small mb-1">
                                                      <%= p.getCategory() %>
                                                    </span>
                                                  </div>
                                                  <h6 class="card-title fw-bold mb-1">
                                                    <%= p.getName() %>
                                                  </h6>
                                                  <p class="card-text text-muted small flex-grow-1 text-truncate"
                                                    title="<%= p.getDescription() %>">
                                                    <%= p.getDescription() %>
                                                  </p>
                                                  <div
                                                    class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
                                                    <span class="fw-bold text-success fs-5">
                                                      <%= String.format("%.2f", p.getPrice()) %> €
                                                    </span>
                                                    <button
                                                      class="btn btn-sm btn-outline-primary rounded-pill px-3 edit-btn"
                                                      type="button" data-id="<%= p.getId() %>"
                                                      data-category-id="<%= p.getCategoryId() %>"
                                                      data-name="<%= safeName %>" data-price="<%= safePrice %>"
                                                      data-description="<%= safeDesc %>" data-image="<%= safeImage %>">
                                                      Modifier
                                                    </button>
                                                  </div>

                                                  <!-- Promotion Info Section -->
                                                  <% if (activePromo !=null) { String
                                                    infoPromoTitle=activePromo.getTitle() !=null ?
                                                    activePromo.getTitle() : "" ; String
                                                    infoPromoEndDate=activePromo.getEndDate() !=null ?
                                                    dateFormat.format(activePromo.getEndDate()) : "indefini" ; %>
                                                    <div
                                                      class="mt-2 p-2 bg-danger bg-opacity-10 rounded-3 border border-danger border-opacity-25">
                                                      <div class="d-flex align-items-center justify-content-between">
                                                        <div>
                                                          <i class="fas fa-tag text-danger me-1"></i>
                                                          <span class="small fw-semibold text-danger">
                                                            <%= infoPromoTitle %>
                                                          </span>
                                                        </div>
                                                        <a href="/admin/promotions"
                                                          class="btn btn-sm btn-outline-danger rounded-pill px-2 py-0"
                                                          title="Gerer les promotions">
                                                          <i class="fas fa-external-link-alt"></i>
                                                        </a>
                                                      </div>
                                                      <div class="small text-muted mt-1">
                                                        <i class="far fa-calendar-alt me-1"></i>
                                                        Jusqu'au <%= infoPromoEndDate %>
                                                      </div>
                                                    </div>
                                                    <% } %>
                                                </div>
                                              </div>
                                            </div>
                                            <% } %>
                                        </div>

                                        <!-- No Results State -->
                                        <div id="noResults" class="text-center py-5" style="display: none;">
                                          <i class="fas fa-search fa-3x text-muted opacity-25 mb-3"></i>
                                          <p class="text-muted">Aucun produit ne correspond à ces critères.</p>
                                        </div>

                                        <% } else { %>
                                          <div class="text-center py-5">
                                            <i class="fas fa-box-open fa-4x text-muted opacity-25 mb-3"></i>
                                            <h4 class="text-muted">Aucun produit en stock</h4>
                                            <p class="text-muted">Utilisez le bouton "Nouveau Produit" pour commencer.
                                            </p>
                                          </div>
                                          <% } %>
                            </div>

                            <!-- MODAL MODIFICATION -->
                            <div class="modal fade" id="editModal" tabindex="-1">
                              <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content border-0 shadow rounded-4">
                                  <div class="modal-header bg-primary text-white border-0 rounded-top-4">
                                    <h5 class="modal-title fw-bold">Modifier le produit</h5>
                                    <button type="button" class="btn-close btn-close-white"
                                      data-bs-dismiss="modal"></button>
                                  </div>
                                  <form action="/admin/products" method="post">
                                    <div class="modal-body p-4">
                                      <input type="hidden" name="action" value="update">
                                      <input type="hidden" name="id" id="editId">

                                      <div class="mb-3">
                                        <label class="form-label fw-semibold">Nom</label>
                                        <input type="text" class="form-control" name="name" id="editName" required>
                                      </div>
                                      <div class="row g-3 mb-3">
                                        <div class="col-6">
                                          <label class="form-label fw-semibold">Prix</label>
                                          <input type="number" step="0.01" class="form-control" name="price"
                                            id="editPrice" required>
                                        </div>
                                        <div class="col-6">
                                          <label class="form-label fw-semibold">Catégorie</label>
                                          <select name="categoryId" class="form-select" id="editCategoryId" required>
                                            <% if (categories !=null) { for (Category c : categories) { %>
                                              <option value="<%= c.getId() %>">
                                                <%= c.getName() %>
                                              </option>
                                              <% }} %>
                                          </select>
                                        </div>
                                      </div>
                                      <div class="mb-3">
                                        <label class="form-label fw-semibold">Description</label>
                                        <textarea class="form-control" name="description" id="editDescription" rows="3"
                                          required></textarea>
                                      </div>
                                      <div class="mb-3">
                                        <label class="form-label fw-semibold">Nouvelle Image URL (opt.)</label>
                                        <input type="url" class="form-control" name="imagePath" id="editImage"
                                          placeholder="http://...">
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

                            <!-- Bootstrap JS Bundle -->
                            <script
                              src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                            <script>
                              document.addEventListener('DOMContentLoaded', function () {
                                const editButtons = document.querySelectorAll('.edit-btn');
                                editButtons.forEach(btn => {
                                  btn.addEventListener('click', function () {
                                    const d = this.dataset;
                                    openEditModal(d.id, d.categoryId, d.name, d.price, d.description, d.image);
                                  });
                                });
                              });

                              function openEditModal(id, categoryId, name, price, description, imagePath) {
                                document.getElementById("editId").value = id;
                                document.getElementById("editName").value = name;
                                document.getElementById("editPrice").value = parseFloat(price);
                                document.getElementById("editCategoryId").value = categoryId;
                                document.getElementById("editDescription").value = description;
                                document.getElementById("editImage").value = imagePath;
                                var editModal = new bootstrap.Modal(document.getElementById("editModal"));
                                editModal.show();
                              }

                              function filterProducts() {
                                const searchName = document.getElementById('searchName').value.toLowerCase();
                                const filterCategory = document.getElementById('filterCategory').value;
                                const filterMaxPrice = document.getElementById('filterMaxPrice').value;
                                const products = document.querySelectorAll('.product-item');
                                let visibleCount = 0;

                                products.forEach(product => {
                                  const name = product.dataset.name;
                                  const category = product.dataset.category;
                                  const price = parseFloat(product.dataset.price);
                                  let show = true;

                                  if (searchName && !name.includes(searchName)) show = false;
                                  if (filterCategory && category !== filterCategory) show = false;
                                  if (filterMaxPrice && price > parseFloat(filterMaxPrice)) show = false;

                                  product.style.display = show ? '' : 'none';
                                  if (show) visibleCount++;
                                });

                                document.getElementById('productCount').textContent = visibleCount + ' produit(s) trouvé(s)';
                                document.getElementById('noResults').style.display = visibleCount === 0 ? 'block' : 'none';
                                const container = document.getElementById('productsContainer');
                                if (container) container.style.display = visibleCount === 0 ? 'none' : 'flex';
                              }

                              function resetFilters() {
                                document.getElementById('searchName').value = '';
                                document.getElementById('filterCategory').value = '';
                                document.getElementById('filterMaxPrice').value = '';
                                filterProducts();
                              }

                              document.getElementById('searchName').addEventListener('input', filterProducts);
                              document.getElementById('filterCategory').addEventListener('change', filterProducts);
                              document.getElementById('filterMaxPrice').addEventListener('input', filterProducts);
                            </script>

                          </body>

                          </html>