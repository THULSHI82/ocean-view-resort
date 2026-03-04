package com.oceanviewresort.reservation.controller;

import com.oceanviewresort.reservation.model.Room;
import com.oceanviewresort.reservation.service.ReservationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {

    private ReservationService reservationService;

    @Override
    public void init() {
        reservationService = new ReservationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1) Flash messages (PRG: session -> request)
        String error = (String) request.getSession().getAttribute("error");
        String success = (String) request.getSession().getAttribute("success");

        if (error != null) {
            request.setAttribute("error", error);
            request.getSession().removeAttribute("error");
        }
        if (success != null) {
            request.setAttribute("success", success);
            request.getSession().removeAttribute("success");
        }

        // 2) Decide which reservation view to show: add or list
        String view = request.getParameter("view");
        if (view == null || view.isBlank()) view = "add";

        // 3) Tell dashboard which module + sub view to include
        request.setAttribute("page", "reservation");
        request.setAttribute("subPage", view);

        // 4) Load data depending on selected view
        if ("list".equals(view)) {

            String keyword = request.getParameter("q");
            String fromDate = request.getParameter("from");
            String toDate = request.getParameter("to");

            if ((keyword != null && !keyword.isBlank()) ||
                    (fromDate != null && !fromDate.isBlank()) ||
                    (toDate != null && !toDate.isBlank())) {

                request.setAttribute("reservations",
                        reservationService.searchReservations(keyword, fromDate, toDate));
                request.setAttribute("q", keyword);
                request.setAttribute("from", fromDate);
                request.setAttribute("to", toDate);

            } else {
                request.setAttribute("reservations", reservationService.getAllReservations());
            }

        } else {
            // "add" view -> load rooms for dropdown
            List<Room> rooms = reservationService.getAllRooms();
            request.setAttribute("rooms", rooms);
        }

        // 5) Render inside dashboard
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("delete".equals(action)) {

            try {
                int reservationId = Integer.parseInt(request.getParameter("id"));

                boolean deleted = reservationService.deleteReservation(reservationId);

                if (deleted) {
                    request.getSession().setAttribute("success", "Reservation deleted successfully.");
                } else {
                    request.getSession().setAttribute("error", "Failed to delete reservation.");
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("error", "Invalid reservation id.");
            }

            response.sendRedirect(request.getContextPath() + "/reservation?view=list");
            return;
        }

        try {
            // customer fields
            String customerName = request.getParameter("customerName");
            String customerPhone = request.getParameter("customerPhone");
            String customerEmail = request.getParameter("customerEmail");

            // reservation fields
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            LocalDate checkIn = LocalDate.parse(request.getParameter("checkIn"));
            LocalDate checkOut = LocalDate.parse(request.getParameter("checkOut"));

            String dateError = reservationService.validateReservationDates(checkIn, checkOut);
            if (dateError != null) {
                request.getSession().setAttribute("error", dateError);
                response.sendRedirect(request.getContextPath() + "/reservation");
                return;
            }

            boolean created = reservationService.createReservation(
                    customerName,
                    customerPhone,
                    customerEmail,
                    roomId,
                    checkIn,
                    checkOut
            );

            if (created) {
                request.getSession().setAttribute("success", "Reservation created successfully!");
            } else {
                request.getSession().setAttribute(
                        "error",
                        "Selected room is not available for the chosen dates. Please choose another room or date range."
                );
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            request.getSession().setAttribute("error", "Invalid input. Please check your details.");
        }

        response.sendRedirect(request.getContextPath() + "/reservation");
    }
}