package com.example.controller;

import com.example.model.User;
import com.example.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.example.config.DataSourceConfig;
import com.example.repository.impl.JdbcUserRepository;

import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "LoginController", urlPatterns = "/login")
public class LoginController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        // Dependency Injection
        JdbcUserRepository userRepo = new JdbcUserRepository(DataSourceConfig.getDataSource());
        userService = new UserService(userRepo);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("uname");
        String password = request.getParameter("psw");

        Optional<User> user = userService.findUserByEmailAndPwd(email, password);

        if (user.isPresent()) {
            request.getSession().setAttribute("fullname", user.get().getFullname());
            request.getSession().setAttribute("role", user.get().getRole().name());
            response.sendRedirect("home");
        } else {
            response.sendRedirect("index.jsp?message=Identifiant ou mot de passe incorrect");
        }
    }

}
