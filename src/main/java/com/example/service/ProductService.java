package com.example.service;

import com.example.model.Product;
import java.util.List;

public interface ProductService {
    List<Product> getAllProducts();

    Product getProductById(Long id);

    List<Product> getProductsByCategory(Long categoryId);

    void createProduct(Product product);

    void updateProduct(Product product);

    void deleteProduct(Long id);
}
