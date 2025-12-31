<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // Récupération des infos de session
  String adminFullname = (String) session.getAttribute("fullname");
  String adminRole = (String) session.getAttribute("role");

  // Vérifier que l'utilisateur est bien admin
  if (adminRole == null || !adminRole.equalsIgnoreCase("admin")) {
    response.sendRedirect("/error.jsp");
    return;
  }
%>

<nav class="navbar navbar-expand-lg navbar-light bg-light p-3 mb-4 shadow-sm">
            <div class="container-fluid">
                <a class="navbar-brand" href="/admin/categories">
                    <b>AdminPanel</b>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="adminNavbar">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" href="/home"><b>Home</b></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <%= request.getRequestURI().contains(" categories") ? "active" : "" %>"
                                href="/admin/categories">Catégories</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <%= request.getRequestURI().contains(" products") ||
                                request.getRequestURI().contains("Product") ? "active" : "" %>"
                                href="/admin/products">Produits</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <%= request.getRequestURI().contains(" promotion") ? "active" : "" %>"
                                href="/admin/promotions">Promotions</a>
                        </li>
                    </ul>
                    <div class="d-flex align-items-center">
                        <span class="navbar-text me-3">
                            <% if (adminFullname !=null) { %>
                                <b>
                                    <%= adminFullname %>
                                </b>
                                <span class="badge bg-danger ms-2">
                                    <%= adminRole !=null ? adminRole.toUpperCase() : "ADMIN" %>
                                </span>
                                <% } else { %>
                                    <b>Admin</b>
                                    <% } %>
                        </span>
                        <form action="/logout" method="post" class="m-0">
                            <button type="submit" class="btn btn-outline-danger btn-sm">Déconnexion</button>
                        </form>
                    </div>
                </div>
            </div>
        </nav>

        <style>
            /* Amélioration globale du style pour l'admin */
            body {
                background-color: #f8f9fa;
            }

            .card {
                border: none;
                box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
                transition: transform 0.2s ease-in-out;
            }

            .card-header {
                background-color: #fff;
                border-bottom: 1px solid rgba(0, 0, 0, .05);
                font-weight: 600;
                color: #495057;
            }

            .navbar-brand span {
                color: #0d6efd !important;
            }

            /* Hover effect on cards */
            .hover-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            }
        </style>
