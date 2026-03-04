package com.oceanviewresort.reservation.service;

import com.oceanviewresort.reservation.dao.ReservationDAO;
import com.oceanviewresort.reservation.dao.RoomDAO;
import com.oceanviewresort.reservation.model.Room;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

public class ReservationService {

    private final RoomDAO roomDAO = new RoomDAO();
    private final ReservationDAO reservationDAO = new ReservationDAO();

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
            int customerId,
            int roomId,
            LocalDate checkIn,
            LocalDate checkOut
    ) {

        double totalPrice = calculateTotalPrice(roomId, checkIn, checkOut);

        return reservationDAO.createReservation(
                customerId,
                roomId,
                checkIn.toString(),
                checkOut.toString(),
                totalPrice
        );
    }
}