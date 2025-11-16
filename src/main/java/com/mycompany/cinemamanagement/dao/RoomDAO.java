package com.mycompany.cinemamanagement.dao;

import com.mycompany.cinemamanagement.model.Room;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO xử lý dữ liệu liên quan đến Room
 */
public class RoomDAO extends DAO {

    private Connection con;

    public RoomDAO() {
        super();
        this.con = super.con;
    }

    /**
     * ✅ Lấy danh sách phòng còn trống theo ngày + thời gian
     *
     * @param showDate java.sql.Date
     * @param startTime java.sql.Time
     * @param endTime java.sql.Time
     */
    public List<Room> getAvailableRooms(Date showDate, Time startTime, Time endTime) {
        List<Room> list = new ArrayList<>();

        String sql
                = "SELECT r.*, "
                + "   CASE WHEN EXISTS ( "
                + "       SELECT 1 FROM showtime s "
                + "       WHERE s.room_id = r.id "
                + "         AND s.show_date = ? "
                + "         AND (s.start_time < ? AND s.end_time > ?) "
                + "   ) THEN 0 ELSE 1 END AS isAvailable "
                + "FROM room r "
                + "ORDER BY r.id";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, showDate);
            ps.setTime(2, endTime);   // lưu ý: end trước
            ps.setTime(3, startTime); // start sau

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Room r = new Room();
                r.setId(rs.getInt("id"));
                r.setNameRoom(rs.getString("nameRoom"));
                r.setCapacity(rs.getInt("capacity"));
                r.setAvailable(rs.getInt("isAvailable") == 1); // 1 = trống, 0 = bận

                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
