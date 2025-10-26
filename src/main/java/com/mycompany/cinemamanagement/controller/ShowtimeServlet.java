package com.mycompany.cinemamanagement.controller;

import com.mycompany.cinemamanagement.dao.ShowtimeDAO;
import com.mycompany.cinemamanagement.dao.MovieDAO;
import com.mycompany.cinemamanagement.model.Room;
import com.mycompany.cinemamanagement.model.Movie;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "ShowtimeServlet", urlPatterns = {"/ShowtimeServlet"})
public class ShowtimeServlet extends HttpServlet {

    private ShowtimeDAO showtimeDAO;
    private MovieDAO movieDAO;

    @Override
    public void init() {
        showtimeDAO = new ShowtimeDAO();
        try {
            movieDAO = new MovieDAO();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "selectRoom":
                selectRoom(request, response);
                break;

            case "selectMovie":
                selectMovie(request, response);
                break;

            case "confirm":
                confirmShowtime(request, response);
                break;

            default:
                response.sendRedirect("create_showtime.jsp");
                break;
        }
    }

    /**
     * ✅ Bước 1 → 2: Từ Create Showtime → Select Room
     */
    private void selectRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String dateStr = request.getParameter("date");
            String startStr = request.getParameter("startTime");
            String endStr = request.getParameter("endTime");

            if (dateStr == null || startStr == null || endStr == null) {
                request.setAttribute("error", "Missing showtime information!");
                request.getRequestDispatcher("create_showtime.jsp").forward(request, response);
                return;
            }

            Date showDate = Date.valueOf(dateStr);
            Time startTime = Time.valueOf(startStr.length() == 5 ? startStr + ":00" : startStr);
            Time endTime = Time.valueOf(endStr.length() == 5 ? endStr + ":00" : endStr);

            List<Room> rooms = showtimeDAO.getListRoomByShowtime(showDate, startTime, endTime);

            request.setAttribute("date", dateStr);
            request.setAttribute("startTime", startStr);
            request.setAttribute("endTime", endStr);
            request.setAttribute("rooms", rooms);

            RequestDispatcher rd = request.getRequestDispatcher("RoomSelectionView.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "⚠ Error loading available rooms!");
            request.getRequestDispatcher("create_showtime.jsp").forward(request, response);
        }
    }

    /**
     * ✅ Bước 2 → 3: Sau khi chọn Room → hiển thị danh sách phim
     */
    private void selectMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dateStr = request.getParameter("date");
        String startStr = request.getParameter("startTime");
        String endStr = request.getParameter("endTime");
        String roomId = request.getParameter("roomId");

        try {
            List<Movie> movies = movieDAO.getAllMovies();

            request.setAttribute("movies", movies);
            request.setAttribute("date", dateStr);
            request.setAttribute("startTime", startStr);
            request.setAttribute("endTime", endStr);
            request.setAttribute("roomId", roomId);

            RequestDispatcher rd = request.getRequestDispatcher("MovieSelectionView.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "⚠ Error loading movie list!");
            request.getRequestDispatcher("MovieSelectionView.jsp").forward(request, response);
        }
    }

    /**
     * ✅ Bước 3 → 4: Hiển thị trang xác nhận thông tin chiếu phim
     */
    private void confirmShowtime(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dateStr = request.getParameter("date");
        String startStr = request.getParameter("startTime");
        String endStr = request.getParameter("endTime");
        String roomId = request.getParameter("roomId");
        String movieId = request.getParameter("movieId");

        try {
            int movieID = Integer.parseInt(movieId);
            int roomID = Integer.parseInt(roomId);

            Movie movie = movieDAO.getMovieById(movieID);
            Room room = showtimeDAO.getRoomById(roomID);

            // ✅ Gửi dữ liệu cho JSP
            request.setAttribute("movie", movie);
            request.setAttribute("room", room);
            request.setAttribute("date", dateStr);
            request.setAttribute("startTime", startStr);
            request.setAttribute("endTime", endStr);

            RequestDispatcher rd = request.getRequestDispatcher("ConfirmView.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "⚠ Error confirming showtime!");
            request.getRequestDispatcher("MovieSelectionView.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("saveShowtime".equals(action)) {
            try {
                // Lấy dữ liệu từ form
                String dateStr = request.getParameter("date");
                String startStr = request.getParameter("startTime");
                String endStr = request.getParameter("endTime");
                int movieId = Integer.parseInt(request.getParameter("movieId"));
                int roomId = Integer.parseInt(request.getParameter("roomId"));

                // Chuyển định dạng dữ liệu
                java.sql.Date showDate = java.sql.Date.valueOf(dateStr);
                java.sql.Time startTime = java.sql.Time.valueOf(startStr.length() == 5 ? startStr + ":00" : startStr);
                java.sql.Time endTime = java.sql.Time.valueOf(endStr.length() == 5 ? endStr + ":00" : endStr);

                // Gọi DAO để lưu vào database
                boolean success = showtimeDAO.addShowtime(showDate, startTime, endTime, roomId, movieId);

                if (success) {
                    // ✅ Sau khi lưu thành công → chuyển hướng về trang tạo suất chiếu
                    response.sendRedirect("ShowtimeManagementView.jsp?message=success");
                } else {
                    // ❌ Nếu lỗi → quay lại kèm thông báo
                    request.setAttribute("error", "❌ Failed to save showtime!");
                    request.getRequestDispatcher("ConfirmView.jsp").forward(request, response);
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "⚠ Error while saving showtime!");
                request.getRequestDispatcher("ConfirmView.jsp").forward(request, response);
            }
        } else {
            doGet(request, response);
        }
    }

}
