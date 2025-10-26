<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cinema Home Page</title>

    <!-- ✅ Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background: url('image/nen1.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            position: relative;
        }

        body::before {
            content: "";
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.55);
            backdrop-filter: blur(2px);
            z-index: 0;
        }

        .container {
            position: relative;
            z-index: 1;
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(8px);
            border-radius: 20px;
            padding: 40px 50px;
            box-shadow: 0 0 20px rgba(0,0,0,0.4);
            width: 80%;
            max-width: 900px;
            color: #fff;
        }

        h2 {
            font-weight: 700;
            text-align: center;
            margin-bottom: 30px;
            color: #f8f9fa;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.6);
        }

        input[type="text"] {
            border-radius: 8px;
            border: none;
            padding: 10px;
            width: 100%;
            font-size: 16px;
        }

        .btn-search {
            background-color: #d32f2f;
            border: none;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-search:hover {
            background-color: #b71c1c;
        }

        .login-btn-container {
            position: fixed;
            top: 20px;
            right: 30px;
            z-index: 10;
        }

        .btn-login {
            border: 2px solid #fff;
            color: #fff;
            font-weight: 600;
            padding: 8px 18px;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(3px);
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            background: #d32f2f;
            border-color: #d32f2f;
            color: #fff;
            transform: scale(1.05);
        }

        table {
            margin-top: 30px;
            color: #212529;
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
        }

        th {
            background-color: #b71c1c;
            color: white;
            text-align: center;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        a {
            text-decoration: none;
            color: #b71c1c;
            font-weight: 600;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

    <!-- 🔐 Nút Login -->
    <div class="login-btn-container">
        <a href="login.jsp" class="btn btn-outline-light btn-login">Login</a>
    </div>

    <div class="container">
        <h2>🎬 Cinema</h2>

        <!-- 🔍 Search Form -->
        <form action="movie" method="get" class="row g-3 justify-content-center mb-4">
            <input type="hidden" name="action" value="search">
            <div class="col-md-8">
                <input type="text" name="keyword" class="form-control" placeholder="Enter movie name...">
            </div>
            <div class="col-md-2 d-grid">
                <button type="submit" class="btn-search">Search</button>
            </div>
        </form>

        <!-- 🎞️ Movie List -->
        <%
            java.util.List<com.mycompany.cinemamanagement.model.Movie> list =
                (java.util.List<com.mycompany.cinemamanagement.model.Movie>) request.getAttribute("listMovie");
            if (list != null && !list.isEmpty()) {
        %>
        <div class="table-responsive">
            <table class="table table-striped table-hover align-middle text-center">
                <thead>
                    <tr>
                        <th>Movie Name</th>
                        <th>Type</th>
                        <th>Year</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                <% for (com.mycompany.cinemamanagement.model.Movie m : list) { %>
                    <tr>
                        <td><a href="movie?action=details&id=<%=m.getId()%>"><%=m.getMovieName()%></a></td>
                        <td><%=m.getType()%></td>
                        <td><%=m.getYearOfProduction()%></td>
                        <td><%=m.getDescription()%></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <%
            } else if (request.getParameter("keyword") != null) {
        %>
        <div class="alert alert-warning text-center mt-4">
            No movies found for "<%=request.getParameter("keyword")%>"
        </div>
        <%
            }
        %>
    </div>

</body>
</html>
