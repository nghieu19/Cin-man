<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Create Showtime</title>

        <!-- ✅ Bootstrap 5 -->
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
                background-color: #5a6268;
                padding: 40px 60px;
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(0,0,0,0.6);
                max-width: 700px;
                width: 100%;
            }

            h2 {
                font-weight: 700;
                text-align: center;
                margin-bottom: 30px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
            }

            label {
                font-weight: 500;
            }

            .btn-danger {
                background-color: #dc3545;
                border: none;
                font-weight: bold;
            }

            .btn-danger:hover {
                background-color: #bb2d3b;
            }

            input[type="time"], input[type="date"] {
                background-color: #f8f9fa;
                color: #000;
                border: none;
                border-radius: 8px;
                padding: 10px;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <h2>Create Showtime</h2>

            <form action="ShowtimeServlet" method="get">
                <input type="hidden" name="action" value="selectRoom">

                <!-- ✅ Chọn ngày chiếu -->
                <div class="mb-3">
                    <label class="form-label">Showtime Date:</label>
                    <input type="date" name="date" class="form-control" required>
                </div>

                <!-- ✅ Chọn giờ bắt đầu -->
                <div class="mb-3">
                    <label class="form-label">Start Time:</label>
                    <input type="time" name="startTime" class="form-control" required>
                </div>

                <!-- ✅ Chọn giờ kết thúc -->
                <div class="mb-3">
                    <label class="form-label">End Time:</label>
                    <input type="time" name="endTime" class="form-control" required>
                </div>


                <!-- ✅ Nhập giá -->
                <div class="mb-3">
                    <label class="form-label">Price (VNĐ):</label>
                    <input type="number" name="price" class="form-control" min="0" required>
                </div>
                <!-- ✅ Nút chuyển bước -->
                <button type="submit" class="btn btn-danger w-100 mt-3">Next </button>
            </form>
        </div>
    </body>
</html>
