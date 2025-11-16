<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Cinema Management</title>

    <!-- ✅ Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background: url('image/nen1.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        body::before {
            content: "";
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(3px);
            z-index: 0;
        }

        .login-box {
            position: relative;
            z-index: 1;
            width: 400px;
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(8px);
            border-radius: 20px;
            padding: 40px 45px;
            box-shadow: 0 0 20px rgba(0,0,0,0.5);
            color: #fff;
            text-align: center;
        }

        h2 {
            font-weight: 700;
            margin-bottom: 25px;
            color: #fff;
            text-shadow: 2px 2px 6px rgba(0,0,0,0.6);
        }

        .form-control {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: #fff;
            padding: 12px;
            border-radius: 8px;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .btn-login {
            background-color: #d32f2f;
            border: none;
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            color: #fff;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-login:hover {
            background-color: #b71c1c;
            transform: scale(1.05);
        }

        a {
            color: #f8d7da;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

    <div class="login-box">
        <h2>Login</h2>

        <form action="LoginServlet" method="post">
            <div class="mb-3">
                <input type="text" name="username" class="form-control" placeholder="Username" required>
            </div>
            <div class="mb-3">
                <input type="password" name="password" class="form-control" placeholder="Password" required>
            </div>
            <button type="submit" class="btn-login">Login</button>
        </form>
    </div>

</body>
</html>
