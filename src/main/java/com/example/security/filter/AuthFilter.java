package com.example.security.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter(urlPatterns = {
        "/home.jsp",
        "/home",
        "/categories.jsp",
        "/categories"
})

public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        String fullname = (String) req.getSession().getAttribute("fullname");
        if (fullname == null || fullname.isEmpty()) {
            ((HttpServletResponse) response).sendRedirect("index.jsp");
        } else {
            filterChain.doFilter(request, response);
        }
    }
}
