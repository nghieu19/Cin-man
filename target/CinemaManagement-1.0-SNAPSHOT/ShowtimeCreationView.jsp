<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Create Showtime</title>

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

            input[type="time"], input[type="date"], input[type="text"] {
                background-color: #f8f9fa;
                color: #000;
                border: none;
                border-radius: 8px;
                padding: 10px;
            }

            /* BACK có khung */
            .btn-back {
                background-color: #6c757d; /* xám */
                color: #fff;
                border: none;
                padding: 6px 18px;
                border-radius: 8px;
                font-weight: bold;
                font-size: 16px;
                cursor: pointer;
                display: inline-block;
            }

            .btn-back:hover {
                background-color: #5a6268;
            }

            /* NEXT có khung */
            .btn-next {
                background-color: #dc3545;
                color: #fff;
                border: none;
                padding: 6px 18px;
                border-radius: 8px;
                font-weight: bold;
                font-size: 16px;
                cursor: pointer;
                display: inline-block;
            }

            .btn-next:hover {
                background-color: #c82333;
            }

            .button-group {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 25px;
            }

        </style>
    </head>

    <body>
        <div class="container">
            <h2>Create Showtime</h2>

            <form action="ShowtimeServlet" method="get">
                <input type="hidden" name="action" value="selectRoom">

                <div class="mb-3">
                    <label class="form-label">Showtime Date:</label>
                    <input type="date" name="date" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Start Time:</label>
                    <input type="time" name="startTime" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">End Time:</label>
                    <input type="time" name="endTime" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Price (VNĐ):</label>
                    <input type="text" id="priceDisplay" class="form-control" required>
                    <input type="hidden" name="price" id="priceValue">
                </div>

                <div class="button-group">
                    <a href="ShowtimeManagementView.jsp" class="btn-back">Back</a>
                    <button type="submit" class="btn-next">Next</button>
                </div>

            </form>
        </div>

        <script>
            const priceDisplay = document.getElementById("priceDisplay");
            const priceValue = document.getElementById("priceValue");

            priceDisplay.addEventListener("input", function () {
                let raw = this.value.replace(/\./g, "").replace(/\D/g, "");
                this.value = raw.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
                priceValue.value = raw;
            });
        </script>

    </body>
</html>
