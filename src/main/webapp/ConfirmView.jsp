<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.mycompany.cinemamanagement.model.Movie, com.mycompany.cinemamanagement.model.Room" %>
<%
    Movie movie = (Movie) request.getAttribute("movie");
    Room room = (Room) request.getAttribute("room");
    String date = (String) request.getAttribute("date");
    String startTime = (String) request.getAttribute("startTime");
    String endTime = (String) request.getAttribute("endTime");
    String price = (String) request.getAttribute("price");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Confirm </title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #1a1a1a;
                color: #fff;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                font-family: 'Segoe UI', sans-serif;
            }
            .container {
                background-color: #5a6268;
                padding: 40px 60px;
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(0,0,0,0.6);
                max-width: 600px;
            }
            h2 {
                font-weight: 700;
                margin-bottom: 30px;
                text-align: center;
            }

            /* ⭐ Căn trái toàn bộ text */
            .info-box p {
                text-align: left;
                font-size: 17px;
                margin: 8px 0;
            }

            .btn-success {
                width: 150px;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="container">

            <h2>Confirm Showtime</h2>

            <div class="info-box">
                <p><b>Movie Name:</b> <%= (movie != null) ? movie.getMovieName() : "N/A"%></p>
                <p><b>Duration:</b> <%= (movie != null) ? movie.getDuration() : "N/A"%> minutes</p>
                <p><b>Time Slot:</b> <%= (startTime != null && endTime != null) ? startTime + " - " + endTime : "N/A"%></p>
                <p><b>Showtime Date:</b> <%= (date != null) ? date : "N/A"%></p>
                <p><b>Room:</b> <%= (room != null) ? room.getNameRoom() : "N/A"%></p>
                <p><b>Price:</b> <%= (price != null) ? price : "N/A"%> VNĐ</p>
            </div>

            <form action="ShowtimeServlet" method="post" class="text-center mt-3">
                <input type="hidden" name="action" value="saveShowtime">
                <input type="hidden" name="movieId" value="<%= (movie != null) ? movie.getId() : 0%>">
                <input type="hidden" name="roomId" value="<%= (room != null) ? room.getId() : 0%>">
                <input type="hidden" name="date" value="<%= (date != null) ? date : ""%>">
                <input type="hidden" name="startTime" value="<%= (startTime != null) ? startTime : ""%>">
                <input type="hidden" name="endTime" value="<%= (endTime != null) ? endTime : ""%>">
                <input type="hidden" name="price" value="<%= (price != null) ? price : ""%>">

                <button type="submit" class="btn btn-success mt-3">Save</button>
            </form>
        </div>
    </body>
</html>
