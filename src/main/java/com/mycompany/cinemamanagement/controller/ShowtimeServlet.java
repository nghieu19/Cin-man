package com.mycompany.cinemamanagement.controller;

import com.mycompany.cinemamanagement.dao.ShowtimeDAO;
import com.mycompany.cinemamanagement.dao.MovieDAO;
import com.mycompany.cinemamanagement.model.Movie;
import com.mycompany.cinemamanagement.model.Room;
import com.mycompany.cinemamanagement.dao.RoomDAO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

@WebServlet(name = "ShowtimeServlet", urlPatterns = {"/ShowtimeServlet"})
public class ShowtimeServlet extends HttpServlet {

    private ShowtimeDAO showtimeDAO;
    private MovieDAO movieDAO;

    @Override
    public void init() {
        showtimeDAO = new ShowtimeDAO();
        movieDAO = new MovieDAO();
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
                redirectToRoomServlet(request, response);
                break;

            case "selectMovie":
                selectMovie(request, response);
                break;

            case "confirm":
                confirmShowtime(request, response);
                break;

            default:
                response.sendRedirect("ShowtimeCreationView.jsp");
        }
    }

    /**
     * ✅ Bước 1 → 2: chuyển sang RoomServlet để chọn phòng
     */
    private void redirectToRoomServlet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String date = request.getParameter("date");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String price = request.getParameter("price");

        String ctx = request.getContextPath();  // ⭐ Lấy context-path (Ví dụ: /CinemaManagement)

        response.sendRedirect(
                ctx + "/RoomServlet?action=available"
                + "&date=" + date
                + "&startTime=" + startTime
                + "&endTime=" + endTime
                + "&price=" + price
        );
    }

    /**
     * ✅ Bước 2 → 3: chọn phòng → hiển thị danh sách phim
     */
    private void selectMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dateStr = request.getParameter("date");
        String startStr = request.getParameter("startTime");
        String endStr = request.getParameter("endTime");
        String roomId = request.getParameter("roomId");
        String price = request.getParameter("price");  // ⭐ LẤY PRICE

        try {
            request.setAttribute("movies", movieDAO.getAllMovies());
            request.setAttribute("date", dateStr);
            request.setAttribute("startTime", startStr);
            request.setAttribute("endTime", endStr);
            request.setAttribute("roomId", roomId);
            request.setAttribute("price", price);   // ⭐ TRUYỀN TIẾP PRICE

            request.getRequestDispatcher("MovieSelectionView.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "⚠ Error loading movie list!");
            request.getRequestDispatcher("MovieSelectionView.jsp").forward(request, response);
        }
    }

    /**
     * ✅ Bước 3 → 4: Hiển thị trang xác nhận suất chiếu
     */
    private void confirmShowtime(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String movieId = request.getParameter("movieId");
            String roomId = request.getParameter("roomId");
            String date = request.getParameter("date");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            String price = request.getParameter("price");

            String movieName = request.getParameter("movieName");
            String duration = request.getParameter("duration");

            request.setAttribute("movieName", movieName);
            request.setAttribute("duration", duration);
            request.setAttribute("roomId", roomId);
            request.setAttribute("date", date);
            request.setAttribute("startTime", startTime);
            request.setAttribute("endTime", endTime);
            request.setAttribute("price", price);

            request.getRequestDispatcher("ConfirmView.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "⚠ Error confirming showtime!");
            request.getRequestDispatcher("MovieSelectionView.jsp").forward(request, response);
        }
    }

    /**
     * ✅ POST: Lưu suất chiếu vào DB
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("saveShowtime".equals(action)) {
            try {
                String dateStr = request.getParameter("date");
                String startStr = request.getParameter("startTime");
                String endStr = request.getParameter("endTime");
                int movieId = Integer.parseInt(request.getParameter("movieId"));
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                double price = Double.parseDouble(request.getParameter("price"));  // ⭐ LẤY PRICE

                Date showDate = Date.valueOf(dateStr);
                Time startTime = Time.valueOf(startStr.length() == 5 ? startStr + ":00" : startStr);
                Time endTime = Time.valueOf(endStr.length() == 5 ? endStr + ":00" : endStr);

                boolean success = showtimeDAO.addShowtime(showDate, startTime, endTime, roomId, movieId, price);

                if (success) {
                    response.sendRedirect("ShowtimeManagementView.jsp?message=success");
                } else {
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
