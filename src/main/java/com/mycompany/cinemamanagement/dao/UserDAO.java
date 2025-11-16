package com.mycompany.cinemamanagement.dao;

import com.mycompany.cinemamanagement.model.User;
import java.sql.*;

public class UserDAO extends DAO {

    public UserDAO() {
        super();
    }
    public User checkLogin(String username, String password) {
        User user = null;
        String sql = "SELECT id, username, role FROM user WHERE username = ? AND password = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setRole(rs.getString("role"));
                }
            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi checkLogin: " + e.getMessage());
        }

        return user;
    }

}
