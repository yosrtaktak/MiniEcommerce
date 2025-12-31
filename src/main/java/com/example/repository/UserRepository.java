package com.example.repository;

import com.example.model.User;
import java.util.Optional;

public interface UserRepository {
    Optional<User> findUserByEmailAndPwd(String email, String pwd);
    // Add other methods if needed, e.g., save, findByEmail
}
