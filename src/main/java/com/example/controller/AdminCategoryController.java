package com.example.controller;

import com.example.config.DataSourceConfig;
import com.example.model.Category;
import com.example.repository.CategoryRepository;
import com.example.repository.impl.JdbcCategoryRepository;
import com.example.service.CategoryService;
import com.example.service.impl.CategoryServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet acting as the Controller for Category operations.
 * Handles HTTP requests, invokes the Service layer, and forwards to JSP view.
 */
@WebServlet(name = "AdminCategoryController", urlPatterns = { "/categories", "/admin/categories" })
public class AdminCategoryController extends HttpServlet {

    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        // Manual Dependency Injection (Composition Root)
        // In Spring, this would be handled by @Autowired
        try {
            CategoryRepository repository = new JdbcCategoryRepository(DataSourceConfig.getDataSource());
            this.categoryService = new CategoryServiceImpl(repository);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize dependencies", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null || !session.getAttribute("role").equals("ADMIN")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null)
            action = "list";

        try {
            switch (action) {
                case "delete":
                    deleteCategory(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                default:
                    listCategories(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null || !session.getAttribute("role").equals("ADMIN")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Should probably not happen for POST but fallback
        }

        try {
            switch (action) {
                case "add":
                    createCategory(request, response);
                    break;
                case "update":
                    updateCategory(request, response);
                    break;
                case "delete":
                    deleteCategory(request, response);
                    break;
                default:
                    listCategories(request, response);
            }
        } catch (Exception e) {
            // Keep the user on the page and show error
            request.setAttribute("error", "Erreur: " + e.getMessage());
            listCategories(request, response);
        }
    }

    private void createCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        Category category = new Category(name, description);
        categoryService.createCategory(category);
        response.sendRedirect("categories?message=Categorie ajoutee avec succes");
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        Category category = new Category(id, name, description);
        categoryService.updateCategory(category);
        response.sendRedirect("categories?message=Categorie mise a jour avec succes");
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);

        // Determine view based on URL or role (simplification for this task)
        // If the URL contains "admin", we might show a different view or the same view
        // with admin controls
        request.getRequestDispatcher("/AdminGestionCategory.jsp").forward(request, response);
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        categoryService.deleteCategory(id);
        response.sendRedirect("categories?message=Categorie supprimee avec succes");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Category existingCategory = categoryService.getCategoryById(id);
        request.setAttribute("category", existingCategory);
        request.setAttribute("categories", categoryService.getAllCategories()); // Refresh list
        request.getRequestDispatcher("/AdminGestionCategory.jsp").forward(request, response);
    }
}
