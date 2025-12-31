package com.example.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Product implements Serializable {
  private Long id;
  private String name;
  private double price;
  private String description;
  private String imagePath;
  private Long categoryId; // Foreign key

  // Optional: for display purposes if we join tables, otherwise we fetch
  // separately
  private String categoryName;
  private Timestamp createdAt;

  // Transient fields for promotion display
  private Double discountedPrice;
  private boolean isOnPromotion = false;

  public Product() {
  }

  public Product(String name, double price, String description, Long categoryId, String imagePath) {
    this.name = name;
    this.price = price;
    this.description = description;
    this.categoryId = categoryId;
    this.imagePath = imagePath;
  }

  public Product(Long id, String name, double price, String description, Long categoryId, String imagePath) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.description = description;
    this.categoryId = categoryId;
    this.imagePath = imagePath;
  }

  // Legacy/DTO Constructor for PanierController
  public Product(String name, double price, String description, String categoryName) {
    this.name = name;
    this.price = price;
    this.description = description;
    this.categoryName = categoryName;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public double getPrice() {
    return price;
  }

  public void setPrice(double price) {
    this.price = price;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getImagePath() {
    return imagePath;
  }

  public void setImagePath(String imagePath) {
    this.imagePath = imagePath;
  }

  public Long getCategoryId() {
    return categoryId;
  }

  public void setCategoryId(Long categoryId) {
    this.categoryId = categoryId;
  }

  // Compatibility for legacy JSP code
  public String getCategory() {
    return categoryName;
  }

  public String getCategoryName() {
    return categoryName;
  }

  public void setCategoryName(String categoryName) {
    this.categoryName = categoryName;
  }

  public Timestamp getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(Timestamp createdAt) {
    this.createdAt = createdAt;
  }

  public Double getDiscountedPrice() {
    return discountedPrice;
  }

  public void setDiscountedPrice(Double discountedPrice) {
    this.discountedPrice = discountedPrice;
  }

  public boolean isOnPromotion() {
    return isOnPromotion;
  }

  public void setOnPromotion(boolean onPromotion) {
    isOnPromotion = onPromotion;
  }
}
