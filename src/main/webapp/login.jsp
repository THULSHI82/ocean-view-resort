<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Ocean View Resort</title>
    <style>
        body {
            font-family: Arial, serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: #f4f6f9;
        }
        .card {
            background: white;
            padding: 30px;
            width: 350px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
        }
        button {
            width: 100%;
            padding: 10px;
            background: #2c7be5;
            color: white;
            border: none;
        }
        .error {
            color: red;
        }
        .success {
            color: green;
        }
    </style>
</head>
<body>

<div class="card">
    <h2>Login</h2>

    <% if (request.getAttribute("error") != null) { %>
    <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>

    <% if (request.getAttribute("success") != null) { %>
    <p class="success"><%= request.getAttribute("success") %></p>
    <script>
        setTimeout(function() {
            window.location.href = "dashboard.jsp";
        }, 2000);
    </script>
    <% } %>

    <form method="post" action="${pageContext.request.contextPath}/login">
        <label>
            <input type="text" name="username" placeholder="Username" required />
        </label>
        <label>
            <input type="password" name="password" placeholder="Password" required />
        </label>
        <button type="submit">Login</button>
    </form>
</div>

</body>
</html>