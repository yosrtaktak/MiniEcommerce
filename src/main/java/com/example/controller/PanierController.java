package com.example.controller;

import com.example.model.Cart;
import com.example.model.Product;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/panier")
public class PanierController extends HttpServlet {

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws IOException {

    HttpSession session = request.getSession();

    // Sécurité : uniquement CLIENT ou ADMIN
    String role = (String) session.getAttribute("role");
    if (role == null || (!"CLIENT".equalsIgnoreCase(role) && !"ADMIN".equalsIgnoreCase(role))) {
      response.sendRedirect("login.jsp");
      return;
    }

    String action = request.getParameter("action");

    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null) {
      cart = new Cart();
    }

    if ("add".equals(action)) {

      String name = request.getParameter("productName");
      String priceStr = request.getParameter("productPrice");
      double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;
      String description = request.getParameter("description");
      String category = request.getParameter("category");
      String imagePath = request.getParameter("imagePath");

      String quantityStr = request.getParameter("quantity");
      int quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Integer.parseInt(quantityStr) : 1;

      Product product = new Product(name, price, description, category);
      product.setImagePath(imagePath);
      cart.addProduct(product, quantity);

    } else if ("remove".equals(action)) {

      String productName = request.getParameter("productName");
      if (productName != null) {
        cart.removeProduct(productName);
      }
    }

    session.setAttribute("cart", cart);
    response.sendRedirect("cart.jsp");
  }

  // Pour les liens <a> (GET)
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException {

    doPost(request, response);
  }
}
