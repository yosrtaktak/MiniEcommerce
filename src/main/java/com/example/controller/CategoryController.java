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
import com.example.service.impl.PromotionServiceImpl;
import com.example.model.Promotion;
import com.example.repository.PromotionRepository;
import com.example.repository.impl.JdbcPromotionRepository;
import com.example.service.PromotionService;

import java.sql.Timestamp;

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
  private PromotionService promotionService;

  @Override
  public void init() throws ServletException {
    try {
      CategoryRepository catRepo = new JdbcCategoryRepository(DataSourceConfig.getDataSource());
      ProductRepository prodRepo = new JdbcProductRepository(DataSourceConfig.getDataSource());
      PromotionRepository promoRepo = new JdbcPromotionRepository(DataSourceConfig.getDataSource());

      this.categoryService = new CategoryServiceImpl(catRepo);
      this.productService = new ProductServiceImpl(prodRepo);
      this.promotionService = new PromotionServiceImpl(promoRepo);
    } catch (Exception e) {
      throw new ServletException("Failed to initialize CategoryController", e);
    }
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    List<Category> categories = categoryService.getAllCategories();
    List<Product> allProducts = productService.getAllProducts();
    List<Promotion> promotions = promotionService.getAllPromotions();

    // Calculate Promotions
    Timestamp now = new Timestamp(System.currentTimeMillis());

    for (Product prod : allProducts) {
      // Réinitialiser les valeurs de promotion
      prod.setDiscountedPrice(null);
      prod.setOnPromotion(false);

      double newPrice = prod.getPrice();
      boolean hasPromotion = false;

      for (Promotion promo : promotions) {
        // Vérifier si la promotion est active (inclut les dates limites)
        if (!now.before(promo.getStartDate()) && !now.after(promo.getEndDate())) {
          boolean applies = false;

          // Vérifier si la promotion s'applique au produit spécifique
          if (promo.getProductId() != null && promo.getProductId().equals(prod.getId())) {
            applies = true;
          }
          // Vérifier si la promotion s'applique à la catégorie
          else if (promo.getCategoryId() != null &&
            promo.getCategoryId().equals(prod.getCategoryId())) {
            applies = true;
          }

          if (applies) {
            double discount = promo.getValue();
            String promoType = promo.getType().toLowerCase();

            // Support pour les types en français ET en anglais
            if (promoType.equals("percentage") || promoType.equals("pourcentage")) {
              newPrice = newPrice * (1 - discount / 100.0);
            } else if (promoType.equals("fixed") || promoType.equals("fixe")) {
              newPrice = newPrice - discount;
            }

            // S'assurer que le prix ne soit pas négatif
            if (newPrice < 0) {
              newPrice = 0;
            }

            hasPromotion = true;
          }
        }
      }

      // Appliquer les modifications
      if (hasPromotion) {
        prod.setDiscountedPrice(newPrice);
        prod.setOnPromotion(true);
      }
    }

    request.setAttribute("categories", categories);
    request.setAttribute("products", allProducts);
    request.getRequestDispatcher("/categories.jsp").forward(request, response);
  }
}
