package com.oceanviewresort.billing.controller;

import com.oceanviewresort.billing.model.Billing;
import com.oceanviewresort.billing.service.BillingService;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/billing")
public class BillingServlet extends HttpServlet {

    private BillingService billingService = new BillingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reservationId = request.getParameter("reservationId");

        if (reservationId != null) {

            Billing bill = billingService.calculateBill(
                    Integer.parseInt(reservationId));

            request.setAttribute("bill", bill);
        }

        request.setAttribute("page", "billing");
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}