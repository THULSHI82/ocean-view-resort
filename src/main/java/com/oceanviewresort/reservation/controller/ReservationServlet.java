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

        // load rooms for dropdown
        List<Room> rooms = reservationService.getAllRooms();
        request.setAttribute("rooms", rooms);

        // tell dashboard which content to include
        request.setAttribute("page", "reservation");
        request.setAttribute("subPage", "add");

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

        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // customer fields
            String customerName = request.getParameter("customerName");
            String customerPhone = request.getParameter("customerPhone");
            String customerEmail = request.getParameter("customerEmail");

            // reservation fields
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            LocalDate checkIn = LocalDate.parse(request.getParameter("checkIn"));
            LocalDate checkOut = LocalDate.parse(request.getParameter("checkOut"));

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
                request.getSession().setAttribute("error", "Failed to create reservation. Try again.");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            request.getSession().setAttribute("error", "Invalid input. Please check your details.");
        }

        response.sendRedirect(request.getContextPath() + "/reservation");
    }
}