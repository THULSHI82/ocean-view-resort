<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.oceanviewresort.auth.model.User" %>
<%@ page import="java.util.Map" %>

<%
    User user = (User) session.getAttribute("loggedUser");
    String currentPage = (String) request.getAttribute("page");
    if (currentPage == null || currentPage.isBlank()) currentPage = "home";
%>

<%
    String subPage = (String) request.getAttribute("subPage");
    if (subPage == null || subPage.isBlank()) subPage = "add";
%>

<%
    Map<String, Object> stats = (Map<String, Object>) request.getAttribute("stats");
    if (stats == null) stats = new java.util.HashMap<>();
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
            grid-template-columns:repeat(4, 1fr);
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

        .infoGrid{
            margin-top:20px;
            display:grid;
            grid-template-columns:1fr 1fr;
            gap:16px;
        }

        .infoCard{
            background:#fff;
            border:1px solid #e5e7eb;
            border-radius:14px;
            padding:16px;
        }

        .infoCard h4{
            margin:0 0 8px 0;
        }

        .infoCard p{
            color:#64748b;
            font-size:14px;
            line-height:1.6;
        }

        .infoCard ul{
            margin:0;
            padding-left:18px;
            color:#64748b;
            line-height:1.7;
            font-size:14px;
        }

        @media(max-width:900px){
            .infoGrid{
                grid-template-columns:1fr;
            }
        }

        @media(max-width:1100px){
            .stats{ grid-template-columns:1fr; }
        }
        @media(max-width:700px){
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

        <a class="nav-link <%= "reservation".equals(currentPage) && !"list".equals(subPage) ? "active" : "" %>"
           href="${pageContext.request.contextPath}/reservation">
            ➕ Add Reservation
        </a>

        <a class="nav-link <%= "reservation".equals(currentPage) && "list".equals(subPage) ? "active" : "" %>"
           href="${pageContext.request.contextPath}/reservation?view=list">
            📋 View Reservations
        </a>

        <a class="nav-link <%= "billing".equals(currentPage) ? "active" : "" %>"
           href="${pageContext.request.contextPath}/dashboard?page=billing">
            💳 Billing
        </a>

        <a class="nav-link <%= "help".equals(currentPage) ? "active" : "" %>"
           href="${pageContext.request.contextPath}/dashboard?page=help">
            ❓ Help
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

        <% if ("list".equals(subPage)) { %>
        <jsp:include page="/WEB-INF/views/reservation/view-reservations.jsp" />
        <% } else { %>
        <jsp:include page="/WEB-INF/views/reservation/add-reservation.jsp" />
        <% } %>

        <%
            } case "billing" -> { %>

        <jsp:include page="/WEB-INF/views/billing/view-bill.jsp" />

        <%
            } case "help" -> { %>

        <h3>Help & Guidelines</h3>
        <p style="color: var(--muted); margin-top:6px;">
            Quick guide for new staff members to use the Ocean View Resort system.
        </p>

        <div style="margin-top:14px;display:grid;grid-template-columns:1fr;gap:12px;">

            <div style="border:1px solid var(--border);border-radius:14px;padding:14px;background:#fff;">
                <strong>1) Login</strong>
                <div style="color:var(--muted);margin-top:6px;font-size:13px;line-height:1.6;">
                    Enter your staff username and password. If credentials are invalid, an error message will appear.
                </div>
            </div>

            <div style="border:1px solid var(--border);border-radius:14px;padding:14px;background:#fff;">
                <strong>2) Add Reservation</strong>
                <div style="color:var(--muted);margin-top:6px;font-size:13px;line-height:1.6;">
                    Go to <b>Reservations</b> and fill customer details, choose a room, then select check-in and check-out dates.
                    The system prevents overlapping bookings automatically.
                </div>
            </div>

            <div style="border:1px solid var(--border);border-radius:14px;padding:14px;background:#fff;">
                <strong>3) View / Search Reservations</strong>
                <div style="color:var(--muted);margin-top:6px;font-size:13px;line-height:1.6;">
                    Use search to filter by Reservation ID, customer name, phone, room number, or by date range.
                </div>
            </div>

            <div style="border:1px solid var(--border);border-radius:14px;padding:14px;background:#fff;">
                <strong>4) Billing & Payments</strong>
                <div style="color:var(--muted);margin-top:6px;font-size:13px;line-height:1.6;">
                    Generate invoices from the reservations list. Settle using Cash/Card.
                    Once a bill is PAID, the billing button becomes disabled.
                </div>
            </div>

            <div style="border:1px solid var(--border);border-radius:14px;padding:14px;background:#fff;">
                <strong>5) Logout</strong>
                <div style="color:var(--muted);margin-top:6px;font-size:13px;line-height:1.6;">
                    Click Logout and confirm to end the session securely.
                </div>
            </div>

        </div>

        <%
            } default -> { %>
        <h3>Home</h3>
        <p style="color: var(--muted); margin-top:6px;">
            Quick overview for staff operations.
        </p>

        <div class="stats">
            <div class="stat">
                <div class="label">Total Reservations</div>
                <div class="value"><%= stats.getOrDefault("reservations", 0) %></div>
                <div class="hint">All reservations recorded in the system.</div>
            </div>

            <div class="stat">
                <div class="label">Active Guests</div>
                <div class="value"><%= stats.getOrDefault("guests", 0) %></div>
                <div class="hint">Guests staying today (based on check-in/out dates).</div>
            </div>

            <div class="stat">
                <div class="label">Available Rooms</div>
                <div class="value"><%= stats.getOrDefault("availableRooms", 0) %></div>
                <div class="hint">Rooms not reserved for today.</div>
            </div>

            <div class="stat">
                <div class="label">Total Revenue</div>
                <div class="value">LKR <%= stats.getOrDefault("revenue", 0) %></div>
                <div class="hint">Sum of reservation totals (billing-linked).</div>
            </div>
        </div>

        <div class="quickActions">
            <a class="action" href="${pageContext.request.contextPath}/reservation">➕ Add Reservation</a>
            <a class="action" href="${pageContext.request.contextPath}/reservation?view=list">📋 View Reservations</a>
            <a class="action" href="${pageContext.request.contextPath}/billing">🧾 Billing</a>
            <a class="action" href="${pageContext.request.contextPath}/dashboard?page=help">❓ Help</a>
        </div>

        <div class="infoGrid">

            <div class="infoCard">
                <h4>Staff Operational Guidelines</h4>
                <ul>
                    <li>Use the <strong>Add Reservation</strong> section to create new bookings.</li>
                    <li>Check room availability before confirming reservations.</li>
                    <li>Generate invoices from the reservation list once a guest checks out.</li>
                    <li>Use the billing module to settle payments and record the payment method.</li>
                    <li>Refer to the Help section if assistance is needed for system usage.</li>
                </ul>
            </div>

        </div>
        <%
                }
            } %>

    </div>

</div>

</body>
</html>