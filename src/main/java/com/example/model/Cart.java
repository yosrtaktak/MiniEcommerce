package com.example.model;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class Cart {

  private Map<String, CartItem> items = new HashMap<>();

  public void addProduct(Product product, int qty) {
    String key = product.getName();

    if (items.containsKey(key)) {
      CartItem item = items.get(key);
      item.setQuantity(item.getQuantity() + qty);
    } else {
      items.put(key, new CartItem(product, qty));
    }
  }

  public void removeProduct(String productName) {
    items.remove(productName);
  }

  public Collection<CartItem> getItems() {
    return items.values();
  }

  public double getTotal() {
    double total = 0;
    for (CartItem item : items.values()) {
      total += item.getTotalPrice();
    }
    return total;
  }

  public boolean isEmpty() {
    return items.isEmpty();
  }
}
