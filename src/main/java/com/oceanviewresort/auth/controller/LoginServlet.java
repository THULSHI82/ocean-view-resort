package com.oceanviewresort.auth.controller;

import com.oceanviewresort.auth.model.User;
import com.oceanviewresort.auth.service.AuthService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() {
        authService = new AuthService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {

            String error = (String) session.getAttribute("error");
            String success = (String) session.getAttribute("loginSuccess");

            if (error != null) {
                request.setAttribute("error", error);
                session.removeAttribute("error");
            }

            if (success != null) {
                request.setAttribute("success", success);
                session.removeAttribute("loginSuccess");
            }
        }

        request.getRequestDispatcher("/login.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = authService.login(username, password);

        if (user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);
            session.setAttribute("loginSuccess", "Login successful!");

            response.sendRedirect(request.getContextPath() + "/login");

        } else {

            request.getSession().setAttribute("error",
                    "Invalid username or password.");

            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}