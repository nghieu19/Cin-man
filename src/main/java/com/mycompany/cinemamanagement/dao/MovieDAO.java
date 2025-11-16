package com.mycompany.cinemamanagement.dao;

import com.mycompany.cinemamanagement.model.Movie;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieDAO extends DAO {

    private Connection con;

    public MovieDAO() {
        super();
        this.con = super.con;
    }

    // 🔍 Tìm phim theo tên
    public List<Movie> getMovieByName(String keyword) {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT * FROM movie WHERE LOWER(name) LIKE LOWER(?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Movie m = extractMovieFromResultSet(rs);
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 📋 Lấy tất cả phim
    public List<Movie> getAllMovies() {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT * FROM movie";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Movie m = extractMovieFromResultSet(rs);
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🎬 Lấy chi tiết phim theo ID
    public Movie getMovieDetails(int id) {
        Movie movie = null;
        String sql = "SELECT * FROM movie WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                movie = extractMovieFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movie;
    }

    // ➕ Thêm phim mới
    public boolean addMovie(Movie movie) {
        String sql = "INSERT INTO movie (name, type, yearOfProduction, director, actor, language, duration, description, notes) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, movie.getMovieName());
            ps.setString(2, movie.getType());
            if (movie.getYearOfProduction() != null) {
                ps.setDate(3, new java.sql.Date(movie.getYearOfProduction().getTime()));
            } else {
                ps.setNull(3, Types.DATE);
            }
            ps.setString(4, movie.getDirector());
            ps.setString(5, movie.getActor());
            ps.setString(6, movie.getLanguage());
            ps.setString(7, movie.getDuration());
            ps.setString(8, movie.getDescription());
            ps.setString(9, movie.getNotes());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 🧩 Hàm hỗ trợ: tạo đối tượng Movie từ ResultSet
    private Movie extractMovieFromResultSet(ResultSet rs) throws SQLException {
        Movie m = new Movie();
        m.setId(rs.getInt("id"));
        m.setMovieName(rs.getString("name"));
        m.setType(rs.getString("type"));
        m.setYearOfProduction(rs.getDate("yearOfProduction"));
        m.setDirector(rs.getString("director"));
        m.setActor(rs.getString("actor"));
        m.setLanguage(rs.getString("language"));
        m.setDuration(rs.getString("duration"));
        m.setDescription(rs.getString("description"));
        m.setNotes(rs.getString("notes"));
        return m;
    }
}
