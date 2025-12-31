<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
      <%@ page import="com.example.model.Category" %>
        <%@ page import="com.example.model.Product" %>

          <% List<Category> categories = (List<Category>) request.getAttribute("categories");
              List<Product> products = (List<Product>) request.getAttribute("products");
                  if (categories == null) categories = new ArrayList<>();
                    if (products == null) products = new ArrayList<>();
                      %>

                      <!DOCTYPE html>
                      <html lang="fr">

                      <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Nos Catégories - Boutique</title>

                        <!-- Fonts & Icons -->
                        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap"
                          rel="stylesheet">
                        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
                          rel="stylesheet">

                        <!-- Bootstrap 5 -->
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                          rel="stylesheet">

                        <style>
                          :root {
                            --primary-color: #2563eb;
                            --secondary-color: #1e293b;
                            --accent-color: #3b82f6;
                            --bg-light: #f8fafc;
                          }

                          body {
                            font-family: 'Outfit', sans-serif;
                            background-color: var(--bg-light);
                            color: var(--secondary-color);
                          }

                          .hero-section {
                            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
                            color: white;
                            padding: 4rem 0;
                            margin-bottom: 3rem;
                            border-radius: 0 0 2rem 2rem;
                            box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.3);
                          }

                          .category-title {
                            position: relative;
                            display: inline-block;
                            margin-bottom: 2rem;
                            color: var(--secondary-color);
                            font-weight: 700;
                          }

                          .category-title::after {
                            content: '';
                            position: absolute;
                            bottom: -10px;
                            left: 0;
                            width: 50px;
                            height: 4px;
                            background: var(--primary-color);
                            border-radius: 2px;
                          }

                          /* Horizontal Scrolling Wrapper */
                          .scrolling-wrapper {
                            overflow-x: auto;
                            overflow-y: hidden;
                            -webkit-overflow-scrolling: touch;
                            scroll-behavior: smooth;
                          }

                          .scrolling-wrapper::-webkit-scrollbar {
                            height: 8px;
                          }

                          .scrolling-wrapper::-webkit-scrollbar-track {
                            background: #f1f5f9;
                            border-radius: 4px;
                          }

                          .scrolling-wrapper::-webkit-scrollbar-thumb {
                            background: #cbd5e1;
                            border-radius: 4px;
                          }

                          .scrolling-wrapper::-webkit-scrollbar-thumb:hover {
                            background: #94a3b8;
                          }

                          .product-item {
                            width: 280px;
                            flex-shrink: 0;
                          }

                          .product-card {
                            border: none;
                            border-radius: 1rem;
                            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                            background: white;
                            height: 100%;
                            overflow: hidden;
                            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
                          }

                          .product-card:hover {
                            transform: translateY(-8px);
                            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
                          }

                          .product-image-container {
                            height: 200px;
                            overflow: hidden;
                            position: relative;
                            background: #f1f5f9;
                          }

                          .product-image {
                            width: 100%;
                            height: 100%;
                            object-fit: cover;
                            transition: transform 0.5s ease;
                          }

                          .product-card:hover .product-image {
                            transform: scale(1.05);
                          }

                          .card-body {
                            padding: 1.25rem;
                          }

                          .price-badge {
                            background: var(--bg-light);
                            color: var(--primary-color);
                            font-weight: 700;
                            padding: 0.5rem 0.8rem;
                            border-radius: 0.5rem;
                            font-size: 0.9rem;
                          }

                          .btn-details {
                            background: var(--primary-color);
                            color: white;
                            border-radius: 0.75rem;
                            padding: 0.5rem 1rem;
                            font-weight: 600;
                            transition: all 0.2s;
                            border: none;
                            font-size: 0.9rem;
                          }

                          .btn-details:hover {
                            background: #1d4ed8;
                            transform: translateY(-1px);
                          }

                          /* Modal Customization */
                          .modal-content {
                            border-radius: 1.5rem;
                            border: none;
                            overflow: hidden;
                          }

                          .modal-header {
                            background: #f8fafc;
                            border-bottom: 1px solid #e2e8f0;
                          }

                          .modal-image {
                            width: 100%;
                            height: 300px;
                            object-fit: contain;
                            background: #f8fafc;
                            border-radius: 1rem;
                          }
                        </style>
                      </head>

                      <body>

                        <jsp:include page="/shared/navbar/navbar.jsp" />

                        <!-- Hero Section -->
                        <section class="hero-section text-center">
                          <div class="container">
                            <h1 class="display-4 fw-bold mb-3 animate-fade-in">Nos Collections</h1>
                            <p class="lead text-white-50 mx-auto" style="max-width: 600px;">
                              Découvrez nos produits soigneusement sélectionnés, organisés par catégories pour votre
                              plaisir.
                            </p>
                          </div>
                        </section>

                        <!-- Filters Section -->
                        <div class="container mb-5">
                          <div class="card shadow-sm border-0 rounded-4">
                            <div class="card-body p-4">
                              <div class="row g-3 items-center">
                                <div class="col-md-4">
                                  <div class="input-group">
                                    <span class="input-group-text bg-white border-end-0"><i
                                        class="fas fa-search text-muted"></i></span>
                                    <input type="text" id="searchInput" class="form-control border-start-0"
                                      placeholder="Rechercher un produit...">
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <select id="categoryFilter" class="form-select">
                                    <option value="">Toutes les catégories</option>
                                    <% for (Category cat : categories) { %>
                                      <option value="<%= cat.getId() %>">
                                        <%= cat.getName() %>
                                      </option>
                                      <% } %>
                                  </select>
                                </div>
                                <div class="col-md-4">
                                  <label for="priceRange" class="form-label small text-muted mb-0">Prix max: <span
                                      id="priceValue" class="fw-bold">2000€</span></label>
                                  <input type="range" class="form-range" id="priceRange" min="0" max="2000" step="10"
                                    value="2000">
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>

                        <!-- Main Content -->
                        <div class="container pb-5" id="productsContainer">
                          <% if (categories.isEmpty()) { %>
                            <div class="text-center py-5">
                              <i class="fas fa-boxes fa-3x text-muted mb-3"></i>
                              <p class="h5 text-muted">Aucune catégorie disponible pour le moment.</p>
                            </div>
                            <% } %>

                              <% for (Category cat : categories) { %>
                                <div class="category-section mb-5 animate-fade-in"
                                  data-category-id="<%= cat.getId() %>">
                                  <h2 class="category-title mb-4">
                                    <%= cat.getName() %>
                                  </h2>

                                  <!-- Horizontal Scrolling Container -->
                                  <div class="scrolling-wrapper d-flex gap-4 pb-3 products-container">
                                    <% boolean hasProducts=false; for (Product prod : products) { if
                                      (prod.getCategoryId() !=null && prod.getCategoryId().equals(cat.getId())) {
                                      hasProducts=true; String safeName=prod.getName() !=null ?
                                      prod.getName().replace("\"", "&quot;" ) : "" ; String
                                      safeDesc=prod.getDescription() !=null ?
                                      prod.getDescription().replace("\"", "&quot;" ) : "" ; %>

                                      <div class="product-item" data-name="<%= safeName.toLowerCase() %>"
                                        data-price="<%= prod.getPrice() %>" data-category-id="<%= cat.getId() %>">
                                        <div class="product-card h-100">
                                          <div class="product-image-container">
                                            <img
                                              src="<%= (prod.getImagePath() != null && !prod.getImagePath().isEmpty()) ? prod.getImagePath() : "https://via.placeholder.com/300x200?text=No+Image" %>"
                                            alt="<%= safeName %>" class="product-image">
                                          </div>
                                          <div class="card-body d-flex flex-column">
                                            <div class="d-flex justify-content-between align-items-start mb-2">
                                              <h5 class="card-title fw-bold mb-0 text-truncate" title="<%= safeName %>">
                                                <%= prod.getName() %>
                                              </h5>
                                            </div>
                                            <p class="card-text text-muted small text-truncate mb-3">
                                              <%= prod.getDescription() %>
                                            </p>

                                            <div class="mt-auto d-flex justify-content-between align-items-center">
                                              <span class="price-badge">
                                                <%= String.format("%.2f", prod.getPrice()) %> €
                                              </span>
                                              <button class="btn btn-details btn-sm shadow-sm"
                                                data-id="<%= prod.getId() %>" data-name="<%= safeName %>"
                                                data-price="<%= prod.getPrice() %>" data-desc="<%= safeDesc %>"
                                                data-image="<%= prod.getImagePath() %>"
                                                data-category="<%= cat.getName() %>" onclick="showDetails(this)">
                                                Voir détails
                                              </button>
                                            </div>
                                          </div>
                                        </div>
                                      </div>
                                      <% } } %>

                                        <% if (!hasProducts) { %>
                                          <div class="w-100 no-products-msg">
                                            <div
                                              class="p-4 rounded-3 bg-white border border-dashed text-center text-muted">
                                              <small>Aucun produit dans cette catégorie.</small>
                                            </div>
                                          </div>
                                          <% } %>
                                  </div>
                                </div>
                                <% } %>
                        </div>

                        <!-- Product Details Modal -->
                        <div class="modal fade" id="productModal" tabindex="-1" aria-hidden="true">
                          <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content shadow-lg">
                              <div class="modal-header">
                                <h5 class="modal-title fw-bold" id="modalTitle">Détails du Produit</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                  aria-label="Close"></button>
                              </div>
                              <div class="modal-body p-4">
                                <div class="row g-4">
                                  <div class="col-md-6">
                                    <img src="" id="modalImage" class="modal-image shadow-sm" alt="Produit">
                                  </div>
                                  <div class="col-md-6 d-flex flex-column justify-content-center">
                                    <h2 class="fw-bold mb-3" id="modalName"></h2>
                                    <h3 class="text-primary fw-bold mb-4" id="modalPrice"></h3>
                                    <p class="text-muted lead mb-4" id="modalDesc"></p>

                                    <form action="panier" method="post" class="mt-auto">
                                      <input type="hidden" name="action" value="add">
                                      <input type="hidden" name="productName" id="inputName">
                                      <input type="hidden" name="productPrice" id="inputPrice">
                                      <input type="hidden" name="description" id="inputDesc">
                                      <input type="hidden" name="category" id="inputCategory">
                                      <input type="hidden" name="imagePath" id="inputImage">

                                      <div class="d-flex align-items-center mb-3">
                                        <label class="me-3 fw-semibold">Quantité:</label>
                                        <input type="number" name="quantity" class="form-control w-25 text-center"
                                          value="1" min="1" max="10">
                                      </div>

                                      <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-dark rounded-pill py-2">
                                          <i class="fas fa-shopping-cart me-2"></i> Ajouter au panier
                                        </button>
                                      </div>
                                    </form>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>

                        <script
                          src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                        <script>
                          // Filters Logic
                          const searchInput = document.getElementById('searchInput');
                          const categoryFilter = document.getElementById('categoryFilter');
                          const priceRange = document.getElementById('priceRange');
                          const priceValue = document.getElementById('priceValue');

                          function filterProducts() {
                            const search = searchInput.value.toLowerCase();
                            const categoryId = categoryFilter.value;
                            const maxPrice = parseFloat(priceRange.value);

                            priceValue.textContent = maxPrice + '€';

                            const products = document.querySelectorAll('.product-item');
                            const categorySections = document.querySelectorAll('.category-section');

                            categorySections.forEach(section => {
                              let hasVisibleProducts = false;
                              // Check if section itself matches category filter
                              const sectionCatId = section.dataset.categoryId;
                              const sectionMatchesCategory = !categoryId || sectionCatId === categoryId;

                              const items = section.querySelectorAll('.product-item');
                              items.forEach(item => {
                                const name = item.dataset.name;
                                const price = parseFloat(item.dataset.price);

                                const matchesSearch = name.includes(search);
                                const matchesPrice = price <= maxPrice;

                                if (matchesSearch && matchesPrice && sectionMatchesCategory) {
                                  item.style.display = 'block';
                                  hasVisibleProducts = true;
                                } else {
                                  item.style.display = 'none';
                                }
                              });

                              // Toggle section visibility based on products
                              if (hasVisibleProducts) {
                                section.style.display = 'block';
                              } else {
                                section.style.display = 'none';
                              }
                            });
                          }

                          if (searchInput) searchInput.addEventListener('input', filterProducts);
                          if (categoryFilter) categoryFilter.addEventListener('change', filterProducts);
                          if (priceRange) priceRange.addEventListener('input', filterProducts);

                          // Modal Logic
                          function showDetails(btn) {
                            const data = btn.dataset;
                            document.getElementById('modalName').textContent = data.name;
                            document.getElementById('modalPrice').textContent = parseFloat(data.price).toFixed(2) + ' €';
                            document.getElementById('modalDesc').textContent = data.desc;

                            // Populate form inputs
                            document.getElementById('inputName').value = data.name;
                            document.getElementById('inputPrice').value = data.price;
                            document.getElementById('inputDesc').value = data.desc;
                            document.getElementById('inputCategory').value = data.category;
                            document.getElementById('inputImage').value = data.image;

                            const imgEl = document.getElementById('modalImage');
                            if (data.image && data.image !== 'null' && data.image !== '') {
                              imgEl.src = data.image;
                            } else {
                              imgEl.src = 'https://via.placeholder.com/400x300?text=No+Image';
                            }

                            var myModal = new bootstrap.Modal(document.getElementById('productModal'));
                            myModal.show();
                          }
                        </script>
                      </body>

                      </html>
