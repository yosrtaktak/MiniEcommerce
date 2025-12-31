package com.example.service;

import com.example.model.Category;
import java.util.List;

/**
 * Service interface for Category business logic.
 * Decouples controller from data access.
 */
public interface CategoryService {
  List<Category> getAllCategories();

  Category getCategoryById(Long id);

  void createCategory(Category category);

  void updateCategory(Category category);

  void deleteCategory(Long id);
}
