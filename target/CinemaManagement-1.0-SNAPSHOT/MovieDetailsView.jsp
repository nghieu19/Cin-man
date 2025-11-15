<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Movie Details</title>

        <!-- ✅ Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <style>
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }

            body {
                min-height: 100vh;
                width: 100%;
                background: url('<%=request.getContextPath()%>/image/nen1.jpg') no-repeat center center fixed;
                background-size: cover;           /* luôn phủ toàn bộ */
                background-attachment: fixed;     /* cố định khi cuộn */
                background-repeat: no-repeat;
                background-position: center;
                overflow-x: hidden;               /* tránh thanh cuộn ngang */
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'Segoe UI', sans-serif;
                position: relative;
            }


            /* Lớp phủ tối để chữ dễ đọc hơn */
            body::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.55);
                backdrop-filter: blur(2px);
                z-index: 0;
            }

            .card {
                position: relative;
                z-index: 1;
                background: rgba(255,255,255,0.1);
                backdrop-filter: blur(10px);
                border-radius: 16px;
                color: #fff;
                box-shadow: 0 4px 20px rgba(0,0,0,0.4);
                width: 80%;
                max-width: 700px;
                padding: 30px 40px;
            }

            h2 {
                text-align: center;
                margin-bottom: 25px;
                font-weight: 700;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.6);
            }

            .detail-label {
                color: #ffcccb;
                font-weight: 600;
            }

            .btn-back {
                background-color: #d32f2f;
                color: white;
                font-weight: 600;
                border: none;
                border-radius: 8px;
                padding: 10px 20px;
                margin-top: 20px;
                transition: 0.3s;
            }

            .btn-back:hover {
                background-color: #b71c1c;
            }

            .movie-info p {
                margin-bottom: 10px;
            }
        </style>
    </head>

    <body>

        <div class="card">
            <h2>🎞 Movie Details</h2>

            <div class="movie-info">
                <%
                    com.mycompany.cinemamanagement.model.Movie m
                            = (com.mycompany.cinemamanagement.model.Movie) request.getAttribute("result");
                    if (m != null) {
                %>
                <p><span class="detail-label">Movie Name:</span> <%=m.getMovieName()%></p>
                <p><span class="detail-label">Year of Production:</span> <%=m.getYearOfProduction()%></p>
                <p><span class="detail-label">Type:</span> <%=m.getType()%></p>
                <p><span class="detail-label">Director:</span> <%=m.getDirector()%></p>
                <p><span class="detail-label">Actor:</span> <%=m.getActor()%></p>
                <p><span class="detail-label">Language:</span> <%=m.getLanguage()%></p>
                <p><span class="detail-label">Duration:</span> <%=m.getDuration()%> minutes</p>
                <p><span class="detail-label">Description:</span> <%=m.getDescription()%></p>
                <%
                } else {
                %>
                <div class="alert alert-warning text-center">No movie details available.</div>
                <%
                    }
                %>
            </div>

            <div class="text-center">
                <a href="Homepage.jsp" class="btn-back">Back</a>
            </div>
        </div>

    </body>
</html>
