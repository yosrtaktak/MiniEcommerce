package com.example.controller;

import com.example.config.DataSourceConfig;
import com.example.model.Product;
import com.example.model.Category;
import com.example.repository.ProductRepository;
import com.example.repository.CategoryRepository;
import com.example.repository.impl.JdbcProductRepository;
import com.example.repository.impl.JdbcCategoryRepository;
import com.example.service.ProductService;
import com.example.service.CategoryService;
import com.example.service.impl.ProductServiceImpl;
import com.example.service.impl.CategoryServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductServlet", urlPatterns = { "/products", "/admin/products" })
public class ProductServlet extends HttpServlet {

    private ProductService productService;
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        try {
            ProductRepository prodRepo = new JdbcProductRepository(DataSourceConfig.getDataSource());
            CategoryRepository catRepo = new JdbcCategoryRepository(DataSourceConfig.getDataSource());

            this.productService = new ProductServiceImpl(prodRepo);
            this.categoryService = new CategoryServiceImpl(catRepo);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize dependencies", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null)
            action = "list";

        try {
            switch (action) {
                case "delete":
                    deleteProduct(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "filter": // Optional: filter by category
                    filterByCategory(request, response);
                    break;
                default:
                    listProducts(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        String imagePath = request.getParameter("imagePath");
        String categoryIdStr = request.getParameter("categoryId");

        Long categoryId = (categoryIdStr != null && !categoryIdStr.isEmpty()) ? Long.parseLong(categoryIdStr) : null;

        Product product = new Product(name, price, description, categoryId, imagePath);

        try {
            if (idStr != null && !idStr.isEmpty()) {
                product.setId(Long.parseLong(idStr));
                productService.updateProduct(product);
            } else {
                productService.createProduct(product);
            }
            response.sendRedirect("products");
        } catch (Exception e) {
            request.setAttribute("error", "Error saving product: " + e.getMessage());
            listProducts(request, response);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryParam = request.getParameter("category");
        List<Product> products;

        if (categoryParam != null && !categoryParam.isEmpty()) {
            try {
                Long categoryId = Long.parseLong(categoryParam);
                products = productService.getProductsByCategory(categoryId);
            } catch (NumberFormatException e) {
                // Invalid category ID, fallback to all products
                products = productService.getAllProducts();
            }
        } else {
            products = productService.getAllProducts();
        }

        List<Category> categories = categoryService.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);

        // Decide view
        if (request.getRequestURI().contains("/admin")) {
            request.getRequestDispatcher("/AdminGestionProduct.jsp").forward(request, response);
        } else {
            // For public view, we usually show categories.jsp or a catalog.
            request.getRequestDispatcher("/categories.jsp").forward(request, response);
        }
    }

    private void filterByCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long catId = Long.parseLong(request.getParameter("categoryId"));
        List<Product> products = productService.getProductsByCategory(catId);
        request.setAttribute("products", products);
        request.setAttribute("categories", categoryService.getAllCategories());
        request.getRequestDispatcher("/categories.jsp").forward(request, response);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        productService.deleteProduct(id);
        response.sendRedirect("products"); // Refresh
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        Product existing = productService.getProductById(id);
        request.setAttribute("product", existing);
        request.setAttribute("categories", categoryService.getAllCategories());
        request.getRequestDispatcher("/AdminGestionProduct.jsp").forward(request, response);
    }
}
