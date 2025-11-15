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
                String startTime = (String) request.getAttribute("startTime");
                String endTime = (String) request.getAttribute("endTime");
                String roomId = (String) request.getAttribute("roomId");
                String price = (String) request.getAttribute("price");   // ⭐ Lấy price
            %>

            <div style="margin: 20px 0; font-size: 18px; color: #fff;">
                <p style="margin-bottom: 10px;"><strong>Showtime Date:</strong> <%= date%></p>
                <p style="margin-bottom: 10px;"><strong>Timeslot:</strong> <%= startTime%> - <%= endTime%></p>
                <p style="margin-bottom: 10px;"><strong>Room:</strong> Room <%= roomId%></p>
                <p style="margin-bottom: 10px;"><strong>Price:</strong> <%= price%> VNĐ</p>
            </div>

            <hr style="border-color: rgba(255,255,255,0.3); margin: 10px 0 25px 0;">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="m-0"></h4>
                <a href="AddMovieView.jsp" class="btn btn-outline-light">+ Add Movie</a>
            </div>


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

                                <!-- ⭐ Truyền toàn bộ dữ liệu -->
                                <input type="hidden" name="roomId" value="<%= roomId%>">
                                <input type="hidden" name="date" value="<%= date%>">
                                <input type="hidden" name="startTime" value="<%= startTime%>">
                                <input type="hidden" name="endTime" value="<%= endTime%>">
                                <input type="hidden" name="price" value="<%= price%>">  <!-- ⭐ PRICE -->

                                <button type="submit" class="btn btn-warning btn-sm">Select</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="4">No movies available.</td></tr>
                    <% }%>
                </tbody>
            </table>
        </div>
    </body>
</html>
