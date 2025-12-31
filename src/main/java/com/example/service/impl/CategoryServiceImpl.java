package com.example.service.impl;

import com.example.model.Category;
import com.example.repository.CategoryRepository;
import com.example.service.CategoryService;

import java.util.List;

/**
 * Implementation of CategoryService.
 * Contains business logic and delegates data access to the repository.
 */
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;

    // Constructor Injection (easier for testing and migration to Spring)
    public CategoryServiceImpl(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @Override
    public List<Category> getAllCategories() {
        return categoryRepository.findAll();
    }

    @Override
    public Category getCategoryById(Long id) {
        return categoryRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Category not found with ID: " + id));
    }

    @Override
    public void createCategory(Category category) {
        // Business logic: Validate name
        if (category.getName() == null || category.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Category name cannot be empty");
        }
        categoryRepository.save(category);
    }

    @Override
    public void updateCategory(Category category) {
        if (category.getId() == null) {
            throw new IllegalArgumentException("Cannot update category without ID");
        }
        categoryRepository.update(category);
    }

    @Override
    public void deleteCategory(Long id) {
        categoryRepository.deleteById(id);
    }
}
