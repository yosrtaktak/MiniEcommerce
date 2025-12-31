<!DOCTYPE html>
<html lang="fr">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Connexion - TechStore</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>

<body>

  <div class="login-container animate-fade-in">
    <div class="login-card">
      <div class="text-center mb-4">
        <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
          style="width: 60px; height: 60px;">
          <i class="fas fa-user-lock fa-2x"></i>
        </div>
        <h2 class="fw-bold">Bon retour !</h2>
        <p class="text-muted">Connectez-vous pour accéder à votre espace.</p>
      </div>

      <form action="/login" method="post">
        <% String message=request.getParameter("message"); %>
          <% if(message !=null) { %>
            <div class="alert alert-danger py-2 text-center" role="alert">
              <small>
                <%= message %>
              </small>
            </div>
            <% } %>

              <div class="mb-3">
                <label for="uname" class="form-label fw-semibold">Nom d'utilisateur</label>
                <div class="input-group">
                  <span class="input-group-text bg-light border-end-0"><i class="fas fa-user text-muted"></i></span>
                  <input type="text" class="form-control border-start-0 ps-0 bg-light" id="uname" name="uname"
                    placeholder="Entrez votre nom" required>
                </div>
              </div>

              <div class="mb-4">
                <label for="psw" class="form-label fw-semibold">Mot de passe</label>
                <div class="input-group">
                  <span class="input-group-text bg-light border-end-0"><i class="fas fa-lock text-muted"></i></span>
                  <input type="password" class="form-control border-start-0 ps-0 bg-light" id="psw" name="psw"
                    placeholder="Entrez votre mot de passe" required>
                </div>
              </div>

              <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="form-check">
                  <input type="checkbox" class="form-check-input" id="remember" name="remember" checked>
                  <label class="form-check-label text-muted small" for="remember">Se souvenir de moi</label>
                </div>
                <a href="#" class="text-decoration-none small text-primary fw-semibold">Mot de passe oublié ?</a>
              </div>

              <button type="submit" class="btn btn-primary-custom w-100 text-white py-2 mb-3">
                Se connecter
              </button>
      </form>

      <div class="text-center text-muted small mt-4">
        Pas encore de compte ? <a href="#" class="text-primary fw-bold text-decoration-none">S'inscrire</a>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>