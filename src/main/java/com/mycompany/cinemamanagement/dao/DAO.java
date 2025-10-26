package com.mycompany.cinemamanagement.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO {
    protected Connection con;

    public DAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3307/cinema_management?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                "root",
                "root"
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
