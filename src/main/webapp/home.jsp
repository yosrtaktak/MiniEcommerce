<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Accueil - TechStore</title>
        <!-- Bootstrap & Google Fonts -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
        <!-- Font Awesome for Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>

    <body>

        <%@include file="shared/navbar/navbar.jsp" %>

            <% if (role !=null && role.equalsIgnoreCase("admin")) { %>
                <!-- ADMIN DASHBOARD -->
                <section class="container py-5 animate-fade-in">
                    <div class="text-center mb-5">
                        <h1 class="display-4 fw-bold text-primary mb-3">Tableau de Bord Administrateur</h1>
                        <p class="lead text-muted">Gérez les catégories, produits et promotions de votre boutique.</p>
                    </div>

                    <div class="row g-4 justify-content-center">
                        <!-- Categories -->
                        <div class="col-md-4">
                            <div class="custom-card p-4 text-center h-100 border-0 shadow-sm">
                                <div class="icon-box bg-light text-primary rounded-circle mx-auto mb-4 d-flex align-items-center justify-content-center"
                                    style="width: 80px; height: 80px;">
                                    <i class="fas fa-tags fa-2x"></i>
                                </div>
                                <h3 class="fw-bold mb-3">Catégories</h3>
                                <p class="text-muted mb-4">Ajoutez, modifiez ou supprimez des catégories de produits.
                                </p>
                                <a href="/admin/categories" class="btn btn-primary-custom text-white w-100">Gérer les
                                    Catégories</a>
                            </div>
                        </div>

                        <!-- Products -->
                        <div class="col-md-4">
                            <div class="custom-card p-4 text-center h-100 border-0 shadow-sm">
                                <div class="icon-box bg-light text-success rounded-circle mx-auto mb-4 d-flex align-items-center justify-content-center"
                                    style="width: 80px; height: 80px;">
                                    <i class="fas fa-boxes fa-2x"></i>
                                </div>
                                <h3 class="fw-bold mb-3">Produits</h3>
                                <p class="text-muted mb-4">Gérez le catalogue produits, les prix et les stocks.</p>
                                <a href="/admin/products" class="btn btn-primary-custom text-white w-100">Gérer les
                                    Produits</a>
                            </div>
                        </div>

                        <!-- Promotions -->
                        <div class="col-md-4">
                            <div class="custom-card p-4 text-center h-100 border-0 shadow-sm">
                                <div class="icon-box bg-light text-danger rounded-circle mx-auto mb-4 d-flex align-items-center justify-content-center"
                                    style="width: 80px; height: 80px;">
                                    <i class="fas fa-percent fa-2x"></i>
                                </div>
                                <h3 class="fw-bold mb-3">Promotions</h3>
                                <p class="text-muted mb-4">Créez et gérez les offres spéciales et réductions.</p>
                                <a href="/admin/promotions" class="btn btn-primary-custom text-white w-100">Gérer les
                                    Promotions</a>
                            </div>
                        </div>
                    </div>
                </section>
                <% } else { %>
                    <!-- CLIENT HERO SECTION -->
                    <section class="hero-section text-center animate-fade-in">
                        <div class="container">
                            <h1 class="hero-title">Bienvenue sur TechStore</h1>
                            <p class="hero-subtitle">Découvrez les meilleures technologies au meilleur prix.</p>
                            <a href="categories"
                                class="btn btn-light btn-lg rounded-pill px-5 py-3 fw-bold text-primary shadow">
                                <i class="fas fa-shopping-cart me-2"></i> Commencer mes achats
                            </a>
                        </div>
                    </section>

                    <!-- Features Section -->
                    <section class="container my-5">
                        <div class="row g-4">
                            <div class="col-md-4">
                                <div class="custom-card p-4 text-center h-100">
                                    <div class="mb-3 text-primary">
                                        <i class="fas fa-rocket fa-3x"></i>
                                    </div>
                                    <h3>Livraison Rapide</h3>
                                    <p class="text-muted">Recevez vos produits en un temps record partout dans le monde.
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="custom-card p-4 text-center h-100">
                                    <div class="mb-3 text-secondary">
                                        <i class="fas fa-shield-alt fa-3x"></i>
                                    </div>
                                    <h3>Paiement Sécurisé</h3>
                                    <p class="text-muted">Vos transactions sont protégées avec les meilleurs standards
                                        de
                                        sécurité.</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="custom-card p-4 text-center h-100">
                                    <div class="mb-3 text-success">
                                        <i class="fas fa-headset fa-3x"></i>
                                    </div>
                                    <h3>Support 24/7</h3>
                                    <p class="text-muted">Une équipe dédiée pour répondre à toutes vos questions à tout
                                        moment.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- CTA Section -->
                    <section class="container my-5">
                        <div class="row align-items-center bg-white rounded-5 shadow overflow-hidden p-5">
                            <div class="col-md-6 mb-4 mb-md-0">
                                <h2 class="fw-bold mb-3">Prêt à passer au niveau supérieur ?</h2>
                                <p class="lead text-muted mb-4">Rejoignez des milliers de clients satisfaits et profitez
                                    de nos
                                    offres exclusives.</p>
                                <a href="categories" class="btn btn-primary-custom text-white text-decoration-none">
                                    Voir toutes les catégories
                                </a>
                            </div>
                            <div class="col-md-6 text-center">
                                <img src="assets/img/tech-illustration.png"
                                    onerror="this.src='https://via.placeholder.com/400x300?text=Tech+Illustration'"
                                    alt="Tech" class="img-fluid rounded-3">
                            </div>
                        </div>
                    </section>
                    <% } %>

                        <!-- Footer -->
                        <footer class="text-center">
                            <div class="container">
                                <p>&copy; 2025 TechStore. Tous droits réservés.</p>
                                <div>
                                    <a href="#" class="text-light me-3"><i class="fab fa-facebook fa-lg"></i></a>
                                    <a href="#" class="text-light me-3"><i class="fab fa-twitter fa-lg"></i></a>
                                    <a href="#" class="text-light"><i class="fab fa-instagram fa-lg"></i></a>
                                </div>
                            </div>
                        </footer>

                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>