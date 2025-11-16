<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String movieName = (String) request.getAttribute("movieName");
    String duration = (String) request.getAttribute("duration");

    String roomId = (String) request.getAttribute("roomId");
    String date = (String) request.getAttribute("date");
    String startTime = (String) request.getAttribute("startTime");
    String endTime = (String) request.getAttribute("endTime");
    String price = (String) request.getAttribute("price");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm</title>
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
        <p><b>Movie Name:</b> <%= (movieName != null) ? movieName : "N/A" %></p>
        <p><b>Duration:</b> <%= (duration != null) ? duration : "N/A" %> </p>
        <p><b>Time Slot:</b> <%= startTime %> - <%= endTime %></p>
        <p><b>Showtime Date:</b> <%= date %></p>
        <p><b>Room:</b> Room <%= roomId %></p>
        <p><b>Price:</b> <%= price.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ".") %> VNĐ
    </div>

    <form action="ShowtimeServlet" method="post" class="text-center mt-3">
        <input type="hidden" name="action" value="saveShowtime">
        <input type="hidden" name="movieId" value="<%= request.getParameter("movieId") %>">
        <input type="hidden" name="roomId" value="<%= roomId %>">
        <input type="hidden" name="date" value="<%= date %>">
        <input type="hidden" name="startTime" value="<%= startTime %>">
        <input type="hidden" name="endTime" value="<%= endTime %>">
        <input type="hidden" name="price" value="<%= price %>">

        <button type="submit" class="btn btn-success mt-3">Save</button>
    </form>
</div>
</body>
</html>
