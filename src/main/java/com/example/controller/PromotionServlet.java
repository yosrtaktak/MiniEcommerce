package com.example.controller;

import com.example.config.DataSourceConfig;
import com.example.model.Promotion;
import com.example.model.Product;
import com.example.model.Category;
import com.example.repository.PromotionRepository;
import com.example.repository.ProductRepository;
import com.example.repository.CategoryRepository;
import com.example.repository.impl.JdbcPromotionRepository;
import com.example.repository.impl.JdbcProductRepository;
import com.example.repository.impl.JdbcCategoryRepository;
import com.example.service.PromotionService;
import com.example.service.ProductService;
import com.example.service.CategoryService;
import com.example.service.impl.PromotionServiceImpl;
import com.example.service.impl.ProductServiceImpl;
import com.example.service.impl.CategoryServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet(name = "PromotionServlet", urlPatterns = { "/promotions", "/admin/promotions" })
public class PromotionServlet extends HttpServlet {

    private PromotionService promotionService;
    private ProductService productService;
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        try {
            PromotionRepository promoRepo = new JdbcPromotionRepository(DataSourceConfig.getDataSource());
            ProductRepository prodRepo = new JdbcProductRepository(DataSourceConfig.getDataSource());
            CategoryRepository catRepo = new JdbcCategoryRepository(DataSourceConfig.getDataSource());

            this.promotionService = new PromotionServiceImpl(promoRepo);
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
            if ("delete".equals(action)) {
                deletePromotion(request, response);
            } else if ("edit".equals(action)) {
                showEditForm(request, response);
            } else {
                listPromotions(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Collect data
        String idStr = request.getParameter("id");
        String title = request.getParameter("title");
        String type = request.getParameter("type");
        double value = Double.parseDouble(request.getParameter("value"));
        String desc = request.getParameter("description");

        // Dates (Simplification: using string fallback or java.sql.Timestamp.valueOf)
        // Format from HTML 'datetime-local' is 'yyyy-MM-ddTHH:mm', need to append ':00'
        // for Timestamp
        // Dates come from <input type="date"> which returns 'yyyy-MM-dd'
        String startStr = request.getParameter("startDate");
        String endStr = request.getParameter("endDate");

        Timestamp startDate = null;
        if (startStr != null && !startStr.isEmpty()) {
            // Append time to make it valid Timestamp format: yyyy-mm-dd hh:mm:ss
            startDate = Timestamp.valueOf(startStr + " 00:00:00");
        }

        Timestamp endDate = null;
        if (endStr != null && !endStr.isEmpty()) {
            endDate = Timestamp.valueOf(endStr + " 23:59:59");
        }

        // Parse IDs (safe parsing)
        Long prodId = parseLong(request.getParameter("productId"));
        Long catId = parseLong(request.getParameter("categoryId"));

        Promotion p = new Promotion(title, type, value, desc, startDate, endDate);
        p.setProductId(prodId);
        p.setCategoryId(catId);

        try {
            if (idStr != null && !idStr.isEmpty()) {
                p.setId(Long.parseLong(idStr));
                promotionService.updatePromotion(p);
            } else {
                promotionService.createPromotion(p);
            }
            response.sendRedirect("promotions");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            listPromotions(request, response);
        }
    }

    private void listPromotions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("promotions", promotionService.getAllPromotions());
        request.setAttribute("products", productService.getAllProducts());
        request.setAttribute("categories", categoryService.getAllCategories());
        request.getRequestDispatcher("/adminPromotion.jsp").forward(request, response);
    }

    private void deletePromotion(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        promotionService.deletePromotion(id);
        response.sendRedirect("promotions");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        request.setAttribute("promotion", promotionService.getPromotionById(id));
        listPromotions(request, response); // Reuse list view but with 'promotion' set for edition
    }

    private Long parseLong(String val) {
        if (val == null || val.isEmpty())
            return null;
        return Long.parseLong(val);
    }
}
