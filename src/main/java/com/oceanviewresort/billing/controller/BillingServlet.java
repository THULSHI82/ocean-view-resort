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

        // PRG messages (optional but very stable UX)
        String error = (String) request.getSession().getAttribute("error");
        if (error != null) {
            request.setAttribute("error", error);
            request.getSession().removeAttribute("error");
        }

        String reservationIdParam = request.getParameter("reservationId");

        if (reservationIdParam != null && !reservationIdParam.isBlank()) {
            try {
                int reservationId = Integer.parseInt(reservationIdParam);

                Billing bill = billingService.calculateBill(reservationId);

                if (bill == null) {
                    request.setAttribute("error", "Reservation ID not found. Please check and try again.");
                } else {
                    request.setAttribute("bill", bill);
                }

            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid Reservation ID format.");
            }
        }

        request.setAttribute("page", "billing");
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}