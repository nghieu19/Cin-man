package com.mycompany.cinemamanagement.controller;

import com.mycompany.cinemamanagement.dao.RoomDAO;
import com.mycompany.cinemamanagement.model.Room;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@WebServlet(name = "RoomServlet", urlPatterns = {"/RoomServlet"})
public class RoomServlet extends HttpServlet {

    private RoomDAO roomDAO;

    @Override
    public void init() {
        roomDAO = new RoomDAO();
    }

    /**
     * ✅ Điều hướng GET
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "available":
                getAvailableRooms(request, response);
                break;

            case "detail":
                getRoomDetail(request, response);
                break;

            default:
                response.sendError(400, "Invalid Room action");
        }
    }

    /**
     * ✅ Lấy danh sách phòng trống theo ngày + time
     */
    private void getAvailableRooms(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    try {
        String dateStr = request.getParameter("date");
        String startStr = request.getParameter("startTime");
        String endStr = request.getParameter("endTime");
        String price = request.getParameter("price");     // ⭐ LẤY PRICE

        Date showDate = Date.valueOf(dateStr);
        Time startTime = Time.valueOf(startStr.length() == 5 ? startStr + ":00" : startStr);
        Time endTime = Time.valueOf(endStr.length() == 5 ? endStr + ":00" : endStr);

        List<Room> rooms = roomDAO.getAvailableRooms(showDate, startTime, endTime);

        request.setAttribute("rooms", rooms);
        request.setAttribute("date", dateStr);
        request.setAttribute("startTime", startStr);
        request.setAttribute("endTime", endStr);
        request.setAttribute("price", price);            // ⭐ TRUYỀN PRICE SANG JSP

        request.getRequestDispatcher("RoomSelectionView.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "⚠ Error loading available rooms!");
        request.getRequestDispatcher("ShowtimeCreationView.jsp").forward(request, response);
    }
}


    /**
     * ✅ Lấy chi tiết 1 phòng
     */
    private void getRoomDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            Room room = roomDAO.getRoomById(roomId);

            request.setAttribute("room", room);
            request.getRequestDispatcher("RoomDetailView.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error loading room details");
        }
    }
}
