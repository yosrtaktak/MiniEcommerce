package com.example.repository;

import com.example.model.Product;
import java.util.List;
import java.util.Optional;

public interface ProductRepository {
  List<Product> findAll();

  Optional<Product> findById(Long id);

  List<Product> findByCategoryId(Long categoryId);

  Product save(Product product);

  void update(Product product);

  void deleteById(Long id);
}
