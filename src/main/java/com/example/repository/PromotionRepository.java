package com.example.repository;

import com.example.model.Promotion;
import java.util.List;
import java.util.Optional;

public interface PromotionRepository {
  List<Promotion> findAll();

  Optional<Promotion> findById(Long id);

  Promotion save(Promotion promotion);

  void update(Promotion promotion);

  void deleteById(Long id);
}
