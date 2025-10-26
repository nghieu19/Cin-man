<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Showtime Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: url('image/nen1.jpg') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            display: flex; justify-content: center; align-items: center;
        }
        .box {
            background: rgba(0,0,0,0.7);
            color: white;
            padding: 50px; border-radius: 20px;
            text-align: center;
        }
        .btn {
            background-color: #ff4b2b; color: white; border: none; padding: 10px 25px;
        }
        .btn:hover { background-color: #c9302c; }
    </style>
</head>
<body>
    <div class="box">
        <h2>Showtime Management</h2>
        <a href="ShowtimeCreationView.jsp" class="btn mt-3">Create Showtime</a>
    </div>
</body>
</html>
