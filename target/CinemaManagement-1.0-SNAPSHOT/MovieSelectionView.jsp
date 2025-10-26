<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.mycompany.cinemamanagement.model.Movie" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Select Movie</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                background-color: #1a1a1a;
                color: #fff;
                font-family: 'Segoe UI', sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }
            .container {
                background-color: #6c757d;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 0 15px rgba(0,0,0,0.6);
                max-width: 1000px;
                width: 100%;
            }
            h2 {
                text-align: center;
                margin-bottom: 20px;
                font-weight: bold;
            }
            .btn-select {
                background-color: #dc3545;
                border: none;
                color: #fff;
                padding: 6px 15px;
                border-radius: 8px;
                font-weight: 600;
                transition: 0.3s;
            }
            .btn-select:hover {
                background-color: #b71c1c;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <h2>Select Movie</h2>

            <%
                List<Movie> movies = (List<Movie>) request.getAttribute("movies");
                String date = (String) request.getAttribute("date");
                String timeslot = (String) request.getAttribute("timeslot");
                String roomId = (String) request.getAttribute("roomId");
            %>

            <table class="table table-dark table-hover text-center align-middle">
                <thead>
                    <tr>
                        <th>Movie Name</th>
                        <th>Duration</th>
                        <th>Type</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (movies != null && !movies.isEmpty()) {
                            for (Movie m : movies) {
                    %>
                    <tr>
                        <td><%= m.getMovieName()%></td>
                        <td><%= m.getDuration()%> minutes</td>
                        <td><%= m.getType()%></td>
                        <td>
                            <form action="ShowtimeServlet" method="get">
                                <input type="hidden" name="action" value="confirm">
                                <input type="hidden" name="movieId" value="<%= m.getId()%>">
                                <input type="hidden" name="roomId" value="<%= request.getAttribute("roomId")%>">
                                <input type="hidden" name="date" value="<%= request.getAttribute("date")%>">
                                <input type="hidden" name="startTime" value="<%= request.getAttribute("startTime")%>">
                                <input type="hidden" name="endTime" value="<%= request.getAttribute("endTime")%>">
                                <button type="submit" class="btn btn-warning btn-sm">Select</button>
                            </form>


                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="4">No movies available.</td></tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <div class="text-start mt-3">
                <a href="AddMovieView.jsp" class="btn btn-outline-light">+ Add Movie</a>
            </div>
        </div>
    </body>
</html>
