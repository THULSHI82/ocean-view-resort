package com.oceanviewresort.reservation.dao;

import com.oceanviewresort.common.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    public List<Map<String, Object>> getAllReservations() {

        List<Map<String, Object>> list = new ArrayList<>();

        try {
            Connection connection = DBConnection.getInstance().getConnection();

            String sql = """
            SELECT r.id,
                   c.name AS customer_name,
                   c.phone AS customer_phone,
                   c.email AS customer_email,
                   rm.room_number,
                   rm.room_type,
                   r.check_in,
                   r.check_out,
                   r.total_price
            FROM reservations r
            JOIN customers c ON r.customer_id = c.id
            JOIN rooms rm ON r.room_id = rm.id
            ORDER BY r.id DESC
        """;

            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getInt("id"));
                row.put("customer_name", rs.getString("customer_name"));
                row.put("customer_phone", rs.getString("customer_phone"));
                row.put("customer_email", rs.getString("customer_email"));
                row.put("room_number", rs.getString("room_number"));
                row.put("room_type", rs.getString("room_type"));
                row.put("check_in", rs.getDate("check_in"));
                row.put("check_out", rs.getDate("check_out"));
                row.put("total_price", rs.getDouble("total_price"));
                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Map<String, Object>> searchReservations(String keyword, String fromDate, String toDate) {

        List<Map<String, Object>> list = new ArrayList<>();

        try {
            Connection connection = DBConnection.getInstance().getConnection();

            String sql = """
            SELECT r.id,
                   c.name AS customer_name,
                   c.phone AS customer_phone,
                   c.email AS customer_email,
                   rm.room_number,
                   rm.room_type,
                   r.check_in,
                   r.check_out,
                   r.total_price
            FROM reservations r
            JOIN customers c ON r.customer_id = c.id
            JOIN rooms rm ON r.room_id = rm.id
            WHERE (c.name LIKE ? OR c.phone LIKE ? OR rm.room_number LIKE ?)
              AND (? IS NULL OR r.check_in >= ?)
              AND (? IS NULL OR r.check_out <= ?)
            ORDER BY r.id DESC
        """;

            PreparedStatement stmt = connection.prepareStatement(sql);

            String like = "%" + (keyword == null ? "" : keyword.trim()) + "%";

            stmt.setString(1, like);
            stmt.setString(2, like);
            stmt.setString(3, like);

            // fromDate filter
            if (fromDate == null || fromDate.isBlank()) {
                stmt.setNull(4, java.sql.Types.DATE);
                stmt.setNull(5, java.sql.Types.DATE);
            } else {
                stmt.setDate(4, java.sql.Date.valueOf(fromDate));
                stmt.setDate(5, java.sql.Date.valueOf(fromDate));
            }

            // toDate filter
            if (toDate == null || toDate.isBlank()) {
                stmt.setNull(6, java.sql.Types.DATE);
                stmt.setNull(7, java.sql.Types.DATE);
            } else {
                stmt.setDate(6, java.sql.Date.valueOf(toDate));
                stmt.setDate(7, java.sql.Date.valueOf(toDate));
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getInt("id"));
                row.put("customer_name", rs.getString("customer_name"));
                row.put("customer_phone", rs.getString("customer_phone"));
                row.put("customer_email", rs.getString("customer_email"));
                row.put("room_number", rs.getString("room_number"));
                row.put("room_type", rs.getString("room_type"));
                row.put("check_in", rs.getDate("check_in"));
                row.put("check_out", rs.getDate("check_out"));
                row.put("total_price", rs.getDouble("total_price"));
                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean deleteReservation(int reservationId) {
        try {
            Connection connection = DBConnection.getInstance().getConnection();

            String sql = "DELETE FROM reservations WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, reservationId);

            int affected = stmt.executeUpdate();
            return affected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}