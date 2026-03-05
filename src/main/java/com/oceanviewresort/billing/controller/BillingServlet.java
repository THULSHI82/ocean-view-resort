package com.oceanviewresort.billing.controller;

import com.oceanviewresort.billing.model.Billing;
import com.oceanviewresort.billing.service.BillingService;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/billing")
public class BillingServlet extends HttpServlet {

    private final BillingService billingService = new BillingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Move billing messages (PRG style)
        String error = (String) request.getSession().getAttribute("billingError");
        if (error != null) {
            request.setAttribute("error", error);
            request.getSession().removeAttribute("billingError");
        }

        String reservationIdParam = request.getParameter("reservationId");

        // If user submitted an ID
        if (reservationIdParam != null && !reservationIdParam.isBlank()) {
            try {
                int reservationId = Integer.parseInt(reservationIdParam);

                Billing bill = billingService.calculateBill(reservationId);

                if (bill == null) {
                    // store in session then redirect (PRG avoids weird refresh states)
                    request.getSession().setAttribute("billingError",
                            "Reservation ID not found. Please check and try again.");
                    response.sendRedirect(request.getContextPath() + "/billing");
                    return;
                } else {
                    request.setAttribute("bill", bill);
                }

            } catch (NumberFormatException e) {
                request.getSession().setAttribute("billingError", "Invalid Reservation ID format.");
                response.sendRedirect(request.getContextPath() + "/billing");
                return;
            }
        }

        request.setAttribute("page", "billing");
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}