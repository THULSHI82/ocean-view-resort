package com.oceanviewresort.reservation.dao;

import com.oceanviewresort.reservation.model.Room;
import com.oceanviewresort.common.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    public List<Room> getAllRooms() {

        List<Room> rooms = new ArrayList<>();

        try {
            Connection connection = DBConnection.getInstance().getConnection();

            String sql = "SELECT * FROM rooms";

            PreparedStatement stmt = connection.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                Room room = new Room(
                        rs.getInt("id"),
                        rs.getString("room_number"),
                        rs.getString("room_type"),
                        rs.getDouble("price")
                );

                rooms.add(room);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rooms;
    }
}