<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.oceanviewresort.auth.model.User" %>
<%
    User user = (User) session.getAttribute("loggedUser");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Ocean View Resort</title>

    <style>
        :root{
            --sidebar:#0f172a;
            --sidebarHover:#1e293b;
            --mainBg:#f3f4f6;
            --card:#ffffff;
            --primary:#111827;
        }

        *{box-sizing:border-box;}

        body{
            margin:0;
            font-family:system-ui;
            display:flex;
            height:100vh;
            background:var(--mainBg);
        }

        /* Sidebar */
        .sidebar{
            width:260px;
            background:var(--sidebar);
            color:#fff;
            display:flex;
            flex-direction:column;
            padding:25px 0;
        }

        .sidebar h2{
            text-align:center;
            margin-bottom:30px;
            font-size:18px;
        }

        .nav-link{
            padding:14px 25px;
            text-decoration:none;
            color:#cbd5e1;
            display:block;
            transition:0.2s;
        }

        .nav-link:hover{
            background:var(--sidebarHover);
            color:#fff;
        }

        .logout{
            margin-top:auto;
            padding:14px 25px;
            color:#f87171;
            cursor:pointer;
        }

        /* Main */
        .main{
            flex:1;
            padding:30px;
            overflow-y:auto;
        }

        .header{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:25px;
        }

        .card{
            background:var(--card);
            padding:25px;
            border-radius:14px;
            box-shadow:0 10px 25px rgba(0,0,0,0.08);
        }
    </style>

    <script>
        function confirmLogout(){
            if(confirm("Are you sure you want to logout?")){
                window.location.href="${pageContext.request.contextPath}/logout";
            }
        }
    </script>

</head>
<body>

<div class="sidebar">
    <h2>Ocean View Resort</h2>

    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard?page=home">Home</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard?page=reservation">Reservations</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard?page=billing">Billing</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard?page=reports">Reports</a>

    <div class="logout" onclick="confirmLogout()">Logout</div>
</div>

<div class="main">

    <div class="header">
        <h2>Welcome, <%= user.getUsername() %></h2>
    </div>

    <div class="card">

        <%
            String currentPage = (String) request.getAttribute("page");

            if ("reservation".equals(currentPage)) {
        %>
        <h3>Reservation Module</h3>
        <p>Reservation management content will appear here.</p>
        <%
        } else if ("billing".equals(currentPage)) {
        %>
        <h3>Billing Module</h3>
        <p>Billing management content will appear here.</p>
        <%
        } else if ("reports".equals(currentPage)) {
        %>
        <h3>Reports Module</h3>
        <p>Reports will be generated here.</p>
        <%
        } else {
        %>
        <h3>Home</h3>
        <p>Welcome to the Ocean View Resort staff dashboard.</p>
        <%
            }
        %>

    </div>

</div>

</body>
</html>