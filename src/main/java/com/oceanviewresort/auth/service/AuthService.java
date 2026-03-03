package com.oceanviewresort.auth.service;

import com.oceanviewresort.auth.dao.UserDAO;
import com.oceanviewresort.auth.model.User;

public class AuthService {

    private final UserDAO userDAO;

    public AuthService() {
        this.userDAO = new UserDAO();
    }

    public User login(String username, String password) {
        if (username == null || username.isBlank()) {
            return null;
        }
        if (password == null || password.isBlank()) {
            return null;
        }

        return userDAO.authenticate(username, password);
    }
}