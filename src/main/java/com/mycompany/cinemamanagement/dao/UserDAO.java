package com.mycompany.cinemamanagement.dao;

import com.mycompany.cinemamanagement.model.User;
import java.sql.*;

public class UserDAO extends DAO {

    public UserDAO() {
        super();
    }

    /**
     * ✅ Kiểm tra thông tin đăng nhập
     * @param username Tên đăng nhập
     * @param password Mật khẩu
     * @return Đối tượng User nếu đăng nhập thành công, null nếu thất bại
     */
    public User checkLogin(String username, String password) {
        User user = null;
        String sql = "SELECT * FROM user WHERE username = ? AND password = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // ✅ Dùng getString với try-catch để tránh lỗi khi thiếu cột (vd: full_name)
                    String fullName = null;
                    try { fullName = rs.getString("full_name"); } catch (SQLException ignored) {}

                    user = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        fullName,
                        rs.getString("role")
                    );
                }
            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi truy vấn checkLogin: " + e.getMessage());
            e.printStackTrace();
        }

        return user;
    }
}
