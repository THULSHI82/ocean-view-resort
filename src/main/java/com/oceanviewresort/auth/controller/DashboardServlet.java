package com.oceanviewresort.auth.controller;

import com.oceanviewresort.dashboard.service.DashboardService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String page = request.getParameter("page");

        if (page == null || page.isBlank()) {
            page = "home";
        }

        request.setAttribute("page", page);

        // Load stats only when viewing Home
        if ("home".equals(page)) {
            Map<String,Object> stats = dashboardService.getDashboardStats();
            request.setAttribute("stats", stats);
        }

        request.getRequestDispatcher("/dashboard.jsp")
                .forward(request, response);
    }
}