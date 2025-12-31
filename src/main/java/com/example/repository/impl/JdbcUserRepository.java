package com.example.repository.impl;

import com.example.model.Role;
import com.example.model.User;
import com.example.repository.UserRepository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

public class JdbcUserRepository implements UserRepository {

    private final DataSource dataSource;

    public JdbcUserRepository(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public Optional<User> findUserByEmailAndPwd(String email, String pwd) {
        // Note: Storing plain text passwords is a security risk. In a real app, use
        // BCrypt.
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, pwd);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getLong("id"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setFullname(rs.getString("fullname"));

                    String roleStr = rs.getString("role");
                    if (roleStr != null) {
                        try {
                            user.setRole(Role.valueOf(roleStr));
                        } catch (IllegalArgumentException e) {
                            user.setRole(Role.CLIENT); // Default fallback
                        }
                    }
                    user.setCreatedAt(rs.getTimestamp("created_at"));

                    return Optional.of(user);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error finding user", e);
        }
        return Optional.empty();
    }
}
