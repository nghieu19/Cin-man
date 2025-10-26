package com.mycompany.cinemamanagement.dao;

import com.mycompany.cinemamanagement.model.Room;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO xử lý dữ liệu Showtime và Room
 */
public class ShowtimeDAO extends DAO {

    private Connection con;

    public ShowtimeDAO() {
        super();
        this.con = super.con; // lấy kết nối từ lớp DAO cha
    }

    /**
     * ✅ Lấy danh sách phòng còn trống theo ngày chiếu và khung giờ
     *
     * @param showDate Ngày chiếu (java.sql.Date)
     * @param startTime Giờ bắt đầu (java.sql.Time)
     * @param endTime Giờ kết thúc (java.sql.Time)
     * @return Danh sách phòng còn trống (không bị trùng giờ chiếu)
     */
    public List<Room> getListRoomByShowtime(Date showDate, Time startTime, Time endTime) {
        List<Room> list = new ArrayList<>();

        String sql
                = "SELECT * FROM room r "
                + "WHERE r.id NOT IN ( "
                + "    SELECT s.room_id "
                + "    FROM showtime s "
                + "    WHERE s.show_date = ? "
                + "      AND (s.start_time < ? AND s.end_time > ?) "
                + ") "
                + "OR NOT EXISTS ( "
                + "    SELECT 1 FROM showtime s WHERE s.show_date = ? "
                + ") "
                + "ORDER BY r.id";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, showDate);
            ps.setTime(2, endTime);
            ps.setTime(3, startTime);
            ps.setDate(4, showDate);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Room r = new Room();
                r.setId(rs.getInt("id"));
                r.setNameRoom(rs.getString("nameRoom"));
                r.setCapacity(rs.getInt("capacity"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * ✅ Lấy 1 phòng theo ID
     */
    public Room getRoomById(int id) {
        Room room = null;
        String sql = "SELECT * FROM room WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                room = new Room();
                room.setId(rs.getInt("id"));
                room.setNameRoom(rs.getString("nameRoom"));
                room.setCapacity(rs.getInt("capacity"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return room;
    }

    public boolean addShowtime(Date showDate, Time startTime, Time endTime, int roomId, int movieId) {
        String sql = "INSERT INTO showtime (show_date, start_time, end_time, room_id, movie_id) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, showDate);
            ps.setTime(2, startTime);
            ps.setTime(3, endTime);
            ps.setInt(4, roomId);
            ps.setInt(5, movieId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
