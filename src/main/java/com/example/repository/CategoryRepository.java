package com.example.repository;

import com.example.model.Category;
import java.util.List;
import java.util.Optional;

/**
 * Repository interface for Category entity operations.
 * Follows the Repository pattern to abstract data access.
 */
public interface CategoryRepository {
  List<Category> findAll();

  Optional<Category> findById(Long id);

  Category save(Category category);

  void update(Category category);

  void deleteById(Long id);
}
