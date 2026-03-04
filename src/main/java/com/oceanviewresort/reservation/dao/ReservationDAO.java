package com.oceanviewresort.reservation.dao;

import com.oceanviewresort.common.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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

    public boolean isRoomAvailable(int roomId, String checkIn, String checkOut) {

        try {
            Connection connection = DBConnection.getInstance().getConnection();

            String sql = """
            SELECT COUNT(*) AS cnt
            FROM reservations
            WHERE room_id = ?
              AND check_in < ?
              AND check_out > ?
            """;

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, roomId);
            stmt.setString(2, checkOut); // existing.check_in < new.check_out
            stmt.setString(3, checkIn);  // existing.check_out > new.check_in

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("cnt") == 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}