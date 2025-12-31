package com.example.repository.impl;

import com.example.model.Promotion;
import com.example.repository.PromotionRepository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class JdbcPromotionRepository implements PromotionRepository {

    private final DataSource dataSource;

    public JdbcPromotionRepository(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public List<Promotion> findAll() {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT p.*, prod.name as product_name, cat.name as category_name " +
                "FROM promotions p " +
                "LEFT JOIN products prod ON p.product_id = prod.id " +
                "LEFT JOIN categories cat ON p.category_id = cat.id " +
                "ORDER BY p.start_date DESC";

        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                promotions.add(mapRow(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching promotions", e);
        }
        return promotions;
    }

    @Override
    public Optional<Promotion> findById(Long id) {
        String sql = "SELECT p.*, prod.name as product_name, cat.name as category_name " +
                "FROM promotions p " +
                "LEFT JOIN products prod ON p.product_id = prod.id " +
                "LEFT JOIN categories cat ON p.category_id = cat.id " +
                "WHERE p.id = ?";

        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error finding promotion with ID " + id, e);
        }
        return Optional.empty();
    }

    @Override
    public Promotion save(Promotion promotion) {
        String sql = "INSERT INTO promotions (title, type, value, description, start_date, end_date, product_id, category_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?) RETURNING id";

        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, promotion.getTitle());
            ps.setString(2, promotion.getType());
            ps.setDouble(3, promotion.getValue());
            ps.setString(4, promotion.getDescription());
            ps.setTimestamp(5, promotion.getStartDate());
            ps.setTimestamp(6, promotion.getEndDate());

            if (promotion.getProductId() != null)
                ps.setLong(7, promotion.getProductId());
            else
                ps.setNull(7, Types.INTEGER);

            if (promotion.getCategoryId() != null)
                ps.setLong(8, promotion.getCategoryId());
            else
                ps.setNull(8, Types.INTEGER);

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        promotion.setId(rs.getLong(1));
                    }
                }
            }
            return promotion;
        } catch (SQLException e) {
            throw new RuntimeException("Error saving promotion", e);
        }
    }

    @Override
    public void update(Promotion promotion) {
        String sql = "UPDATE promotions SET title = ?, type = ?, value = ?, description = ?, start_date = ?, end_date = ?, product_id = ?, category_id = ? WHERE id = ?";

        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, promotion.getTitle());
            ps.setString(2, promotion.getType());
            ps.setDouble(3, promotion.getValue());
            ps.setString(4, promotion.getDescription());
            ps.setTimestamp(5, promotion.getStartDate());
            ps.setTimestamp(6, promotion.getEndDate());

            if (promotion.getProductId() != null)
                ps.setLong(7, promotion.getProductId());
            else
                ps.setNull(7, Types.INTEGER);

            if (promotion.getCategoryId() != null)
                ps.setLong(8, promotion.getCategoryId());
            else
                ps.setNull(8, Types.INTEGER);

            ps.setLong(9, promotion.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error updating promotion", e);
        }
    }

    @Override
    public void deleteById(Long id) {
        String sql = "DELETE FROM promotions WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting promotion", e);
        }
    }

    private Promotion mapRow(ResultSet rs) throws SQLException {
        Promotion p = new Promotion();
        p.setId(rs.getLong("id"));
        p.setTitle(rs.getString("title"));
        p.setType(rs.getString("type"));
        p.setValue(rs.getDouble("value"));
        p.setDescription(rs.getString("description"));
        p.setStartDate(rs.getTimestamp("start_date"));
        p.setEndDate(rs.getTimestamp("end_date"));

        long prodId = rs.getLong("product_id");
        if (!rs.wasNull())
            p.setProductId(prodId);

        long catId = rs.getLong("category_id");
        if (!rs.wasNull())
            p.setCategoryId(catId);

        try {
            p.setProductName(rs.getString("product_name"));
            p.setCategoryName(rs.getString("category_name"));
        } catch (SQLException ignored) {
            // These columns might not exist if called from a method using "SELECT *"
        }

        p.setCreatedAt(rs.getTimestamp("created_at"));
        return p;
    }
}
