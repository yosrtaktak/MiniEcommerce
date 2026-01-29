package com.example.security.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Filtre d'authentification global pour sécuriser tous les endpoints de
 * l'application.
 * 
 * - Les pages publiques (login, index, ressources statiques) sont accessibles
 * sans authentification
 * - Les pages client nécessitent une authentification (CLIENT ou ADMIN)
 * - Les pages admin nécessitent le rôle ADMIN
 */
@WebFilter(urlPatterns = { "/*" })
public class AuthFilter implements Filter {

    // Pages publiques qui ne nécessitent pas d'authentification
    private static final Set<String> PUBLIC_PAGES = new HashSet<>(Arrays.asList(
            "/index.jsp",
            "/login.jsp",
            "/login",
            "/logout",
            "/error.jsp"));

    // Extensions de ressources statiques à exclure
    private static final Set<String> STATIC_EXTENSIONS = new HashSet<>(Arrays.asList(
            ".css", ".js", ".png", ".jpg", ".jpeg", ".gif", ".ico", ".svg", ".woff", ".woff2", ".ttf", ".eot"));

    // Pages/URLs réservées aux administrateurs
    private static final Set<String> ADMIN_PAGES = new HashSet<>(Arrays.asList(
            "/admin/categories",
            "/admin/products",
            "/admin/promotions",
            "/promotions",
            "/AdminGestionCategory.jsp",
            "/AdminGestionProduct.jsp",
            "/adminPromotion.jsp"));

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation si nécessaire
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        // Enlever le context path pour avoir le chemin relatif
        String path = uri.substring(contextPath.length());

        // Si le chemin est vide, c'est la racine
        if (path.isEmpty()) {
            path = "/";
        }

        // 1. Autoriser les ressources statiques (CSS, JS, images, etc.)
        if (isStaticResource(path)) {
            filterChain.doFilter(request, response);
            return;
        }

        // 2. Autoriser les pages publiques (login, index, etc.)
        if (isPublicPage(path)) {
            filterChain.doFilter(request, response);
            return;
        }

        // 3. Vérifier l'authentification pour toutes les autres pages
        HttpSession session = req.getSession(false);
        String fullname = (session != null) ? (String) session.getAttribute("fullname") : null;
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        // Si l'utilisateur n'est pas connecté, rediriger vers la page de connexion
        if (fullname == null || fullname.isEmpty()) {
            resp.sendRedirect(contextPath + "/index.jsp");
            return;
        }

        // 4. Pour les pages admin, vérifier le rôle ADMIN
        if (isAdminPage(path)) {
            if (!"ADMIN".equalsIgnoreCase(role)) {
                // L'utilisateur n'est pas admin, rediriger vers la page d'accueil client
                resp.sendRedirect(contextPath + "/home");
                return;
            }
        }

        // 5. L'utilisateur est authentifié et autorisé, continuer
        filterChain.doFilter(request, response);
    }

    /**
     * Vérifie si le chemin correspond à une ressource statique
     */
    private boolean isStaticResource(String path) {
        if (path == null)
            return false;

        // Vérifier les dossiers de ressources statiques
        if (path.startsWith("/css/") || path.startsWith("/js/") ||
                path.startsWith("/images/") || path.startsWith("/fonts/") ||
                path.startsWith("/assets/") || path.startsWith("/uploads/")) {
            return true;
        }

        // Vérifier les extensions de fichiers statiques
        String lowerPath = path.toLowerCase();
        for (String ext : STATIC_EXTENSIONS) {
            if (lowerPath.endsWith(ext)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Vérifie si le chemin correspond à une page publique
     */
    private boolean isPublicPage(String path) {
        if (path == null)
            return false;

        // La racine redirige vers index.jsp
        if ("/".equals(path)) {
            return true;
        }

        return PUBLIC_PAGES.contains(path);
    }

    /**
     * Vérifie si le chemin correspond à une page admin
     */
    private boolean isAdminPage(String path) {
        if (path == null)
            return false;

        // Toutes les URLs commençant par /admin/ sont des pages admin
        if (path.startsWith("/admin/")) {
            return true;
        }

        // Vérifier les pages admin spécifiques
        return ADMIN_PAGES.contains(path);
    }

    @Override
    public void destroy() {
        // Nettoyage si nécessaire
    }
}
