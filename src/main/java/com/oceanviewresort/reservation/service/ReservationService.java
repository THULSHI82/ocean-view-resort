package com.oceanviewresort.reservation.service;

import com.oceanviewresort.reservation.dao.ReservationDAO;
import com.oceanviewresort.reservation.dao.CustomerDAO;
import com.oceanviewresort.reservation.dao.RoomDAO;
import com.oceanviewresort.reservation.model.Room;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;

public class ReservationService {

    private final RoomDAO roomDAO = new RoomDAO();
    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();

    public List<Room> getAllRooms() {
        return roomDAO.getAllRooms();
    }

    public double calculateTotalPrice(int roomId, LocalDate checkIn, LocalDate checkOut) {

        List<Room> rooms = roomDAO.getAllRooms();

        for (Room room : rooms) {

            if (room.getId() == roomId) {

                long days = ChronoUnit.DAYS.between(checkIn, checkOut);

                if (days <= 0) {
                    days = 1;
                }

                return room.getPrice() * days;
            }
        }

        return 0;
    }

    public boolean createReservation(
            String customerName,
            String customerPhone,
            String customerEmail,
            int roomId,
            LocalDate checkIn,
            LocalDate checkOut
    ) {

        if (customerName == null || customerName.isBlank()) {
            return false;
        }

        boolean available = reservationDAO.isRoomAvailable(
                roomId,
                checkIn.toString(),
                checkOut.toString()
        );

        if (!available) {
            return false; // room already booked in that date range
        }

        double totalPrice = calculateTotalPrice(roomId, checkIn, checkOut);

        int customerId = customerDAO.createCustomer(customerName, customerPhone, customerEmail);

        if (customerId == -1) {
            return false;
        }

        return reservationDAO.createReservation(
                customerId,
                roomId,
                checkIn.toString(),
                checkOut.toString(),
                totalPrice
        );
    }

    public String validateReservationDates(LocalDate checkIn, LocalDate checkOut) {
        if (checkIn == null || checkOut == null) return "Please select valid dates.";
        if (!checkOut.isAfter(checkIn)) return "Check-out date must be after check-in date.";
        return null;
    }

    public List<Map<String, Object>> getAllReservations() {
        return reservationDAO.getAllReservations();
    }

    public List<Map<String, Object>> searchReservations(String keyword, String fromDate, String toDate) {
        return reservationDAO.searchReservations(keyword, fromDate, toDate);
    }
}