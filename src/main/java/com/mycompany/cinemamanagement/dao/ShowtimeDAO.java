package com.mycompany.cinemamanagement.dao;

import java.sql.*;

public class ShowtimeDAO extends DAO {

    private Connection con;

    public ShowtimeDAO() {
        super();
        this.con = super.con;
    }

    // ⭐ Thêm price vào hàm
    public boolean addShowtime(Date showDate, Time startTime, Time endTime, int roomId, int movieId, double price) {

        String sql = "INSERT INTO showtime (show_date, start_time, end_time, room_id, movie_id, price) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDate(1, showDate);
            ps.setTime(2, startTime);
            ps.setTime(3, endTime);
            ps.setInt(4, roomId);
            ps.setInt(5, movieId);

            // ⭐ Thêm dòng này
            ps.setDouble(6, price);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
