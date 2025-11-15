<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Movie</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #1c1c1c;
            color: #fff;
            font-family: 'Segoe UI', sans-serif;
        }
        .container {
            background-color: #2b2b2b;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.5);
            max-width: 700px;
            margin-top: 60px;
        }
        label {
            font-weight: 500;
        }
        .btn-custom {
            background-color: #ffc107;
            color: #000;
            font-weight: 600;
        }
        .btn-custom:hover {
            background-color: #ffcd39;
        }
    </style>
</head>

<body>
<div class="container">
    <h2 class="mb-4 text-center">Add New Movie</h2>

    <!-- Form gửi dữ liệu về MovieServlet -->
    <form action="movie" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Movie Name</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="Enter movie name" required>
        </div>

        <div class="mb-3">
            <label for="type" class="form-label"> Type</label>
            <input type="text" class="form-control" id="type" name="type" placeholder="e.g. Action, Drama, Romance">
        </div>

        <div class="mb-3">
            <label for="yearOfProduction" class="form-label">Year of Production</label>
            <input type="date" class="form-control" id="yearOfProduction" name="yearOfProduction">
        </div>

        <div class="mb-3">
            <label for="director" class="form-label">Director</label>
            <input type="text" class="form-control" id="director" name="director" placeholder="Enter director name">
        </div>

        <div class="mb-3">
            <label for="actor" class="form-label">Actor(s)</label>
            <input type="text" class="form-control" id="actor" name="actor" placeholder="Main actor(s)">
        </div>

        <div class="mb-3">
            <label for="language" class="form-label">Language</label>
            <input type="text" class="form-control" id="language" name="language" placeholder="e.g. English, Korean, Japanese">
        </div>

        <div class="mb-3">
            <label for="duration" class="form-label">Duration</label>
            <input type="text" class="form-control" id="duration" name="duration" placeholder="e.g. 120 minutes">
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="3"
                      placeholder="Short summary of the movie..."></textarea>
        </div>

        <div class="mb-3">
            <label for="notes" class="form-label">Notes</label>
            <textarea class="form-control" id="notes" name="notes" rows="2"
                      placeholder="Any special notes..."></textarea>
        </div>

        <div class="d-flex justify-content-between mt-4">
            <a href="movie?action=list" class="btn btn-outline-light px-4">← Back</a>
            <button type="submit" class="btn btn-custom px-4">Save Movie</button>
        </div>
    </form>
</div>

</body>
</html>
