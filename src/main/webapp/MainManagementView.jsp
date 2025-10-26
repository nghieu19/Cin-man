<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Main Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: url('image/nen1.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex; justify-content: center; align-items: center;
            height: 100vh;
        }
        .box {
            background: rgba(0,0,0,0.6);
            padding: 50px; border-radius: 15px;
            color: white; text-align: center;
            box-shadow: 0 0 15px rgba(0,0,0,0.4);
        }
        a.btn {
            background-color: #ff4b2b; border: none;
            color: white; font-weight: 600; padding: 10px 30px;
            transition: 0.3s;
        }
        a.btn:hover { background-color: #c9302c; }
    </style>
</head>
<body>
    <div class="box">
        <h2>Main Management</h2>
        <a href="ShowtimeManagementView.jsp" class="btn mt-3">Showtime Management</a>
    </div>
</body>
</html>
