package com.mycompany.cinemamanagement.controller;

import com.mycompany.cinemamanagement.dao.MovieDAO;
import com.mycompany.cinemamanagement.model.Movie;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/movie")
public class MovieServlet extends HttpServlet {

    private MovieDAO movieDAO;

    @Override
    public void init() {
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
            action = "list";
        }

        try {
            switch (action) {
                case "search":
                    searchMovie(request, response);
                    break;
                case "details":
                    showDetails(request, response);
                    break;
                case "add":
                    showAddForm(request, response);
                    break;
                default:
                    listMovies(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // 📜 Danh sách phim
    private void listMovies(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Movie> list = movieDAO.getAllMovies();
        request.setAttribute("listMovie", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Homepage.jsp");
        dispatcher.forward(request, response);
    }

    // 🔍 Tìm kiếm phim
    // 🔍 Tìm kiếm phim
    private void searchMovie(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String keyword = request.getParameter("keyword");

        List<Movie> list;
        if (keyword == null || keyword.trim().isEmpty()) {
            // 🟡 Nếu không nhập gì thì hiển thị toàn bộ phim
            list = movieDAO.getAllMovies();
        } else {
            // 🟢 Nếu có từ khóa thì tìm kiếm chính xác (không phân biệt hoa thường)
            list = movieDAO.getMovieByName(keyword.trim());
        }

        request.setAttribute("listMovie", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Homepage.jsp");
        dispatcher.forward(request, response);
    }

    // 🎬 Hiển thị chi tiết phim
    private void showDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Movie movie = movieDAO.getMovieById(id);
        request.setAttribute("result", movie);
        RequestDispatcher dispatcher = request.getRequestDispatcher("MovieDetailsView.jsp");
        dispatcher.forward(request, response);
    }

    // ➕ Form thêm phim
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("AddMovie.jsp");
        dispatcher.forward(request, response);
    }

    // 💾 Thêm phim vào DB
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String name = request.getParameter("name");
            String type = request.getParameter("type");
            String year = request.getParameter("yearOfProduction");
            java.sql.Date yearOfProduction = (year == null || year.isEmpty())
                    ? null : java.sql.Date.valueOf(year);

            String director = request.getParameter("director");
            String actor = request.getParameter("actor");
            String language = request.getParameter("language");
            String duration = request.getParameter("duration");
            String description = request.getParameter("description");
            String notes = request.getParameter("notes");

            Movie movie = new Movie();
            movie.setMovieName(name);
            movie.setType(type);
            movie.setYearOfProduction(yearOfProduction);
            movie.setDirector(director);
            movie.setActor(actor);
            movie.setLanguage(language);
            movie.setDuration(duration);
            movie.setDescription(description);
            movie.setNotes(notes);

            boolean success = movieDAO.addMovie(movie);

            if (success) {
                response.sendRedirect("movie?action=list");
            } else {
                response.getWriter().println("❌ Failed to add movie. Please try again!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("⚠️ Error while saving movie: " + e.getMessage());
        }
    }
}
