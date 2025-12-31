package com.example.controller;

import com.example.config.DataSourceConfig;
import com.example.model.Category;
import com.example.model.Product;
import com.example.repository.CategoryRepository;
import com.example.repository.ProductRepository;
import com.example.repository.impl.JdbcCategoryRepository;
import com.example.repository.impl.JdbcProductRepository;
import com.example.service.CategoryService;
import com.example.service.ProductService;
import com.example.service.impl.CategoryServiceImpl;
import com.example.service.impl.ProductServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CategoryController", urlPatterns = { "/categories" })
public class CategoryController extends HttpServlet {

    private CategoryService categoryService;
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        try {
            CategoryRepository catRepo = new JdbcCategoryRepository(DataSourceConfig.getDataSource());
            ProductRepository prodRepo = new JdbcProductRepository(DataSourceConfig.getDataSource());
            this.categoryService = new CategoryServiceImpl(catRepo);
            this.productService = new ProductServiceImpl(prodRepo);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize CategoryController", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories = categoryService.getAllCategories();
        List<Product> allProducts = productService.getAllProducts();

        // Group products by Category ID for easier access in JSP
        // You could also do this logic in JSP with filtered lists, but a Map is cleaner
        // if we use scriptlets or custom tags.
        // However, standard JSTL might find it hard to access Map<Long, List>.
        // Simple approach: Pass both lists and filter in JSP, or distinct attributes.

        request.setAttribute("categories", categories);
        request.setAttribute("products", allProducts);

        request.getRequestDispatcher("/categories.jsp").forward(request, response);
    }
}
