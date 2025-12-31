package com.example.service;

import com.example.model.User;
import com.example.repository.UserRepository;

import java.util.Optional;

public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public Optional<User> findUserByEmailAndPwd(String email, String pwd) {
        return userRepository.findUserByEmailAndPwd(email, pwd);
    }
}
