<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.mycompany.cinemamanagement.model.Room" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Select Room</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                background-color: #1a1a1a;
                color: #fff;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                font-family: 'Segoe UI', sans-serif;
            }

            .container {
                background-color: #6c757d;
                padding: 40px 60px;
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(0,0,0,0.6);
                max-width: 900px;
                width: 100%;
            }

            h2 {
                text-align: center;
                font-weight: bold;
                margin-bottom: 25px;
            }

            .info-line {
                border-bottom: 1px solid rgba(255,255,255,0.3);
                margin: 15px 0;
            }

            .room-btn {
                width: 100%;
                margin: 10px 0;
                font-weight: 600;
                background-color: #495057;
                border: none;
                color: #fff;
                border-radius: 10px;
                padding: 15px 10px;
                transition: 0.3s;
            }

            .room-btn:hover {
                background-color: #ffc107;
                color: #000;
            }

            .busy-room {
                background-color: #b02a37 !important;
                color: #fff !important;
                border: 2px solid #ff0000;
                cursor: not-allowed;
                opacity: 0.9;
            }

            .no-room {
                text-align: center;
                background-color: rgba(0,0,0,0.3);
                padding: 15px;
                border-radius: 8px;
                margin-top: 20px;
            }

            .back-btn {
                display: inline-block;
                background-color: #dc3545;
                border: none;
                padding: 10px 25px;
                border-radius: 8px;
                color: #fff;
                text-decoration: none;
                font-weight: 600;
                transition: 0.3s;
            }

            .back-btn:hover {
                background-color: #b02a37;
                text-decoration: none;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <h2>Select Room</h2>

            <%
                String date = request.getParameter("date") != null ? request.getParameter("date") : (String) request.getAttribute("date");
                String startTime = request.getParameter("startTime") != null ? request.getParameter("startTime") : (String) request.getAttribute("startTime");
                String endTime = request.getParameter("endTime") != null ? request.getParameter("endTime") : (String) request.getAttribute("endTime");
                String price = request.getParameter("price") != null
                        ? request.getParameter("price")
                        : (String) request.getAttribute("price");
                List<Room> rooms = (List<Room>) request.getAttribute("rooms");

                // ⭐ FORMAT PRICE: 150000 → 150.000
                String formattedPrice = "N/A";
                if (price != null && !price.isEmpty()) {
                    try {
                        long p = Long.parseLong(price);
                        formattedPrice = String.format("%,d", p).replace(",", ".");
                    } catch (Exception e) {
                        formattedPrice = price;
                    }
                }
            %>

            <p><strong>Showtime Date:</strong> <%= (date != null ? date : "N/A")%></p>
            <p><strong>Timeslot:</strong> <%= (startTime != null && endTime != null) ? startTime + " - " + endTime : "N/A"%></p>

            <!-- ⭐ HIỂN THỊ GIÁ ĐÃ FORMAT -->
            <p><strong>Price:</strong> <%= formattedPrice%> VNĐ</p>

            <hr class="info-line">

            <div class="row text-center">
                <%
                    if (rooms != null && !rooms.isEmpty()) {
                        for (Room r : rooms) {
                            boolean available = r.isAvailable();
                %>
                <div class="col-md-4 col-sm-6">

                    <form action="ShowtimeServlet" method="get">
                        <input type="hidden" name="action" value="selectMovie">
                        <input type="hidden" name="roomId" value="<%= r.getId()%>">
                        <input type="hidden" name="date" value="<%= date%>">
                        <input type="hidden" name="startTime" value="<%= startTime%>">
                        <input type="hidden" name="endTime" value="<%= endTime%>">
                        <input type="hidden" name="price" value="<%= price%>">

                        <button type="submit"
                                class="room-btn <%= available ? "" : "busy-room"%>"
                                <%= available ? "" : "disabled"%>>
                            <%= r.getNameRoom()%><br>
                            <small><%= r.getCapacity()%> seats</small>
                        </button>

                    </form>

                </div>
                <%
                    }
                } else {
                %>
                <div class="no-room">
                    ⚠ No rooms available for this time range!
                </div>
                <%
                    }
                %>
            </div>

            <div class="text-center mt-4">
                <a href="ShowtimeCreationView.jsp" class="back-btn">Back</a>
            </div>
        </div>
    </body>
</html>
