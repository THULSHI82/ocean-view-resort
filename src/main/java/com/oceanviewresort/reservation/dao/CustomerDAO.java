package com.oceanviewresort.reservation.dao;

import com.oceanviewresort.common.util.DBConnection;

import java.sql.*;

public class CustomerDAO {

    public int createCustomer(String name, String phone, String email) {

        try {
            Connection connection = DBConnection.getInstance().getConnection();

            String sql = "INSERT INTO customers (name, phone, email) VALUES (?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            stmt.setString(1, name);
            stmt.setString(2, phone);
            stmt.setString(3, email);

            int affected = stmt.executeUpdate();

            if (affected == 0) {
                return -1;
            }

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }
}