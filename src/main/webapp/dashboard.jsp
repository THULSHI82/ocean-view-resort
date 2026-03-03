<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.oceanviewresort.auth.model.User" %>
<%
    User user = (User) session.getAttribute("loggedUser");
    String currentPage = (String) request.getAttribute("page");
    if (currentPage == null || currentPage.isBlank()) currentPage = "home";
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Ocean View Resort</title>

    <style>
        :root{
            --sidebar:#0f172a;
            --sidebarHover:#1e293b;
            --active:#111827;
            --mainBg:#f3f4f6;
            --card:#ffffff;
            --text:#0f172a;
            --muted:#64748b;
            --border:#e5e7eb;
            --shadow:0 10px 25px rgba(0,0,0,0.08);
        }

        *{box-sizing:border-box;}

        body{
            margin:0;
            font-family:system-ui,-apple-system,Segoe UI,Roboto,Arial;
            display:flex;
            height:100vh;
            background:var(--mainBg);
            color:var(--text);
        }

        /* Sidebar */
        .sidebar{
            width:270px;
            background:var(--sidebar);
            color:#fff;
            display:flex;
            flex-direction:column;
            padding:22px 14px;
        }

        .brand{
            padding:10px 14px 18px 14px;
            border-bottom:1px solid rgba(255,255,255,0.08);
            margin-bottom:12px;
        }
        .brand h2{
            margin:0;
            font-size:16px;
            letter-spacing:0;
        }
        .brand small{
            display:block;
            margin-top:6px;
            color:rgba(255,255,255,0.65);
            font-size:12px;
        }

        .nav{
            margin-top:10px;
            display:flex;
            flex-direction:column;
            gap:6px;
        }

        .nav-link{
            padding:12px 14px;
            border-radius:12px;
            text-decoration:none;
            color:#cbd5e1;
            display:flex;
            align-items:center;
            gap:10px;
            transition:0.18s ease;
        }
        .nav-link:hover{
            background:var(--sidebarHover);
            color:#fff;
        }
        .nav-link.active{
            background:rgba(255,255,255,0.12);
            color:#fff;
            border:1px solid rgba(255,255,255,0.18);
        }

        .spacer{ flex:1; }

        .logoutBtn{
            width:100%;
            padding:12px 14px;
            border-radius:12px;
            border:1px solid rgba(248,113,113,0.35);
            background:rgba(248,113,113,0.10);
            color:#fecaca;
            cursor:pointer;
            transition:0.18s ease;
            font-weight:600;
            display:flex;
            align-items:center;
            justify-content:center;
            gap:10px;
        }
        .logoutBtn:hover{
            background:rgba(248,113,113,0.16);
            border-color:rgba(248,113,113,0.55);
        }

        /* Main */
        .main{
            flex:1;
            padding:26px 28px;
            overflow-y:auto;
        }

        .header{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:18px;
        }
        .header h1{
            margin:0;
            font-size:20px;
            letter-spacing:-0.2px;
        }
        .header .sub{
            color:var(--muted);
            font-size:13px;
            margin-top:4px;
        }

        .card{
            background:var(--card);
            padding:22px;
            border-radius:16px;
            box-shadow:var(--shadow);
            border:1px solid var(--border);
        }

        /* Home stats */
        .stats{
            display:grid;
            grid-template-columns:repeat(3, 1fr);
            gap:14px;
            margin-top:14px;
        }
        .stat{
            background:#fff;
            border:1px solid var(--border);
            border-radius:14px;
            padding:16px;
        }
        .stat .label{
            color:var(--muted);
            font-size:12px;
            margin-bottom:6px;
        }
        .stat .value{
            font-size:22px;
            font-weight:800;
            letter-spacing:-0.3px;
        }
        .stat .hint{
            color:var(--muted);
            font-size:12px;
            margin-top:8px;
        }

        .quickActions{
            display:flex;
            gap:10px;
            margin-top:16px;
            flex-wrap:wrap;
        }
        .action{
            display:inline-flex;
            align-items:center;
            gap:8px;
            padding:10px 12px;
            border-radius:12px;
            border:1px solid var(--border);
            background:#fff;
            cursor:pointer;
            text-decoration:none;
            color:var(--text);
            font-weight:600;
            font-size:13px;
            transition:0.18s ease;
        }
        .action:hover{
            box-shadow:0 8px 18px rgba(0,0,0,0.08);
        }

        @media(max-width:1100px){
            .stats{ grid-template-columns:1fr; }
        }
    </style>

    <script>
        function confirmLogout(contextPath){
            if(confirm("Are you sure you want to logout?")){
                window.location.href = contextPath + "/logout";
            }
        }
    </script>
</head>

<body>

<div class="sidebar">
    <div class="brand">
        <h2>Ocean View Resort</h2>
        <small>Staff Dashboard</small>
    </div>

    <div class="nav">
        <a class="nav-link <%= "home".equals(currentPage) ? "active" : "" %>"
           href="${pageContext.request.contextPath}/dashboard?page=home">
            🏠 Home
        </a>

        <a class="nav-link <%= "reservation".equals(currentPage) ? "active" : "" %>"
           href="${pageContext.request.contextPath}/dashboard?page=reservation">
            🗓️ Reservations
        </a>

        <a class="nav-link <%= "billing".equals(currentPage) ? "active" : "" %>"
           href="${pageContext.request.contextPath}/dashboard?page=billing">
            💳 Billing
        </a>

        <a class="nav-link <%= "reports".equals(currentPage) ? "active" : "" %>"
           href="${pageContext.request.contextPath}/dashboard?page=reports">
            📊 Reports
        </a>
    </div>

    <div class="spacer"></div>

    <button class="logoutBtn" type="button"
            onclick="confirmLogout('${pageContext.request.contextPath}')">
        🚪 Logout
    </button>
</div>

<div class="main">

    <div class="header">
        <div>
            <h1>Welcome, <%= user != null ? user.getUsername() : "User" %></h1>
            <div class="sub">Manage reservations, billing and reports from one place.</div>
        </div>
    </div>

    <div class="card">

        <% switch (currentPage) {
            case "reservation" -> { %>
        <h3>Reservations</h3>
        <p style="color: var(--muted); margin-top:6px;">
            Reservation management content will appear here (Add / Search / View).
        </p>

        <%
            } case "billing" -> { %>
        <h3>Billing</h3>
        <p style="color: var(--muted); margin-top:6px;">
            Billing generation and printing content will appear here.
        </p>

        <%
            } case "reports" -> { %>
        <h3>Reports</h3>
        <p style="color: var(--muted); margin-top:6px;">
            Reports and analytics will appear here.
        </p>

        <%
            } default -> { %>
        <h3>Home</h3>
        <p style="color: var(--muted); margin-top:6px;">
            Quick overview for staff operations.
        </p>

        <div class="stats">
            <div class="stat">
                <div class="label">Today’s Reservations</div>
                <div class="value">0</div>
                <div class="hint">Will update when Reservation module is connected.</div>
            </div>

            <div class="stat">
                <div class="label">Pending Check-ins</div>
                <div class="value">0</div>
                <div class="hint">Based on check-in date and status.</div>
            </div>

            <div class="stat">
                <div class="label">Revenue (Today)</div>
                <div class="value">LKR 0</div>
                <div class="hint">Calculated from billing module.</div>
            </div>
        </div>

        <div class="quickActions">
            <a class="action" href="${pageContext.request.contextPath}/dashboard?page=reservation">➕ Add Reservation</a>
            <a class="action" href="${pageContext.request.contextPath}/dashboard?page=billing">🧾 Generate Bill</a>
            <a class="action" href="${pageContext.request.contextPath}/dashboard?page=reports">📌 View Reports</a>
        </div>
        <%
                }
            } %>

    </div>

</div>

</body>
</html>