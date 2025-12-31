<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <% String fullname=(String) session.getAttribute("fullname"); String role=(String) session.getAttribute("role"); %>

    <nav class="navbar navbar-expand-lg navbar-light bg-light p-3 mb-4 shadow-sm">
      <div class="container-fluid">
        <a class="navbar-brand" href="/categories">
          <b>TechStore</b>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav me-auto">
            <li class="nav-item">
              <a class="nav-link" href="/home"><b>Home</b></a>
            </li>
            <% if (role !=null && role.equalsIgnoreCase("client")) { %>
            <li class="nav-item">
              <a class="nav-link" href="/categories">Catégories</a>
            </li>

            <li class="nav-item">
              <a class="nav-link" href="/cart.jsp">Panier</a>
            </li>
            <% } %>
            <% if (role !=null && role.equalsIgnoreCase("admin")) { %>
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle text-danger" href="#" id="adminDropdown" role="button"
                  data-bs-toggle="dropdown">
                  <b>Administration</b>
                </a>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="/admin/categories">Gérer Catégories</a></li>
                  <li><a class="dropdown-item" href="/admin/products">Gérer Produits</a></li>
                  <li><a class="dropdown-item" href="/admin/promotions">Gérer Promotions</a></li>
                </ul>
              </li>
              <% } %>
          </ul>

          <span class="navbar-text">
            <% if (fullname !=null) { %>
              <span class="me-2">Bonjour, <b>
                  <%= fullname %>
                </b></span>
              <% if (role !=null) { %>
                <span class="badge bg-<%= role.equalsIgnoreCase(" admin") ? "danger" : "secondary" %>">
                  <%= role.toUpperCase() %>
                </span>
                <% } %>
                  <form action="logout" method="post" class="d-inline ms-2">
                    <button type="submit" class="btn btn-outline-danger btn-sm">Déconnexion</button>
                  </form>
                  <% } else { %>
                    <a href="/index.jsp" class="btn btn-primary-custom text-white btn-sm px-3">Se connecter</a>
                    <% } %>
          </span>
        </div>
      </div>
    </nav>
