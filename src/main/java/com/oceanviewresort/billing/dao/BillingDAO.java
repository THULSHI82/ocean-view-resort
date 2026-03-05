package com.oceanviewresort.billing.dao;

import com.oceanviewresort.billing.model.Billing;
import com.oceanviewresort.common.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BillingDAO {

    public Billing getBillingDetails(int reservationId) {

        Billing billing = null;

        String sql = """
        SELECT 
            r.id,
            c.name,
            rm.room_number,
            r.check_in,
            r.check_out,
            rm.price
        FROM reservations r
        JOIN customers c ON r.customer_id = c.id
        JOIN rooms rm ON r.room_id = rm.id
        WHERE r.id = ?
    """;

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, reservationId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    billing = new Billing();

                    billing.setReservationId(rs.getInt("id"));
                    billing.setCustomerName(rs.getString("name"));
                    billing.setRoomNumber(rs.getString("room_number"));
                    billing.setCheckInDate(rs.getString("check_in"));
                    billing.setCheckOutDate(rs.getString("check_out"));
                    billing.setPricePerNight(rs.getBigDecimal("price"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return billing;
    }
}