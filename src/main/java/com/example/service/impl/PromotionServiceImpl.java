package com.example.service.impl;

import com.example.model.Promotion;
import com.example.repository.PromotionRepository;
import com.example.service.PromotionService;

import java.sql.Timestamp;
import java.util.List;

public class PromotionServiceImpl implements PromotionService {

    private final PromotionRepository promotionRepository;

    public PromotionServiceImpl(PromotionRepository promotionRepository) {
        this.promotionRepository = promotionRepository;
    }

    @Override
    public List<Promotion> getAllPromotions() {
        return promotionRepository.findAll();
    }

    @Override
    public Promotion getPromotionById(Long id) {
        return promotionRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Promotion not found with ID: " + id));
    }

    @Override
    public void createPromotion(Promotion promotion) {
        validatePromotion(promotion);
        promotionRepository.save(promotion);
    }

    @Override
    public void updatePromotion(Promotion promotion) {
        if (promotion.getId() == null) {
            throw new IllegalArgumentException("Cannot update promotion without ID");
        }
        validatePromotion(promotion);
        promotionRepository.update(promotion);
    }

    @Override
    public void deletePromotion(Long id) {
        promotionRepository.deleteById(id);
    }

    private void validatePromotion(Promotion p) {
        if (p.getTitle() == null || p.getTitle().trim().isEmpty()) {
            throw new IllegalArgumentException("Title is required");
        }
        if (p.getValue() <= 0) {
            throw new IllegalArgumentException("Value must be positive");
        }
        if (p.getStartDate() != null && p.getEndDate() != null && p.getStartDate().after(p.getEndDate())) {
            throw new IllegalArgumentException("Start date cannot be after end date");
        }
    }
}
