<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.example.model.Cart" %>
        <%@ page import="com.example.model.CartItem" %>
            <%@ page import="java.util.Collection" %>

                <% Cart cart=(Cart) session.getAttribute("cart"); if (cart==null) { cart=new Cart();
                    session.setAttribute("cart", cart); } %>

                    <!DOCTYPE html>
                    <!DOCTYPE html>
                    <html lang="fr">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Votre Panier - TechStore</title>
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                            rel="stylesheet">
                        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap"
                            rel="stylesheet">
                        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                            rel="stylesheet">
                        <link rel="stylesheet" href="css/style.css">
                    </head>

                    <body class="bg-light">

                        <%@include file="shared/navbar/navbar.jsp" %>

                            <div class="container py-5 animate-fade-in">
                                <h1 class="fw-bold mb-4 display-6">Votre Panier</h1>

                                <% if (cart.isEmpty()) { %>
                                    <div class="text-center py-5">
                                        <div class="mb-4">
                                            <i class="fas fa-shopping-cart fa-4x text-muted opacity-25"></i>
                                        </div>
                                        <h3 class="text-muted">Votre panier est vide</h3>
                                        <p class="text-muted mb-4">Il semble que vous n'ayez pas encore ajouté de
                                            produits.</p>
                                        <a href="categories" class="btn btn-primary-custom text-white px-4">
                                            Commencer mes achats
                                        </a>
                                    </div>
                                    <% } else { %>
                                        <div class="row g-4">
                                            <!-- Liste des produis -->
                                            <div class="col-lg-8">
                                                <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                                                    <div class="card-body p-0">
                                                        <div class="table-responsive">
                                                            <table class="table table-hover align-middle mb-0">
                                                                <thead class="bg-light text-muted small text-uppercase">
                                                                    <tr>
                                                                        <th class="ps-4 py-3">Produit</th>
                                                                        <th class="py-3">Prix</th>
                                                                        <th class="py-3">Quantité</th>
                                                                        <th class="py-3">Total</th>
                                                                        <th class="pe-4 py-3 text-end">Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <% for (CartItem item : cart.getItems()) { %>
                                                                        <tr>
                                                                            <td class="ps-4 py-3">
                                                                                <div class="d-flex align-items-center">
                                                                                    <% if
                                                                                        (item.getProduct().getImagePath()
                                                                                        !=null &&
                                                                                        !item.getProduct().getImagePath().isEmpty())
                                                                                        { %>
                                                                                        <img src="<%= item.getProduct().getImagePath() %>"
                                                                                            class="rounded-3 shadow-sm me-3 bg-white border"
                                                                                            style="width: 60px; height: 60px; object-fit: contain; padding: 5px;">
                                                                                        <% } else { %>
                                                                                            <div class="rounded-3 me-3 bg-light d-flex align-items-center justify-content-center text-muted"
                                                                                                style="width: 60px; height: 60px;">
                                                                                                <i
                                                                                                    class="fas fa-image"></i>
                                                                                            </div>
                                                                                            <% } %>
                                                                                                <div>
                                                                                                    <h6
                                                                                                        class="mb-0 fw-bold">
                                                                                                        <%= item.getProduct().getName()
                                                                                                            %>
                                                                                                    </h6>
                                                                                                    <small
                                                                                                        class="text-muted text-truncate d-block"
                                                                                                        style="max-width: 200px;">
                                                                                                        <%= item.getProduct().getDescription()
                                                                                                            %>
                                                                                                    </small>
                                                                                                </div>
                                                                                </div>
                                                                            </td>
                                                                            <td class="fw-semibold text-muted">
                                                                                <%= String.format("%.2f",
                                                                                    item.getProduct().getPrice()) %> €
                                                                            </td>
                                                                            <td>
                                                                                <span
                                                                                    class="badge bg-light text-dark border px-3 py-2 rounded-pill">x
                                                                                    <%= item.getQuantity() %></span>
                                                                            </td>
                                                                            <td class="fw-bold text-primary">
                                                                                <%= String.format("%.2f",
                                                                                    item.getTotalPrice()) %> €
                                                                            </td>
                                                                            <td class="pe-4 text-end">
                                                                                <form action="panier" method="post"
                                                                                    class="d-inline">
                                                                                    <input type="hidden" name="action"
                                                                                        value="remove">
                                                                                    <input type="hidden"
                                                                                        name="productName"
                                                                                        value="<%= item.getProduct().getName() %>">
                                                                                    <button type="submit"
                                                                                        class="btn btn-outline-danger btn-sm rounded-circle p-2"
                                                                                        title="Retirer">
                                                                                        <i class="fas fa-trash-alt"></i>
                                                                                    </button>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                        <% } %>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="mt-4">
                                                    <a href="categories"
                                                        class="btn btn-link text-decoration-none text-muted">
                                                        <i class="fas fa-arrow-left me-2"></i>Continuer mes achats
                                                    </a>
                                                </div>
                                            </div>

                                            <!-- Résumé -->
                                            <div class="col-lg-4">
                                                <div class="card border-0 shadow-sm rounded-4">
                                                    <div class="card-body p-4">
                                                        <h4 class="card-title fw-bold mb-4">Résumé</h4>
                                                        <div class="d-flex justify-content-between mb-3 text-muted">
                                                            <span>Sous-total</span>
                                                            <span>
                                                                <%= String.format("%.2f", cart.getTotal()) %> €
                                                            </span>
                                                        </div>
                                                        <div class="d-flex justify-content-between mb-3 text-muted">
                                                            <span>Livraison</span>
                                                            <span class="text-success">Gratuit</span>
                                                        </div>
                                                        <hr>
                                                        <div class="d-flex justify-content-between mb-4">
                                                            <span class="h5 fw-bold">Total</span>
                                                            <span class="h5 fw-bold text-primary">
                                                                <%= String.format("%.2f", cart.getTotal()) %> €
                                                            </span>
                                                        </div>

                                                        <button type="button"
                                                            class="btn btn-primary-custom w-100 text-white py-3 shadow"
                                                            onclick="alert('Fonctionnalité de paiement à implémenter !')">
                                                            Procéder au paiement <i class="fas fa-arrow-right ms-2"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <% } %>
                            </div>

                            <script
                                src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                    </body>

                    </html>