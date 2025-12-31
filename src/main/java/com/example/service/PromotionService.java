package com.example.service;

import com.example.model.Promotion;
import java.util.List;

public interface PromotionService {
  List<Promotion> getAllPromotions();

  Promotion getPromotionById(Long id);

  void createPromotion(Promotion promotion);

  void updatePromotion(Promotion promotion);

  void deletePromotion(Long id);
}
