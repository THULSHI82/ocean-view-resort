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

        String success = (String) request.getSession().getAttribute("billingSuccess");
        if (success != null) {
            request.setAttribute("success", success);
            request.getSession().removeAttribute("billingSuccess");
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reservationIdParam = request.getParameter("reservationId");
        String method = request.getParameter("paymentMethod");

        if (reservationIdParam == null || reservationIdParam.isBlank() ||
                method == null || method.isBlank()) {

            request.getSession().setAttribute("billingError", "Please select a payment method.");
            response.sendRedirect(request.getContextPath() + "/billing");
            return;
        }

        try {
            int reservationId = Integer.parseInt(reservationIdParam);

            boolean settled = billingService.settleBill(reservationId, method);

            if (settled) {
                request.getSession().setAttribute("billingSuccess", "Bill settled successfully (" + method + ").");
            } else {
                request.getSession().setAttribute("billingError", "Failed to settle bill. Please try again.");
            }

            // PRG redirect to avoid form resubmission
            response.sendRedirect(request.getContextPath() + "/billing?reservationId=" + reservationId);
            return;

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("billingError", "Invalid Reservation ID format.");
            response.sendRedirect(request.getContextPath() + "/billing");
        }
    }
}