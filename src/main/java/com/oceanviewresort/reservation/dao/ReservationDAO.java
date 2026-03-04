package com.oceanviewresort.reservation.dao;

import com.oceanviewresort.common.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ReservationDAO {

    public boolean createReservation(
            int customerId,
            int roomId,
            String checkIn,
            String checkOut,
            double totalPrice
    ) {

        try {

            Connection connection = DBConnection.getInstance().getConnection();

            String sql = """
                    INSERT INTO reservations
                    (customer_id, room_id, check_in, check_out, total_price)
                    VALUES (?, ?, ?, ?, ?)
                    """;

            PreparedStatement stmt = connection.prepareStatement(sql);

            stmt.setInt(1, customerId);
            stmt.setInt(2, roomId);
            stmt.setString(3, checkIn);
            stmt.setString(4, checkOut);
            stmt.setDouble(5, totalPrice);

            stmt.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}