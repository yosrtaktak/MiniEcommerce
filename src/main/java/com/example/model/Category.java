package com.example.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Domain entity representing a product category.
 */
public class Category implements Serializable {

  private Long id;
  private String name;
  private String description;
  private Timestamp createdAt;

  public Category() {
  }

  public Category(Long id, String name, String description) {
    this.id = id;
    this.name = name;
    this.description = description;
  }

  public Category(String name, String description) {
    this.name = name;
    this.description = description;
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

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public Timestamp getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(Timestamp createdAt) {
    this.createdAt = createdAt;
  }

  @Override
  public String toString() {
    return "Category{id=" + id + ", name='" + name + "', description='" + description + "'}";
  }
}
