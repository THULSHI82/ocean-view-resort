package com.oceanviewresort.dashboard.dao;

import com.oceanviewresort.common.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class DashboardDAO {

    public Map<String, Object> getDashboardStats() {

        Map<String, Object> stats = new HashMap<>();

        try {

            Connection conn = DBConnection.getInstance().getConnection();

            // total reservations
            String reservationsSql = "SELECT COUNT(*) FROM reservations";
            PreparedStatement stmt1 = conn.prepareStatement(reservationsSql);
            ResultSet rs1 = stmt1.executeQuery();
            if(rs1.next()) stats.put("reservations", rs1.getInt(1));


            // revenue
            String revenueSql = "SELECT IFNULL(SUM(total_price),0) FROM reservations";
            PreparedStatement stmt2 = conn.prepareStatement(revenueSql);
            ResultSet rs2 = stmt2.executeQuery();
            if(rs2.next()) stats.put("revenue", rs2.getDouble(1));


            // active guests
            String guestsSql = """
                    SELECT COUNT(*)
                    FROM reservations
                    WHERE CURDATE() BETWEEN check_in AND check_out
                    """;

            PreparedStatement stmt3 = conn.prepareStatement(guestsSql);
            ResultSet rs3 = stmt3.executeQuery();
            if(rs3.next()) stats.put("guests", rs3.getInt(1));


            // available rooms
            String roomsSql = """
                    SELECT COUNT(*)
                    FROM rooms
                    WHERE id NOT IN (
                        SELECT room_id
                        FROM reservations
                        WHERE CURDATE() BETWEEN check_in AND check_out
                    )
                    """;

            PreparedStatement stmt4 = conn.prepareStatement(roomsSql);
            ResultSet rs4 = stmt4.executeQuery();
            if(rs4.next()) stats.put("availableRooms", rs4.getInt(1));


        } catch (Exception e) {
            e.printStackTrace();
        }

        return stats;
    }
}