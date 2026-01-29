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
                        <link
                          href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                          rel="stylesheet">
                        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
                          rel="stylesheet">

                        <!-- Bootstrap 5 -->
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                          rel="stylesheet">
                        <link rel="stylesheet" href="css/style.css">

                        <style>
                          body {
                            font-family: 'Inter', sans-serif;
                            background-color: #f8fafc;
                            color: #1e293b;
                          }

                          .hero-section {
                            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
                            padding: 4rem 0;
                            border-radius: 0 0 40px 40px;
                            margin-bottom: 3rem;
                          }

                          .hero-section h1 {
                            font-weight: 800;
                            letter-spacing: -0.025em;
                          }

                          .category-title {
                            font-weight: 800;
                            font-size: 1.75rem;
                            color: #1e293b;
                            margin-bottom: 1.5rem;
                            position: relative;
                            padding-left: 1rem;
                            border-left: 5px solid #4f46e5;
                          }

                          /* Filters */
                          .filter-card {
                            border: none;
                            border-radius: 1.5rem;
                            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                          }

                          /* Scrolling Wrapper */
                          .scrolling-wrapper {
                            overflow-x: auto;
                            display: flex;
                            gap: 1.5rem;
                            padding: 0.5rem 0.5rem 1.5rem;
                            scrollbar-width: thin;
                            scrollbar-color: #4f46e5 #f1f5f9;
                          }

                          .scrolling-wrapper::-webkit-scrollbar {
                            height: 6px;
                          }

                          .scrolling-wrapper::-webkit-scrollbar-track {
                            background: #f1f5f9;
                            border-radius: 10px;
                          }

                          .scrolling-wrapper::-webkit-scrollbar-thumb {
                            background: #cbd5e1;
                            border-radius: 10px;
                          }

                          .scrolling-wrapper::-webkit-scrollbar-thumb:hover {
                            background: #4f46e5;
                          }

                          /* Product Cards */
                          .product-item {
                            width: 280px;
                            flex-shrink: 0;
                          }

                          .product-card {
                            border: none;
                            border-radius: 1.25rem;
                            background: white;
                            transition: all 0.3s ease;
                            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                            height: 100%;
                            display: flex;
                            flex-direction: column;
                            overflow: hidden;
                          }

                          .product-card:hover {
                            transform: translateY(-5px);
                            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
                          }

                          .product-image-container {
                            height: 200px;
                            background: #f1f5f9;
                            position: relative;
                            overflow: hidden;
                          }

                          .product-image {
                            width: 100%;
                            height: 100%;
                            object-fit: contain;
                            padding: 1rem;
                            mix-blend-mode: multiply;
                          }

                          .promo-badge {
                            position: absolute;
                            top: 0.75rem;
                            right: 0.75rem;
                            background: #ef4444;
                            color: white;
                            padding: 0.25rem 0.75rem;
                            border-radius: 9999px;
                            font-weight: 700;
                            font-size: 0.75rem;
                            box-shadow: 0 2px 4px rgba(239, 68, 68, 0.3);
                            z-index: 2;
                          }

                          .card-body {
                            padding: 1.25rem;
                            flex-grow: 1;
                            display: flex;
                            flex-direction: column;
                          }

                          .card-title {
                            font-size: 1.125rem;
                            font-weight: 700;
                            color: #1e293b;
                            margin-bottom: 0.5rem;
                            overflow: hidden;
                            text-overflow: ellipsis;
                            white-space: nowrap;
                          }

                          .card-text {
                            font-size: 0.875rem;
                            color: #64748b;
                            margin-bottom: 1.25rem;
                            display: -webkit-box;
                            -webkit-line-clamp: 2;
                            line-clamp: 2;
                            -webkit-box-orient: vertical;
                            overflow: hidden;
                          }

                          /* Price Styling */
                          .price-container {
                            margin-top: auto;
                          }

                          .original-price {
                            display: block;
                            font-size: 0.875rem;
                            color: #94a3b8;
                            text-decoration: line-through;
                            margin-bottom: -0.25rem;
                          }

                          .current-price {
                            font-size: 1.25rem;
                            font-weight: 800;
                            color: #4f46e5;
                          }

                          .current-price.promo {
                            color: #ef4444;
                          }

                          .btn-details {
                            background: #f1f5f9;
                            color: #475569;
                            border: none;
                            border-radius: 0.75rem;
                            padding: 0.5rem 1rem;
                            font-weight: 600;
                            font-size: 0.875rem;
                            transition: all 0.2s;
                          }

                          .btn-details:hover {
                            background: #e2e8f0;
                            color: #1e293b;
                          }

                          /* Modal */
                          .modal-content {
                            border-radius: 1.5rem;
                            border: none;
                          }

                          .modal-header {
                            background: #f8fafc;
                            border-bottom: 1px solid #f1f5f9;
                            padding: 1.5rem;
                          }

                          .modal-image {
                            border-radius: 1rem;
                            background: #f1f5f9;
                            padding: 1rem;
                            max-height: 400px;
                            width: 100%;
                            object-fit: contain;
                          }

                          /* Custom Animations */
                          @keyframes fadeIn {
                            from {
                              opacity: 0;
                              transform: translateY(10px);
                            }

                            to {
                              opacity: 1;
                              transform: translateY(0);
                            }
                          }

                          .animate-fade-in {
                            animation: fadeIn 0.4s ease-out forwards;
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
                          <div class="card filter-card">
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
                                  <select id="categoryFilter" class="form-select border-0 bg-light">
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
                                        data-price="<%= prod.isOnPromotion() ? prod.getDiscountedPrice() : prod.getPrice() %>"
                                        data-category-id="<%= cat.getId() %>">
                                        <div class="product-card">
                                          <div class="product-image-container">
                                            <% if (prod.isOnPromotion()) { double discount=((prod.getPrice() -
                                              prod.getDiscountedPrice()) / prod.getPrice()) * 100; %>
                                              <div class="promo-badge">
                                                -<%= String.format("%.0f", discount) %>%
                                              </div>
                                              <% } %>
                                                <img
                                                  src="<%= (prod.getImagePath() != null && !prod.getImagePath().trim().isEmpty()) ? prod.getImagePath() : "https://via.placeholder.com/300x200?text=No+Image" %>"
                                                alt="<%= safeName %>" class="product-image">
                                          </div>
                                          <div class="card-body">
                                            <h5 class="card-title" title="<%= safeName %>">
                                              <%= prod.getName() %>
                                            </h5>
                                            <p class="card-text">
                                              <%= prod.getDescription() %>
                                            </p>

                                            <div class="mt-auto d-flex justify-content-between align-items-end">
                                              <div class="price-container">
                                                <% if (prod.isOnPromotion()) { %>
                                                  <span class="original-price">
                                                    <%= String.format("%.2f", prod.getPrice()) %>€
                                                  </span>
                                                  <span class="current-price promo">
                                                    <%= String.format("%.2f", prod.getDiscountedPrice()) %>€
                                                  </span>
                                                  <% } else { %>
                                                    <span class="current-price">
                                                      <%= String.format("%.2f", prod.getPrice()) %>€
                                                    </span>
                                                    <% } %>
                                              </div>

                                              <button class="btn btn-details btn-sm" data-id="<%= prod.getId() %>"
                                                data-name="<%= safeName %>"
                                                data-price="<%= prod.isOnPromotion() ? prod.getDiscountedPrice() : prod.getPrice() %>"
                                                data-original-price="<%= prod.getPrice() %>"
                                                data-on-promotion="<%= prod.isOnPromotion() %>"
                                                data-desc="<%= safeDesc %>" data-image="<%= prod.getImagePath() %>"
                                                data-category="<%= cat.getName() %>" onclick="showDetails(this)">
                                                Détails <i class="fas fa-arrow-right ms-1 small"></i>
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

                        <div class="modal fade" id="productModal" tabindex="-1" aria-hidden="true">
                          <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content shadow-lg border-0">
                              <div class="modal-header border-0 pb-0">
                                <h5 class="modal-title fw-bold" id="modalTitle">Produit</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                  aria-label="Close"></button>
                              </div>
                              <div class="modal-body p-4">
                                <div class="row g-4">
                                  <div class="col-md-6">
                                    <div class="p-3 bg-light rounded-4">
                                      <img src="" id="modalImage" class="modal-image" alt="Produit">
                                    </div>
                                  </div>
                                  <div class="col-md-6 d-flex flex-column">
                                    <h2 class="fw-extrabold mb-1" id="modalName"></h2>
                                    <div class="mb-4">
                                      <span id="modalOriginalPrice"
                                        class="text-muted text-decoration-line-through me-2 d-none"></span>
                                      <span id="modalPrice" class="fs-2 fw-bold text-primary"></span>
                                    </div>

                                    <h6 class="text-uppercase text-muted fw-bold small mb-2">Description</h6>
                                    <p class="text-secondary mb-4" id="modalDesc"></p>

                                    <div class="mt-auto border-top pt-4">
                                      <form action="panier" method="post">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="productName" id="inputName">
                                        <input type="hidden" name="productPrice" id="inputPrice">
                                        <input type="hidden" name="description" id="inputDesc">
                                        <input type="hidden" name="category" id="inputCategory">
                                        <input type="hidden" name="imagePath" id="inputImage">

                                        <div class="row g-3 align-items-center mb-4">
                                          <div class="col-auto">
                                            <label class="fw-bold small text-muted">QUANTITÉ</label>
                                          </div>
                                          <div class="col-4">
                                            <div class="input-group input-group-sm">
                                              <input type="number" name="quantity"
                                                class="form-control text-center rounded-3" value="1" min="1" max="10">
                                            </div>
                                          </div>
                                        </div>

                                        <button type="submit"
                                          class="btn btn-primary-custom w-100 text-white rounded-pill py-3">
                                          <i class="fas fa-shopping-cart me-2"></i> Ajouter au panier
                                        </button>
                                      </form>
                                    </div>
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

                            // Handle promotion pricing
                            const isOnPromotion = data.onPromotion === 'true';
                            const modalOriginalPrice = document.getElementById('modalOriginalPrice');
                            const modalPrice = document.getElementById('modalPrice');

                            if (isOnPromotion) {
                              modalOriginalPrice.textContent = parseFloat(data.originalPrice).toFixed(2) + ' €';
                              modalOriginalPrice.classList.remove('d-none');
                              modalPrice.textContent = parseFloat(data.price).toFixed(2) + ' €';
                              modalPrice.classList.add('text-danger');
                              modalPrice.classList.remove('text-primary');
                            } else {
                              modalOriginalPrice.classList.add('d-none');
                              modalPrice.textContent = parseFloat(data.price).toFixed(2) + ' €';
                              modalPrice.classList.add('text-primary');
                              modalPrice.classList.remove('text-danger');
                            }

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
