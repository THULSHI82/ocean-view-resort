package com.oceanviewresort.common.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static DBConnection instance;
    private final Connection connection;

    private DBConnection() throws SQLException {
        String URL = "jdbc:mysql://localhost:3306/ocean_view_resort";
        String USER = "root";
        String PASSWORD = "";
        this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static DBConnection getInstance() throws SQLException {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }
}