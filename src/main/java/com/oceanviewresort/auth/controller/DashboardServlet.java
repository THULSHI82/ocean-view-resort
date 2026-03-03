package com.oceanviewresort.auth.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String page = request.getParameter("page");

        if (page == null || page.isBlank()) {
            page = "home";
        }

        request.setAttribute("page", page);

        request.getRequestDispatcher("/dashboard.jsp")
                .forward(request, response);
    }
}